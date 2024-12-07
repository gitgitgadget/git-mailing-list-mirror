Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483C1323D
	for <git@vger.kernel.org>; Sat,  7 Dec 2024 02:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733537257; cv=none; b=kjwd2DqZjJkMHJynAjpIbk4B0TKU2KJfKHORMLsOSLKVXjspqObaJ0ImRxgQXJhA7OIaU+ctfQF7dzQjFEXT6sRBSHYhEZ62i7bVkLO19pkMavEV8hpxXklYOcHdLtnCBJ4HbV4JV1LG6cDdAEyDmE1J8Lzv27X5dZArFQVKBeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733537257; c=relaxed/simple;
	bh=PFTlFl8IyZwwJVm1dctPvXcSlChwKDE7gKOUPuSeNBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAZ1Hi+Jrauw74gXR1QoIf/bzfwubqiW4nx4xwFy8WLaXEs9s+pSNNzDDa6eYJPz6VsNRPYVVCR8vEo1+u0EjnrrtXNke70wEIFk14374AdeeHxERR0JG7XLA3YHscqxaA9GBWf1yxgPVrWE+J/u5AJsiRQzYCouxOZL28QJU/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kdu/IuVz; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kdu/IuVz"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3eb22f18e4bso475689b6e.3
        for <git@vger.kernel.org>; Fri, 06 Dec 2024 18:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733537255; x=1734142055; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5b+1tsReNgOfRtuFEAOS/Xnj32QotYdklTwmo+64hzs=;
        b=Kdu/IuVze+PuUIEovGT400aI9sxBSvAp6Xb3oQSL4kjyQ+kAvu0iyHMajj/QjEgnzg
         wDjNY6Uq3CMqUokIS3//aJmSox9I62PPSytHCCh1QghfaJWNUsyUR4vjrv00MFUp4WD+
         PtXmC0CiJzE4bPmvgrm0fugW8c3RXdToic5y7qsGO8ukR+HCowD9fnedktSo+fvq9G7Z
         schhkdeFJ+tR9Xl7WVv+6fg0XuUpYdLmlJ5c9Ig6tj0LMewEjTmCMREtgraPw4HJo9RS
         3hOc0h82I51yHObn3w1AtBjT+yQb9Os/stID8VlaLkFk1UR8YaWHh6/Crh6hHrDoBWNZ
         Kdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733537255; x=1734142055;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5b+1tsReNgOfRtuFEAOS/Xnj32QotYdklTwmo+64hzs=;
        b=E+9Ik4ylbPcJtshCHAyuJYCm8wrZQQ/nOjbGrBRGrbp5sd1EOzgSUQa09LJCO8MkIn
         pBNoaeQqZMJxUKPK1y47oplh77ge/0GafsADNS88Qti50AsiR4SviVlBqPoOUmxmrtFP
         9Bg3PODJCyWUZfNQr3d80n4bX0jVIKEJl4jCuBD/4BgKtjOfKzEytbWGcUpUVcdUkwyS
         b6gUfP6OzNWnClPOa0QYW4VmM1xdMELc3ws4PlWpdP+Q3S/JMWP98n91wGDgGlD3Xsvw
         rfZk66mjq0nEIZpw/CaQAo3iuAaz0CnJJaO60lCEOzTt8bTA41VHEeFXH1x2XynWYZH7
         rpQg==
X-Forwarded-Encrypted: i=1; AJvYcCW8DN8iPpIm9eJcF5avrzm16ZQapAdLn6SAZd0+jfKhdUpjVBZnJOmxzhwv+NX9z6J/WaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqNZA130gh7VtCiw2G1UrA16K7krd/09dGVSXpeXQozKIQ7OyN
	OLADqVQ0tSzACQZsZeSda8gFrp3KFdBB9yKO26kVOc6hdSeVlkUp
X-Gm-Gg: ASbGnctLm6dxIPTtXRMsFmpQaN2k30G5wAr7C7X+cUef8WmySQXqlgyYoyUOdrGBHoS
	wTI9diI6IvGWA4969hUvseYBpHQDiFc6JQXaAWZRAwabc0grx5GIryKjTlpcK9h71oSZw0QKz3L
	/lz8k8DFlupPWOr/rpVogcLiGPOnDvi+k2l1q6aFBNPWYJiE/NDUfxn5luIlXTvwK+Cgn1F6vW0
	uxiaO8CXi52PM3jKTWkf0Esvz1PEMmzrR/wO+IokSs=
X-Google-Smtp-Source: AGHT+IFodSN+lqeKlKr22Uxtq9FGZ/39/UP8c6TRCf770HKHt+n8qKi1ht9mZEuLrVRTbi57Tg/c0Q==
X-Received: by 2002:a05:6808:14c3:b0:3ea:3db5:ffe6 with SMTP id 5614622812f47-3eb19df8a14mr2986040b6e.31.1733537255239;
        Fri, 06 Dec 2024 18:07:35 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3eb0766d95asm1110508b6e.2.2024.12.06.18.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 18:07:34 -0800 (PST)
Date: Fri, 6 Dec 2024 20:05:27 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Aarni Koskela <aarni@valohai.com>, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] object-name: fix reversed ordering with ":/<PATTERN>"
 revisions
Message-ID: <rgy5ghibgbsblrtzn4ujzv3ggx6m4cx4uba56l74dcuhqyikuq@y4ljecsqm5ox>
References: <20241206-pks-rev-parse-fix-reversed-list-v1-1-95a96564a4d7@pks.im>
 <20241206-pks-rev-parse-fix-reversed-list-v2-1-190514278ead@pks.im>
 <4fc44fe4-cf34-4b6b-a073-8ad5b02fe663@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4fc44fe4-cf34-4b6b-a073-8ad5b02fe663@app.fastmail.com>

On 24/12/06 03:33PM, Kristoffer Haugsbakk wrote:
> On Fri, Dec 6, 2024, at 13:28, Patrick Steinhardt wrote:
> > Recently it was reported [1] that "look for the youngest reachable
> > commit with log message that match the given pattern" syntax (e.g.
> > ':/<PATTERN>' or 'HEAD^{/<PATTERN>}') started to return results in
> 
> But the regression is only for `:/`.  Not for `HEAD^{/}`.  I’m sorry
> that I wasn’t clear in my previous message[1] since I didn’t establish
> the context properly:
> 
>     I have indeed noticed that `HEAD^{/}` returns a sensible thing while
>     `:/` does something strange like finding the root commit.
> 
> What I had noticed myself for a little while was that `HEAD^{/}` on
> Git 2.47.0 did something that I wanted (and which is documented) while
> `:/` behaved (behaves) weirdly.  I just shrugged that off since the
> second syntax is more useful anyway (like Junio said).

I was a bit curious why the regression only affected the `:/` syntax but
not `HEAD^{/}` as they both use `get_oid_oneline()`. The commit list
that was getting reversed only ever contain the reference commits
themselves and not the commits being traversed to find the matching
commit (that part comes a bit later). This means it is not a problem
when there is only a single reference being traversed as in the case of
`HEAD^{/}`. So this fix looks good. :)

-Justin
