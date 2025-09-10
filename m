Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7490F25F798
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 23:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757546963; cv=none; b=jAanU8nphwsTkQhiS0hxGUe4JWzfzicl5RMyTpemoGE12wa007fg/KX3znhtHeW6WDEw969UNSiIy9EihO9S7JG1xEZAGsACbssszS7KQz0edFXzOvWqmTgczGnL9pd4ccrQ9kmjZMBBlU55BCfMa44aLfjfFdz0ntwk+D9ggEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757546963; c=relaxed/simple;
	bh=KBpMizUVbLt9SJELjqWZWf+ciJNO9TCFV/wU2La7kaQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ndclaMwVI6gwsW7mhz0dXPYBU6eQ6h+YZPo5v7a3F2Xecia5tOJSmjUI1T4xOwqtgm8SOjDSSANZ+Dg/8QLYXNlkbV+47c5ymeB3EPjwQaPuIhPaSLvHhnbQMqiS9J8/rWpc9XCi3CxNOfkxgPYmDj46cgJBfyf31/vEZmRc710=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SouMahNP; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SouMahNP"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e97021a3695so52252276.3
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 16:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757546958; x=1758151758; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KBpMizUVbLt9SJELjqWZWf+ciJNO9TCFV/wU2La7kaQ=;
        b=SouMahNP1VbeRyu14aTG+urIz/MUobEcWFIkGSMGqo/+RgYhuCJlVZIBzLKmZzPeCk
         yZxsCK/6S9oCC4UulNUUs6KPHaxtkRFjtKuEE5vrg31BKHHMKqBATHYw8yM8TzIHAyJn
         N4ehR21+/d1U0GWWQ8Cb2FsjsbQ3sTGOgCSqZe5ABgj9a3kZYuaXtMtb2svorusTqrP9
         BmGISfpHQLgCOtlXOAJcQWm0Fn6XOM5H//sN4cei7cDgE89dikW3/62lKv79lb60aIXL
         8u3zrMhHJeE2DRhnNxX0dgQgw/HGd1NORg5To1bTM2Kl7anOm/5U0kdLltYyO/50GQ/Y
         joHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757546958; x=1758151758;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KBpMizUVbLt9SJELjqWZWf+ciJNO9TCFV/wU2La7kaQ=;
        b=tN/FNLsTIeRdFwDKptQLSQl1/WWUoTOtEXCr2TIgiFfNP+F5LhdH2+9M74FFKZvEPp
         vLQafwlAYaDkzBgl1vW9ClAgCjpFqYe3Qlfag/Y8j8iOW8CqO7H/QE29jcTHmBji4vkl
         Qr5IP+pp3cotsqK62/KCx38I4ya2ANP4yXCBevX372Y8Hh26pj6TC7Gi9EcEVdq1CVka
         NuElysdCqpYsiIlgtYrNMmll0NZRexQ9rUADRS+plLjWO8/849K4/zGQzbh8plX0m+Db
         WCkMsq2MliDehxcOkLS/QDySeoyRfIXBYQmpr0DzqenxSOzYqoIllN8et0oj9Vkb33o3
         NlCQ==
X-Gm-Message-State: AOJu0Yz0AkZi3/AZsug+ZAjqRMj2Sb+5d8COmZ7drR5XEL3XIrJH7Y9/
	o/Vg/kN1NXcxs7PVFF/j/GfRHEMwUXJQ6qDvzDZQpN3Qo610ycw5vQQUIMehK0JJHfdKLoC2vg9
	VhEefE/zq/KnzFU5EWUvCo4rn271cbGfQRn4rMPk=
X-Gm-Gg: ASbGncvajj3hrGlyzAgQMS99ym0YDnlkHCbF3moiID0Hz0XtOexHoZJW+2Yzdd1hzhS
	6Tu/TxjgeREAyEG1X6iVOe/11YoBe4VBA2hYMvREmX9fkxoQZSg5NYW9RbPgSCfSMVb/6UVRYwC
	hTxvzttwWDMiy871yD/YSXfRowv1cSRlV7FUwHHMRAuMjRspOTeZfR1CzHaDKJyIs8COpLXy+wp
	3xXxw==
X-Google-Smtp-Source: AGHT+IFhN5c6dfKGRKcE4vzUola49NZeBCDziaetn+1JNZre5GCy+yyT8Kp6LgcJ4gIxXJ+csuQSGUFFv9uUcOZFx8U=
X-Received: by 2002:a53:b9d1:0:b0:600:4a6c:bed3 with SMTP id
 956f58d0204a3-6102995bfcamr12426592d50.26.1757546958170; Wed, 10 Sep 2025
 16:29:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: ynckz <yanckezcs@gmail.com>
Date: Thu, 11 Sep 2025 02:28:54 +0300
X-Gm-Features: Ac12FXzhKeRyrQi5v6ND64yg4Csgj8-HGAe-9my-ZSa2_FyjXFxFNPr_puw3kwU
Message-ID: <CAGyVUB5QLV+HQMWT+0kDu1_H0uXHK7kTy35WqhXQaETZ5if5EQ@mail.gmail.com>
Subject: Git private branch Feature Suggestion
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Git developers,

I have a request for you. Could you please add private branches? This
is a really useful thing.
Imagine that you want to publish your project as open source, but you
need to hide the .env file in a separate repository. It's easier to do
everything in one repository, but in a different branch. Maybe there
is another way, and I'm just dumb as fuck, but here's another example:
Say you don't want to release a new feature yet. To do so, create a
private branch, make the feature there, then merge it into the main
branch.

Maybe I'm a dumb ass, and don't need to ask this of you, but GitLab,
etc., anyway, I'd appreciate it if you could add this feature.
