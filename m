Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2664D1E0E05
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 18:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497062; cv=none; b=cveBEnKWsy4wcJj2u18Z87uOF+4QqcZMkYbEd3e5fSNdjLwOEYlvS/j5LNqLbtSuiWeSzKwn2FeJ0VeE+xNkDUFcg9RISeJMYr47lEI8gppavmbcn3yR66NFxU8fDGtxxRuuHHcZ/UuhaR1KPQ4VhuJ24ZvSXVPcegzDjddu9Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497062; c=relaxed/simple;
	bh=mPBgKpKU8BVGQXxqNbLoy9YmTkENgqp0imoaa11VR+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=TXG8Y5cqoI7lFJ9sqQiORPkLgNcfSv1dnM3IcMZQgfAMKwbljdycEs4+Dph39COYJa6dyzI13ByY8xMaX2UYNbUV+9ME7TKavvF6/o9HgwyOvxnFGjmpRYTWFyrANNZG3W1YrFfSitea+W1EheSvuJ7/hhBWsE8m5OpkFQ8w23g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvXIMuop; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvXIMuop"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso68644a12.1
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 11:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728497060; x=1729101860; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FefGmQAAmDI+3VRFu/7z7mvOeNx90S7Jqg//nkHgPE0=;
        b=NvXIMuophqwWCGcdaqacqdgXk7gRcQCpSna74hXcQQnUMZw9ynYfdmK7TPv29smRO5
         +w6p6JuV9cTbya+AGmegM3lb+Xhyv2eXaWOTSHbwrlSFKawnqj93USjLr6xpOuK76UBr
         6qoe7KL4vEr7mbYkDufRWgIUorhLC5rv2yBhy5hKUC4nO67v5F+BiCjeFblhsnK884Fe
         3IznZHQqd9TLtDK64kswzjcFIz0jr58i2FQxjDo9YNsU52uRp3RDHRyJWbf6xKADTtnK
         v6BCyEo/a/2h2HE4QmG29iyHDU8j25itsY4Gf/YFvsfYcURcn8ZhGCXyhWthpUE7/He9
         1BnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728497060; x=1729101860;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FefGmQAAmDI+3VRFu/7z7mvOeNx90S7Jqg//nkHgPE0=;
        b=CxHMMSZ4cLxV7TU38u8EBNGZetAc8/UO61qTUezA8TAXu3H4sKamrfN66pfFbGEDSG
         j3RYmT9J/j3tckRAMk3sojD5Enn/YcswnIFygXjc64Re7EMRyOj2ulMJGs97ckHJRvZr
         n/LUK5wNjH+h2e2vKxOkFLIWPT003gOH1eOnAw7Dr34ACy0TZJUU/2KwewwwwI9rMNcI
         hkvEkEw6NycigUSAn05dj3uUuF9LPZOtgEvloE6o7l9fLWjiXgE3btX0b5UDpPW0J3rK
         fSkoj9fyNyQpebWMZDPas5xjnHWXW9qSQPjn+bBx3angmBLVPWE9eBXNz+SpOcGI8Pol
         Kb7Q==
X-Gm-Message-State: AOJu0Ywp0ACNUboyRzP8TIxt5mHCz4EfKzhGdLxPnuHpY7vSkR2laVCm
	JBC5LhjAYjM0UdiYZC1b/+ajL64GqVB+NGhFXNvo9ZacZkVrhl67JsKq1hko83gkZ+gi6UC28Ar
	eTvifIfKJihD0DccJJY22c2m0Ei0NrMvG
X-Google-Smtp-Source: AGHT+IEmZbvN2Vq6VovueboaUXh0gSSjQRa5AaABJx+Z9EQpNIpfpDz/EG/fppiMmLqv3jeePvZhIO9yw4FYpbGcUsA=
X-Received: by 2002:a17:90a:d913:b0:2e0:89f2:f60c with SMTP id
 98e67ed59e1d1-2e2c805fe05mr751672a91.11.1728497059556; Wed, 09 Oct 2024
 11:04:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHoc8a8JQd=c0bD5Yneg8R7tEjETyns-yyWjP=V3TTn9R48Nzg@mail.gmail.com>
In-Reply-To: <CAHoc8a8JQd=c0bD5Yneg8R7tEjETyns-yyWjP=V3TTn9R48Nzg@mail.gmail.com>
From: Amith Ashok <amithashok8@gmail.com>
Date: Wed, 9 Oct 2024 23:34:08 +0530
Message-ID: <CAHoc8a8b2o7eJULhoF+5VM15ickjRY_f=WBmpPsG=0kwrx1CfQ@mail.gmail.com>
Subject: Fwd: Git bug
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi ,

I wanted to report a git bug that I encountered today .

I created a feature branch from a release branch before my peer
committed to it . My peer committed to this branch through the lower
branches of auto merge option to this high branch .

However when I do a git  pull I was facing the issue in of the files.
I tried multiple ways to debug this but ultimately found that the
issue is with got itself .

I took the a fresh branch from this branch (post merge of my friend )
then the error does not occur.


I appreciate if you look into this . And if this indeed is an issue
could you fix it and you acknowledge my original receipt as the
findings to this .


Thanks
Amith Ashok Chugani
