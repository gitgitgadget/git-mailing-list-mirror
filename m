Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169C911712
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 05:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754371878; cv=none; b=Sl2MDDXSbNKG+n/46uhIK7wGsDQfltNh5fDOJXV1UQYAuzceOTJqHXLmb/G+DkyBnpbjl0NXzq5VUduZkt3XcnE919FZerzSMbPuKpMJD9NjbQwB3xHJOpDctt5V6mBH9Z9EaCCoDgqulWblQtR0iqQn5wgY/fYdu39Zd0zJ1Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754371878; c=relaxed/simple;
	bh=AusXxe51GzrUayOGWd8PnoTEG9wnrYZm/T7H74ggtOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRLpgBHtBtAKUPmKinyT7YPSJC/b+2tprJaCNzJWLw0BnAtZOxhYtlEv7+bO2lzyY6kvQC9cmimHFj7APs5OtzYjoBApwNpvFToSEATtHmmvtE68MtIIJkY283CXMBQCImJDQNX9R4110mLb5FoZaJ/3Qf9snrNT745+t+nGiIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZLjp7oj; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZLjp7oj"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4243715fb0so77564a12.1
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 22:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754371876; x=1754976676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=el5mZvsJrvIkVN2y52MvTyTqeZw2T0BS8Z3OUxTAjOM=;
        b=LZLjp7ojkjsfMEyeP1BrGYYwUjjguCh3CL6gaeQuFWd+Q0PEPZPG6ekZk1EMihchX8
         714vKeKiL0CEBJY6yApc5AkTPDSPmV2epViA1zQQ+c8A6vS6k8cl6EUi14pMfwiPapym
         yPF+MgFKHHo56UHYYOS8gzhlIpvsAkI60GeR4nqMZ8ROtaH75RIKdNPZKe8W9y6tIaDG
         FaEaNTnnOXsxzkEqT8Z8XzkGVsXPUfhhUlYM/xBmWavfO4m0pDddCGBvNo/CB2xG1iIq
         qufazhvSUWA/9l8GM+3ugjEEEfI88KHkKyj+4fCCizSX0Digs0Rrweg1yZk3K77YE2+E
         cSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754371876; x=1754976676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=el5mZvsJrvIkVN2y52MvTyTqeZw2T0BS8Z3OUxTAjOM=;
        b=fyOOoxAsfQnDYsG3Fpqgcsj1+ATsn9VmdNOCEVO99b3oJj+lyQjEFIWhVoMhcCGszH
         H/OfmpkHwZuipc6tQT+hjzS9hv0LxSuv8BTYjbQQFS/f34kROk3AWpVblfigugAbERxu
         zZioM94+K88x4KyYFgrWuCJX62NXyG5LCU4TNwB1aKo8ndGSIVPPQZ1tp8JROS18w9np
         T5WE59GwxnPkxY8NMUxV7elgXp/cHIC/mZI/cdnDGp7PcfjEF3WBQrmFkJXiMWkq+iy/
         2anLUj/FpNBOJNaxN6ca2ac70Icfq/E2Ya6m9Yr+M8YMHoqx8Uay/Emz/pzlZUqGY8FL
         XlCQ==
X-Gm-Message-State: AOJu0Yz8Hn+ZktnE8HFIDcU5A9UzZ5sW39HRAsShFCPyXXXh0x4gbZMy
	UFwZgsG5itiT2YInQgvdazOzpUogW/oFZmL8a9YNg/kih32qEqpCnHFfDP+9Dg==
X-Gm-Gg: ASbGncuVCrjhrQZlBX8WK1H29rL/NH0+SX5f8IHwp0yp4yhsMLQwLdjk9J7K3LkfNuV
	fD/IGjadaFiZZntlJ2Vqla7N1Aana+jvbvKhPfEqcBE1nPyZ5sERLt63EOCtE2LtI3kAU7MQa+B
	Wpbn9LTe/YNajWwygtIfQpnRdUtSjHnmFEMfr17qlAvGqF8HyiK0sF8R7J2P+YR1jP0387K2Oru
	2gUscuTiRtQCL5+mZNAgk8k9ZHPb6lnpx28jaBhQsEwmyw1L7DZ2kEyPMNQpAfaNjOTErw8ZOkA
	bkLC5IET0WWe+NLx9WhRhWZ70h+GJ3+mJCTCP0/EcAbqOV9dqtGpsAL/yShAzGs4txzMjmOEC+T
	qBjqhMDMK25trM7IddZWTJbJIM+8s7Q==
X-Google-Smtp-Source: AGHT+IHI/cG2OXShmZwLieiOn/j88RXHaEW+deHbFfiiEP+YIdGOIg51dTiCnZ26dcdwLxmDDpF9/g==
X-Received: by 2002:a05:6a00:4804:b0:76b:f23f:65a4 with SMTP id d2e1a72fcca58-76bf23f79d9mr3565127b3a.5.1754371876012;
        Mon, 04 Aug 2025 22:31:16 -0700 (PDT)
Received: from generichostname ([2601:645:8300:3b10:e54:15ff:fe8e:caa6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bd1d4e312sm11364047b3a.17.2025.08.04.22.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 22:31:15 -0700 (PDT)
Date: Mon, 4 Aug 2025 22:31:13 -0700
From: Denton Liu <liu.denton@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 1/2] remote: bail early from set_head() if missing remote
 name
Message-ID: <458ec588b7fe4d40f834d535b8f7d83684f9935b.1754371650.git.liu.denton@gmail.com>
References: <d03308e9474f5e26fd4a5494ec243a278e971443.1754302009.git.liu.denton@gmail.com>
 <cover.1754371649.git.liu.denton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754371649.git.liu.denton@gmail.com>

From: Jeff King <peff@peff.net>

In "git remote set-head", we can take varying numbers of arguments
depending on whether we saw the "-d" or "-a" options. But the first
argument is always the remote name.

The current code is somewhat awkward in that it conditionally handles
the remote name up-front like this:

  if (argc)
     remote = ...from argv[0]...

and then only later decides to bail if we do not have the right number
of arguments for the options we saw.

This makes it hard to figure out if "remote" is always set when it needs
to be. Both for humans, but also for compilers; with -Og, gcc complains
that "remote" can be accessed without being initialized (although this
is not true, as we'd always die with a usage message in that case).

Let's instead enforce the presence of the remote argument up front,
which fixes the compiler warning and is easier to understand. It does
mean duplicating the code to print a usage message, but it's a single
line.

Noticed-by: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
Tested-by: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
Thanks Peff for writing this patch up

 builtin/remote.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 5dd6cbbaee..f0e49a5681 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1474,10 +1474,13 @@ static int set_head(int argc, const char **argv, const char *prefix,
 	};
 	argc = parse_options(argc, argv, prefix, options,
 			     builtin_remote_sethead_usage, 0);
-	if (argc) {
-		strbuf_addf(&b_head, "refs/remotes/%s/HEAD", argv[0]);
-		remote = remote_get(argv[0]);
-	}
+
+	/* All modes require at least a remote name. */
+	if (!argc)
+		usage_with_options(builtin_remote_sethead_usage, options);
+
+	strbuf_addf(&b_head, "refs/remotes/%s/HEAD", argv[0]);
+	remote = remote_get(argv[0]);
 
 	if (!opt_a && !opt_d && argc == 2) {
 		head_name = xstrdup(argv[1]);
-- 
2.50.1

