Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B27A1FF6D
	for <e@80x24.org>; Tue, 29 Nov 2016 09:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756813AbcK2Jio (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 04:38:44 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34607 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756780AbcK2JiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 04:38:25 -0500
Received: by mail-pg0-f65.google.com with SMTP id e9so15842841pgc.1
        for <git@vger.kernel.org>; Tue, 29 Nov 2016 01:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=D12nVyf5/2miTbFOvhKqElTeuPAyUc9BB0UBpyzEoh8=;
        b=wfzMCw6Ol0laW0y1wb7NHTuJD77s6cTqGjV1ahgKXqQ56yumfrdjMQCYenP3WqpmD1
         uN+g/kcTgnssNE7e1t/sFaYHLonJfJBtNjheEnqKPNniWoPjstvV2onYWnVQSikV68S9
         8/MleC3wt6BYWHEp9C6GKiCaggVgkzCoTWzvKUQQHZ3d7q+y98P0/nCc+ctRGsaDmr0y
         JBKkQ9h4BeSHSs1x0G7/CvsJZJsnuWCwze94M2thYOUmNAfNgd4JOcZ6hTEDxRPNCEZG
         698D2Fo3zc5iUN+pCuebz/wm5cpTJgYOaeR+W5Q3hx3riTWxT4X7avEq/a81GNkDxJz5
         xfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D12nVyf5/2miTbFOvhKqElTeuPAyUc9BB0UBpyzEoh8=;
        b=kI0jSuz93qS2fKU+0pMh5r7naXMA3AQ5B/2qsw8SoAw9aRqV3iLdBKkmdReimWZfK0
         zT4wLgJ0w3UTiRoZOLeEhrDWDANAjJfrGEltFkogeQ27OQIJHe+jNmU8Ak66rEFGQoIj
         ILzWw65oswRvj9fKhuF/wRjLjC8z9daYr5FJB/vL9crKolmnDAX/cA7uxrkypSjHSfTn
         kbMB8SFJLda+4upjK8BcxtWKS1qQdsuE6LOPeL+b1UUn+/R7Ey0Jtujd7EPpLnPWxgt9
         0bUU7mggGzMJgJ9AB5ufNnGOAs3164rvOD+8A0B206iY8pcHArNrxuKaNrpErl+eK+Gr
         rYqw==
X-Gm-Message-State: AKaTC00dmaoLvgjfRjZrhEj7FVvxH4KMyhJI4C3wn7ccrvzR22Hy8orlSUs4Du3mawVTyg==
X-Received: by 10.84.209.161 with SMTP id y30mr60448873plh.163.1480412303481;
        Tue, 29 Nov 2016 01:38:23 -0800 (PST)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id f81sm93465296pfd.71.2016.11.29.01.38.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2016 01:38:22 -0800 (PST)
From:   David Aguilar <davvid@gmail.com>
To:     Git ML <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Dun Peal <dunpealer@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Dickson Wong <dicksonwong@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Dan McGee <dpmcgee@gmail.com>,
        Markus Heidelberg <markus.heidelberg@web.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        James Bowes <jbowes@dangerouslyinc.com>
Subject: [PATCH 2/2] mergetools/vimdiff: trust Vim's exit code
Date:   Tue, 29 Nov 2016 01:38:20 -0800
Message-Id: <20161129093820.24722-1-davvid@gmail.com>
X-Mailer: git-send-email 2.11.0.rc3.6.g2e567fd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow vimdiff users to signal that they do not want to use the
result of a merge by exiting with ":cquit", which tells Vim to
exit with an error code.

This is better than the current behavior because it allows users
to directly flag that the merge is bad, using a standard Vim
feature, rather than relying on a timestamp heuristic that is
unforgiving to users that save in-progress merge files.

The original behavior can be restored by configuring
mergetool.vimdiff.trustExitCode to false.

Reported-by: Dun Peal <dunpealer@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
I've included anyone that has ever touched the vimdiff feature on the Cc:
list since I'm assuming that you use vimdiff.

This change is a slight change in default behavior when using
mergetool with vimdiff, but I think it's a better default overall.

 mergetools/vimdiff | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index a841ffdb4..10d86f3e1 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -42,3 +42,7 @@ translate_merge_tool_path() {
 		;;
 	esac
 }
+
+exit_code_trustable () {
+	true
+}
-- 
2.11.0.rc3.6.g2e567fd

