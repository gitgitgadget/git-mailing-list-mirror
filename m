Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4CA171B0
	for <git@vger.kernel.org>; Sun, 16 Jun 2024 11:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718538477; cv=none; b=LncL9NIIvzXJl+k1lwkYVjIgAqlN+ysYvqNo6ULVW0enYRqkapwV7UhyUjvwxqUZZOB5c16Lajb+ev9iLQoapPiXewfHZuy3QlGTGDicqX1fxDIICFFtVvlZ8F0zR9lH0TOxBqI2ulTQTWrp5pbnzUFvSyrK57EzxLUQ7ASa7Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718538477; c=relaxed/simple;
	bh=jlTMMsYvELHCO04vuGkJ9WUTfFNfrM7dlQD4V6h8R7A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=MYYDvqOn2Cj8f4yTQc8sqAlCSJ5MBbDMx0ea9Ja//1oxSDubp0YK6FRO5W69xq0uRBBSg39xkqufSQtjbYc9xyUFA68cWeMPa3lNCKs4QJiO4y7S/21Ua1siYzP25A0TM75Gu/P+sdsK82zh6zYzlvKJub6GDKzNlA+EXJ0hXVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EffZizOE; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EffZizOE"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52c82101407so6029388e87.3
        for <git@vger.kernel.org>; Sun, 16 Jun 2024 04:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718538473; x=1719143273; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jlTMMsYvELHCO04vuGkJ9WUTfFNfrM7dlQD4V6h8R7A=;
        b=EffZizOEnqXTlel6SFTbOs9zgfOfhMl9JAAHNV9P8I3gAX/zcAAw6SG7/X5PiGnk+e
         ZN+TzzV6jxFUeCEVT3NimHUQIP0OmjA709aizeO5urypTmd0Mp+B3DpZHVV0u//2GUJ5
         eTx2n8rTPZH/1zybTxxtf1lVYoy7YmAFJzipeJMoq7yBqBOPTJy0aFiENxQXTKTvlzdk
         2TkxTvnQazlLwoEnjJwakdqOXKDDPGWel0uwOAP4LfNCvmQgiJXnnWSFcT7czTTZOKDQ
         jeYb2ZOzSzCZm0yblGMjWYs/5tLC9gCL1hd2YWgpRi/wZOVQXKHUW8ql+ByDpMnlELB4
         oghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718538473; x=1719143273;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jlTMMsYvELHCO04vuGkJ9WUTfFNfrM7dlQD4V6h8R7A=;
        b=XagsRu0zL5G2i07aciKGHBt2QoLev0x5poK6kZtGz2injna5gEVqPY0o12f8hdnRRE
         zYZ7tRac60A4LpXZM0vNti0ifBevblcnbLaSSD12X7AyzTMqIXw5mUHlA/GCJLj05MGv
         FbBa8AaO2KQIaC9IlLBDwNaYJ9qd2Nu5dwUJeYTQPvp/veCiY9NPbFQfLXi7XG2ThbR1
         nYOGg0v/rPYpn0BH5lMu9TbzZW12gAATa7Qco0Ob3dKQvwflRfwthwPhT//sBRp1GZdp
         QyYx7T9KJKcfZuvPOQHPlIAvPzW8wZA72xXx/6iraHWP+ykGMmPJnUFCv6ek1yeUT3Rq
         l4/Q==
X-Gm-Message-State: AOJu0YwMPkF5pQGRZIt06eJ2Vq1+7XtCV42Ujmo3Ste22NuIlpdlB2vy
	CmU6Pz4AhLwmmyL7x9anRhaQbudlY0tlrgcJCw0sOo/zILcaRhYnbJ+m18xCjYCY4xJZtRJhkMQ
	Vbg/rcYLfK/9IyM+4F8NB5HwcXP6mFUrmQBo=
X-Google-Smtp-Source: AGHT+IHQgOH72jYUwc4FnfzLKL0BymUzCYc5k6TertCaUjcKzk4Izaof+kXVIbIuSONJOlp1fG/mvV2uU2rG58vJMiU=
X-Received: by 2002:ac2:532a:0:b0:52c:8075:4f3 with SMTP id
 2adb3069b0e04-52ca6e6e9c6mr5344994e87.36.1718538473346; Sun, 16 Jun 2024
 04:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Devste Devste <devstemail@gmail.com>
Date: Sun, 16 Jun 2024 13:47:41 +0200
Message-ID: <CANM0SV3CQPRyJCDanB8JFpkAMwuoo-mg3A=_L743_GXJtoFtQA@mail.gmail.com>
Subject: Add warning when v0 protocol is used/downgraded
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

- When "git config protocol.version 2" is used, there is no
warning/message when the remote returns a response in v0 format. This
leads to any issues related to slow(er) git caused by old protocol use
being unnoticed, leading to wasted time debugging.

- v2 protocol has been standard since 2.26
https://github.com/git/git/blob/master/Documentation/RelNotes/2.26.0.txt#L101
However, there are still large providers (that rhyme with
Nuntucket...) that do not support it/have actively disabled it now
(years after the release)
Additionally, we encountered various self-hosted git servers that had
the protocol version restricted to 1 in their initial setup and this
being forgotten about. This led to unnecessarily slow fetches by their
users unaware of this problem, since git just silently accepts v1 (0)
protocol.

Since v2 is the default protocol, I think it would be expected that if
a non-default protocol reply is returned, there is a message shown to
the user (like e.g. the detached head warning) to make the user aware
that an outdated git protocol was used making git slow.

Otherwise, this (currently) leads to reports that e.g. git fetch is
getting slower and slower (as repo sizes increase over time). However
the issue in all cases we have handled so far, has always been that
the old protocol was used without the user being aware of it and not
an issue with git itself.

e.g.
If
protocol.version is not explicitly set or v2
and both the local and server git version are >=2.26
and the reply is not in v2 protocol format
