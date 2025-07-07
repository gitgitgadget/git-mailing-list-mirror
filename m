Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CAC7E9
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 01:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751850666; cv=none; b=jeajyrVXx0KvMCglzTSZAzoqjFZ5IyaIK+Y8A6XFCdmSkrcl/UuEQ7xcmZ0Pk1j4OjDoy6NrCOw4LYwK9cM1FEqxD3uWc/ruLWYu99QQA0vk9iyw3KEGts1Z0pc2TswAYK6b3oWhI1tGYLlxBR/Qb7wlYKqOC5g5l3uv3vuYzOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751850666; c=relaxed/simple;
	bh=5xXZEYGfzb+GvPnO/klLCxsBZc4HEYpsCYvjevsRHJE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MqNX3MKfzQRtEmGIcL6VX4lk4lh0t13NKPdnkG/vp5Y0CBGmop3iI34i3iTunYnipccG3etTS79BG4wQzGmmRCUmE3PTxuNVquTI1VIJcTGDMLvD4XA4SHBCk7PbcpVDDG3e3TojsN2nE+evbzB0b7JiZ4VPi5KIR8zdiwtg8yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KihQKVox; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KihQKVox"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso2213033b3a.0
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 18:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751850664; x=1752455464; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uwG6SPA5cBI55qSLjcuR0YHnnkxxdLm6qKfIXcZAZMM=;
        b=KihQKVoxuhJtNsFMSANmg+fhfpvpcf2YjJNqV9ooCiB66bwC43JFV3w7yiW+BU4C5y
         0EPeYkfJRt7Gmd8VwG2YsRpkAzDiKzDHKG0/Vq+LEqCPHIV444Lr0+MGRYGzeVj0VKfV
         kEH/56mCLD9dCg8oBYOuzSUCKuWsEFtNwOjetCw0LEIhkTHnTPO2pIkJIjYxI8ApsocF
         cw+HuTFQbHGA42EGlMXFTPlc2JbxwHc/rlpHZ4Wu4ogGcoBnpnpk3yoe04UJsGmiZYBn
         A9EbQh38jShK42i7LB00frIV31RlhMuQhjNNa0mLVRA3yCo0qTOfRayNMkCijB3pYChw
         CsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751850664; x=1752455464;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uwG6SPA5cBI55qSLjcuR0YHnnkxxdLm6qKfIXcZAZMM=;
        b=NxRFBKjNz4hvn97/sE4At5jt3AnNtt4SMoEDJW8eptYlgn7w9unHLSojCH9XCGoSJ0
         uBJ0gOLo3ZrbSepsW6BHAqlxR4SgLFHlEBm1mkiTlZUMEoavTiUMtmfZzM8VB21qepuK
         ktkIUdQKtYQ77PWlhPO7/k5PxRxThaGRL4IaDgeaFs6HWlpa2/WrmVxukqBSQo/3XXb3
         mV51fgrBoLgOuRVG/OoyQ+Ze6xOYwpvLHFnNv16m35IU72n/DUzv6nbAiF6hq3LLxUQo
         5PlBl4TK4NrrH6ZHcfw2J4QgVWCidRQBgx11tVoROoijGcyAKLlsRCr7k0dyFoRE0dDf
         +Wdw==
X-Gm-Message-State: AOJu0Yymp6Zq0qm7zZ7kNQD5jJM8+gkasc07PxAwBCU33hwpsEkqW+Oq
	bm0zkFEkOmOwPrvXHFIwPMraCn4BsnGri8zUBztBJeu83/+H4ySY/H3m
X-Gm-Gg: ASbGncsBRivOSJDUbOaz20PYW23tG8+JZCtSlhegM9PPN+6cmQqev8DUq5ZnsjekVyo
	pSt14L5HcnQgMhOts+jSl9iunIw/LiGN3Hqi+OTeh5XJRd4D4J+WRdU9jDzQwH07hwiw5WWWwTr
	XQQya8qd9FGnLLsfKcMQa06hBK0Ob7thT4WEoVcttN98KEAntH4/N+EmNJIfq63xeru/JUymhqU
	uSFIPrhzH3Dvudu5vAhKk9z3PZd7u2+djH29WNgdI0dhCilExOEVk+uWksBlunCoWQ0X4pN2RIY
	85/Io7fKE29LyrpgooljsNqehTb7wCb6kpkEGhhdxbiZFgM9b156Gnifix4BEa4kZLJfbs+aThN
	v2EdZivaZowgnVA0ufvZZswoUDQQ=
X-Google-Smtp-Source: AGHT+IEgmHx3ivuJ6DugP0+xHpYmxUzesovzk7UMkCo/ZQx+Z8WE/uimQmtvjk3pi155jz1SJ4SiDQ==
X-Received: by 2002:a05:6300:6141:b0:1f3:33bf:6640 with SMTP id adf61e73a8af0-22609a89960mr15459487637.18.1751850663625;
        Sun, 06 Jul 2025 18:11:03 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74ce429af7asm7370853b3a.123.2025.07.06.18.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 18:11:03 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Jeff King <peff@peff.net>,  redoste
 <redoste@redoste.xyz>
Subject: Re: [PATCH] SubmittingPatches: allow non-real name contributions
In-Reply-To: <20250706163009.335780-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Sun, 6 Jul 2025 16:30:09 +0000")
References: <20250706163009.335780-1-sandals@crustytoothpaste.net>
Date: Sun, 06 Jul 2025 18:11:02 -0700
Message-ID: <xmqqv7o4ajq1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Our submission guidelines require people to use their real name, but
> this is not always suitable for various reasons.
> ...

Another thing to consider, which may matter even more in the context
of SubmittingPatches, is if it is necessary.  If there is a
requirement, which may or may not be the "real name", that is
essential to keep DCO enforceable, we will not be able to drop such
an essential requirement, even if it is "not suitable" for some
people.  We would have to rather ask these people refrain from
contributing.

But if a requirment we currently have, like "real name", is not
necessary and if "known identity" is sufficient, then by all means,
let's make sure we can loosen the wording to make it "suitable" to
more people.

> In addition, there are some developers who are so widely known
> pseudonymously that they have a Wikipedia page with their handle and no
> real name.  It would seem silly to reject patches from people who are
> known and respected in their open-source community just because they
> don't wish to share a real name.

Yup.

> Retain the prohibition on anonymous contributions that the Linux kernel
> has to ensure that we have some line of provenance to a known (if
> pseudonymous) author who might be able to respond to questions about it.

Where is this reference to "Linux kernel" come from?  Shouldn't we
name our own project and adopt this new language for our own rules?

And yes, total anonymity goes directly against provenance traceability,
so it is not a passive "unfortunately we cannot accept" with regret;
it is a lot more active and positive "we must not accept an
anonymous contributions."

> I don't claim that this is the best possible wording and I'm open to
> changing it.   The term "known identity" comes from Linux, but if we
> need to clarify using different language or otherwise change any part of
> this up, we can do so.

Thanks for writing this.

>  [[real-name]]
> -Also notice that a real name is used in the `Signed-off-by` trailer. Please
> -don't hide your real name.
> +Please use a known identity in the `Signed-off-by` trailer, since we
> +unfortunately cannot accept anonymous contributions. It is common to use some

Drop "unfortunately".  We will not accept anonymous contributions.
It is not like we would wish to if we can but somebody else tells us
not to.

> +form of your real name. We realize that some contributors are not comfortable
> +doing so or prefer to contribute under a pseudonym or preferred name and we can
> +accept your patch either way.

Thanks.
