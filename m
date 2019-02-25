Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7503420248
	for <e@80x24.org>; Mon, 25 Feb 2019 17:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbfBYREG (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 12:04:06 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:52315 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbfBYREF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 12:04:05 -0500
Received: by mail-wm1-f54.google.com with SMTP id m1so8877715wml.2
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 09:04:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=INn/C+KBgNboS9HHMQni80QFxXBQooKmy1gg9I2XFw8=;
        b=tga/FOUjT6QVBCLjTASaF22s6nZxNkh/8DbF+jbNIamD3kQeHDgGzee+osekcN3jac
         d7xs/m3Srn9A/QH2vYti7FJj/1TdaCL1k4gWENsPsQXrTiKm94JD5MmsCX+2Vz/zF/I0
         5YN0oMGFtvf1G0siu9iFQ+uXb9weScdJp8run6gH3h0u1i1C7Qg4x1F24W+uTY0gfgVM
         uMdh/G7LwxJjH3gJLJQFsTpCj6OFEbIAHqSgQxi+CEN4n5vNrvBUXdKLK0B30dYepZnv
         5PLise5QZCf07tOEW083PtGO4jrXVUBpG0zehZjID8Jce4SDQ/TwCvWtjzC9VnCYaCBP
         2T3A==
X-Gm-Message-State: AHQUAubS2xL/Z4fd0wJ2ib1bbFDHduCzkhRgWWXWYl1V6UZ8bluDJhwf
        Kcg5Cer8cui7jxj2uNqP0ghDeYk9nioOHVcaoF3mYpBvOwQZRw==
X-Google-Smtp-Source: AHgI3IYn6h5e+ANRN2UCbytA1JMrcFbclUnWgaeERYLe5Yiq9mJXQnxMBnSHyFMzS82kDtmzCJgcB/T5hbApU78lAgI=
X-Received: by 2002:a7b:c766:: with SMTP id x6mr11281010wmk.15.1551114243967;
 Mon, 25 Feb 2019 09:04:03 -0800 (PST)
MIME-Version: 1.0
From:   Matthew Booth <mbooth@redhat.com>
Date:   Mon, 25 Feb 2019 17:03:50 +0000
Message-ID: <CAEkQehdFu5zM4AY3ihN0pn1aCNEomY0WV07pryfAB45JN-tDDA@mail.gmail.com>
Subject: [BUG] git log -L ... -s does not suppress diff output
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Example output:

=========
$ git --version
git version 2.20.1

$ git log -L 2957,3107:nova/compute/manager.py -s
commit 35ce77835bb271bad3c18eaf22146edac3a42ea0
<snip>

diff --git a/nova/compute/manager.py b/nova/compute/manager.py
--- a/nova/compute/manager.py
+++ b/nova/compute/manager.py
@@ -2937,152 +2921,151 @@
     def rebuild_instance(self, context, instance, orig_image_ref, image_ref,
                          injected_files, new_pass, orig_sys_metadata,
<snip>
=========

git log docs suggest it should not do this:

       -s, --no-patch
           Suppress diff output. Useful for commands like git show
that show the patch by default, or to cancel
           the effect of --patch.

Couldn't find anything in a search of the archives of this mailing
list, although that's obviously far from conclusive. Seems to be
longstanding, as it was mentioned on StackOverflow back in 2015:

https://stackoverflow.com/questions/31709785/git-line-log-git-l-suppress-diff

Matt
-- 
Matthew Booth
Red Hat OpenStack Engineer, Compute DFG

Phone: +442070094448 (UK)
