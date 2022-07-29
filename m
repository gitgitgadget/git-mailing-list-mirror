Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF2CC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 08:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbiG2IbS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 04:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235101AbiG2IbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 04:31:16 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADF17CB4F
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:31:15 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l4so5098928wrm.13
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ypr5qyU03INn4eiRpN9C6ExMEYvwNX2XHO80wjv/JUg=;
        b=U4EYtLz6r/9nHWS9bTSWW2QrtOtt84y7mahVrkRi8K1pUC2rdK8/MraqDzALqsyUX9
         4d6eA72/i0YshJoyKg79UpGkN76Kw9kxqSm135vjgPtRjx4ujKyiRHQMPEe0pkuYId1/
         OPjhTMc54k/nMb3/MSX6ZHR1h1zFoVRAkqqu/ZAdy1CdGfqL8fm2dg23rdrz9ZhV+/7m
         ERZF19by23dd6vHy0sMnDgdRiQ93DJNp5d+qw7waQorRxH/v0uC58BinrJ76ul1Lrnht
         WOFl4W87S92XRVIEWoUqs/2Z3YdGgas7TkF1ZUlVL/9gRbzVNqenWYBqZKtUOajdZaOn
         vksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ypr5qyU03INn4eiRpN9C6ExMEYvwNX2XHO80wjv/JUg=;
        b=XkmvNk0i/rcRqkgjH38PIOR3Z1d87cEfRTRtc9kkbHr3mjbkDJefyGjlDueccRqqPH
         Sbil0/7LJOcaA+1zzLZ/wbL+OPEio8WRn26nB5XjwR1s9R4cK5FkUVq+aoFqhXZZ2QUo
         cS2p6I5lwZIh956OZE1xrAWueEU3neFFqRJoO0rijRsjQwgOhmzpw+cCYZEAIoTJJv5G
         uqmnlCwilcenLD2Idj/8mxIKfyZYJRi62GF+F9QTGJPdvx86b819PzZP1/yK94jwh2Iv
         bXL5ZCr886np4bKrffMsPKfg05W2bYqcpSnK4FO97KGF1XTGAsK+qicCagjj664rnxak
         qpIQ==
X-Gm-Message-State: ACgBeo0vd2ofNFKnLx0D+PyAgYmR+cncW4Zj3Vm4YTy7Z70EWu/6+6sS
        z5MQG/jWGSzoh3rZt051S3WJcbpCF9U+3g==
X-Google-Smtp-Source: AA6agR49EAP9O1f8VsVvWr9kdPvqxX/X71QfsTJvDpP5vxjMgvyGmlWOFzctkiq2NjxMx6PNFnlwOw==
X-Received: by 2002:a05:6000:168e:b0:21d:b5ed:381d with SMTP id y14-20020a056000168e00b0021db5ed381dmr1596646wrd.241.1659083473905;
        Fri, 29 Jul 2022 01:31:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f13-20020adfe90d000000b0021f0c0c62d1sm2325467wrm.13.2022.07.29.01.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 01:31:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/6] test-fast-rebase helper: use release_revisions() (again)
Date:   Fri, 29 Jul 2022 10:31:04 +0200
Message-Id: <patch-v2-2.6-bbd3a7e5ecc-20220729T082919Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1196.g8af3636bc64
In-Reply-To: <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug in 0139c58ab95 (revisions API users: add "goto cleanup" for
release_revisions(), 2022-04-13), in that commit a release_revisions()
call was added to this function, but it never did anything due to this
TODO memset() added in fe1a21d5267 (fast-rebase: demonstrate
merge-ort's API via new test-tool command, 2020-10-29).

Simply removing the memset() will fix the "cmdline" which can be seen
when running t5520-pull.sh.

This sort of thing could be detected automatically with a rule similar
to the unused.cocci merged in 7fa60d2a5b6 (Merge branch
'ab/cocci-unused' into next, 2022-07-11). The following rule on top
would catch the case being fixed here:

	@@
	type T;
	identifier I;
	identifier REL1 =~ "^[a-z_]*_(release|reset|clear|free)$";
	identifier REL2 =~ "^(release|clear|free)_[a-z_]*$";
	@@

	- memset(\( I \| &I \), 0, ...);
	  ... when != \( I \| &I \)
	(
	  \( REL1 \| REL2 \)( \( I \| &I \), ...);
	|
	  \( REL1 \| REL2 \)( \( &I \| I \) );
	)
	  ... when != \( I \| &I \)

That rule should arguably use only &I, not I (as we might be passed a
pointer). He distinction would matter if anyone cared about the
side-effects of a memset() followed by release() of a pointer to a
variable passed into the function.

As such a pattern would be at best very confusing, and most likely
point to buggy code as in this case, the above rule is probably fine
as-is.

But as this rule only found one such bug in the entire codebase let's
not add it to contrib/coccinelle/unused.cocci for now, we can always
dig it up in the future if it's deemed useful.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-fast-rebase.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
index 4e5553e2024..45665ec19a5 100644
--- a/t/helper/test-fast-rebase.c
+++ b/t/helper/test-fast-rebase.c
@@ -184,8 +184,6 @@ int cmd__fast_rebase(int argc, const char **argv)
 		last_picked_commit = commit;
 		last_commit = create_commit(result.tree, commit, last_commit);
 	}
-	/* TODO: There should be some kind of rev_info_free(&revs) call... */
-	memset(&revs, 0, sizeof(revs));
 
 	merge_switch_to_result(&merge_opt, head_tree, &result, 1, !result.clean);
 
-- 
2.37.1.1196.g8af3636bc64

