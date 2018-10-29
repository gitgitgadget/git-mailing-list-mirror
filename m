Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 134621F453
	for <e@80x24.org>; Mon, 29 Oct 2018 15:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeJ3A2j (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 20:28:39 -0400
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:58940
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727085AbeJ3A2j (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 29 Oct 2018 20:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1540827570;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=jS7ea31vcailWU8XFhkz0IziRj5mH6N7cE6V4BvZ8yA=;
        b=R3wbc22yV4FpAsXblvjMM8+WPWYJKnON05kyG6twhSoDBN0pGyqgOiUYhHVQrsCV
        ApaqtopiYifEG5WwtL73CqGQ+jsxjyxy+gDTb0m9AaTElSojFcjT4lIAGMkAI5+RGW6
        1W7J6gA26YZ10dxAQV61K/tf9LZ4m1kOge7PL3ts=
From:   Pete <pietro.cagnoni@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020166c07adf27-0c2cb5ac-2292-4ce3-808e-b627202fd45f-000000@eu-west-1.amazonses.com>
Subject: [PATCH] Prevent warning
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 29 Oct 2018 15:39:30 +0000
X-SES-Outgoing: 2018.10.29-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prevent the following warning in the web server error log:
gitweb.cgi: Odd number of elements in anonymous hash at /usr/share/gitweb/gitweb.cgi line 3305
---
 gitweb/gitweb.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2594a4badb3d7..200647b683225 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3302,7 +3302,7 @@ sub git_get_remotes_list {
 		next if $wanted and not $remote eq $wanted;
 		my ($url, $key) = ($1, $2);
 
-		$remotes{$remote} ||= { 'heads' => () };
+		$remotes{$remote} ||= { 'heads' => [] };
 		$remotes{$remote}{$key} = $url;
 	}
 	close $fd or return;

--
https://github.com/git/git/pull/548
