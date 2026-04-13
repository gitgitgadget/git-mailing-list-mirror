Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CBA1C68F
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 23:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776124624; cv=none; b=Cz6SRbNLMoke3ZjyHJ7poTh1rtyVyOjx9PSWwvxYpt963UKR0MsCZhydk9fgIbYI3DCTN306f6zH804L5JVTXIuye1IidaVRg9zQDDh2iakaBrfAJRHEhuYL7qD9hO0fChd+mry57FqcaeIef9v9gfHaejXh4qzGQgKuAit1/9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776124624; c=relaxed/simple;
	bh=Z357isrKsgFoRxaW9kuMFUKbnVI0EhQUqu19Uf4EjE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Piw6xFhOtMZJiZnipeNIBK9tfdY5Tn6Fxf0pLRWNU7t/NPskyujsXokLmZTP4S0K3c0/vmUp9yK+tDExcQrhAqDgfbCWub/6tMXww4Pv9hg1Fm781V5Allw1qUDmMgBSOBYZUjJq2kQOha4R/qt333BuymHQkUwOqqZrHvgEuYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=RNg9SVq0; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="RNg9SVq0"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7927261a3acso47100257b3.0
        for <git@vger.kernel.org>; Mon, 13 Apr 2026 16:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776124622; x=1776729422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IvT1NiPrpp+RJgKHbXtVNdZR1VPGCdc30aQetNr45kw=;
        b=RNg9SVq0U1rIDxysFYjfLhCzK6X39BwqIbSyTkr3FgZ4iEPOkK7QSstwQGrCMVjlij
         FdLSTB7UQjdMAeQTSgM0fb/BPCXgfN7qzr5Ws4yyL7y+XNHMPuQQAP+7DoqpYgI5B1Tx
         nWb3/U65njiz9AVkZFqWv6VhmblZ7PxcMqKGtS/GI30vSvZm3kODKcxUF1yTJ/+RsLzJ
         qiv4B8UiL7nB/4/R0yIF26lCaqXprXWB02qIAFBpWbiBjECR3g5uVIK/DWNKm1cUDYQB
         rQiHvqzM6sVnHIDJj1wlBhJ5gjLrTX28xkxD5m1PqvUdbWyJKJhxrsfRKqwqOGgEnOP+
         L/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776124622; x=1776729422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvT1NiPrpp+RJgKHbXtVNdZR1VPGCdc30aQetNr45kw=;
        b=nbdLwprkfad4R9On0cD18opXIAqeEFNQb3kAuBchQdwrSP3vx89ldyxlGIS3QJD2jO
         dDIo0M8Fy5jKlb+xfld+wJxtPy7IBoGGKXFnXjk+uBn/o7VhnmJRb9BMeutww82Ub8XC
         +64WJUsG2fIuzu0u/wT03BPhA4hA1+AmGcFnTjvT30jOBqEFs/yeFnaDXHyaS3G6VXUN
         f3ugQJwlHYfDRclp285Zt/B/HJziIymmAwLsYGKplxJRQfy/6nXqVU1/4no1UCqz1TX6
         HBp8+pZLKK+B0lm/4nmRVQPQ7rOIkdD3O/Ih8sH/Ild1J5R1H2n0DbGFgsMp/jboauHw
         o88w==
X-Gm-Message-State: AOJu0Yxa8sp3Z+uEoHGitAmS70Vz/5NUfcWZ3pKYk4Z73ve7OPVaMi3g
	BnYVs2POio+xVIqi+CMXpIx4H1RxFRPQQdUwlY0DLbi0veFO4b31oQM0qpVw25llDxA9lS7m++E
	Q5YzllcY=
X-Gm-Gg: AeBDietRjxdnXGNVWo2woHXwVTc0E1gXRpMqvWzOGpiuFcqzUfEMxlDg7E2yV/napJx
	4FUSeaxo+VrpydrBinsA+yVQHzcCzihrwmpubtQdFlM1aOgAv/Nf6n76uf8MiqH1IYoDL43FX1K
	+GNknvrbDSFalMYBZ/YHNdQ+Xnm6n+c+gwC3EcAG2i9CHbtdiM7nvwjfOmlGM2xWpPsovrQZf2C
	wUNGx6NLqsNrlXaRL7qPpwn3fJfhox7pZJ6ne8SR++iiwuDVU0GCZ4V6UG2TI/N4SYqsttjRUXB
	DhC4yZumVxoJzDUffnsPZ6hMrw+zNyHjx60LMX5k3eSF9H/w5eVupZmwou9cT8MDBje3tQsNY8O
	KWLWt+NpjeaqW2IP7Q5CUw2MpPZkQXVrXVNwReM/+SG80z/sTwza0ogqnoav0f/L5ufPM4LcjT2
	KjLW+J0cZrynOC4YkgfP3p9nTLAYon00eQ+CJxjCl3qpbhZarkrjNVfnCPdovXfLkorcA4oA4IC
	qNbD9WwjxkcAalJYZGESXAOqeQ3aoCJKQvLlL98jDAyZxf0GjOwUVchLFL5Mfdk/1zLOKIFssHV
	tCH41Fmwhr7m+udL4I8euep0wvE=
X-Received: by 2002:a05:690c:6604:b0:79a:c7f8:d9a0 with SMTP id 00721157ae682-7af712830e8mr173019127b3.33.1776124622328;
        Mon, 13 Apr 2026 16:57:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b14dd29c7esm36148627b3.26.2026.04.13.16.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 16:57:01 -0700 (PDT)
Date: Mon, 13 Apr 2026 19:57:01 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH 8/8] pack-bitmap: prevent pattern leak on pseudo-merge
 re-assignment
Message-ID: <8f4e017095210afb79e547832f50bc8fb51017bc.1776124589.git.me@ttaylorr.com>
References: <cover.1776124588.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1776124588.git.me@ttaylorr.com>

When "bitmapPseudoMerge.*.pattern" appears more than once for the same
group, `pseudo_merge_config()` frees the old `regex_t *` pointer
but does not call `regfree()` on it first. This leaks whatever internal
state `regcomp()` allocated.

The final cleanup path in `pseudo_merge_group_release()` does call
`regfree()` before `free()`, so only the intermediate replacement is
affected.

Fix this by guarding the replacement with a NULL check and calling
`regfree()` before `free()` when the pointer is non-NULL.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pseudo-merge.c                  |  5 ++++-
 t/t5333-pseudo-merge-bitmaps.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/pseudo-merge.c b/pseudo-merge.c
index 75bed043602..22b8600d689 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -150,7 +150,10 @@ static int pseudo_merge_config(const char *var, const char *value,
 	if (!strcmp(key, "pattern")) {
 		struct strbuf re = STRBUF_INIT;
 
-		free(group->pattern);
+		if (group->pattern) {
+			regfree(group->pattern);
+			free(group->pattern);
+		}
 		if (*value != '^')
 			strbuf_addch(&re, '^');
 		strbuf_addstr(&re, value);
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index 46e8e6a8ea1..34d432ce76d 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -662,4 +662,34 @@ test_expect_success 'sampleRate=0 does not cause division by zero' '
 	)
 '
 
+test_expect_success 'duplicate pseudo-merge pattern does not leak' '
+	git init pseudo-merge-dup-pattern &&
+	test_when_finished "rm -fr pseudo-merge-dup-pattern" &&
+
+	(
+		cd pseudo-merge-dup-pattern &&
+
+		test_commit_bulk 64 &&
+		tag_everything &&
+		git repack -ad &&
+
+		pack=$(ls .git/objects/pack/pack-*.pack) &&
+
+		# Set the same group'\''s pattern twice. The second
+		# assignment should cleanly release the compiled regex
+		# from the first without leaking.
+		git config bitmapPseudoMerge.test.pattern "refs/tags/" &&
+		git config --add bitmapPseudoMerge.test.pattern "refs/tags/" &&
+		git config bitmapPseudoMerge.test.maxMerges 1 &&
+		git config bitmapPseudoMerge.test.threshold now &&
+		git config bitmapPseudoMerge.test.stableThreshold never &&
+
+		git rev-parse HEAD~63 |
+		test-tool bitmap write "$(basename $pack)" &&
+
+		test_pseudo_merges >merges &&
+		test_line_count = 1 merges
+	)
+'
+
 test_done
-- 
2.54.0.rc1.73.g8f4e0170952
