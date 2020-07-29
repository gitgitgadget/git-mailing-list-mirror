Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027D7C433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB59B2074B
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="qmqlrEEk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgG2USd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:18:33 -0400
Received: from out1.migadu.com ([91.121.223.63]:3792 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbgG2USd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 16:18:33 -0400
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1596053911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=7Ph/zGIja6M6IfSFy1MZ9UP6gtb4UFofejAPmxR2tJM=;
        b=qmqlrEEklUtDB+pZkBvLJo7+je0XeL+alnbtPOg76bwrIdtPNhd8ScTmjZqnEkxoqNBzhQ
        Rg3UqfVTr8/gWfRDI9Zl8OqPyrJCMBzpAAe78v6ku3PugK+ieuXEkREjA92RjwuIR1T89t
        jM7mUtqKgfFyjGDI7qqOKjSecW2yl3s=
Content-Type: text/plain; charset=UTF-8
Subject: Re: Issue when adding new files to staged changes using interactive
 mode
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     "Another Email" <yetanotheroneemail@gmail.com>,
        <git@vger.kernel.org>
Date:   Wed, 29 Jul 2020 14:58:09 -0400
Message-Id: <C4JC6LFSAFFS.2U4ZZ9ZMO066A@ziyou.local>
In-Reply-To: <5BDF4B85-7AC1-495F-85C3-D429E3E51106@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is introduced in commit feea6946a5b746ff4ebf8ccdf959e303203a6011
(diff-files: treat "i-t-a" files as "not-in-index"). I guess this leads
to add-patch skipping directly to attempting to apply the hunk, rather
than trying to combine it with what's already in the index, and apply
--check --cached correctly reports that it's already in the index.

I'm looking at add-patch.c but it's not immediately obvious to me how it
handles already-staged changes, so I don't have a proposed patch.
