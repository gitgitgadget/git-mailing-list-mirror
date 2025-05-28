Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3CB1F37D3
	for <git@vger.kernel.org>; Wed, 28 May 2025 23:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748474414; cv=none; b=LMRJlp5ODAhujPE8HvD1XF6We7k/TblYW8VLq2NaPtyJ3adsj8PFou6x1YqKeFfkvwoUDvny4s0bOFcW6Ifbg1Vk815OJDuUIkpCRms+QC+5Kk6YsesvwLgBq7SANmb6cVKg9kokOMLf0Exy32CmVnpE2u81Bazs7PJRA3JCb7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748474414; c=relaxed/simple;
	bh=r2EdR6GF11zWeztH9M0RQ57tDOAJL65VFjW/3mGue/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YF9iaWcoetBVdSl4vDf+Fu8mkj5Y0Lw6oy8opnwUNCmzOoAcgpCAIiPaX6S79o8opAB83C50W5szeq0ek9Q8SXoaXeURlgDvsPeM66bGzGJLX9vpoOzb8oGtJTkrIXIVAzg0lSN7wgq5L3Sukl4zueCZ6TRUviGzd4oFXkFAeMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=q3cHtITG; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="q3cHtITG"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e731a56e111so301573276.1
        for <git@vger.kernel.org>; Wed, 28 May 2025 16:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1748474412; x=1749079212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zliwixFIngOr9x6kqPqTPOP9BAntX508+Urk0NPZ0Ms=;
        b=q3cHtITGxlAiBL9PsJ1ZADe/9ODOmWxK+mBW2ekk7wJSgYKRgujAgNk/BgiHITieNy
         XOa/kH49q6ug1MaZMCF6iOw7wFPj8G1pLNCfcy2Hh+1ZiWYd7GHnVGEr6MCjin0eUgOV
         66pWIG13vRoPYjWnqSNA9QY7dk/MJ4on+rERE2VJRY6EnoW+HXdGUIbuyqbF4uUVNLBu
         7vRaO57Cg6u7mPlHcef3UGCWJXrPUAEPaIOMuCVMaKcOBzZs8TnE2nnuKgnFushTUtRf
         cP/3F8XghumO5tme+Ex07UxxPoRCU7ec12aYmUpNAimoXsKc0tKnCnUVgd+KKQooCEwt
         N4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748474412; x=1749079212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zliwixFIngOr9x6kqPqTPOP9BAntX508+Urk0NPZ0Ms=;
        b=G0ZUHBUMkC27DoPATFI/jH6n4VYVWYElcZJfW2t7lO5P1hz5Z/zWEpQsmBIO0igM+N
         XQib1GQYW/NjWwyunJbIaMSSlbsYqugFtfahfooPgJ+Stx/Qqn7qHHybDqD/KBPJJW5z
         tXcBrDVQ0IT9EBgdSqCzbcwvLc1iXlyYfnQd+nHsVs4C8IznnyztESsOgWMhfTIgpY9u
         4weIkeQdBLPD0RjC+rg1KbJ5ESOabC2vD33mPy3cuT9nI+PBbKU5dWa2UQzXcMF08v0x
         ZJVlee/D7tV39nKffe2apZfuZioeYqnkdxOPrkstB9NXoOq9qorBoCM6IRzotYVoWStp
         GYeQ==
X-Gm-Message-State: AOJu0YwNzcztORUTgsZGzuYuJvbpcvYyhCcu9Useak4NU1KfXm/Hkule
	CA5EC2nQKNCjtqmwvMoMfoa6XQ10+nW2Ef5p7KX86iuwPGER7uwuZWIu7BUNEcoFolGpYfO7Wb/
	vPMv6
X-Gm-Gg: ASbGncvK436QHGrioZt8BolqbFIBQnCPz53s64jbvdH35Xbc1cKzcCoeA5kYghht1FA
	tDApIo406j3tfGizN+17uG+Ac5fjpd1d87NhT+MQ/87p+6+ZV4zo0SEIMgj1ADzZOks4lByvYg3
	4kGIa9iRQFl9FFUgnjcZzTTqsxPbA8e7sGMqjFuzx5+p/oaBB8XrJ/nPzqZErv8lFqz/CHwNns/
	80bQnFEtq+ZV3IlZRn/aAIM/At4WWuxj6FuQs14/S7d/2i1X76cqGbXyNrTIZJwOosCvt0nLRs3
	d8JvQpIyfiSPHkbos9uG4OoRzAz6Rh+1ojK1bcotqL6BOFBYmBOXwUStl1LZnzC3TXRGOrZZ1DF
	b+IchF3pH0vjWShn23YRIzUs=
X-Google-Smtp-Source: AGHT+IF68V+SaGMZOG0AHFGmR5LsInxavvQAiLs8CqrictwUiILt4pPfdi9TxVcYLgSP7CFr7l+U5g==
X-Received: by 2002:a05:6902:f87:b0:e7d:c5dd:78bd with SMTP id 3f1490d57ef6-e7dc5dd7d19mr12593480276.43.1748474411704;
        Wed, 28 May 2025 16:20:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e7f733cf0f8sm32889276.21.2025.05.28.16.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 16:20:11 -0700 (PDT)
Date: Wed, 28 May 2025 19:20:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 1/9] pack-objects: use standard option incompatibility
 functions
Message-ID: <f8b31c6a8d788fa53f7b39fb9ae4b61ebfc882b9.1748473890.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1748473889.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1748473889.git.me@ttaylorr.com>

pack-objects has a handful of explicit checks for pairs of command-line
options which are mutually incompatible. Many of these pre-date
a699367bb8 (i18n: factorize more 'incompatible options' messages,
2022-01-31).

Convert the explicit checks into die_for_incompatible_opt2() calls,
which simplifies the implementation and standardizes pack-objects'
output when given incompatible options (e.g., --stdin-packs with
--filter gives different output than --keep-unreachable with
--unpack-unreachable).

There is one minor piece of test fallout in t5331 that expects the old
format, which has been corrected.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c        | 20 +++++++++++---------
 t/t5331-pack-objects-stdin.sh |  2 +-
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6b06d159d2..20dd870bbf 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4651,9 +4651,10 @@ int cmd_pack_objects(int argc,
 		strvec_push(&rp, "--unpacked");
 	}
 
-	if (exclude_promisor_objects && exclude_promisor_objects_best_effort)
-		die(_("options '%s' and '%s' cannot be used together"),
-		    "--exclude-promisor-objects", "--exclude-promisor-objects-best-effort");
+	die_for_incompatible_opt2(exclude_promisor_objects,
+				  "--exclude-promisor-objects",
+				  exclude_promisor_objects_best_effort,
+				  "--exclude-promisor-objects-best-effort");
 	if (exclude_promisor_objects) {
 		use_internal_rev_list = 1;
 		fetch_if_missing = 0;
@@ -4691,13 +4692,14 @@ int cmd_pack_objects(int argc,
 	if (!pack_to_stdout && thin)
 		die(_("--thin cannot be used to build an indexable pack"));
 
-	if (keep_unreachable && unpack_unreachable)
-		die(_("options '%s' and '%s' cannot be used together"), "--keep-unreachable", "--unpack-unreachable");
+	die_for_incompatible_opt2(keep_unreachable, "--keep-unreachable",
+				  unpack_unreachable, "--unpack-unreachable");
 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
 		unpack_unreachable_expiration = 0;
 
-	if (stdin_packs && filter_options.choice)
-		die(_("cannot use --filter with --stdin-packs"));
+	die_for_incompatible_opt2(stdin_packs, "--stdin-packs",
+				  filter_options.choice, "--filter");
+
 
 	if (stdin_packs && use_internal_rev_list)
 		die(_("cannot use internal rev list with --stdin-packs"));
@@ -4705,8 +4707,8 @@ int cmd_pack_objects(int argc,
 	if (cruft) {
 		if (use_internal_rev_list)
 			die(_("cannot use internal rev list with --cruft"));
-		if (stdin_packs)
-			die(_("cannot use --stdin-packs with --cruft"));
+		die_for_incompatible_opt2(stdin_packs, "--stdin-packs",
+					  cruft, "--cruft");
 	}
 
 	/*
diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
index b48c0cbe8f..8fd07deb8d 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -64,7 +64,7 @@ test_expect_success '--stdin-packs is incompatible with --filter' '
 		cd stdin-packs &&
 		test_must_fail git pack-objects --stdin-packs --stdout \
 			--filter=blob:none </dev/null 2>err &&
-		test_grep "cannot use --filter with --stdin-packs" err
+		test_grep "options .--stdin-packs. and .--filter. cannot be used together" err
 	)
 '
 
-- 
2.49.0.640.ga4de40e6a8

