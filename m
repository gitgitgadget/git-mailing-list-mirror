Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC5F84A2B
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740577797; cv=none; b=DFYpWQ2n8qi50ZW4/LwazMDVjUtOSTnPYVObPdVTIszlBDbuB+fUiQ5/pKv5FJyg5U0i5vmLGYG4T8Vurv/tCC3fg/0QprOt1psfYi5R8/Lypd1Fn1AhOOuWWXLSLJuVrCdMbemh9yMpajPqFAHKIuGrtPeUzdlgO2ZSnoUAPyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740577797; c=relaxed/simple;
	bh=9hCCkJ+oO+v030s9XZReTLgv95w22u/vH/zWWdvw5Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyxbmLaeImUNxh8YKLrhyPD6icx5gwD8Gw9/DG0UOj7BmJw5ZId9Z3jJY4G9spAebB2iTq4ls1WkY61DKTvaqcOC++pYFu6fyv0Q7P3E99BCj0+W5cMuJ0oPAUWQN+0L+kPaofsnjd9FxGGbsi7F+YSFjMuiljO8B3C/M8x3ZL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AX0pGLZ2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AX0pGLZ2"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22113560c57so52904565ad.2
        for <git@vger.kernel.org>; Wed, 26 Feb 2025 05:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740577794; x=1741182594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ELSZTUjJoWvdKhri4SRQIotqUgncELf7FCh1d37h7C4=;
        b=AX0pGLZ2//YQONFkPJWNg91Wgi6Ie15T7T7W16z0rUZ9Ik2CMpadmhqD3nuSoJkOHZ
         m4qThXkXp4JRiTgR4975wNI97YNhe0L5JpWo1uoIIphqRwJXKB9S2wk8nIpNloaNF61R
         gN60kLyFCcnOUMsGF7wwV5rLaGP2uKljuCoOq5EaAZ4QuCq5anvA9bbJTqDDIkwrP2VN
         Q0i8BteOLPgfIPdxAx4GXj80LMCywSK9XO+vsJX8iFaQbYqR/siJE5UETSySOLPa+4iW
         n2XPTIIFx5jbQaM/3EZojG3gVJI38kABo0rcWfElmbFYFUrkTVhhLVsw68lJpiqFv1Pe
         Df0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740577794; x=1741182594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELSZTUjJoWvdKhri4SRQIotqUgncELf7FCh1d37h7C4=;
        b=PmEF+w2Xb5+zIeBaw4AlKZzKOcgKqvDPUGLLYtlexd4JEa3Mzx4udWxJLQ8Xw55lMt
         LeXxPose5GP+9Cp5Y13LejxpEyf8caXJy1iIZdtgv4gHed7Dkauo8jr3qq4o54Y5U6JL
         lDkR/3IbL3Qkxy46FTzdE/EL/CQW9fo9ZpS/doCX1ndKbnSuM5ORU/BM3ZMVb1T3Tozs
         9iEEEpTotMQNxHr3KA9l6pc2FqqHwzn8XGwr5GAagd+mrVX9TrLmHG9SIqo35VBfgwaU
         khZea5nf777TfRtBaRPq44kLGwdkJGZMsKGRiTL+7kwMrGkgjq8EGT0w+VWtfFuuTs2O
         LLOg==
X-Gm-Message-State: AOJu0Yy4N2IGy4rob8ltj1jrRtctds98CD7p4wmqUSOB4GzQYOKY3lmK
	dHaa2EOvvDrKT8LW3eskJlThXHIZ0fYguuZ/OBadVAVzKFSznwtwMsiWdA==
X-Gm-Gg: ASbGncsNe7RxJXl30MRYSE5hOWKSaPCSJc8FCvhwBF0oecwBdd/4WX8oaLtoTbT/Ho+
	Yeip84rdnAz6WCQj9890qtJ2JXzrGB7tDajvvQjcsWiVv+u4iO+fUFzZ1jCen/crhymh4eq6kTQ
	tujnUonuwJE5KBRNBhrv1rJERuJs/kdCK3nSKN+ndZ7rB5Q2fw/+/5eJGoH+NOThPlXxPAaCUyX
	YXHH5keeLHLWbAGZYVfO9NwC3Lea1e/zQQa0uavEkTxPGuFkh0jSrOmk2O/n3N+hPJGjONFEOuQ
	eSZ6RtYKcctSs76P1gdSFQ==
X-Google-Smtp-Source: AGHT+IH1v5FygJ2osnNl+p8B8IiZpvWfvgcrwX0T4X+BVulorz5PChwW0eLwEmtRT6O2Z2IrqR6NSA==
X-Received: by 2002:a17:902:f64c:b0:21f:49f2:e33f with SMTP id d9443c01a7336-221a0ed7885mr342037405ad.21.1740577794350;
        Wed, 26 Feb 2025 05:49:54 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22334002d9esm9904985ad.229.2025.02.26.05.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 05:49:53 -0800 (PST)
Date: Wed, 26 Feb 2025 21:50:03 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 4/9] packed-backend: check if header starts with "#
 pack-refs with: "
Message-ID: <Z78cC7LY7PxEvDlB@ArchLinux>
References: <Z78bmBSrDR20GY6g@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z78bmBSrDR20GY6g@ArchLinux>

We always write a space after "# pack-refs with:" but we don't align
with this rule in the "create_snapshot" method where we would check
whether header starts with "# pack-refs with:". It might seem that we
should undoubtedly tighten this rule, however, we don't have any
technical documentation about this and there is a possibility that we
would break the compatibility for other third-party libraries.

By investigating influential third-party libraries, we could conclude
how these libraries handle the header of "packed-refs" file:

1. libgit2 is fine and always writes the space. It also expects the
   whitespace to exist.
2. JGit does not expect th header to have a trailing space, but expects
   the "peeled" capability to have a leading space, which is mostly
   equivalent because that capability is typically the first one we
   write. It always writes the space.
3. gitoxide expects the space t exist and writes it.
4. go-git doesn't create the header by default.

As many third-party libraries expect a single space after "# pack-refs
with:", if we forget to write the space after the colon,
"create_snapshot" won't catch this. And we would break other
re-implementations. So, we'd better tighten the rule by checking whether
the header starts with "# pack-refs with: ".

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/packed-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index f69a0598c7..3dd3fec459 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -694,7 +694,7 @@ static struct snapshot *create_snapshot(struct packed_ref_store *refs)
 
 		tmp = xmemdupz(snapshot->buf, eol - snapshot->buf);
 
-		if (!skip_prefix(tmp, "# pack-refs with:", (const char **)&p))
+		if (!skip_prefix(tmp, "# pack-refs with: ", (const char **)&p))
 			die_invalid_line(refs->path,
 					 snapshot->buf,
 					 snapshot->eof - snapshot->buf);
-- 
2.48.1

