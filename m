Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AF24DE711
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408174; cv=none; b=Ylhg+GPuj2/b4Hxjs0aKNty9c3qbpbEC8JPui4YT0u9aOYqSZpazJp3aC56o1GPRWa81IgTDvWIAJ5IRTIcAg2oPWia/bit0r0SN82qurgtkV06NruE/ZqMQHx7Bl8qsLpsiuCa+vCNVLq49PmdorYW3gcCXp2sH8q8Vml+9MOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408174; c=relaxed/simple;
	bh=EyAQ5+scAYS/qj9Hut/bgNACAmHQTb2M1EC7whwzaO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bAvLL7/ELpsWVQjHop+xMc6kTcYTUStxBuHckMlOaGX29OeoLlHHZokc7IQbL/emVXjAZgsZURcMaySmlxL3LWuaKSb+eVKFt9bWtRQzqLeFMvans3mgzKvQMhLZJIUNG5r4ldcNy3p0ABdtxqPEnXUW5L+q1FY2wXrqYmxQl44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gitlab.com; spf=pass smtp.mailfrom=gitlab.com; dkim=pass (1024-bit key) header.d=gitlab.com header.i=@gitlab.com header.b=Dnv1/otZ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gitlab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gitlab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gitlab.com header.i=@gitlab.com header.b="Dnv1/otZ"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48dfdd0678dso1293398f8f.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 04:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google; t=1792408171; x=1793012971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N8l6yktrgpDp3zxGyGvOK3xVcd8++eBzfgnniuRC4EM=;
        b=Dnv1/otZ0XVV/3YpkpeORC4p11ca3wBdNY8HeHrtJ4d3t9an/cS+jC6MoMCd6YyD6E
         ZO5ryG0B0P7i9kZBBeA8KJ8WhWbK9GHFQ9FOx3utu3s0ClJ7UGhE4m17VNjCzhaoO6Xd
         I/IpI2joUII/Bc7IjS3uWQGu2eLfuz9rWux2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792408171; x=1793012971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N8l6yktrgpDp3zxGyGvOK3xVcd8++eBzfgnniuRC4EM=;
        b=mgsSkjo8Let3+fl1DVVhcC/I4rUP9e2sd4qbEHNZ+twyeVLd+YbzVZXY41rm5spTwM
         GwMbl+yd58dBTQsxvPskIz9pJlKHZEBPrEeIZSeN7uSGWC8ZNrtbP8BR5+1rl4mAEgLs
         CmJa8JgvFY6TRXcEJ4MWGHBN+aAh369WxTEle9nsnl2RIUwoJZ3Mtkz/xfNOLU5sPAzf
         EWTVqmWA56uUg4+s8gkRistRlGmyiC90P9Ck06ZsK6+lwGUrlQ8T9NpBba0bNlSMDSAL
         2aSK6y5oauQ/wzVUNGafHIEMrtQaOlxzCzzm3aSdaq+WO2Z0I4siLAFTXt9GlBwp0+Jj
         ri2Q==
X-Gm-Message-State: AFq9FYIf5xfc+Tl+VfhYPO9Uwrz1fMV0jnHURP/Lw+wctIZTLX5R9Ema
	UCc0Yx5THFEwWwLATvywU5GZ37Ra82RI4CD685oBywAFwIsd6KpWia9OWIiGdg1BQnUud/ll5Kj
	oLtwPypItRw==
X-Gm-Gg: AYBFou2T4E7dlPVPIA5/fQAde4l5j/OM0BsLBLIjteAtDs1iZmzbNoHKY+3ZShNra5t
	wasikkdRfzRhapmG1BnCGwofB/Axd9FVGmWovTER1Tlt4Z6obOv9eNkhWqG5Gj+P8jjEHN88b1s
	2ZknCwBFn9WFtAsaKkvY0ume4kF1nrChjLL8sQkyHF+mAYdYBKfIgHwB7Hn9Y/V+K8FK3fgA96A
	wpG0jB3VVZB7bUXrW4ZdViPzNzbvA5U0ANoD+VLlQrepVPQ6q9Fq0yAPiw5mcy+Xp7nMMdNbe8K
	CORmhi0NoWJq2n3+eW+sUmdnV1isnRB1LaStxf5necM8+WqdTr5XNCTei6f74DG1vy9CpSQ1zPS
	lFhmOssyaLBH1owrmEu+UHqnXcKOGx2Tu1vJFWSmmS6AkLscs9JxrzzORAgjwV35cHYWP2JBLbR
	eBzvHoFZP8r8hSjdSHid4IupgRe6fSVHFiaxedkeaa8QOoktojVau2huX9wDPJFsKbSRY29K0Gq
	/ax1oI4xXXWx7FAW7bmo9imXEHLCF60stC52iBMh7M9hnc0Vg==
X-Received: by 2002:a05:6000:230d:b0:48e:1299:663f with SMTP id ffacd0b85a97d-48e1299672fmr7593530f8f.56.1792408170893;
        Mon, 19 Oct 2026 04:09:30 -0700 (PDT)
Received: from iwiedler--20220823-X3P9M ([2001:9e8:a97:4482:588f:b276:463d:6918])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4d4dddsm22208956f8f.22.2026.10.19.04.09.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 04:09:30 -0700 (PDT)
From: Igor Wiedler <iwiedler@gitlab.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	peff@peff.net,
	jltobler@gmail.com,
	Igor Wiedler <iwiedler@gitlab.com>
Subject: [PATCH v3 1/2] connected: negate alternate refs in deepening fetches too
Date: Mon, 19 Oct 2026 13:09:17 +0200
Message-ID: <20261019110918.71193-2-iwiedler@gitlab.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261014181134.56220-1-iwiedler@gitlab.com>
References: <20261014181134.56220-1-iwiedler@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The connectivity check spawned by check_connected() uses

  git rev-list --objects --stdin --not --all --quiet --alternate-refs

where 39b44ba771 (check_everything_connected: assume alternate ref
tips are valid, 2019-07-01) added "--alternate-refs" so that the walk
from the fetched tips stops at the refs of any alternate object store,
on the assumption that the alternate is already fully connected.

That only works because "--alternate-refs" comes after "--not".
cf1e7c0770 (fetch-pack: write shallow, then check connectivity,
2018-07-02) drops "--not --all" for deepening fetches, since those
need to verify the whole chain up to the new shallow boundary rather
than stopping at refs we already had. For such fetches we therefore
run

  git --shallow-file ... rev-list --objects --stdin --quiet --alternate-refs

with the alternate's refs as positive revisions, and rev-list
enumerates every object reachable from them. Unless one of those refs
happens to lie inside the newly fetched shallow range, where the
grafts cut the walk short, that is the alternate's entire history.

This is slow for setups that attach a large alternate to a fresh
repository and then do a shallow fetch of a ref that is a few commits
ahead of the alternate, which is how CI runners share a clone of a
big repository between jobs. With a 7M-object alternate (a bare clone
of gitlab-org/gitlab), "git fetch --depth 1" transfers an empty pack
in under a second and the connectivity check then takes 227s. With
the alternate's refs negated the same rev-list finishes in 0.0s.

Pass "--not" in both cases, before the branch that adds "--all" for
non-deepening fetches, so that "--alternate-refs" is negated for
deepening fetches as well. Such a fetch still has to reach the new
shallow boundary from the fetched tips without stopping at our own
refs, which is what cf1e7c0770 wanted. It stops at the alternate's
refs, as every other fetch already does. Move "--alternate-refs" up
next to "--all" so that the arguments that bound the walk are in one
place.

Add tests to t5618 that check the arguments of the rev-list child via
GIT_TRACE2_EVENT for a regular and for a deepening fetch. The result
of the check is the same either way for a complete alternate, so
there is no behavioural difference to assert on. The difference is
only in which objects are walked.

Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Igor Wiedler <iwiedler@gitlab.com>
---
 connected.c               |  6 ++++--
 t/t5618-alternate-refs.sh | 12 ++++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/connected.c b/connected.c
index 929b9bd28d..cdf103bba5 100644
--- a/connected.c
+++ b/connected.c
@@ -121,15 +121,17 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	strvec_push(&rev_list.args, "--stdin");
 	if (repo_has_promisor_remote(the_repository))
 		strvec_push(&rev_list.args, "--exclude-promisor-objects");
+
+	/* define where the traversal should stop */
+	strvec_push(&rev_list.args, "--not");
 	if (!opt->is_deepening_fetch) {
-		strvec_push(&rev_list.args, "--not");
 		if (opt->exclude_hidden_refs_section)
 			strvec_pushf(&rev_list.args, "--exclude-hidden=%s",
 				     opt->exclude_hidden_refs_section);
 		strvec_push(&rev_list.args, "--all");
 	}
-	strvec_push(&rev_list.args, "--quiet");
 	strvec_push(&rev_list.args, "--alternate-refs");
+	strvec_push(&rev_list.args, "--quiet");
 	if (opt->progress)
 		strvec_pushf(&rev_list.args, "--progress=%s",
 			     _("Checking connectivity"));
diff --git a/t/t5618-alternate-refs.sh b/t/t5618-alternate-refs.sh
index 2fb6d549d3..3c5fbef463 100755
--- a/t/t5618-alternate-refs.sh
+++ b/t/t5618-alternate-refs.sh
@@ -58,4 +58,16 @@ test_expect_success 'log --source shows .alternate marker' '
 	test_cmp expect actual
 '
 
+test_expect_success 'connectivity check of a fetch excludes alternate refs' '
+	GIT_TRACE2_EVENT="$(pwd)/fetch.trace" git fetch origin &&
+	test_subcommand_flex git rev-list --objects --stdin --not --all \
+		--alternate-refs --quiet <fetch.trace
+'
+
+test_expect_success 'connectivity check of a deepening fetch excludes alternate refs' '
+	GIT_TRACE2_EVENT="$(pwd)/deepen.trace" git fetch --depth=1 origin one &&
+	test_subcommand_flex git rev-list --objects --stdin --not \
+		--alternate-refs --quiet <deepen.trace
+'
+
 test_done
-- 
2.56.0

