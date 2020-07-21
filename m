Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F169CC433E1
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 23:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDDDD20771
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 23:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vO/SjS9s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731471AbgGUX3y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 19:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgGUX3y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 19:29:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277B6C061794
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 16:29:54 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id y3so145674wrl.4
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 16:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=lUMDIqXHcyNwrQ/zhPwVBDGP4M3dPi2/PFjbX+9lnYo=;
        b=vO/SjS9s3W9F0hwsY+TEzHlvMvCca5jHTmRxVP4UgEwERYTzdodJg8qXPpX8LAlSN1
         6WkmhdZAcx9uOfQKTHCB8QUPSOQnGvybW18LXXgjUkaTczr6omQjbgyjHf3JDnN47d1a
         j5RUPjUx6y2Ctz9mPJdJ1K8PB3SAk/xrDoqHgeVZPIdHimLWPYCi4kX6kWsNIcSiji1c
         u6i6dN+YnN7Gr0jynGgaQFJiyAyDPUgb2pxSi5pUS4L5pYcOiYR5MpqKc+Jsz7kACXQr
         77SC+5gx8sqYX3JjWh55Y3hJp0DxSCTAC/NPG3w6gZJl+coWZjIA8zepVL0sfNU4eMMg
         aBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=lUMDIqXHcyNwrQ/zhPwVBDGP4M3dPi2/PFjbX+9lnYo=;
        b=dJsFkBettqV1CccmwAn6SXeobuZquEBdF+7o5ZHwjJ+qMHQacM3P5Do3DlqHJoITw4
         b474fGteqeTcHNurBUn0Ts+m6KKzUdfjn8xmfB4e+l71lILZWP2BoIEJ5COkFrB9e/+J
         pNYCh9FqAWV0S//zd/Hg8e1NPPz9+/nGPEkqL9dQ/KDso5eUrHuEAjRkzZImfNm8xiLP
         EWC8SjmHxswaAg9V2D/EtFi1XFJy+llFILiEoowcNNbbOOciik7pvfBPc+CSwCrIMPqu
         I7gsvW6LP2KNtdDUc3IcG9QXT3YhRkOMWnN0ZLDTdnix86P/ukSrE5P1LT6wBXwYFrKL
         sdkg==
X-Gm-Message-State: AOAM533aXWYnWcGpSbbsvoHbls7abUD9s54m8NChvPt4643Kia6embDV
        npqBWqIE7p611nMyei2CXo3mFz4dw08=
X-Google-Smtp-Source: ABdhPJxQIy02J2VY5u8FKZBPGlf4jczxI/dcYDjownxyNU8O0WwpJMs41AfSR0xl8jqVnCYvU8pUtA==
X-Received: by 2002:a5d:6681:: with SMTP id l1mr15008736wru.47.1595374192612;
        Tue, 21 Jul 2020 16:29:52 -0700 (PDT)
Received: from ?IPv6:2a02:120b:2c36:8d20:98db:6930:820f:d5be? ([2a02:120b:2c36:8d20:98db:6930:820f:d5be])
        by smtp.gmail.com with ESMTPSA id h14sm38402459wrt.36.2020.07.21.16.29.51
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 16:29:51 -0700 (PDT)
To:     git@vger.kernel.org
From:   "B. Stebler" <bono.stebler@gmail.com>
Subject: Improving merge of tricky conflicts
Message-ID: <a0418859-c62e-c207-a1b0-1b1aaf178527@gmail.com>
Date:   Wed, 22 Jul 2020 01:29:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have been looking for a tool to display merge conflicts, that instead 
of showing the two versions of the conflicting section, would show the 
diff for that section in both conflicting commits.

The situation that would benefit a lot from this is when one branch has 
modified a large section of code (e.g. change in indentation), while the 
other branch has only a small change. In that case git will display the 
entire modified section twice, making it very hard to spot the difference.

Being able to see both commits diff would immediately make it clear how 
to apply the small change into the branch with the large edit.

I've looked around but couldn't find anything, but I'm pretty sure 
solutions exists. Anyone knows of an existing tool / script that does this?

Thank you,
B. Stebler

