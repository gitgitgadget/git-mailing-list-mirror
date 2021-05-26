Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36169C2B9F7
	for <git@archiver.kernel.org>; Wed, 26 May 2021 08:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07A78613D3
	for <git@archiver.kernel.org>; Wed, 26 May 2021 08:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbhEZIHM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 04:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhEZIHL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 04:07:11 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6B8C061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 01:05:40 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id y76so696934oia.6
        for <git@vger.kernel.org>; Wed, 26 May 2021 01:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=N51Lv6+468c4YpJdeDxUGqYxwJmASSZ1TGLqnMQvVy0=;
        b=uxuEqwdZMNCSs6RI5S3dq8XJn7CtD/wbUd1pRZow16d/OnpAJM8zZKcIDBRQNQkV7W
         0k/FYUDRSIsiYXBAVCzU69Ccne5BSf/swcQeUNmb9zuaQ264wF/NLmxxoTurpWw8EKwP
         rQaYp1ZHdp8st+EPwEQTZcPCklmXybp+P+FwRbscTAqqbENIOvZeJYn8VsVpMOPdfCjS
         SnmoabcSNAiX6LFy5VjjKpGtM/QthrWv2vJ3ewCUjnBcJM6f7MgOIemC4fq91f/P+MW0
         +vE7rf/y35oqFC+VbZi844Bkn7PRoPI0UB051qW4sJPsP+sCGymPOXoG+t0XzqPdfziS
         AjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=N51Lv6+468c4YpJdeDxUGqYxwJmASSZ1TGLqnMQvVy0=;
        b=Nm/pMB19BFl0aRzlaL5DLdg6/vXVlb5rdhaXmXqzKXRjT1VXbade2sWtFFWyNn8fQs
         IQbcBM+TLBJ4auy0UQfrUGYYfoF74uNx49G97H5qtPuWULnPBqufsyLsb/oagMsfRkWR
         GRfWdylKkBZcdaGX1ZxnbDEsOnHdOiJlgFplUVuNeKBHqpDfyD91uKbifduAoUhlmOzJ
         fXUZ39vlKvkBSDXtYX0mvDp7yBhpyNH2pTUonQE2Ig+uUvvvPjrO+znKowLNJ+Q0qDmV
         OBffNBuTqmMmZp2HP5QK6CdftSXa6ChUXH26/2PYOZxSR+fLszHE4981WW6kQU3V04uU
         85kA==
X-Gm-Message-State: AOAM531nJL9g6JGa5uEImrkDFWSebkP7MhRhoMfy9nyVRjtLxJEG0jaZ
        +PH4ziq5gDx6Xe121ZRBcdI=
X-Google-Smtp-Source: ABdhPJzmBZBTenCNkwTfJv3Aj1cGMkZg2LyYAQX0ZBn1l4PR4cN1a79a5Ug8cB+M14spinnpYKhs/A==
X-Received: by 2002:a05:6808:d1:: with SMTP id t17mr1058418oic.109.1622016339523;
        Wed, 26 May 2021 01:05:39 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id 35sm4400450oth.49.2021.05.26.01.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:05:38 -0700 (PDT)
Date:   Wed, 26 May 2021 03:05:37 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Message-ID: <60ae0151b4df8_34e96208d0@natae.notmuch>
In-Reply-To: <24504f19-eb8e-c725-723a-22efea7c865c@gmail.com>
References: <60ad75ac7ffca_2ae08208b@natae.notmuch>
 <24504f19-eb8e-c725-723a-22efea7c865c@gmail.com>
Subject: Re: The top 1% of commit trailers
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya wrote:
> On 26/05/21 05.09, Felipe Contreras wrote:

> > Total wealth: 1%
> > 
> > [1] https://gist.github.com/felipec/ce491d351c88e4acbdbf6bc02a47223d
> 
> Why did you deliberately exclude Signed-off-by trailer? I don't see
> that trailer above.

Because it's in a completely different class. It is mandatory, and we
all know it's #1, by far.

In the wealth analogy Signed-off-by is a king; so far away from anybody
else it's not even worth contemplating.

> For some trailers that have only 1 occurrence, these are typos of
> intended trailers (such as heled-by and helpd-by which means
> helped-by).

Indeed. I had code in place to fix those, but then I decided against
that because they exemplify a crucial part of language; mistakes happen.

It would be cheating to hide that truth.

Heled-by is now part of the history, just like
Simplified-testcase-and-bisection-by, and I'm not going to try to hide
either of those.

Cheers.

-- 
Felipe Contreras
