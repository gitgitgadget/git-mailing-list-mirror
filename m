Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1577522F177
	for <git@vger.kernel.org>; Sun, 14 Dec 2025 23:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765756349; cv=none; b=OcRFuqQWsJ6nQnsIB6ANyPlrJH9gulRcumk7HUYjzG8507AslezIb8PNv1HMHqmdkEJGgT6OF5mhPyI+jglEDCqwpnzkyVFxYBIYYNtz5gXjGgSKMRsYnzjU4+c5RizeiWFZ3UVHnc3qKP5T892CAdCnLGuqXiAyVRy1HqG8KFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765756349; c=relaxed/simple;
	bh=wpw+aU/6TafZPWZUHlNj0zKRPiu9H31s/Zzn9WJ5SNY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B30H89+KMD1yk8Dbc3AV99E1t0prDTLSaKmnulhCGnzjudjqZMA8/TrirtQEZCjWrIRlqT79T1cM8JNju5PAiThpC7Ox34sCRU9VGtT6skzfO/Ce9mfv/jJ+Hnac/R4UQIXByjQpMvoeEGrC/VHpdEo2kR0i9r5UD9MM1vnUq8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUnzJHKO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUnzJHKO"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a0d5c365ceso8656005ad.3
        for <git@vger.kernel.org>; Sun, 14 Dec 2025 15:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765756347; x=1766361147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJ9TezuN1J5gZsgdlKXCsvbMAIJptY/Gxj8tvXFjUQE=;
        b=PUnzJHKOrzGJFbyTnb/glN2VVkF23AeEAbjiIr/CdlznvMT9KIKni8+1VMEiE7LBjj
         3h1/OSz9RndVIrwhTX3wFJERDEdYkWE0jVrjC8560wTDZ2wKWU4QfobauKmkAIOyXt2/
         Cl1+jNB5TV0pfVmMI+r2C1pRgLZkNkJsTNE+5o8OneiMerYzWjaDrPPZzVvcA+8y+sn3
         5ZbmygCzTTPLADEjxXvaUCL9+UzOWbaKUpLGShAIoL7mpyvcHRLBX01+ZmPQzJpjRPhF
         weQFdm5QsAgkxTLdfBrmSJy1qWJJyDIdJ494jEdUiXFOktb1nPpGht46VjACpOT5WXTb
         IC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765756347; x=1766361147;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJ9TezuN1J5gZsgdlKXCsvbMAIJptY/Gxj8tvXFjUQE=;
        b=Ywux4XDx/i94MEgFQXcm0EAS7mMDPFhzB4j/HxUcNoJ1l3xo0UoEpirD3WrXmkSDEM
         GgDCnna2RbF2LwDgksmJx5Ab51NGucZNmZCSgqYxJPuoEIBcPFYXuiib8WFu32jGEa43
         L0QejrFuXIZ4Pz08/Z3iJm4SYaAU7unkQR24oU8Q+zRoHObLiw/a53fK5kwwJmpjJK1Q
         quyjjQg5RL73JEidDOnMNfqPF9ydxktjqr2r7Qc+1VPMdSiWb7WFXLVNEN+MKbTJoyls
         2LxL1RI87skBS6vxMiz7zaPAKi5facP1npeNUKY9xvIWIVM5XncZG9fAHuZRuqRGsNvU
         naiw==
X-Forwarded-Encrypted: i=1; AJvYcCVsrAd0IHydzeAAsnnpSeu9Z//GeAG+gHLubqfREMqqIv4xEblKp6f5FTCG4G34DwrHw0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAEjNxYKiue6FIocB+GJNpEZ+EM1KIjUheO3h319CgiMcyPVh1
	dN6Vt7KqtIz0lAKYhpS5l46oI6h2JYw2VKsFz9umSXehmIod2DjeD0dvixnoZQ==
X-Gm-Gg: AY/fxX4iMj5hpa6tY0xn2PXCfQhn4md6MyP7Bito+3JXVLMLigWutI2e2WV2zXSFFE5
	RE7OIiUYGV646E0DhensPYeiuZO6XZgI7oqZu9/4+FWS1XV0/Y1026KSCS1TdXSw1YgnQ3BOFWr
	2/Sul1EX75nzbIDsS6i9bm0BSvgs0hYTTZPSMX5psviJ5yKbzyBwgF0TZgF4dxtZipZ3DAg4mTw
	Um0GuBBvJCepHYS1cBi+Tc405dhI0ksiEK5icVO3pPD7bga/lu8zseP2wYsvZNFjilwQNWRbvrI
	Zya6GLuhAtHoaH60F77f8T0AfdFjhAIsUznanN0Y5BOo6yfl+YJoUR7qkYilYqR4kR4T9r1JL9K
	+xTcEmVT50R2XZLJUKVdtO5ZoZ4gXOOhRvY3mPSjfJmC2B/tNTjX4pmzdfaZeEuGAKTxm
X-Google-Smtp-Source: AGHT+IGchrW5Z99m/4ViuMBRJp36CLS+ld3vX4ybw+LPl48FZqXzfo8QASTsEYFSeWjm1T7SopULOA==
X-Received: by 2002:a17:902:d2c7:b0:2a0:e94e:5df6 with SMTP id d9443c01a7336-2a0e94e5ebemr15460085ad.50.1765756347009;
        Sun, 14 Dec 2025 15:52:27 -0800 (PST)
Received: from fedora ([2601:646:8081:3770::d056])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0e96df1c9sm13528125ad.39.2025.12.14.15.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 15:52:26 -0800 (PST)
From: Collin Funk <collin.funk1@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,  Stefan
 Haller
 <lists@haller-berlin.de>,  Git <git@vger.kernel.org>
Subject: Re: Would it make sense to add a commit.signOff config?
In-Reply-To: <xmqqsedc8w7k.fsf@gitster.g>
References: <86c5d40d-5a06-4a69-90d8-a737685b0536@haller-berlin.de>
	<aT7lkXl65-TBIsRS@Carlos-MacBook-Air.local>
	<xmqqsedc8w7k.fsf@gitster.g>
Date: Sun, 14 Dec 2025 15:52:25 -0800
Message-ID: <87zf7k39l2.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:
>
>> this was discussed recently[0] and the point that was made is that SOA a=
re
>> meant to be relevant mainly in open source contexts and should be explic=
itly
>> given.
>>
>> Carlo
>>
>> [0] https://lore.kernel.org/git/xmqq4iwvfx8s.fsf@gitster.g/
>
> Thanks for a spelunking starter.
>
> Perhaps we should resurrect a proposed patch from 2020 (which no
> longer apply cleanly, but quoted to show what the additinoal text
> said).
>
> https://lore.kernel.org/git/xmqqpnfw8gyn.fsf@gitster-ct.c.googlers.com/
>
> to save time from potential contributors?  I do not want to see new
> contributors feeling they wasted their time after putting their
> effort.

Sounds like a good idea to me since it has come up a few times and, at
least from that thread, there is wide agreement it shouldn't be added.

> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index ced5a9beab..1909551087 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -171,6 +171,13 @@ The `-m` option is mutually exclusive with `-c`, `-C=
`, and `-F`.
>  	the rights to submit this work under the same license and
>  	agrees to a Developer Certificate of Origin
>  	(see http://developercertificate.org/ for more information).
> ++
> +As it makes it harder to argue against one who tells the court "that
> +log message ends with a SoB by person X but it is very plausible
> +that it was done by inertia without person X really intending to
> +certify what DCO says, and the SoB is meaningless." to more
> +publicized ways to add SoB automatically, Git does not (and will not)
> +have a configuration variable to enable it by default.

I think it is a bit more clear to just write "Signed-off-by" instead of
using the abbreviation SoB. That isn't used elsewhere, as far as I can
tell.

Collin
