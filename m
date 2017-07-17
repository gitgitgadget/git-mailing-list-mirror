Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7270020357
	for <e@80x24.org>; Mon, 17 Jul 2017 19:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbdGQT0U (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 15:26:20 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:38752
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751334AbdGQT0T (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 Jul 2017 15:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1500319577;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=q766pLCXAX0wG0Z7NFf+NZ181bTmi7A9KBLawsXXG9w=;
        b=SSER4ezeTuoCt9X822l4t1wVGIYN5zvcC+9ypyzvNdwMKhN3L+ZUU3GtaL7Qs8i/
        RlSGoN9EvTwKYV/VrUs92m7Eo2nV2zOULWGdtmZSzK4zjyhsmsugw9PbaWlJ4/1+cnI
        IaL6qqVeWh4nLTTfQoo5wYjLQOjtxEWySert1dfY=
From:   Hielke Christian Braun <hcb@unco.de>
To:     git@vger.kernel.org
Message-ID: <0102015d5203f2ae-c7f1daeb-a6ab-413d-9036-c8da816c4c18-000000@eu-west-1.amazonses.com>
Subject: [PATCH] check for search permission
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 17 Jul 2017 19:26:16 +0000
X-SES-Outgoing: 2017.07.17-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 gitweb/gitweb.perl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3d4a8ee27c96a..9208f42ed1753 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3071,6 +3071,8 @@ sub git_get_projects_list {
 				return if (m!^[/.]$!);
 				# only directories can be git repositories
 				return unless (-d $_);
+				# need search permission
+				return unless (-x $_);
 				# don't traverse too deep (Find is super slow on os x)
 				# $project_maxdepth excludes depth of $projectroot
 				if (($File::Find::name =~ tr!/!!) - $pfxdepth > $project_maxdepth) {

--
https://github.com/git/git/pull/384
