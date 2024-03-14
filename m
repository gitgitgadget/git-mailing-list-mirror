Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BE47353C
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 21:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710452680; cv=none; b=EPIX2af/4KmC2hqdRIv6znLvLGW+7XVFE5lHRj13xfyLpFKf3zg3xbUfyufgcgwOn3Jh1z5l9UGL4nNDv60WPXT0AHY1TM7lCUetluRQvQAgRfJZLtUgBSfQOOn9TjSHdQ4WPKNcKDs2zRtYkYrP9U7utwMYqAJ6SgpvaWnlSzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710452680; c=relaxed/simple;
	bh=8sZ7KJnkr/IlQzG4VXt8DiQWPw5AyUApLVMsq8jcRSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MlvVQ0f5tGkVXxaCFDpagnRHlUQz+JkUO9fFbOqhPThhM3BsOSAB9WAmn6fqnMwOM6vsmMSkOrfQsY62DzJ4V7L5n3LFVLXz5y0zBPDJcOddDWU6hE2nAieg9qkrRBrc8uPOSVvT7b53UO65+WEVVgll+S9C83KDHs7EZ18uAhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDjEOZv/; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDjEOZv/"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso1180547a12.0
        for <git@vger.kernel.org>; Thu, 14 Mar 2024 14:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710452678; x=1711057478; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VpVPYFc5317Yz8QyAgUJXITf9Na9fF5AUq4sFRNVI1c=;
        b=DDjEOZv/I2r6HV4euscVeBm9gtdjNrmE43W84P36Y43cxq5ashvDYYRg2S/naXu5yy
         mBwxrVXawePD7CfcOVY2ENZvT1VjqHrMQlDQ1Px0G+eLUaJCfvnGHaEnPK/HECTZtXZ1
         wY+gS8lYwTIksvpZA7Thskc7O3FMom0Je5XEbLTj3Z1pZ9Ts6ZNs20mXgzUSB99O0VRl
         q93fU/sgYHDcHnsuy8Hrat/PQMnAfs3I5YAe4VVyEpE0sMxD0aQwX9iz8wOJ3tGgI+mf
         qENa+G6je/u4og0YKxaMPkQkmQ1x91jpT/P9the0mhIT5Ci1eXVAPeO91Qw8o2+X/XuS
         PV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710452678; x=1711057478;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VpVPYFc5317Yz8QyAgUJXITf9Na9fF5AUq4sFRNVI1c=;
        b=py0Ds6DK+hNEve/70ADygqdCI4ztCuyDR16+sgaFn/lFpIjPzRxTXFhCFmSE1wH05X
         jWEUXXF3zoEf0SutOGDXQtVgEmwzDxymEJpO5t2WwQZAWKuHanvruZ0znooHUPL60lSO
         UjmBKMyCZy0KelKvd/4FU9GI2FH026E+FIiaTL3R8IDvdd6LRDH0KhgH/fV9sVJC3bqH
         9/ft8mu3XPmQWrjIdAQIZYL7T/Qh0E41tD35ydoyGW6tf0i1h7bCLjafCLAQlValHsM3
         37PSBPFVjKKEloFjCVoeUXxGUR5+8jetYoD9wi3OKlJTTX7dN5Nlcf97QtftnaM7Ojpf
         dMLg==
X-Gm-Message-State: AOJu0YyUDPsMcD7R2ot1GU8MF93x4tTGyDAoD+45gVyQrpBMW2zeUGX2
	Bq5ivDz9X0q1qDcwjcgEy6JwccRM/dmZDBGmngdK9kWTeSBFvTHqodo+eY4G54duZ8aiu2+/z4i
	OijTY3mS4PLnUNx9EGsqZhHa24Cg=
X-Google-Smtp-Source: AGHT+IEz8sGDNjMd5oHwQByGRiyan/pw0zz370zYLbV0zOvAC/Nj7hVG5cX7XvgNFwiQbUCh6JBO1fILif57/Blq30Y=
X-Received: by 2002:a17:90a:88d:b0:29d:e70f:7240 with SMTP id
 v13-20020a17090a088d00b0029de70f7240mr1296745pjc.11.1710452678332; Thu, 14
 Mar 2024 14:44:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SA1PR14MB4691A8AC86E290A3539BE1398D2B2@SA1PR14MB4691.namprd14.prod.outlook.com>
In-Reply-To: <SA1PR14MB4691A8AC86E290A3539BE1398D2B2@SA1PR14MB4691.namprd14.prod.outlook.com>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Thu, 14 Mar 2024 22:44:26 +0100
Message-ID: <CAN0heSp2A-sx_WA__90WGhP1yD3EBBtR7_N7s5ZPWqe559xpKA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Add transport message for up-to-date references
To: Christopher Lindee <christopher.lindee@webpros.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Mar 2024 at 22:55, Christopher Lindee
<christopher.lindee@webpros.com> wrote:
>
> If the `--send-up-to-date` option in the previous commit is used, the
> "Everything up-to-date!" message will never appear, even if all of the
> refs are up to date.  Moreover, the output `deadbeef..deadbeef` appears
> suspicious, almost as if a collision occurred.  To clarify that the hash
> is, in fact, identical & to allow grepping for the phrase "up-to-date",
> add a message to the output when the ref is transmitted, but no change
> occurred.

> +                       if (oideq(old_oid, new_oid))
> +                               msg = "up-to-date";

From a grammar point of view, I think this should be "up to date". (A
branch can be up to date, in which case it is an up-to-date branch.)

There is quite some history exactly around this phrase, though, see,
e.g., 80bdaba894 ("messages: mark some strings with "up-to-date" not to
touch", 2024-01-12). If we really want "up-to-date" here, I think we
should add a comment similar to 80bdaba894, although it does feel
awkward to knowingly introduce a new instance. So maybe better, go for
"up-to-date ref"?

If we worry about how "Everything up-to-date" disappeared in the
previous commit, maybe that commit should instead detect that all refs
were such no-ops and emit that "Everything up-to-date"?

(Part of me wonders what kind of existing scripts [1] would be helped by
us sticking to the dashed form. If they go "grep '^Everything
up-to-date$", they won't notice this new output. If they use a more
relaxed "grep up-to-date", they might get confused, possibly much more
often than they could already be by a branch called "up-to-date".)

Martin

[1] They don't even provide this new option, but let's assume we
eventually grow a config knob.
