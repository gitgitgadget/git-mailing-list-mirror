Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F8B1D9A43
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 19:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728328317; cv=none; b=a1A0Y0pIcozGNyzViddozuDKMUXu3MCyYvFMQDFJl4vA8qjjh9trbVYe8mTJiK8O8tN4M7NlLiUuzNUmRyzC4k97jx4pwlhbdd33MyYeWY33DGSdhuj8+2F5ggwmaaM891a6zfkrpMKmrGbTsQT5YJTXMYp+JxkUxJxUY/hWWws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728328317; c=relaxed/simple;
	bh=UqVyeyhlKplj/b+6wDGdfKT5ExnGf8BlY7PsSd0/uS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbgS9uVK1qvet2TYTaS1XnlhPinqYD7cAZ6Hu+/RHaiXG/eC4Vk+NU4cKxVtR/QQGHxw96Npzda4UXneXGReQv9gieGOg0IRhn+W8J+73Gu4y6Osbf6tWz3WMeXUi4kVPylajIaYSMThiHO5qCQY9evGj06S5/lPbFqetxrFThY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFC0Gefs; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFC0Gefs"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fac9eaeafcso50845451fa.3
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 12:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728328313; x=1728933113; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lbDZo1fFYYLi4JsN14qdPubqySHA3lIpdUX3Cr34KqI=;
        b=mFC0GefsRdHYBeLhPush+gOPP9VXCbAT8YNuZL05kr2VgrA/VozDK1qUQrZT/lT0xb
         tDrkaZ8UykpM+oh2EwAkbbXFrJobm8LZd9nKCF61pB/9hZaeN34hLCW6Iar7hWju34RL
         KW6x4IwVGKOBZKycVmqsYANmDI5HTzf0n3Z2AszcyghMr950CLXzxB6q1crd8TUa0+Ol
         Z0FD3sW+ytuvxtLW2zbP3kl4DWFYT8Fb5qwd8BJJxlt/E42YXmiU0+PibWcCJxVvDoHi
         NH6nwPD355Abf14SYtRE3V2XW+jFnHG+VAWulteDpTnVJfC6DnHuWuvTb4EDvVBpmlCE
         87tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728328313; x=1728933113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lbDZo1fFYYLi4JsN14qdPubqySHA3lIpdUX3Cr34KqI=;
        b=dA4wGFk3lgkkrxwO44GD5IWQUrW0PZ3p+Jx64fDF5EGZtQJh3AzanGUtbcr8CmQPed
         arAsDfdKBU5ln8n6X5CS9q/CfEkVwh/7DKTk36RcCGxCThrflwfa/b0ppgQlZAgVBCW5
         Ber0asUzwzmzvMMswrRJUlDkJGj9wJmVyNswnZrNfxSvQp3OY/RwgKDtvZAw8Zu+VLDg
         qLQVxea6EBnzyaesZZeSlZEzHL80LUWOvVbuIK8EVg16L2gkh69LjX7CCvswZJfVgoo3
         NJIu9dMhiord+lKOJgsYFHPagmAlfbipiEbsrDedRJLn2NwII22knx7HkwPIARTVkxPG
         n8FA==
X-Gm-Message-State: AOJu0YyZNfELovqHukNc0DP/mQO7L0iBPhvPN1dVE4j7ViEjK2Q1KYjd
	ftSLhW83lwjM9I1QBNSkCshqGZAR682ohN2lqI2MCfDF4x8tPj+PFZSmj3HMFLUyIwExXzkIzNP
	gJN45GsoaD/q2T4+am8rkar0o4AHkP3iR0to=
X-Google-Smtp-Source: AGHT+IHJbp4PeEGzhRuUDlHBVXQdfqrgATsYwcUoU5nno+N0ZAinaRKcymXjf7YpdsIL6OvmYFYr95ezpeQtOaCXXmM=
X-Received: by 2002:a2e:bc21:0:b0:2fa:d534:3ee7 with SMTP id
 38308e7fff4ca-2faf3d724dfmr64020991fa.35.1728328312947; Mon, 07 Oct 2024
 12:11:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACwP9ara-N1PGYi8wt3MsDvs50thXf9iw2w4n-syZD0wwXXqfA@mail.gmail.com>
 <ZwNvu00mQuFQD7Ps@pks.im>
In-Reply-To: <ZwNvu00mQuFQD7Ps@pks.im>
From: Chizoba ODINAKA <chizobajames21@gmail.com>
Date: Mon, 7 Oct 2024 20:11:15 +0100
Message-ID: <CACwP9apjMAwwA7cqdKmyj08=wENV4+NpeUdojz54c4=6=pNWEA@mail.gmail.com>
Subject: Re: [Outreachy] Applicant Introduction
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks Patrick, I do like to register my interest to work on:
Avoid pipes in git related commands in test scripts, based of,
https://github.com/git/git/commit/c6f44e1da5e88e34
Test script to implement changes  - t6050-replace.sh
Code sample -
`test_expect_success 'replace the author' '
        git cat-file commit $HASH2 | grep "author A U Thor" &&
        R=$(git cat-file commit $HASH2 | sed -e "s/A U/O/" | git
hash-object -t commit --stdin -w) &&
        git cat-file commit $R | grep "author O Thor" &&
        git update-ref refs/replace/$HASH2 $R &&
        git show HEAD~5 | grep "O Thor" &&
        git show $HASH2 | grep "O Thor"
'
`
I do like to hear your thought on this. Thanks again

On Mon, 7 Oct 2024 at 06:21, Patrick Steinhardt <ps@pks.im> wrote:
>
> Hi,
>
> On Sun, Oct 06, 2024 at 01:12:19PM +0100, Chizoba ODINAKA wrote:
> > Hello, Chizoba here. I am interested in contributing to Git - Convert
> > unit tests to use the clar testing framework.
> > PS: I also have read:
> > [1]: https://git.github.io/Mentoring-Program-Guide/
> > [2]: https://git.github.io/General-Microproject-Information/
>
> welcome to our community, thanks for your interest in contributing to
> Git! Let us know in case you hit any issues while working on your
> microproject of choice.
>
> Patrick
