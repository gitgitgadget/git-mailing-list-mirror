Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E67821F403
	for <e@80x24.org>; Thu,  7 Jun 2018 05:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbeFGFGX (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 01:06:23 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:46661 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751318AbeFGFGW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 01:06:22 -0400
Received: by mail-ot0-f195.google.com with SMTP id q1-v6so10004099oth.13
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 22:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ndjDklWF78AvxNjlc96dgfWAVfyomgRHumiXQjQpJfc=;
        b=l/DNW4/1bk9VA075ySS5s2khLkiNDGXgWFx5qBjVc0yh9U/3wGVfqBTZ3Qw57xuvsV
         YEfKPg/jkfAKlkgQY51tiJiQfb1BY1OpsAAMWjfNBS6qSl3XW7LilS36HWbC4/GS9jdw
         DGbRMRDOlMpPduG5ptYt7UVrgWJ8JbAGjk5zfe9ruhtj6knAIgDYV9Ynd+kfQIRqLkXI
         XiTfas+sUQjKl6RHvcW/Ev8xOMdDZYNOOCQ3hdlgf1RpAtR8mNgl4fOUNLpz4o4gQFYV
         tPnc+Kl9Hjtg9my1bW1kNHqZH0fgoGUFYeLfFyvlEmeRVc2b4OGe4DpJPVIFd+5DkCks
         d9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ndjDklWF78AvxNjlc96dgfWAVfyomgRHumiXQjQpJfc=;
        b=Mo/WsJw1w79gefhitBF8D+s54cs4g4eP4LzkJhpfaQnsEdeHhyQFY6Tu3Hxz35M/vb
         33dCGqg98OyeD1y8ct49I3bEyBimhTlSi6lJlTunWhUJZryaTIVvDWhnY4hDAUDP5qZc
         4sCe0WlFXMOl+KZ/WUdN99WFdnNQXv74hKQeArNlD/mk4GPDF0I7sx01meSpKW9ZrLgE
         zNUyBi698pUQqOz/9XHnJTq5FWE8xzHmdfOTI7KFqvwRsw/mJtfEJE37cNZVcSSDJCRD
         6MjU2diHw1HLwJByw+9BVJMh5PH2hWj7+bt6YkJr5RR4nCVIDKLd2GF17Se2Qlkaa79N
         ot/w==
X-Gm-Message-State: APt69E0b5thAuJpvxV+W/9XwvKzIFJJZK+GWemL0IYTQcfsb79gOoVeQ
        r0mZBFrhCAEpfrdtS0h61NVuFg==
X-Google-Smtp-Source: ADUXVKLGwM5JMANU1oDpQsyX/GXNXSiwhJXz1yL2ItdglyTJg0468kk6+qYmu4d4T5tCwM32LSeuMg==
X-Received: by 2002:a9d:14f3:: with SMTP id r48-v6mr186823otr.279.1528347981485;
        Wed, 06 Jun 2018 22:06:21 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id w10-v6sm2303776oif.41.2018.06.06.22.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 22:06:21 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH] git-rebase--merge: modernize "git-$cmd" to "git $cmd"
Date:   Wed,  6 Jun 2018 22:06:15 -0700
Message-Id: <20180607050615.19598-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.46.g9cee8fce43
In-Reply-To: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<Comments for after diffstat:>
I tend to think git-rebase--merge is less popular than the other rebase
types, leading to it being more overlooked and less well tested than the
other ones.  This git-$cmd usage seems to support that argument.

Anyway, this patch may be irrelevant if others agree with my goal to
delete git-rebase--merge and implement --merge on top of the --interactive
machinery, but sending it along in case others don't agree with that goal.
</Comments>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 git-rebase--merge.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index cf4c042214..aa2f2f0872 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -71,7 +71,7 @@ call_merge () {
 	test -z "$strategy" && strategy=recursive
 	# If cmt doesn't have a parent, don't include it as a base
 	base=$(git rev-parse --verify --quiet $cmt^)
-	eval 'git-merge-$strategy' $strategy_opts $base ' -- "$hd" "$cmt"'
+	eval 'git merge-$strategy' $strategy_opts $base ' -- "$hd" "$cmt"'
 	rv=$?
 	case "$rv" in
 	0)
@@ -88,7 +88,7 @@ call_merge () {
 		;;
 	*)
 		die "Unknown exit code ($rv) from command:" \
-			"git-merge-$strategy $cmt^ -- HEAD $cmt"
+			"git merge-$strategy $cmt^ -- HEAD $cmt"
 		;;
 	esac
 }
-- 
2.18.0.rc0.46.g9cee8fce43

