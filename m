Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D972F1F991
	for <e@80x24.org>; Sun,  6 Aug 2017 23:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751409AbdHFXjB (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Aug 2017 19:39:01 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33778 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751355AbdHFXjA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Aug 2017 19:39:00 -0400
Received: by mail-wm0-f68.google.com with SMTP id q189so11995285wmd.0
        for <git@vger.kernel.org>; Sun, 06 Aug 2017 16:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y6K28M8daCfNAo38IyZyn0ogNV9nx0fK20S1HjVSAR4=;
        b=E8cnv78KWTddekYxbg7rNi0mwAT+hR+qsXs1glFB3a+4EHsioPbrl56KcarpjQClXi
         D1IbmsQ4qIBmHVCCjGu7QnKbdhdllvYeA5w10L7BYA8F9/3+EQDnVfI5gFBoM5BMnGHY
         Sy6yfdyAa2XsMxGOohHWWdGHBdEdTtcseP46MIppc/auEuqRygmRoFCSyj66ZqtVkENZ
         8/7+8VQS6x9ET2G4/6DzbYlVHILipSbBpfn/CmuTKsm5HHuUwTC/LMWTYBKxvSvtumjC
         SuJ/xbfsrXqG2mlOsfOX9L7gSrNTW/LWefcGIUJ3mb2mFbfsaQE8PiehbVLlSlJk+GLX
         vl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y6K28M8daCfNAo38IyZyn0ogNV9nx0fK20S1HjVSAR4=;
        b=Xc4l2mS/DuqLS3gJvSFt68+djYrGeaNepoa64STlyhTltypu90odIXUUWdDu0+2Mwg
         ju5adulCWP/WEUfrpXcmeXMdIK1zQQNPDoHYaY0Ye67cHWAK6NITOqmkyjTp95sbANNW
         mepcEx4cqFTJz+/d2x7MOu0cw5omKPeCaK7TUHzCSrmeYf7VC+AnK4qcajXyKcKWs8Fw
         5gZqNqYs25nBBmS65xmnRZVN1Sn25MV8p77Vuo1gcp/HqTgQg2SHGLznOHXmHy0ToiJh
         4GBHPo3cBywv476fDgzwnFff+td1moP4MSg1VlS5Axzs7dLNzpZ32jEvlUXOqFmHbLdt
         jHvg==
X-Gm-Message-State: AIVw113nAncNaMtAfIEs2fu/o+GpNohz6o2JolsI+h14tY2K5o6Td16y
        0PXG+j0aWz438XSrf8k=
X-Received: by 10.80.154.97 with SMTP id o88mr9412038edb.137.1502062739380;
        Sun, 06 Aug 2017 16:38:59 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id g4sm4811165edh.89.2017.08.06.16.38.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Aug 2017 16:38:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Coppa <dcoppa@openbsd.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] tests: don't give unportable ">" to "test" built-in, use -gt
Date:   Sun,  6 Aug 2017 23:38:50 +0000
Message-Id: <20170806233850.14711-1-avarab@gmail.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change an argument to test_line_count (which'll ultimately be turned
into a "test" expression) to use "-gt" instead of ">" for an
arithmetic test.

This broken on e.g. OpenBSD as of v2.13.0 with my commit
ac3f5a3468 ("ref-filter: add --no-contains option to
tag/branch/for-each-ref", 2017-03-24).

Upstream just worked around it by patching git and didn't tell us
about it, I discovered this when reading various Git packaging
implementations: https://github.com/openbsd/ports/commit/7e48bf88a20

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

David, it would be great to get a quick bug report to
git@vger.kernel.org if you end up having to monkeypatch something
we've done. We won't bite, promise :)

As shown in that linked Github commit OpenBSD has another recent
workaround in turning on DIR_HAS_BSD_GROUP_SEMANTICS and skipping a
related test, maybe René can make more sense of that?

There's more patches in their ports which indicate possible bugs of
ours: https://github.com/openbsd/ports/tree/master/devel/git/patches/

 t/t7004-tag.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 0ef7b94394..0e2e57aa3d 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1887,7 +1887,7 @@ EOF"
 	run_with_limited_stack git tag --contains HEAD >actual &&
 	test_cmp expect actual &&
 	run_with_limited_stack git tag --no-contains HEAD >actual &&
-	test_line_count ">" 10 actual
+	test_line_count "-gt" 10 actual
 '
 
 test_expect_success '--format should list tags as per format given' '
-- 
2.14.0.rc1.383.gd1ce394fe2

