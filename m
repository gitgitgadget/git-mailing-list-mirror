Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53277C54FD0
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 07:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140AA208DB
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 07:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgCYHD5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 03:03:57 -0400
Received: from smtp2.goneo.de ([85.220.129.33]:40942 "EHLO smtp2.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgCYHD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 03:03:56 -0400
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Mar 2020 03:03:55 EDT
Received: from localhost (localhost [127.0.0.1])
        by smtp2.goneo.de (Postfix) with ESMTP id 8FF0223F4F1;
        Wed, 25 Mar 2020 07:56:32 +0100 (CET)
X-Virus-Scanned: by goneo
Received: from smtp2.goneo.de ([127.0.0.1])
        by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6ACdZTxRVDqG; Wed, 25 Mar 2020 07:56:31 +0100 (CET)
Received: from [192.168.177.59] (ip-88-153-12-55.hsi04.unitymediagroup.de [88.153.12.55])
        by smtp2.goneo.de (Postfix) with ESMTPA id 81B9D23F6DB;
        Wed, 25 Mar 2020 07:56:31 +0100 (CET)
To:     e@80x24.org
Cc:     git@vger.kernel.org, pjwhams@gmail.com, normalperson@yhbt.net
From:   Lukas Pupka-Lipinski <lukas.pupkalipinski@lpl-mind.de>
Subject: [PATCH] added: Multi line support for ignore-paths configuration
Message-ID: <e5c78a24-e17f-c1bb-4ea7-3ddaa45abcf0@lpl-mind.de>
Date:   Wed, 25 Mar 2020 07:56:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 From 01d4e4dbc4e524db6188f41904a7274d1582d066 Mon Sep 17 00:00:00 2001
From: lukas.pupkalipinski@lpl-mind.de
Date: Tue, 24 Mar 2020 13:47:27 +0100
Subject: [PATCH] added: Multi line support for ignore-paths configuration
In addition we should add multi line support for include-paths.

Signed-off-by: lukas.pupkalipinski@lpl-mind.de
Reported-by:
Acked-by:
Reviewed-by:
Tested-by:
---
  perl/Git/SVN/Fetcher.pm | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
index 64e900a0e9..1bcba49a76 100644
--- a/perl/Git/SVN/Fetcher.pm
+++ b/perl/Git/SVN/Fetcher.pm
@@ -31,7 +31,8 @@ sub new {
      # override options set in an [svn-remote "..."] section
      $repo_id = $git_svn->{repo_id};
      my $k = "svn-remote.$repo_id.ignore-paths";
-    my $v = eval { command_oneline('config', '--get', $k) };
+    my $v = eval { command('config', '--get-all', $k) };
+    $v  =~ s/[\x0A\x0D]//g if (defined $v);
      $self->{ignore_regex} = $v;

      $k = "svn-remote.$repo_id.include-paths";
-- 
2.25.1.windows.1

