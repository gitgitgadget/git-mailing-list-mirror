Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3278290BC0
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 23:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744413982; cv=none; b=FG/vovQdiibQwEh3ApeONV+3g7Wp8YxWfJ5LvioIw8N+67oRpAYvgPTiik/rtX12yaE8PhNI5bgQDW8XsO2owl74X4Qm5D0Lza5/G9SyZ/JDLhiRmXWYEdk4If6YiZE9LxT+ih1mXLYUz4jUo9m9ZNIMvdGhYq/9SFUOGi0fOUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744413982; c=relaxed/simple;
	bh=O4JPKmvTb43e3HUoPslAZ6O5wiHYdf41zNqqMSwFUtc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hnx2G5pJCjLXp93JATWXAt1pFPwY9IrFtpsTDxfOSOoDAaxuM5GPnCwMxjaDuo9YvIPIXuer0Ck8nkVBthwd73EKnnAipj6+9QEIB/rfYZ9iBd7cemp/3szooZmJUJDl1n3+rvVtEoIugudljHHZX0RWU0So2z6B4T3vibd66Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=JhuZfv2R; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="JhuZfv2R"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c07cd527e4so242851985a.3
        for <git@vger.kernel.org>; Fri, 11 Apr 2025 16:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744413978; x=1745018778; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=woqZ+P7Ow4pzrplRJn85n74dIpSn9wlFMgv30VYaxAE=;
        b=JhuZfv2RuIYGM4GqniEx3oPCwqPiIOdlkHb+SzjAZKHA4lGBvZUIpHLUGnBijXJP0z
         HJ5Ra2y7h9HuiMr29bKCTHsq6OnjzE4WFV7KW4eqB6MxQBaMf8ofCZ68jl5Z8fdn+ftq
         2YmrlAm5rlzrTl7QXG+ezAtJFsYW7yzzplnm4mHFYU1wZmnohf4wf+kGfe5MOR0pHtO1
         YoIDkBoun6GSjCqLQVnpasOyAJFb3qcrNwpRYMcJ7MnMTLCxs0nG+SUvX/rXZ7AZ4q8v
         XEK56JOREhZQiBgv7Iw+LkSh4Zx4QK6zauByu0eGQroe4V//b3bnqdUBhZQfboaxjpWd
         XMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744413978; x=1745018778;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=woqZ+P7Ow4pzrplRJn85n74dIpSn9wlFMgv30VYaxAE=;
        b=TArMrnH0o27zI3k84LzUFGF6pfmFxkt/TMsB0QGfM9yD5VvS9CxKV8jCPsLFyRg+KT
         /GGAmo1+d2hjLphbDj+PGGqgNgk7XoSXfo1DNGwMYU2yTSipCMGxN7vWYBlPick90IiN
         Eq5k3jREnHb5VfDAd36HfGVjQCmPsbEJQNMCbsatMlthNIDat4ICwafEN8N3LbUJwNFe
         FgG+rzZbd9J5L2rsQJUNHFdwZpy5mbR4373J6Kl824NwRJAo6zx3PuYSXewhk/5rr7Ix
         U55wE3Lnqi8meWBtJP8hvVhVBsOb04PqkOH7tsfXkv90/dSKjljvWB2iC2jUrvUVYXI8
         yhYw==
X-Gm-Message-State: AOJu0Yw3bMjFU+sLOw31QKWnv2F85kdy0fkQgZEYn5Q6q/3Ge72XTzAm
	Wd07o57TM6GiFyPPp5IfsZIiUa9x+2PVuzKCLOj8yLy7v7EPPWzyqmcM1gVOCaFpP3RkZx8RfJL
	kwVQ=
X-Gm-Gg: ASbGncsaza/1YaG/WcrAQKIwjTxBA3vRl9X+78bBXV009hm03Ymns8xQ/9wAH+dmyd6
	0w0FgXiWwu3ivF6x9GApIWlddWrZeYcYqEtqgoYp7AGXtDUOVU/dbneRJEIxIlTQI9AYJR5SV1U
	OuzUMUsUhm6Ec/C4tp4v+iLo+rTmigoSy5leT5rChaO0+sXPNIQb3xYwTyCPclsgNC8dGYE4sSu
	Wy6wy1azWzAfWjVd28HzrtmQP2ZOPg58PuswENKwncdLAQaOa8pMuWG3MDciuPKseWNrsx07lO/
	kOalDNVaWFbSp7+WXXtJntZDKQzSq0N8nyozdpGnvtZPL1F0rVhHgYZ971ELJJ/BZFPomt0qFmE
	cyIQ/PoSON/3a
X-Google-Smtp-Source: AGHT+IH62423HxI3rqgxV+T/H14GaYIsBQWMBC/9BIp4WGr8ikP2ab2foj47ivJONVQDHIfgqScXLw==
X-Received: by 2002:a05:620a:2911:b0:7c7:5a9f:7a90 with SMTP id af79cd13be357-7c7af0c1073mr672295285a.4.1744413978455;
        Fri, 11 Apr 2025 16:26:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4796ed9cc64sm32405801cf.62.2025.04.11.16.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 16:26:18 -0700 (PDT)
Date: Fri, 11 Apr 2025 19:26:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 0/8] repack: avoid MIDX'ing cruft pack(s) where possible
Message-ID: <cover.1744413969.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This is a short-ish series I wrote today while thinking through an idea
that Peff and I were talking about yesterday that allows us to avoid
MIDX'ing any cruft pack(s) in a repository when repacking.

The core of the idea is to introduce a variant of the '--stdin-packs'
option in 'pack-objects'. The existing behavior is to create a pack
whose contents is the set difference between the specified included and
exclude packs. The new mode (which I'm calling --stdin-packs=follow)
tweaks the namehash traversal we do at the end of --stdin-packs to also
pick up and pack objects which were reachable from commits in the above
set difference, but don't appear in the included or excluded pack.

If you repack consistently using this strategy, you can guarantee that
the union of geometrically-repacked packs are closed under reachability
without having to keep track of any cruft pack(s) in the MIDX.

I'm pretty sure that this is all sound, having played with it for the
better part of the day and not being able to come up with any
counter-examples. I'm sending this as an RFC because I'm not sure if
there's an obvious case that I am missing that makes this whole idea
bogus.

Code-review is welcome, but I think at this stage it may be more useful
to center the discussion around whether or not the idea makes sense
first.

Thanks in advance :-).

Taylor Blau (8):
  pack-objects: use standard option incompatibility functions
  pack-objects: limit scope in 'add_object_entry_from_pack()'
  pack-objects: factor out handling '--stdin-packs'
  pack-objects: declare 'rev_info' for '--stdin-packs' earlier
  pack-objects: perform name-hash traversal for unpacked objects
  pack-objects: introduce '--stdin-packs=follow'
  repack: keep track of existing MIDX'd packs
  repack: exclude cruft pack(s) from the MIDX where possible

 Documentation/git-pack-objects.adoc |   8 +-
 builtin/pack-objects.c              | 193 +++++++++++++++++-----------
 builtin/repack.c                    |  97 +++++++++++---
 t/t5331-pack-objects-stdin.sh       | 103 ++++++++++++++-
 t/t7704-repack-cruft.sh             |  70 ++++++++++
 5 files changed, 376 insertions(+), 95 deletions(-)


base-commit: 485f5f863615e670fd97ae40af744e14072cfe18
-- 
2.49.0.229.g19b69c1246
