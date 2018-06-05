Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D301C1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 21:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbeFEVkx (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 17:40:53 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36988 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751619AbeFEVkx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 17:40:53 -0400
Received: by mail-pg0-f68.google.com with SMTP id r21-v6so1537788pgv.4
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 14:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LUFcF7PxWywM2w46Url7ye1IjlmCkKZaV+DGZvpBbOI=;
        b=hWIjrlB+59HdBEC7aPcgZjqooTCFtTF4Q7XCKDqf3vJ/SZgXA/ziOUKD4z3iosT9BB
         47M7VrhqvPldOaABIiRvdD+z8cqaLbqHQoTNNfKctYyejo5HDfQVqclrZFy689VtsBF8
         RoiUkuanmm1X7OtfL1s0GnOXpUsFS9qKGGi7yc80oWuYy7+DAN9xmlzSFqCCJJ6LpkC7
         YWxwyU52pgQNWk3UdCFnMOYaiQ00yFYoJb1aSRgNQue+3jXgImmjG+M8B7Dp7wsV26xU
         JfKB7vCNinWDsVWZrLiz/4R4AbRTBaoYneVBwuYzRRjzsccL5IZAqcHPJlJqDEH/+MMO
         q6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LUFcF7PxWywM2w46Url7ye1IjlmCkKZaV+DGZvpBbOI=;
        b=PsI1RaLXtRKd94HkSw5gTrpoUip8UfRIFWti5mWvE27x77k7ubaS9yfQ6Gha9zSjQk
         tjLGSUVTwmIMPoBu6RDAY25qVjIrAQIF4yCDTv8tgg05kae5aISCzwwK7ctZ1d9l6rIy
         6S/bnVQom3AYIAvf7SxVwxbPsCyQXs0byh7SBwU3ZA2mcEZa4ESyti+OGEYfRW/ze4Qr
         TIsY6uGmgobDsixAjefg8aypfkU7h4oTvuIUcUfymV7O4+Z/5yEJ5Oq+j0NAedImzgnt
         rTcw08hRXMSepQI2TOJLnsZIdeGFwVkANwXIdfVtb1LK90QVZOAYxoSyEHNZBeJZFOac
         bzOQ==
X-Gm-Message-State: APt69E2uIMXXP+LhyF0WO3ECYvcFxsQXGB0aMu3JTZvEB3BDx/nxuc4s
        owN31zSWu9WSs4z/5hW42Pv7vm2b90Y=
X-Google-Smtp-Source: ADUXVKJ4WnAYlahuiqDCkAC5gpU205TY2B9EAVQe12iO38UJdwAFLxuCWe/ezM0oUAUo9WtTcL+7Ww==
X-Received: by 2002:aa7:850f:: with SMTP id v15-v6mr327723pfn.144.1528234852140;
        Tue, 05 Jun 2018 14:40:52 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id 76-v6sm27451138pfr.172.2018.06.05.14.40.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 14:40:51 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, bmwill@google.com
Subject: [PATCH v2 1/2] t5702: test fetch with multiple refspecs at a time
Date:   Tue,  5 Jun 2018 14:40:35 -0700
Message-Id: <2bc7df55a6451afbd35638b31a1551c648129b22.1528234587.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.768.g1526ddbba1.dirty
In-Reply-To: <cover.1528234587.git.jonathantanmy@google.com>
References: <cover.1528233146.git.jonathantanmy@google.com> <cover.1528234587.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the protocol v2 tests to also test fetches with multiple refspecs
specified. This also covers the previously uncovered cases of fetching
with prefix matching and fetching by SHA-1.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5702-protocol-v2.sh | 47 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index a4fe6508b..261e82b0f 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -359,6 +359,53 @@ test_expect_success 'default refspec is used to filter ref when fetchcing' '
 	grep "ref-prefix refs/tags/" log
 '
 
+test_expect_success 'fetch supports various ways of have lines' '
+	rm -rf server client trace &&
+	git init server &&
+	test_commit -C server dwim &&
+	TREE=$(git -C server rev-parse HEAD^{tree}) &&
+	git -C server tag exact \
+		$(git -C server commit-tree -m a "$TREE") &&
+	git -C server tag dwim-unwanted \
+		$(git -C server commit-tree -m b "$TREE") &&
+	git -C server tag exact-unwanted \
+		$(git -C server commit-tree -m c "$TREE") &&
+	git -C server tag prefix1 \
+		$(git -C server commit-tree -m d "$TREE") &&
+	git -C server tag prefix2 \
+		$(git -C server commit-tree -m e "$TREE") &&
+	git -C server tag fetch-by-sha1 \
+		$(git -C server commit-tree -m f "$TREE") &&
+	git -C server tag completely-unrelated \
+		$(git -C server commit-tree -m g "$TREE") &&
+	
+	git init client &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
+		fetch "file://$(pwd)/server" \
+		dwim \
+		refs/tags/exact \
+		refs/tags/prefix*:refs/tags/prefix* \
+		"$(git -C server rev-parse fetch-by-sha1)" &&
+
+	# Ensure that the appropriate prefixes are sent (using a sample)
+	grep "fetch> ref-prefix dwim" trace &&
+	grep "fetch> ref-prefix refs/heads/dwim" trace &&
+	grep "fetch> ref-prefix refs/tags/prefix" trace &&
+
+	# Ensure that the correct objects are returned
+	git -C client cat-file -e $(git -C server rev-parse dwim) &&
+	git -C client cat-file -e $(git -C server rev-parse exact) &&
+	git -C client cat-file -e $(git -C server rev-parse prefix1) &&
+	git -C client cat-file -e $(git -C server rev-parse prefix2) &&
+	git -C client cat-file -e $(git -C server rev-parse fetch-by-sha1) &&
+	test_must_fail git -C client cat-file -e \
+		$(git -C server rev-parse dwim-unwanted) &&
+	test_must_fail git -C client cat-file -e \
+		$(git -C server rev-parse exact-unwanted) &&
+	test_must_fail git -C client cat-file -e \
+		$(git -C server rev-parse completely-unrelated)
+'
+
 # Test protocol v2 with 'http://' transport
 #
 . "$TEST_DIRECTORY"/lib-httpd.sh
-- 
2.17.0.768.g1526ddbba1.dirty

