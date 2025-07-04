Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD022E499B
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 08:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751617080; cv=none; b=B6H93fjwgQFYFb4me2kMte+GZwi42aMlEw92r0i0c03eeh44wcIFpP4NNkGf0IvZRzlLxoiFidWQwqtjGTdcLVP++xIHl8hEjYP0D90bsvl2Prw5kfvosCXm2iWQTSGCmsGThsK7v7USlCWEzz8h/DWyZUVs2ucZLOHaNI2t4JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751617080; c=relaxed/simple;
	bh=z3bDfHx6MYMJ18dWAwSdxQNH9jq4IhQmoisRVRWc68o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=F+Q9hwoexBOYe+SWKLpj9Uof5cXwZ3a1QMUPKpC2nJj91KNOkwX3bhF/gY0jqzifcLdI2CGIei1ph5f5NemSXg3VdDoakL0JfjB2w5wQ+GLGOdoniXw9UlJPf7AeZRM/DzkgBfysDQvmdEzojM5oCWkH9D4EiSBzJeAVB5ZlT9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MH4H7+/Q; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MH4H7+/Q"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b1fd59851baso459236a12.0
        for <git@vger.kernel.org>; Fri, 04 Jul 2025 01:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751617078; x=1752221878; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntebDDZc0wy7DTJpcV5z6fnKA+8Zk7MdbD40hOXwYac=;
        b=MH4H7+/Q5BZQIGaaB2A/RnYywK/gelbX/Um+F608RESXadTHD8KEaZ1l3sLkx2FVWN
         SikIdb4q8dtj4WK7WidBZYiFLVSRhtlShn5UPzxRmI0lh94kThtvTu9Q9k2FCdteTUnw
         BsaJa8GNayTuaHzthUZ5KzFZyLCUULnky0hcgLWrmlQWYNb44oDq58IYVGp312B9LeqJ
         /YpQ5Sbn0SohjUJ/EZHpyht9e1UxtAtgIf1CxjMY3hniz75cap3eeQUP5mMlPL2qOepY
         d6J6dMu4IZVLaV7reIQ7unXBzeMp/ui8cCKSezSFPws589w5b4gcKuIt61YMeRuk23tH
         ojbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751617078; x=1752221878;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ntebDDZc0wy7DTJpcV5z6fnKA+8Zk7MdbD40hOXwYac=;
        b=SAc2QMI81W5t3v9U+og0ZJo5eLYMOEJe2cXni2KYEY61ExEfyl7jQLm+C7F+0VrrB5
         awqV5TFWYdciqp+L1JkbbbfnYqxnspcw+CjckU4LhFYWa0Uw60XXfqRKF2Pk7oGZ7LrA
         2iigJczTauGgbqyQSjT1SfI5/FUHrNejmyXSBWeEVjfTBPCLR0B7xx9Ajz15W6DRZz9y
         8GPRLHvBt8YGYnzfcNFzWSmSPqpgQVc0HlL8FyrrhSIJKSQDw8ZcPqGwaw/HT1AXxq5w
         Ub0GLHvN4eDCUXK1hLRX0NOUAzET277KAx9SG4FZC0qQ9VdDxZttC5hdMCgbV6HW01qZ
         Zdcw==
X-Forwarded-Encrypted: i=1; AJvYcCW8qCgtMaiHkKW5AbWA+U8wlz5khlWPWIvFd1jWX/HDv+LJVuzp4SlYBO4NCwIOu9LYWzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9KK0bqNl67Oh0I0c86XOORvpVZ29639Vmf8+X5YLSTRlEZVgu
	yFoqE3RgV5uatriHbmehKibRv5xfmCC+D5M69eTzIRICcQP1+1br7n2l
X-Gm-Gg: ASbGncv/IILIjePlOcHocC8yJ8mjQsSVZvMkRn2S/PDZ7B99PZ6bO6zIckAXsLMABlR
	+W0vJOdd9AIixbXydiHIn861U0M1UX2Fg8OV2jNm52MT54U+uT+OgXjKKffOqDgvbfYpwrYJ3+s
	yGLWZj31JksVeka5KJW3EtRGFqNY4vPOambfyj6P4NJG1NjsNv2TTQsOFi/tTtXzdNigaBpXtL6
	lXJkXWrfi8K0+A92oKlvAySSx52paMpfKy/Kv5Y9zoUcEAQbeegsDwI837hb1XpVxsywPUz8bQp
	+I/K2XszWtOSH8x5iaQG64fWRXlkO4IEjLpZowB8tgCgbdEomaO5LyYfqZtw3bkuO+AEvbW2caO
	NS09g7Iwj/wXSUq633Sg62Dq8b+8ajT8lmd1oJ5pPv9wcDv159KafWW6LIXnTOwk=
X-Google-Smtp-Source: AGHT+IFQD2KfmVTFPOWz1sPNNpWbZl7TdJm13XZe23aA3M7kM22aoagn2KLKEa8/7nMibF6sACDDiA==
X-Received: by 2002:a17:90b:3fc3:b0:313:33ca:3b8b with SMTP id 98e67ed59e1d1-31aac44bb6fmr3012434a91.9.1751617077889;
        Fri, 04 Jul 2025 01:17:57 -0700 (PDT)
Received: from smtpclient.apple (awork062145.netvigator.com. [203.198.28.145])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31aaae40a75sm1532026a91.3.2025.07.04.01.17.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jul 2025 01:17:57 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: Allowing "/" in the name of a git remote is a strange choice
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <aGdi6GRbI6Txm25Q@pks.im>
Date: Fri, 4 Jul 2025 16:17:43 +0800
Cc: Junio C Hamano <gitster@pobox.com>,
 Per Cederqvist <ceder@lysator.liu.se>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AC45E9DD-5E2B-4DD5-B2C4-9276C70D05A6@gmail.com>
References: <CAHx6-Um1dq0xJ-RkW+qXe=sEa6JGViSJxjzNw56u55DHLYoT2Q@mail.gmail.com>
 <xmqqikk8bltr.fsf@gitster.g> <aGdi6GRbI6Txm25Q@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Patrick Steinhardt <ps@pks.im> write:
>=20
> We cannot just blanket-disallow this now, true. But shouldn't Git be
> able to detect this conflict, similar to how a user cannot have both
> refs/heads/branch and refs/heads/branch/nested?
>=20

I also find `git fetch` works fine, but check out remote branch detect =
this
conflict

$ git branch --set-upstream-to=3Dorigin/chat/master chat/master

Gives

fatal: not tracking: ambiguous information for ref =
'refs/remotes/origin/chat/master'
hint: There are multiple remotes whose fetch refspecs map to the remote
hint: tracking ref 'refs/remotes/origin/chat/master':
hint:   origin/chat
hint:   origin
hint:=20
hint: This is typically a configuration error.
hint:=20
hint: To support setting up tracking branches, ensure that
hint: different remotes' fetch refspecs map into different
hint: tracking namespaces

