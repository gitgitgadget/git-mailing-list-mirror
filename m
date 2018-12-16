Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 018BB1F405
	for <e@80x24.org>; Sun, 16 Dec 2018 23:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbeLPXYd (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Dec 2018 18:24:33 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38312 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731012AbeLPXYc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Dec 2018 18:24:32 -0500
Received: by mail-pf1-f193.google.com with SMTP id q1so5409552pfi.5
        for <git@vger.kernel.org>; Sun, 16 Dec 2018 15:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4ymxL4QKTjngdKKy1mYvfMR65atKrKvhEc/sIO96bAo=;
        b=L4vfILbrdub/ifFLDY9zYNN9TiGG7U4BCx5MHz2Nhf98KlUASd9rYw3C44AMPR2Mvn
         CB0YaEVI6oUX/H3aIXmJ3FI3l2lM9VMDqsCYjdrP8X6+pvAoELoAEO9ipnNiuLOXbAv+
         MyxZ2+hPrJ25Er/2mndlvecUJo6Dx9VGgNMscoY92QearkTQ1jfsSgts36pb3ki/+872
         M2DeqebR7qU2J11PGxjvQ5hNicXVjJr78qFG4mGHeuFUduxV/pB6X2WoX3MGJrhSMFAM
         Un+D+oYPrButyv/73oCB+o++9tDQnFwNmagMxpZmhob984pr7ClL9+LhbfrKHnOOi6pl
         U0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4ymxL4QKTjngdKKy1mYvfMR65atKrKvhEc/sIO96bAo=;
        b=FnFpbz57YGzaN78bS3GfSSeK3KCvxZ8JJhuU8jRUkl+Pk3IZL0RvjDNkOn7UJBzbjM
         JO+hRgFXsBY/0FoHim98641Sfoo0qZlGG5Gur7ykUEkqH0Ia2ITns+MfYtq4VeHzMnha
         9ou1Yd+Ra1veRGCsL53G9fyMJEzGMsfh1y1XUtBXnwlRtrOtZk0CBn5a/M/3C5Fucrwj
         bqx/BzqAjxEitqTZ5219aU+3imBt57gKEhL6BZFKmtmtJPv6HBBxx2Z8BANkEFSUN2h2
         as4JNaSXxFAI+Y4+/+EtYhfiAJaRjHVxY9xWpjNUiHl9g6bdRhptNIlnrvT0sddGI3qe
         za4A==
X-Gm-Message-State: AA+aEWYu2bhX033utc4B+moWk/UkTfngh4h00Xg90fLrb69v+HPyAnT5
        rO2Xzpn10G6oaktN3/DUZiI=
X-Google-Smtp-Source: AFSGD/U4SbXH39pUZZdo/iCvM0ySwra2jH0c6kRfsGXnb+GP8le/Wn4CZFctpoTAXCjxr0QHuO4JXA==
X-Received: by 2002:a63:b543:: with SMTP id u3mr10132648pgo.420.1545002671556;
        Sun, 16 Dec 2018 15:24:31 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id d69sm14227740pfg.168.2018.12.16.15.24.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Dec 2018 15:24:30 -0800 (PST)
Date:   Sun, 16 Dec 2018 15:24:29 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Robert Luberda <robert@debian.org>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: [PATCH] gitweb: correctly store previous rev in javascript-actions
 mode
Message-ID: <20181216232429.GJ75890@google.com>
References: <53CECC87.7030209@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53CECC87.7030209@debian.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Luberda <robert@debian.org>
Date: Sun, 16 Mar 2014 22:57:19 +0100

Without this change, the setting

 $feature{'javascript-actions'}{'default'} = [1];

in gitweb.conf breaks gitweb's blame page: clicking on line numbers
displayed in the second column on the page has no effect.

For comparison, with javascript-actions disabled, clicking on line
numbers loads the previous version of the line.

Addresses https://bugs.debian.org/741883.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi Robert,

Years ago, you sent this obviously correct patch to the link mentioned
above, but it got lost in the noise.  Sorry about that.  Hopefully
late is better than never.

May we forge your sign-off?  See
https://www.kernel.org/pub/software/scm/git/docs/SubmittingPatches.html#sign-off
for more details about what this means.

Jakub et al, any thoughts?  I don't see any unit tests in gitweb/static
that could avoid this regressing --- am I missing some, or if not any
hints for someone who would want to add a test framework?

Thanks,
Jonathan

 gitweb/static/js/blame_incremental.js | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/static/js/blame_incremental.js b/gitweb/static/js/blame_incremental.js
index db6eb50584..e100d8206b 100644
--- a/gitweb/static/js/blame_incremental.js
+++ b/gitweb/static/js/blame_incremental.js
@@ -484,7 +484,7 @@ function processBlameLines(lines) {
 			case 'previous':
 				curCommit.nprevious++;
 				// store only first 'previous' header
-				if (!'previous' in curCommit) {
+				if (!('previous' in curCommit)) {
 					var parts = data.split(' ', 2);
 					curCommit.previous    = parts[0];
 					curCommit.file_parent = unquote(parts[1]);
-- 
2.20.0.405.gbc1bbc6f85

