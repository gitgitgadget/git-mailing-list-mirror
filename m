Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150FDC10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 23:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7316206F1
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 23:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgCLXLc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 19:11:32 -0400
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:53420 "EHLO
        smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgCLXLb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 19:11:31 -0400
X-Greylist: delayed 599 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Mar 2020 19:11:30 EDT
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
        by smtpfb2-g21.free.fr (Postfix) with ESMTP id 0D6634D57C
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 23:55:58 +0100 (CET)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:cbb4:28e2:f54c:7a58])
        by smtp4-g21.free.fr (Postfix) with ESMTP id CE75119F57C
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 23:55:57 +0100 (CET)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     git@vger.kernel.org
Subject: Regression in v2.26.0-rc0 and Magit
Date:   Thu, 12 Mar 2020 23:55:57 +0100
Message-ID: <3091652.KAqcNXvZJ4@cayenne>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all, 

When trying the latest rc with magit, I found that git segfaults under Magit with auto-revert enabled. The message in emacs is

Error in post-command-hook (magit-auto-revert-mode-check-buffers): (wrong-type-argument number-or-marker-p "Segmentation Fault")

I was able to bisect the issue to commit e0020b2f82910f50bc697d86aff70c3796fbdc41 but unfortunately, it seems difficult to print the exact command from magit.

Reverting this patch solves the issue.

Most probably emacs runs commands with not all env variables set.

JN


