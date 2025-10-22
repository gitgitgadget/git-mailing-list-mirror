Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ECE2D2481
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 20:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761165299; cv=none; b=gMehvVMFwesO8prVpmQkJWCODPspg5m85BAc1NxbTzkIl74gRE/Os13pm1nf8W12QoqbThBmmoTaBmTAZYAjSQjLtaQdxsQKE1XbC9agN6+9+tjWF8IEIIsz06yzDIazeTtgRGcSj3IRqIFfTcANfnsnSghnAUUSVJslU4rDFcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761165299; c=relaxed/simple;
	bh=hHmah/7q8wnjrnWYTwQ0UgsgaJ/RPtp6rtLLxh36cy4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=oqVGN9j6e+TmoUD2TGSXVw89SxheEio8V1uoWP/4J8YhfXY6mEoohCGKIQy0+UFDn4qaQLztst6VLUzzomXtTHNOFF0OMK5SIPkcKnJ93XsQ8TjuRveEHTrZteaMmi7oN5uV2+eo7PWF0fZYTAI/0LCbkusMVRTfhb+Tand+J8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmEgapHC; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmEgapHC"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-33f9aec69b6so90267a91.1
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 13:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761165297; x=1761770097; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NCYWWMGpGagFfnbhst/ETL2pu9gpvHjD2vsXhC8gF4=;
        b=WmEgapHCJRynPalBcUAe3UuwE882oBxetLkF9IZcOvFoZy6bRFwfVZZZw+o6Hkz4p4
         +iHOjTgqBnLiKkM2Yj45Gf3nt4eXid1UL+bWwHVUWWrjKLWDneRSqT1HFDWCc6iWYjw3
         gNgZKiuAw0gq1b8iOV5g4bv0o3Ep5kjFJmF11mvq9NFq74dJZzmZnQ1KUZ+8mV4c/x15
         N5d1OEbi47lP8qgMir6ZtoyYpPuU2sau8ie7J45t+NgwHtiYa2jTbWFRh1XmmN+nMjbr
         6CSzCXVc1sQKW5v+iG0b0d02aeVOTA/6FWMT5WW3CjhwfEnC4Jz6P+W0hpNJMAbfZSe/
         DH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761165297; x=1761770097;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NCYWWMGpGagFfnbhst/ETL2pu9gpvHjD2vsXhC8gF4=;
        b=pI3T/iG/hIHnqzq4AjqJSncKvOHmCbAZSmiVR3+1oYWCxjljXp716iZw5GBM4CHxqx
         itCpPCk7HwVhANl2OfgTcBh485Xp73cBrEniFLsa9iQy+0MkJIpp54N6m47mUHzvFCYF
         xXPpWrzDutpE90Wjg3wwvEOxj9c9DPZAFXirCrWDB634aDywqxjCrrbov9dsPI92+YNP
         Rsb8pexENxF9s5yHSQMyZ++apWyutNNCk7jOQ2W30/eKYBLdL/OvUN6VBNoJgo8/NfCh
         wEuwMfABlKjwpbFQN59Kam9/1GNSb+4AUuMtBGXJvVmY7aSw1g5pTaQjUkUnvI71+rCI
         yncA==
X-Gm-Message-State: AOJu0Yz+ws7GNyYoTVPa6t97Sp1Eo362MW606QgeywL3tIzgaa0PMRkA
	AbBfXlxdAN+tOSO5ntSQf2yZhPaX81cpyh/P+D0O0XwkzW/oS70H54pr
X-Gm-Gg: ASbGncs5CHQrE8daPFayBViq5A36PAXE1sUHPFpVxUYImTCtqDH5hc6zHdDAjQBD01G
	VvHJvZuGc2orFJT9dCfKGbxtqQEsFwpYiKjZHUEqic1C6C6BYAlYXEJJuUw+VpksjzspgpBm2Sl
	0DPjSUAjVlKBxtl9dXYu9fSDpGQZC7EllAtOg2u4szG25oIQQLD0D+y4cvhoWZSCGznXZbE/U4V
	ZjHYvl7q0XkuplQSPVJnr6Gm/gDOAOdPGpE3Ibj1/MzV9X2J7+ABY+pTgj8GKa5/C4NC1CLWpX9
	d46AvhHCxdDSqeIm0F1nQrgQQYhiIVR4uPIkOmgC/ZFXnaaW8kw4enAlBGQekPZz7bbunktOsxm
	OBXXYCwGE3n5NaOmEgnsw7WhoXEgxW0pzE4QiOLNfeqBc/QFPvUwjF8jS5zctKHqqjFet0k28me
	jfU30kFFE6QLNwV01ad8bi+4EwkSA4v3R3DiDuXQwqwSlP6dnRBg==
X-Google-Smtp-Source: AGHT+IGm62lkqoBAl1TVzj/eGp6CgRRevg9qUZPAAKZkWq4DoeS9Xw5Rui9ls5haKBIYDeIs9RC5yg==
X-Received: by 2002:a17:90b:1c89:b0:32e:7bbc:bf13 with SMTP id 98e67ed59e1d1-33bcf91b83bmr28692709a91.34.1761165297350;
        Wed, 22 Oct 2025 13:34:57 -0700 (PDT)
Received: from smtpclient.apple (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dfb1dbddbsm3114449a91.0.2025.10.22.13.34.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Oct 2025 13:34:57 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH v6 6/7] builtin/repo: add keyvalue and nul format for
 structure stats
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20251021182601.2687284-7-jltobler@gmail.com>
Date: Wed, 22 Oct 2025 17:34:43 -0300
Cc: git@vger.kernel.org,
 ps@pks.im,
 karthik.188@gmail.com,
 sunshine@sunshineco.com,
 gitster@pobox.com
Content-Transfer-Encoding: 7bit
Message-Id: <A076B823-F619-435F-9A7D-40C6D60254D1@gmail.com>
References: <20251015211213.361797-1-jltobler@gmail.com>
 <20251021182601.2687284-1-jltobler@gmail.com>
 <20251021182601.2687284-7-jltobler@gmail.com>
To: Justin Tobler <jltobler@gmail.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)


> All repository structure stats are outputted in a human-friendly table
> form. This format is not suitable for machine parsing. Add a --format
> option that supports three output modes: `table`, `keyvalue`, and `nul`.
> The `table` mode is the default format and prints the same table output
> as before.

Now I'm thinking... What about making --format a flag for git-repo,
working for both git-repo-info and git-repo-structure? It doesn't seem
to be hard to make git-repo-info compatible with your table format and
it looks to me that it would make git-repo more consistent.

I'm also wondering if git-repo-info use this table format by default.
git-repo-info and git-repo-structure are completely different under
the hood, but their interface are very similar and it seems to be that
they could be more closer to each other.


> "git repo info [--format=(keyvalue|nul)] [-z] [<key>...]",
> - "git repo structure",
> + "git repo structure [--format=(table|keyvalue|nul)]",

Do you intend to add a key parameter like in git-repo-info? This way,
we could run:

  git repo structure references.branches.count references.tags.count

and it would return only the branch and tag count.
