Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF665C433FE
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C106C22D3E
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="P7zp3JXv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgHFGBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 02:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgHFGBw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 02:01:52 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3382AC061574
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 23:01:49 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1596693705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yKAKkogOnXyY9GnL8pooL3CBofrPuEg4dnI6n/+oOB8=;
        b=P7zp3JXvSuoMqsPkC1QmoH0e+h1e/xtO5OT7Ktxr4k46ekeBt1N5XWn3+/FqFlnZpIU9ro
        jhYWWFgMoITct+hGAYTaOKpgl17V2X/Gm1GaYcr/TRcxhjLWWugUhT8b7QwEaQtUeDNs5a
        5KEB9IBw/hzmlLjY5tt50Man9t1SQO4=
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Raymond E. Pasco" <ray@ameretat.dev>
Subject: [PATCH v4 0/3] apply: handle i-t-a entries in index
Date:   Thu,  6 Aug 2020 02:01:16 -0400
Message-Id: <20200806060119.74587-1-ray@ameretat.dev>
In-Reply-To: <C4ON23BIKMVK.2ZESQJ1FB5PVA@ziyou.local>
References: <C4ON23BIKMVK.2ZESQJ1FB5PVA@ziyou.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've finished this up and completed the tests as well. Just as
read-cache.c says, i-t-a entries should never match the worktree -
therefore, apply --index always fails.

Raymond E. Pasco (3):
  apply: allow "new file" patches on i-t-a entries
  apply: make i-t-a entries never match worktree
  t4140: test apply with i-t-a paths

 apply.c              | 26 ++++++++++++++++----
 t/t4140-apply-ita.sh | 56 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 4 deletions(-)
 create mode 100644 t/t4140-apply-ita.sh

-- 
2.28.0.2.g72bf77540a.dirty

