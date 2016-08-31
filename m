Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 633AE1F859
	for <e@80x24.org>; Wed, 31 Aug 2016 18:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933939AbcHaSjg (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 14:39:36 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34771 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933952AbcHaSjf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 14:39:35 -0400
Received: by mail-wm0-f65.google.com with SMTP id d196so4801776wmd.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 11:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qN+gplrGEjIQwOGOSbAiX656CzoLb7AwBYX9hHwCcV0=;
        b=P6r3Zgczo5QoJiJSEhj8+PAlQbEbKGif01F8aIB2zzvri2UoeyjsP/mPNznxwDjvSY
         2BySmjhBoQn2VDE9Q8jJP/TdC/3N8+5FpYJEoJDh3o1QHZNZN4ssrrjwrMApv35Q4gxG
         8zD/FuKO+4JNTyjCT0iPmXCErT9TPzk3wurhlZcLOm/ea7zXsTuxk6q4N71Nxfxv0Cro
         cv9SySDymwiqUubSaIMviGd6PXxvtWm/KpRy4qRBGNzIDd/fnd38eBAAX7k2ZVBq0bF/
         6zGOYeBVsde2yF50VjevY3WibDR46RuAsRE2M4WOZEgzBStnUeXdscD6cXUi30AcmpRH
         CfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qN+gplrGEjIQwOGOSbAiX656CzoLb7AwBYX9hHwCcV0=;
        b=NA3xYFjsYHrECdOuda9fk092h0BRJLpWT7cOhqu1xSR11nUrTrMK8iTrircEOi/0LK
         cYefk5jh6vzbMIrPDdzkPQ/iNI1WLcmSFo1s0mDRrsjFqr/wTUxmWEJZPz+a2LoZ+xOf
         FbpqfqVEyExcmN9Cs0rtZpyLK2w7I09rtjm9vRVaZM2v1nf0FjG6v1GUFjewzP0Dz6qP
         PiMdJzFToTj4C0RbaqQHpxs3WtpPAox5FUD6gMg5L4jXFaZ8DgQBiYl5/hU+Fn85lXTy
         rSnpDRkvF58y2WNAhC2Ung5s0Ieh00l7FhJkrTRnV7QcREsgpECdaX7MBfm6QxnbOR4f
         h4Og==
X-Gm-Message-State: AE9vXwOHZECH4LnFo94oUVzqANRxa9OnFycSI/x1je5MK9H+cdsQFlsb3jWsR5PuuQiX4g==
X-Received: by 10.194.161.70 with SMTP id xq6mr11793126wjb.189.1472668772855;
        Wed, 31 Aug 2016 11:39:32 -0700 (PDT)
Received: from hurricane.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id jd4sm1165546wjb.6.2016.08.31.11.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 11:39:32 -0700 (PDT)
Message-ID: <1472668771.4265.74.camel@kaarsemaker.net>
Subject: Re: [PATCH 06/34] sequencer (rebase -i): write the 'done' file
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Date:   Wed, 31 Aug 2016 20:39:31 +0200
In-Reply-To: <516d2aaf8837c8675141cf9c330c18c44765b69d.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
         <516d2aaf8837c8675141cf9c330c18c44765b69d.1472633606.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On wo, 2016-08-31 at 10:54 +0200, Johannes Schindelin wrote:
> In the interactive rebase, commands that were successfully processed are
> not simply discarded, but appended to the 'done' file instead. This is
> used e.g. to display the current state to the user in the output of
> `git status` or the progress.

Wouldn't it make more sense to have this patch before the ones that
implement the actual rebase commands?

Hmm, and after reading more of this series, I think the same applies to
some other patches too, e.g. 08/34 and 14/34, so I'm probably missing
something. So before I make a fool of myself and suggest that the
implementation of the actual commands should come at the end, maybe you
could tell me what I'm missing :) 

D.
