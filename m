Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926071A2396
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 02:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750214712; cv=none; b=sGKWzL4kEBF78Z7/UdhuyjiUYRZXk5YmiQcCjE7NLKqyYAsyggRo3f1BVdrlJjWwdJtn0uPpgVZMObbHp8xh/UO5CDFW/+fJLNKk+V8lQrJZowIj++faBGeQ48IHkN+P/53jHvMgDE3xm83N5vAT1reHiFwxMAQ/3wnrifhIVDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750214712; c=relaxed/simple;
	bh=4ofQKZkbF+Ip9huSgI3uUhuoX3T8Czukyjl9XyhlnVE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=i5RNeEzT0Bg4x4EfBJziq2kY7ww2SeliVHnQ0U7RWMpX99lX1G7fl45eevoT73oTsu6bm2k5gJ/pr9Q/YX2B0Z1sS1pcOB/5Mv4WlELAIWRO+Rg7H3FcmIcIB0FSQSR7MnmdttnqIA8sSzB6LQdhgfRCTzwzsaL5UYTjF+3J4+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RP4S9VQw; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RP4S9VQw"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-313a001d781so5696831a91.3
        for <git@vger.kernel.org>; Tue, 17 Jun 2025 19:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750214710; x=1750819510; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baoCv0fXJmcT88YdwhraAPKLE13aMOI5PffAXHnFFyU=;
        b=RP4S9VQweftMB414oyHAN1hjpu4r5SNzuisSKZwtarUBA2Ynvz2ryRiEaRAFMK5aJC
         IWutrG8sEIvXpfemECTVzfpLj8L+YJTImXEvXxyLR7wL2LlyR92J75SdrILAWExtikAn
         EgVfd6b/63MVvAtSsKbx6jD0DRpwETTGPUhJD03quvGrGfWWvCThngAKGf1v0rEaWbnq
         dD8HbarHzQ2XBjGuNyplcrS6nmPgY9VjUA9vzE550QvMd6HvQqKoqNlGhfiDsNj5aj+m
         a9VLfnA693lw2tsTv9JoAFI8EUS6rmhARigCU7LWQ0SGWHJwQQiMJspvEwBladIZEH0G
         PlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750214710; x=1750819510;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=baoCv0fXJmcT88YdwhraAPKLE13aMOI5PffAXHnFFyU=;
        b=Yn41ByMoeYPhqMvE7Ai7Rf6LDs3BTv836+r3abcfx86kTyB9n119nWv+RSiddmCAon
         30KzxqOWyUoSErpsav4WSAsEkG1u1zCBWkzperW40SSuY6fAwGPWLq8ouMycMOFs2ial
         Jr1h6dT62SPUdMyLD+SDHYJmm1KXZuUWkMcSGXHIXSFBcim42n1FKD0LeCoZKN1V2zwA
         Ai0tpWqCW2FVhHdVBRp71tzZ1sCZe6J5jb5zUTixrryIXZcaK1j/nNTn6AW4EGr7N7bW
         DFYl93GnM/V7vk2y9su1a9QCwn5F38nEhog4NpinYz28UnWXac9FzfIiUwVYCp3eH4Qw
         u2Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ43afJaTjKPCxKpMzrse6nmVyJqKvDxROj+z30rD+jl6N5PLOlYyITrO5LZrNmU9UwXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCLywU7bhnf12kz44ht960c6rzNQk3JyWO9875MDR/GQN/D2L1
	cv8xZ7HShFOJKBl02aNbAW1guihggOASYx7yWLvPTmWiIV+Tjwj2vQRwRpzeaPKZ0AYjeQ==
X-Gm-Gg: ASbGncseF14G/UMnIhhz8lU35SUzXFqdiRrag1WFZHTl4b3QKC6HiPrW2CYE8YRlQSm
	bO5B95HXMAnmqcAuWjez0YYCEETbORvZ+cVq8R1A44qDOAHk4jw46Oy7vHkKch4wfozliFtlGB6
	qS7apy7bJlrmtgBHA2YvtT5/V7xvnbiVSCrWLItGTJ4ZoD5IDSyWMFHmyCx32N+U7CO8dmnWMkY
	3PIah/6zRwfb2vjrUqWv07DNKm6xhgGJs3tQ7vplTgxhboXndLqH5Nv4RGXbEYBx533XNPbzf2c
	cR+8ohspM/vwKiEui4eL9EFGyrkk5JoTCMiJ3G7mEAhUo92f3URgsKoiYUxyUWO7x0bMf2+CS39
	dKNM14DO5XcDiXUGlPZjHm15tLt3IOV0WN/D7qNk1Yxx7szsB1ErWo/EaTnnD8Wc4LJI4wZ2OmV
	g=
X-Google-Smtp-Source: AGHT+IEe7flcP87EjuT9o7p4IbYhoyWBK7+ljF+znKTPfamrvhnSIM7CNf6dH2LcOm+hRFNPSZliwA==
X-Received: by 2002:a17:90b:3a4b:b0:313:5d2f:54f8 with SMTP id 98e67ed59e1d1-313f1e22fc8mr27151239a91.33.1750214709616;
        Tue, 17 Jun 2025 19:45:09 -0700 (PDT)
Received: from smtpclient.apple (n058152022104.netvigator.com. [58.152.22.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deb4f85sm88649435ad.183.2025.06.17.19.45.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jun 2025 19:45:09 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2 1/6] remote: fix tear down of struct branch and struct
 remote
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <d72fb411-2e05-441e-aee4-d8a26d652fea@intel.com>
Date: Wed, 18 Jun 2025 10:44:51 +0800
Cc: Junio C Hamano <gitster@pobox.com>,
 git@vger.kernel.org,
 Jacob Keller <jacob.keller@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
Content-Transfer-Encoding: quoted-printable
Message-Id: <16C5347A-3EB4-4629-9C7A-575F60B86CA3@gmail.com>
References: <20250617-jk-submodule-helper-use-url-v2-0-04cbb003177d@gmail.com>
 <20250617-jk-submodule-helper-use-url-v2-1-04cbb003177d@gmail.com>
 <xmqqcyb2uhth.fsf@gitster.g> <d72fb411-2e05-441e-aee4-d8a26d652fea@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Jacob Keller <jacob.e.keller@intel.com> writes=EF=BC=9A
>=20
> We initialize branch->merge with set_merge() which is called by
> branch_get() and which is the only way for callers external to =
remote.c
> of getting a branch structure.
>=20
> The issue is that merge_nr can be non-zero because if no caller has =
done
> a branch_get() on the given branch, we still have merge_nr is non-zero
> and merge is NULL. I suspect you're right that merge_name will never =
be
> NULL while merge_nr is non-zero.

Maybe we can initialize each branch->merge in read_config(). Then =
branch->merge
will always as large as branch->merge_nr. Do you think this would be a =
good idea?

---
diff --git a/remote.c b/remote.c
index 4099183cac..835939c59e 100644
--- a/remote.c
+++ b/remote.c
@@ -596,6 +596,8 @@ static void alias_all_urls(struct remote_state =
*remote_state)
=20
 static void read_config(struct repository *repo, int early)
 {
+       struct hashmap_iter iter;
+       struct branch *b;
        int flag;
=20
        if (repo->remote_state->initialized)
@@ -614,6 +616,9 @@ static void read_config(struct repository *repo, int =
early)
        }
        repo_config(repo, handle_config, repo->remote_state);
        alias_all_urls(repo->remote_state);
+       hashmap_for_each_entry(&repo->remote_state->branches_hash, =
&item, b, ent) {
+               set_merge(repo->remote_state, b);
+       }
 }
=20
 #ifndef WITH_BREAKING_CHANGES
---

