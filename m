Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A095379981
	for <git@vger.kernel.org>; Mon, 25 May 2026 19:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779738065; cv=none; b=HWnRG3+Emq/PsKJqiE7GurngV6HFY+Az+tpbaJSO8uQWQJ52gJt6R6ZojgMZdR3RjFWBNxmh1oYIHnoDAx29YYdI3tWvVR6cY9ELZMP0q4YMGTU1VJEWoeb+BqQ07jqH3GlJeJ0E4UA9cm7iaLBa7ltpzEQ7RgdwMDbCX89/NgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779738065; c=relaxed/simple;
	bh=SrAp0loLnAzm9u5hPBEkDWaamFFFRF38Xx+Ub2fbaaw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dsvXnckJQ1C8Wab61JciDBbOxVHECMqBrvlnjF+W/kax+0DFTou8yC29r3ZZXCSAGzuUsbTbjE0nSvBsSvuEG86d53AO5z4wux9NMVDMpOy8Y6tQwLu86lcM2coIpXMjbXKy8lusJA9P7zBsM21P5Xcv6OHmhC/l+BQCL3n+LVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlvfF/3p; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlvfF/3p"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7de4be15125so9829967a34.0
        for <git@vger.kernel.org>; Mon, 25 May 2026 12:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779738063; x=1780342863; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlqkWpw9RfJm46sPVtm2GbsuNeqr0c2CSqvwe1OmCzo=;
        b=VlvfF/3pDwr4ysu34TEHo5nfzyJNXJkD7mB6nmj2kgoesre82cWbgNyrRP/F6PSv3p
         pSaCp0u/1OVCzHnKzdDNhNuN8jMS/W5pWftUJE350Xui5/RskgdsfS3gwPY03qey9JYa
         zMJWQhjRqdoTYVGhKmoN9MnnbMG4hjBD83cQRulF5yMObsUxgy+3hPr1vG2jhKcoGPT1
         XUY584RRMqXNYaVPQ9HzcFpnBUiw9kEI6gu68vPYiTxdpwIvb4tu7rWhH3WJRCaXsFCo
         p27br6DNzogwr6E8UeOec95LqNz8eyCSqDRfvqEJqfAc9u27UxOI9pEW/YUq1B2ONuc9
         /uQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779738063; x=1780342863;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vlqkWpw9RfJm46sPVtm2GbsuNeqr0c2CSqvwe1OmCzo=;
        b=DZchrqM8rHGTRqjzkIIQz/l04OZQ6NEDn907esKg66Sbh4qflgV05SRZ2B2KJpEwjU
         aZyQQ5gaq9mx1xCJpYKx6x8GJelbbvciyfAOqndKk95NMCxNr8dJxbmX90PovRsqnls8
         G86QVBlA5KTJEd+foJoOA2GKhn2F9GT38lub4T3kp5IL7Pfcj9FK4YKPRgzkIs0rTJVH
         x6ibg7IxZldwVILnTR6/0ZZQkaoLbxgw6MkuM62pGgUCyobfcZt69OOMlVJNUhKkDddR
         BbxY6MZsvnQfFPpcq05/mr/lyfWKZgYzIdo5jT/Q3f/tkOoYfprk7q+6KQdvGZmDY/WQ
         dbpA==
X-Gm-Message-State: AOJu0YwGy471N9SQo3slLAuXnlTqlY98vefKCoUhN5MBz5w5b8eHFGnU
	JIzx6c9X6UMnBdgAa2sqn9LX04WaKnZr9gPqe+RPZCFKci5oAe+nv9SlbvgF6w==
X-Gm-Gg: Acq92OG+HoH+DufXn4kncpdgnfy0jSvtrIM+qN6H+t1QengfRkU8m7ZDw3v6KCpI1Ek
	dWSsQqmNa4X69F4ZBoOhMZ7reWhPwc+KAAzHoc7CLlM6S8XNUAzf5JWK6FJ2ceUedN9sGJvuPwv
	coskriDh4ggfMU0igHwAyvq/KvLpJXD7P+1izCuVHp5VYH9O0oNP/B/xz+eONPtnYcuLUr+hIzj
	TeNYH9bONra/jRK7ohulbGeqvZTMWgx5xyuwA2Pn4Lxn2MWl2yGHCIbNoZkatFIiriDh3h6hVVz
	JFH5y2lO56W1w+yqXbzY78DB3yU+HctsZlR8SU0rgPZCELNGkdprJjPkW7Pbm55brkDfEXVU5Q/
	TAuVRPS8BJO0bKqNnAt7X2RT9xjr57ayyzUr731AjiV0edmW2MiSrDoopja5WSvKxVuTn4Ynw7H
	rqFlnoo3bqfJnM3OmFVyF3mV1Xsk6Ks/9/8iMCCw==
X-Received: by 2002:a05:6820:4c13:b0:69d:7777:75a0 with SMTP id 006d021491bc7-69d7eb750b8mr8286231eaf.24.1779738062996;
        Mon, 25 May 2026 12:41:02 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.164.19])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d90813a6bsm4880926eaf.0.2026.05.25.12.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 12:41:01 -0700 (PDT)
Message-Id: <9633eb62c620c7935f4e0aa87cae8808a6128c26.1779738059.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2094.v2.git.1779738059.gitgitgadget@gmail.com>
References: <pull.2094.git.1777349126.gitgitgadget@gmail.com>
	<pull.2094.v2.git.1779738059.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 May 2026 19:40:56 +0000
Subject: [PATCH v2 1/3] revision: move -L setup before output_format-to-diff
 derivation
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

The line_level_traverse block sets a default DIFF_FORMAT_PATCH when
no output format has been explicitly requested.  This default must
be visible to the "Did the user ask for any diff output?" check
that derives revs->diff from revs->diffopt.output_format.

Currently the -L block runs after that derivation, so revs->diff
stays 0 when no explicit format is given.  This does not matter yet
because log_tree_commit() short-circuits into line_log_print()
before consulting revs->diff, but the next commit will route -L
through the normal log_tree_diff() path, which checks revs->diff.

Move the block above the derivation so the default DIFF_FORMAT_PATCH
is in place when revs->diff is computed.  No behavior change on its
own.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 revision.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/revision.c b/revision.c
index 599b3a66c3..4a8e24bc38 100644
--- a/revision.c
+++ b/revision.c
@@ -3112,6 +3112,14 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		object_context_release(&oc);
 	}
 
+	if (revs->line_level_traverse) {
+		if (want_ancestry(revs))
+			revs->limited = 1;
+		revs->topo_order = 1;
+		if (!revs->diffopt.output_format)
+			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
+	}
+
 	/* Did the user ask for any diff output? Run the diff! */
 	if (revs->diffopt.output_format & ~DIFF_FORMAT_NO_OUTPUT)
 		revs->diff = 1;
@@ -3125,14 +3133,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->diffopt.objfind)
 		revs->simplify_history = 0;
 
-	if (revs->line_level_traverse) {
-		if (want_ancestry(revs))
-			revs->limited = 1;
-		revs->topo_order = 1;
-		if (!revs->diffopt.output_format)
-			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
-	}
-
 	if (revs->topo_order && !generation_numbers_enabled(the_repository))
 		revs->limited = 1;
 
-- 
gitgitgadget

