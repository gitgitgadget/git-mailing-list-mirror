Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77B531F453
	for <e@80x24.org>; Mon, 11 Feb 2019 17:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbfBKRRB (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 12:17:01 -0500
Received: from avasout05.plus.net ([84.93.230.250]:42382 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfBKRRB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 12:17:01 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id tFCUgijGp3a8gtFCVgoByw; Mon, 11 Feb 2019 17:17:00 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=U7m889ju c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=5rxgeBVgAAAA:8 a=FEwn8AxFsdz831qadf8A:9
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22 a=PwKx63F5tFurRwaNxrlG:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] sequencer: make sign_off_header a file local symbol
Message-ID: <93b23b5a-7fcd-e9ec-3411-f8362b601732@ramsayjones.plus.com>
Date:   Mon, 11 Feb 2019 17:16:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLBmy1N1brpQ/dDr7OjniCRsnlNgPEuxAZOi8RtQERinYJFOlvlcJ1ZAcmzjpmnYalc0kM+WVhKmN17Mu5E9+sQwwEczXv6mPpeiq7yYPwveNWmy1yBH
 3eLEIWTwqc1z3Cr55wXuwRMgDHrCIQj4EU9qBl40E2ThhQlL2or9jbluFwhJykvREVC25bt2BV0yBQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Commit d0aaa46fd3 ("commit: move empty message checks to libgit",
2017-11-10) removes the last use of 'sign_off_header' outside of
the "sequencer.c" source file. Remove the extern declaration from
the header file and mark the definition of the symbol with the
static keyword.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

This has been hanging around for a while. I sent it to the list last
time in [1], but it seems to have been dropped. (Found while attempting
to rebase loads of old branches to a newer base!)

ATB,
Ramsay Jones

[1] https://public-inbox.org/git/8caabe3e-4dc3-657a-236d-6cf91e1e6d03@ramsayjones.plus.com/

 sequencer.c | 2 +-
 sequencer.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e1a4dd15f1..20f1823b06 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -35,7 +35,7 @@
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
-const char sign_off_header[] = "Signed-off-by: ";
+static const char sign_off_header[] = "Signed-off-by: ";
 static const char cherry_picked_prefix[] = "(cherry picked from commit ";
 
 GIT_PATH_FUNC(git_path_commit_editmsg, "COMMIT_EDITMSG")
diff --git a/sequencer.h b/sequencer.h
index 5071a73563..e5e4845f14 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -102,8 +102,6 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 		    unsigned autosquash);
 int rearrange_squash(void);
 
-extern const char sign_off_header[];
-
 /*
  * Append a signoff to the commit message in "msgbuf". The ignore_footer
  * parameter specifies the number of bytes at the end of msgbuf that should
-- 
2.20.0
