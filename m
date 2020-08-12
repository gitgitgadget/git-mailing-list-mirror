Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43759C433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 17:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05C4E207DA
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 17:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rY7DnP10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgHLR3t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 13:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgHLR3t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 13:29:49 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B3EC061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 10:29:48 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id r9so2273211qtp.7
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 10:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=elr+mSFK8taALdV4AXkZ90zo2rU9KKaT5HiyNaQPdXE=;
        b=rY7DnP108HkqlP0NM1dZ7H2fhubzrS7JtCmhL5qfK8kYmSVTbSd7eKF5DYSqHVIQCS
         HeHM4bJspuUwspw+W+uIqlc5R4arPqI6JGMu3YzS16IqjtRRCKUS1UTnkxPD/wucVRgq
         0HmGVEasU2MeHiOE2ezCujGn6UNG50tpgK2amn50KWG6D8jeNbp39SKxeR5v5j9SSTGW
         vLsenocDqTPTR4zL4y05ym62G3pfWSSQTno6BAxCZbG3qvfxKZZkG/Pf5ChrBqhE/Ocr
         klmxOWukRyItGBID2JYJjkW8aOYETkAA6gbx68W7OJ9VOXzCQV+io143JBo04L9OHN8k
         D8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=elr+mSFK8taALdV4AXkZ90zo2rU9KKaT5HiyNaQPdXE=;
        b=fJxzUR/Jz5dg6Xkjt+miNMjAhlYmAf85TB7n1/MRoNtm1ggso5mk2f74ekADXl4H5f
         jZt5vJ1RWWd/bixtSq90XTEPMXO6GguBE9ojOPh4MAVgV6FvYolMHL5DtmjhCmRa+4PB
         2Ox2mcenSTvfHq4JHzULw4tpaz0RPSTSnX1EQw+wn50j4YZ1INJq7cS2XVOE818/tcmu
         mWYaBDQEQYk2s+bDSL5B9KobEpzwbnQOKLSYaqi6cSGW2phaEcHwssFivxIsic0QVuao
         3RX56k4DumlVDSOcS+cTgiLD6q1hLD4zWdkcnPJfowsgzN6NLH+YmAwsT7go0ee3kyeC
         EYHA==
X-Gm-Message-State: AOAM530dNCQ95AqGIKVg555mlcg/ImVA8Og2ZZ8u/PRBve2leEa5nhEV
        YDFNK+xpnLeDlnbDGAHkxgVsmdZ6YFaNmjTPu9FD
X-Google-Smtp-Source: ABdhPJwlxRWvrPlAZd0P2h2fal0tmyR2tusso7neQ5khwQ9CIkFCK9TAwaDl7z6bbwblJb1sV8FOTiLlb/9ApDAqu3ZJ
X-Received: by 2002:ad4:4942:: with SMTP id o2mr639135qvy.231.1597253387905;
 Wed, 12 Aug 2020 10:29:47 -0700 (PDT)
Date:   Wed, 12 Aug 2020 10:29:43 -0700
In-Reply-To: <xmqqsgcr7r1p.fsf@gitster.c.googlers.com>
Message-Id: <20200812172943.1253226-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqsgcr7r1p.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: Re: [PATCH v2 1/7] negotiator/null: add null fetch negotiator
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     stolee@gmail.com, jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Derrick Stolee <stolee@gmail.com> writes:
> 
> > On 8/11/2020 6:52 PM, Jonathan Tan wrote:
> >> Add a null fetch negotiator. 
> >
> > I understand the value of this negotiator. I'm concerned about using
> > "null" as the name, since it has a clear relationship to zero-valued
> > pointers and that's not what is happening. (My gut feeling starting the
> > patch was that some function pointers would be NULL or something.)
> >
> > Instead, might I recommend "noop" or "no_op" in place of "null" here?
> 
> Personally I am OK with null [*], but noop is also fine.
> 
> 	Side note.  I actually would find it good to establish the
> 	pattern that something that does not use NULL pointer as its
> 	implementation detail can be called null if "null-ness" of
> 	its behaviour is its defining characteristics.
> 
> Thanks.

OK, in a future version I'll go with "noop".
