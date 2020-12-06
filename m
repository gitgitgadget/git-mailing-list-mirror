Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECC9C4361B
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 22:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AB24230FD
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 22:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgLFWX6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Dec 2020 17:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgLFWX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Dec 2020 17:23:58 -0500
X-Greylist: delayed 632 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Dec 2020 14:23:17 PST
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F95C0613D1
        for <git@vger.kernel.org>; Sun,  6 Dec 2020 14:23:17 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 66EBD5C7568B3; Sun,  6 Dec 2020 23:12:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 63DE660F32D71
        for <git@vger.kernel.org>; Sun,  6 Dec 2020 23:12:43 +0100 (CET)
Date:   Sun, 6 Dec 2020 23:12:43 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     git@vger.kernel.org
Subject: `git grep` is too picky about option parsing
Message-ID: <704q5rs6-63q1-sp78-9845-227oq8q42o8q@vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Version: 2.29.2


-e, -i, -l and -n are all valid options for grep as well as git grep, 
yet git-grep refuses to operate if they appear in a specific order.

Observed:

$ git grep -e abc -lin
error: did you mean `--lin` (with two dashes)?

Expected:

$ git grep -e abc -lin
somefile
