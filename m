Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3374619C540
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097258; cv=none; b=hGjOhdswjIq2tbwWSBQGcqALX4oObPtJwae5IMVy9oSEppYC615Uu7Nuri2aY9tHcquBp76Fti31qH9r4Q7cddX2/98C3ugE8Z2q3NXVwrjnPunwQ8WRrml4xjbOR9LLXFyd5skOhLV6GZheBciP4PsIksxXq3JhlRMMIdoe5XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097258; c=relaxed/simple;
	bh=f8dQFAvazdPd7POHZgZPjYKJQGFc3m6g1PQf3H4msXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpkjRRggGXwpkGDzVA/vRy5JHofy35tXeRI3phivl1bpEAnZtouz9H4zXUKKKusGX7gGhj6WyL3E8PzPz0VfwhwGQIFbSFbKcWDjnF1AeVc9rCwdPw3mq2q0Tvka/q9cSFZetsyL/rZICjVdPmfvr46xO1qQJCFDUNzdACrZhzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=gRep75SR; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="gRep75SR"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-743ba48eb71so57706057b3.1
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097256; x=1759702056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VfePnYsqvc5ZQDNZTkN6T2bT0uCCPGas0oda/mrdeyo=;
        b=gRep75SRz7SKQD2QWJBYhShrcCvtbKeUQRmbFgdvUInHDKiL10Af3RWxJcA1KkTcsd
         PFPUHJqfh0Pd2E+7/rgP2wtTe+Upis4d2R6k5CwcqgUqUSckbkkPjwurvzUzoxsbNS44
         RKmAsWYOLLtVPIFjoqjShP2JVIdyjhCRXoJnjT2M5aNl+k8o0h094o1JNjJkBH5gMonw
         WGTVoYgMF5E9OLOOZCUVN4WB7BpU+TJM+MP8RSfQyGE932vohGTGNBHkT2m2TEm14v3g
         UyL5pJ1ku7m5TTSyoYdxZKIN/GRRCp66doyeVHCAeJLC8D6GiYVm9diDv1dSdM+UDxSy
         aPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097256; x=1759702056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfePnYsqvc5ZQDNZTkN6T2bT0uCCPGas0oda/mrdeyo=;
        b=sNGMc2aWSc83HZ7n2mMpck4+Rndoil3CG9ccI8ZJqEXXxEV93cnN6ujsKEbLMU11WZ
         xonr5dbpwCvUVaNuRuRV+5+HGi/vGfORCMJTzSYlm3+okX4qv6qedGgOULrbvnO6DUbm
         fgMNRtzl2wvp84zWuwQFBhuANFyMNNvDrEplG2fTK8bQiClMc/jHQVoOukx1Y8gAbh6w
         ZqlSnO6wV72OjBY2gf556k37FjFpWH3Bsa/fzfGD9qXrYWeeU7us4p2vjB0tKREpIoyo
         hmHpSDPfVduDSztL6f9Mt1PehOaq9jrPsbZ1hPUpq/wxyM6mZQOxA6ZvVJkuPm1NlYxV
         AAxg==
X-Gm-Message-State: AOJu0YyNul6fdvxQqK3fblmlWW0+KMGMeuo1E9ZMB2OzbzbHhSIXZVtH
	rxihwqR+rUirGwK40JSp10aPjKovr6xqFG0V1pNpI3I2/9FnpuMoM6s6Gi6MWEkn12RURr0pEsf
	7IDfBeec=
X-Gm-Gg: ASbGncvuvSXaP/KZiVoeVXCNCnlbwTGV8wlnKILqfeFGNoGmZ6xI3HS+l9adgB9yTgf
	Fyaj9v5LpAru1NUXWfiqdd0CHGeHMX9985Atl9ZFARNMZ5GUekfWUX1Y4jpK9CzFZpwhN0SuFn+
	Nuuy32gnhoLGYeMyc8X1Wt7V1CawThqk2xaynHAjSrdUHAxQzjdCs8gFLBAD0ovqvE8JifIM0BM
	XRAFYRacdIjGA8FLV1IAOJ/QOyohaR6dkEnqJblB69un3CJDfjmT94EeH2T8PGDhHdQqVFjXXWS
	UbKxUc1PkHnnjR/tIP8q3XHgWUO5lbP0F9Yj9u699LGi2duZmZHjzB7U5mk9XVuqBRbiVlt71x5
	uHoYKLZl+QSqPncVkh0hmXobulpJ6CEN//SiAVlznKncpjTBG245zciLHloGXSHqJ9qwW1Rq8pF
	rCNgAzEge4C1ZVfL0tPLdM34tWHw==
X-Google-Smtp-Source: AGHT+IEvW7hnnha6ZBCeNNM2NA4dSkuXZE3cwZ60yHJSh/1SMKkS8PmFBvJQS3q7PhiqLZNJBbGThQ==
X-Received: by 2002:a53:d208:0:b0:636:20c2:8eaf with SMTP id 956f58d0204a3-636dddd2be7mr6727735d50.20.1759097255975;
        Sun, 28 Sep 2025 15:07:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-eb38392553fsm2931396276.20.2025.09.28.15.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:07:35 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:07:33 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 06/49] builtin/repack.c: avoid "the_hash_algo" when deleting
 packs
Message-ID: <2f97882ace437e57e826a681db0a505052eb45a9.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

The "mark_packs_for_deletion_1" function uses "the_hash_algo->hexsz" to
isolate a pack's checksum before deleting it to avoid deleting a newly
written pack having the same checksum (that is, some generated pack
wound up identical to an existing pack).

Avoid this by passing down a "struct git_hash_algo" pointer, and refer to
the hash algorithm through it instead.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 4f08b57ddb..094f5a0cc2 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -168,11 +168,12 @@ static int pack_is_retained(struct string_list_item *item)
 	return (uintptr_t)item->util & RETAIN_PACK;
 }
 
-static void mark_packs_for_deletion_1(struct string_list *names,
+static void mark_packs_for_deletion_1(const struct git_hash_algo *algop,
+				      struct string_list *names,
 				      struct string_list *list)
 {
 	struct string_list_item *item;
-	const int hexsz = the_hash_algo->hexsz;
+	const int hexsz = algop->hexsz;
 
 	for_each_string_list_item(item, list) {
 		char *sha1;
@@ -217,8 +218,9 @@ static void mark_packs_for_deletion(struct existing_packs *existing,
 				    struct string_list *names)
 
 {
-	mark_packs_for_deletion_1(names, &existing->non_kept_packs);
-	mark_packs_for_deletion_1(names, &existing->cruft_packs);
+	const struct git_hash_algo *algop = existing->repo->hash_algo;
+	mark_packs_for_deletion_1(algop, names, &existing->non_kept_packs);
+	mark_packs_for_deletion_1(algop, names, &existing->cruft_packs);
 }
 
 static void remove_redundant_pack(struct repository *repo,
-- 
2.51.0.243.g16eca91f2c0

