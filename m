Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF88C1DC720
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 19:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725392864; cv=none; b=KvNmO4E4Z603A1Nf1WEOhATKp7cCod/IbSEO9D64dI5tEUPdKJOK1IOJMdlP1rACbACE4hXdklcf7U2bc1iacpBhF4zr0cRPo2/xuZ2NuUA2sMx4NQj0mGMcrzNjdDEqZqO2Pzalf4lDghsseeYgSzuZK/BQzRa0b+I4CL8G83k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725392864; c=relaxed/simple;
	bh=BCgB1wPXFAMDJ7/A/Dek9yc1vJSwIPxnrewU31E2rlM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7AMw0A5P+APfv90pCQg02Qp4NcAoAX3vZekJdumdhS2tnWhHnV9aZGgMr2TUqgiLtqegPbhiCs4X6me6OBrQ+b/rzFguTNSoGtGzPY6utwJu/b+R4yOF8mj0K8PxjCh1xdFmDkBdjEGs2EyNJ4GADRJUq0InDHnw/vBBX9frNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=LVwaW+ZY; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="LVwaW+ZY"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a8160a7239so293040785a.3
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 12:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725392862; x=1725997662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BkcwLBF1sb2qFZ6JEYpzJnIXaWrKB6L+FUmjztIX7zg=;
        b=LVwaW+ZYACi078UsAF5FmM1bYX/vM3d/qs6g+AyEBAnjx4oewN2bxk+1tv0fzJLKJ8
         DWKG1Agq+PVkS7cd2iEZxqZdpQlcRcFc/RkJzcNpGpeqora1OYZxcx0BPvL5c9wcHPSI
         jN5q82qbJj9V3+FtsS1ue6HetkC7XYwBgQAFijfWYqKCxPi2cNEFIHp6Ni8Fo+57Khb5
         hoxWUAGMaVEiq4kEUlydB5scVon6Ulz+NTtXxGD8ff6CrdAGuZCM2sPUcWwfUFxiUBwT
         WvuwMSv3VdX3GxNeHcK83xNRvLfJJTdGW+UPrSbik/MFBWjLO7aSNNu55V6X0S0dsNvu
         zIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725392862; x=1725997662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkcwLBF1sb2qFZ6JEYpzJnIXaWrKB6L+FUmjztIX7zg=;
        b=Jaz8WXCqqsw/IwNyS7PZ4ffwANPnprbS1VbSsxQ68cswszC2m4kKZardjvaFeGfPPT
         Lg1iajFgAWBZOg6Z7wCqzwVhqYjA3G3TIuXZRwl3AGyky63fmOXV8a9U3Twngv9Z8Ddn
         iPUeQMkAhioVHimiX0RKuFkxSQan5/4J293YgJO7A9OvYCwKOBE6PztciCeZTx1gLTm5
         75m1trpstfj5TF2UjoGNl8FOhsJRc5nL9g0LLd6djJJDe+kJG1Mgvkx3LBYY3PKDsF9u
         PooY1cmspzy4Z5GSSBNoqoWc6aWo9LJo2F6XO2mBfLMqvdb/rvnZxESzPHBRlsSMjDMU
         i4vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGpQCrCe+t/DUx9VsbgxQ4eyZa+Q9iCvfEGfbSG6o3LI/su0vd3IpnSPQOwin/Rs7hs/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA/iMjicJqIVQaizpm6thkScO3dyJ6hs7TLRHopwpQxEykdKTQ
	1EJwsfXG1FXVZGKAatgm5spEqbsuQjIEo9WLntgOm77xxnCZ0sg/TkDpuXIDpDc=
X-Google-Smtp-Source: AGHT+IHuOCAt68FKMAdq7jlg7aczw4ZhvhCp6MbHojH74/fLgzeMGL25chML4fUfkdfeVBnNfHnYwA==
X-Received: by 2002:a05:620a:f06:b0:79f:57b:f633 with SMTP id af79cd13be357-7a80427797dmr1899132285a.56.1725392861682;
        Tue, 03 Sep 2024 12:47:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d3a047sm556588185a.98.2024.09.03.12.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 12:47:41 -0700 (PDT)
Date: Tue, 3 Sep 2024 15:47:39 -0400
From: Taylor Blau <me@ttaylorr.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] hash.h: support choosing a separate SHA-1 for
 non-cryptographic uses
Message-ID: <Ztdn25zfi8WHO+GS@nand.local>
References: <cover.1725206584.git.me@ttaylorr.com>
 <ZtXG2cEbxr8pNg7j@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtXG2cEbxr8pNg7j@tapette.crustytoothpaste.net>

On Mon, Sep 02, 2024 at 02:08:25PM +0000, brian m. carlson wrote:
> On 2024-09-01 at 16:03:15, Taylor Blau wrote:
> > This series adds a build-time knob to allow selecting an alternative
> > SHA-1 implementation for non-cryptographic hashing within Git, starting
> > with the `hashwrite()` family of functions.
> >
> > This series is the result of starting to roll out verbatim multi-pack
> > reuse within GitHub's infrastructure. I noticed that on larger
> > repositories, it is harder thus far to measure a CPU speed-up on clones
> > where multi-pack reuse is enabled.
> >
> > After some profiling, I noticed that we spend a significant amount of
> > time in hashwrite(), which is not all that surprising. But much of that
> > time is wasted in GitHub's infrastructure, since we are using the same
> > collision-detecting SHA-1 implementation to produce a trailing checksum
> > for the pack which does not need to be cryptographically secure.
>
> Hmm, I'm not sure this is the case.  Let's consider the case where SHA-1
> becomes as easy to collide as MD4, which requires less than 2 hash
> operations for a collision, in which case we can assume that it's
> trivial, because eventually we expect that will happen with advances in
> technology.

I'm not sure this attack is possible as you described.

We still run any packs through index-pack before landing them in
$GIT_DIR/objects/pack, and index-pack still uses the collision-detecting
SHA-1 implementation (if the repository uses SHA-1 and Git was compiled
with it).

So if I were a malicious attacker trying to compromise data on a forge,
I would have to first (a) know the name of some pack that I was trying
to collide, then (b) create a pack which collides with that one before
actually pushing it. (b) seems difficult to impossible to execute
(certainly today, maybe ever) because the attacker only controls the
object contents within the pack, but can't adjust the pack header,
object headers, compression, etc.

But even if the attacker could do all of that, the remote still needs to
index that pack, and while checksumming the pack, it would notice the
collision (or SHA-1 mismatch) and reject the pack by die()-ing either
way. (AFAICT, this all happens in
builtin/index-pack.c::parse_pack_objects()).

> So in that case, we believe that an attacker who knows what's in a pack
> file and can collide one or more of the objects can create another
> packfile with a different, colliding object and cause the pack contents
> to be the same.  Because we use the pack file hash as the name of the
> pack and we use rename(2), which ignores whether the destination exists,
> that means we have to assume that eventually an attacker will be able to
> overwrite one pack file with another with different contents without
> being detected simply by pushing a new pack into the repository.

Right... but I think we would die() before we attempt to rename() the
pack into place as above.

Thanks,
Taylor
