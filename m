Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FE518024
	for <git@vger.kernel.org>; Sat, 13 Sep 2025 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757777763; cv=none; b=sofmdHTiCfe/zPDNq1NBNZa5L5ocCD2noPbf16w5s5UvPNvQZdR9QkRT4ioFkEhYQm8eYlCzrNrWIqA7AUDvnHruQyJhi00W2+glvOw1mnREGBJ1QdDvF5AmjzC620VkNSyNUItk580PYbnCLBqI+phWRbn6ht46ScSZwa6nXC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757777763; c=relaxed/simple;
	bh=SgaFfhqpW8AGfgpYfAGv/OsS2rSg9gSdgJ9oap7+AFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6X4vDKUOWG2f3t3aWGGN9zJnJLEVMt1YVEu+KvUdxYt2EYXkwLC/N6VxZPF9QFe9wbZxtjszhVqt4asLor82NXSZWzpSmSv9+DRT1TaNdtfk6N/r+epP1ZDSiEJWqlDQEwj7RvnFIvPqyy6+qmpWFcPbbALktgene8x2CXNoXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YD770pUf; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YD770pUf"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-8d74e29eae5so234647241.3
        for <git@vger.kernel.org>; Sat, 13 Sep 2025 08:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757777760; x=1758382560; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SgaFfhqpW8AGfgpYfAGv/OsS2rSg9gSdgJ9oap7+AFg=;
        b=YD770pUfeFGmBe0eBbT2V4TZjKJBkj71vpRDZQ1EcGwSQp/gubzE7ZZbWKkma0DQ8I
         xWtaGhRRXdO07QrRp4GV0eFRw8Ym4lp1m5IoztPdXY4pit7ygLWtUgIshVrV83mhCQew
         5agh0vRJAYvfeb154k4EBxMGmf+7ONP9oWUZBPdg3LsT8NYUNrjatuJmHgP48iDMwN9v
         NchNqlZJKgCLKxL1F3L2y6MzPG4DFMQQEYLMhx9mhHvrk9jdKqvPf3CtYKwXsq12PqFn
         1O8GN2sqn1f01N+SptMvmK37QPoxmqKthgRyoQYIkVQCWhrXqWtzqjT4UDvtMNF92dd0
         OQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757777760; x=1758382560;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SgaFfhqpW8AGfgpYfAGv/OsS2rSg9gSdgJ9oap7+AFg=;
        b=TIyy977nERw1y/J7nNwVGZygqW51RE8K+QpKMVIRq0ERMiPyiCUnCE+1a8cCavGHyB
         KwT7Vriqz28vDmsFBJy5e6wIr9odCtMYHYo8rTCZ5FNzEkD5XRCzv18AJnR0G5+M2WeA
         vy1LDOdoUqNNJsHt265YNG258xCJu9qbhydYonyNlqHVqY/eXdc9CoRDQ4reZHQ2PTcN
         pMdFHPH1dADUmyJajLlda8D7z0TNT9UaDchglp1P7OlLMlokOqeOhGjpiuFNvgL2szFq
         pPXootNs04Bf5hOhd9qOBQKcPwWgVoxjv5WDJBOIWqF7DvfLU4KjQORn0mDDQuEdu8P3
         ob/g==
X-Gm-Message-State: AOJu0YxegFR3qShCm+h/mvVPok6pA5oG7wJue0/8bagXH7OaiDsafEGN
	oeU7p9TuG5yO0AlhxKqAqPTPLWchtDls0WdluhJX3RbG/f0LkArS9YPzpL9MNn+ggr9BR6a7HCi
	qU+guXa2f/sgaHDkMRsLN8XKPc1XQWpk=
X-Gm-Gg: ASbGncsEwLuQez8ZVKaTwd749SdICnevJDUqIlZIc9LJOjQ6hMkwRNEcE4MRb85+Ctm
	fDM0oltm9enKxVjFGBmFlD2u1H1ZbswQc5F4GeqQp2+5JX2RTsF2nN6tGstNnLnZNI7jOB3Mq/U
	X8AYdGdIUzQg2VpiHOcIaI4umgaF7jIhS0e/knJOh3NWXl5/7P1L+SoYWWiVp2HJEqMGsayHdSE
	ikLnzkxbqq3AzF4D2T/c76q5efVB83aOj/RtgVSDBU9F+qbRhWdQmmZRYUM
X-Google-Smtp-Source: AGHT+IGY6Zk9vyLeylfjNcZr+2dqYdemZ+OkSzsE9FvNOFgFPFm4opqqjrS8PzSdZnMuOYKPCSqm+itNqYkOcAn3Ntc=
X-Received: by 2002:a67:e7c7:0:b0:527:8b63:78fb with SMTP id
 ada2fe7eead31-5561230d5abmr3260494137.34.1757777759930; Sat, 13 Sep 2025
 08:35:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD2OcOaSsumKGZ-oVVWzttc48CvmQZD8tQaWTGQR7wR1EA@mail.gmail.com>
In-Reply-To: <CAP8UFD2OcOaSsumKGZ-oVVWzttc48CvmQZD8tQaWTGQR7wR1EA@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sat, 13 Sep 2025 21:05:48 +0530
X-Gm-Features: AS18NWCCFKZ48-P6ZeP5SisnbOKqeCoxUurmjQ14t5LowmH_n8iOZCC1oVFpI8E
Message-ID: <CAPSxiM8prcfrnm8ktMG+DqguuNXvZukg=RQVV3oWdU88RNsiZA@mail.gmail.com>
Subject: Re: Participating in the Outreachy December 2025 cohort
To: Christian Couder <christian.couder@gmail.com>
Cc: git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

> we don't find mentors, good interns or sponsorship for the interns.
>
Hi Christian,

Thanks for the information.
> I have mentioned GitLab, GitHub and the Git project as organizations
> that might be willing to sponsor, but others are very welcome to help
> as Outreachy is navigating significant financial challenges these
> days.
>
> For more information, see:
>
> https://www.outreachy.org/blog/2025-08-14/december-2025-call-for-mentoring-organizations/
> https://www.outreachy.org/blog/2024-08-14/outreachy-needs-your-help/
>
> As usual, everyone is welcome to participate especially in
> (co)mentoring, providing microproject and project ideas and sending
> PRs to update relevant pages on https://git.github.io/.
I am writing here to indicate my interest in Co-mentoring.
Thanks.

>
> Thanks.
>
