Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9367E30E828
	for <git@vger.kernel.org>; Sun, 30 Aug 2026 20:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788122922; cv=none; b=laDOlaWIqAS6qHRxdfJtc0YBLrwEdX5VuW66ynRyTWVUnYt3ulcIMJzqKwLVzoVONkiL95lre4MytuY8yaPewG9al44bsrX2YEDZz+UH9uamI6VgOKkH/VnEaOH8UcNN3gidhVNwt0/bvtLfL9uwmdhd0Q/6UbQKU6f/JmUgjkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788122922; c=relaxed/simple;
	bh=9fOKEHxvcqyNDycSbcgN3L2rWfrP1sLM7oH8o5T7VUs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxsI9++ERgfHQOQox5krt8ARe/PgkYD38QfPRoU0wN/q/xgz7J0FfgJ4jcoro1VGJii2ZA/f+QzHjgJ2AV2ZBWNL5bJFWpfAdELAC10WWzwraiswvwfmDLJZNuZjwVvlXmj7g7fdixMsFtNIqjCDEf9rZg0R5c7TjTFsZiiuVyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=m/TUV3Rj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mPZGA5y5; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="m/TUV3Rj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mPZGA5y5"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id DA92EEC0141;
	Sun, 30 Aug 2026 16:48:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Sun, 30 Aug 2026 16:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1788122919; x=
	1788209319; bh=w1YCSaBiXuZlIv8ea7IHcfxCBrqtDESa/nCwyGAe5SA=; b=m
	/TUV3RjIWaP7AP08NaDm6YlRtsYmPgESqgRh/if+PWRd6TEEmmu9CkvlUIe2NIkP
	QhmviNHTAYR041/o3iPGreUoOenw9QRCKEFgCMHUN6ZlRK3kziqi5EeKWPdkTyTq
	A2/BSEvyXuYmkWh1WEWFoyUK28iLJAn0Xhn/dFd2ySTl1ia1u/EfAA3/4fvJT2TX
	o9V3jyvFKxh7seK/Tuat5NtZC2uDF6DiebH8nnif6uQTw/kU4gOHz+Iq8Y1hqho7
	EzmEJA1BqITGYSNcyfLQ7/g3RPuP4nhHpOPAFGH5kLyBFJQzknviflrGBtO+9rjZ
	5sZA7f517lztQcl5uC7vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1788122919; x=1788209319; bh=w1YCSaBiXuZlIv8ea7IHcfxCBrqt
	DESa/nCwyGAe5SA=; b=mPZGA5y5bDB9ihdnHUhPmM6F5gihSggUemSNGVId1Er0
	sw8MXYH9Ov44Cyp3Nr1JdeMzb3jjGq4TF0Ud6XuEPoZ7vFcta8i+MWd0jBltY9fI
	MoQ3qH+TUwwI9LijW9lFMxE1dy0Kg32/n6Q585CKjhFD1A5NWwyk+o5fqipqXZ48
	gydcjBZoOFY22vviggkTy+uUU2YrWZ7lnaWqwE6JAgClPmg0y5sCxL3bq1GHuodw
	niXC72a+JkpNKB4H8NDQ6yjHbzjqXgGOYMo0mjJwioL6IBKNLaRqTn2eSWD3L9WJ
	rL3Ga31C1on0wSWkxfgwipEgMs7tvunHIi1T1qXqPg==
X-ME-Sender: <xms:J5eUaukUTz8wMU2y6yRCALRGKorkC3T9LXTgWARAcsnArTBaujPa-A>
    <xme:J5eUar3c1C5Ad8z10uD3jkH6ekg00eAzb6lEofYvwcupVyU_xxwg5vq2fpAuhpggW
    26EQg6K8Zc8riZQMXhyP3_ZrteWopvgD0W1kn-XK9ciBtCuhqFyD0w>
X-ME-Received: <xmr:J5eUaqTAeMffdf5TqeUJIoPLLzdbcuqzgbOhUUYOPGa0nvq0nuUte9zQmPPwG-eQ3if_IBPLRLUJN_pjPgMoQLXUlEI7fsSXXw>
X-ME-Proxy-Cause: dmFkZTFScx5N3yID/Wd8piL81iio/vbFBvkFUjI0kIswckuEWS4J5hDifEykfqhESoeOdC
    mwVC8gsuMoEHcRCa0lvsSozaXSelQ6CrY0zT742PYgh1E2l/nRGebCx4/z1qYDE67jEG39
    /B2iVXiolehkRkNhZgPNwdXbXryA2vLv8f0n8e9ovVR6aOgUoOuueTLTatZkiWO+ay2+6r
    c0lcpVsTuIoMHKtwg2MuyTGIZdu33aW/DIf85hVtEgSZr+eNkyWfTuwnHkUaE19zISEs6P
    GdP8ByQrI20KvDmh30LXRH/4yC8jlRNe4SFbibbt/pnsMtVQm6k9k69VKYlig4q9SCItYd
    UNMjqUGjz74YsB+7mbViTtKYU9aF6L7x3pA0OUrtsJWEGCiTicnKpuLMkO4OOEiVQT8Ira
    s6TZ0C2Fl9IFoCaKzO6+Vkfy14wTCBi4phAgegXrzFiggn7yztAU8TJ0ziBN5sBghL3veN
    74iLnWFVq/lXB1MxAWCcQVR8UQH4CBsN7JBSnkL7JG8tpA10bqGjl8jRKH4nwmf8XFSffU
    HExBV04Ukhs7ABwKZOvf+z2vdJaIXl+kxEuOZKyNa66lT26GxqWfR3w9cXm5tpoh7DpfHh
    TdukT92pOc5s0wz8ijoZOFAeMwm2b45lyBrJaXenr1etclQQwBdUUZRjg8nw
X-ME-Proxy: <xmx:J5eUatumh2JQgyZE5g06cdyeHV2KlHNH4Bot6NpZHUDXOQZjn-l4pQ>
    <xmx:J5eUavZKVXn_s1tBXDPlCllpfvV04gOWoGohtnYEX_a3YZNT-f9sbg>
    <xmx:J5eUaivaCVdrwBEP38S8tmMxi3rdh4-ho__GZPCj3db051iaEODWeQ>
    <xmx:J5eUahE5bS7rjfDbYm8iXZsIrXWNpp6nQZCexW96FYGMkexzEZh5YA>
    <xmx:J5eUap_LhfC65isd9Y2WBElQKiCTUd26vj9nIbdx0bgB4MzPk4VqDp9G>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Aug 2026 16:48:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 2/8] checkout: validate new branch name in checkout_branch()
Date: Sun, 30 Aug 2026 13:48:29 -0700
Message-ID: <20260830204835.1040408-3-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-884-g76cf8659c2
In-Reply-To: <20260830204835.1040408-1-gitster@pobox.com>
References: <20260828225206.310500-1-gitster@pobox.com>
 <20260830204835.1040408-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In checkout_main(), new branch name validation is performed before
dispatching to checkout_branch() or checkout_paths().  Checking out
paths does not create new branches, so this validation only belongs
in checkout_branch().

Move the validate_branchname() and validate_new_branchname() calls
from checkout_main() into checkout_branch().  checkout_paths()
checks and fails if '.new_branch' is set before doing anything,
which indicates that this change is safe and makes good sense.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 774e4fd5b3..14542626e9 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1734,6 +1734,17 @@ static int checkout_branch(struct checkout_opts *opts,
 		free(full_ref);
 	}
 
+	if (opts->new_branch) {
+		struct strbuf buf = STRBUF_INIT;
+
+		if (opts->new_branch_force)
+			opts->branch_exists = validate_branchname(opts->new_branch, &buf);
+		else
+			opts->branch_exists =
+				validate_new_branchname(opts->new_branch, &buf, 0);
+		strbuf_release(&buf);
+	}
+
 	if (!new_branch_info->commit && opts->new_branch) {
 		struct object_id rev;
 		int flag;
@@ -2062,17 +2073,6 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			die(_("you must specify path(s) to restore"));
 	}
 
-	if (opts->new_branch) {
-		struct strbuf buf = STRBUF_INIT;
-
-		if (opts->new_branch_force)
-			opts->branch_exists = validate_branchname(opts->new_branch, &buf);
-		else
-			opts->branch_exists =
-				validate_new_branchname(opts->new_branch, &buf, 0);
-		strbuf_release(&buf);
-	}
-
 	if (opts->patch_mode || opts->pathspec.nr)
 		ret = checkout_paths(opts, &new_branch_info);
 	else
-- 
2.55.0-884-g76cf8659c2

