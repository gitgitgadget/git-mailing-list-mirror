Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D5FC43334
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 14:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347601AbiFTOSO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 10:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243913AbiFTORu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 10:17:50 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF5024F11
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 06:32:19 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id go6so5422896pjb.0
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 06:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hCMnEmVmhSarA40M4xokJkBt9WnZFHiBO92VBaRt+jk=;
        b=EjAOfyJfjqXSImWai63dzz8AsqsWODvaO/IzJ7/2WI/s+j4n8ianTbGotU1Z8RnX8J
         yoRN/yi9RKMf4aywb6Bw8zez5InUe/YkXGVZQAgHj+ztcgDjNxbLgaRjsDgt/Vy23Cb9
         LWzF/R7Bzb834clQsUO6BKce1iidiWaZCxTgd0nWYU6SCho+1P0I3GKtPE0ZDQ0X5eHm
         P0uvNUfqq9FmGe5nL5VZpOOFTILxLw36emhv2R0E+rJFu5lLmU1Cf64my20lkFburZqa
         MfT856spHCiJCFVOQJQcy8v7mkegPxjIwrFD+ADa8XyPKh5YcXsnpTqDwor2BDsBXtcI
         Shmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hCMnEmVmhSarA40M4xokJkBt9WnZFHiBO92VBaRt+jk=;
        b=Sk2RmKObEThZRdJrvi/b/fPeGqjTKdGSQjBR8Pyg65pkX89ziwluzIURR6zKpQ7rsA
         /fxAlw2dJpL2kJCp2nrJagxc2LZ1eTkzt1flDtXXWw9447alOCPaOLcI9eBU2TrHH8Rg
         OLMZomHLqpiy8t7akcmGUTzOlMspWqUAmEbXpGuFjUS+4njEUxHaNmxOzGkFx7o/6kFL
         Uld++1kkO86uKZoKN7/23//L1Z0tnaVkE7WvqQpPKgF08G6RFfCA0siGdi1hWrb2rvNw
         EGtC2N1bCbuk8b71BfQl17JsXXQE3Cs2H64PlBX24ldquB1STPXrKJmqKgwPgMdVh7td
         k8jg==
X-Gm-Message-State: AJIora/Yj6OTUNUiUYzo6+E2OjKdd+gLQZSkq7MjBpIFSidBTWRE/UrA
        +ZZTvGER1R/iPv5Jq7PEfJ4=
X-Google-Smtp-Source: AGRyM1vQBbBnOnXpdvJWUni/ufqtFP4gTmfLzwgfXVnNrsh9dqaU8zZurNXKGqCBUMB+wQUZfI/a0w==
X-Received: by 2002:a17:903:268b:b0:16a:17e5:f2a9 with SMTP id jf11-20020a170903268b00b0016a17e5f2a9mr9329030plb.38.1655731938521;
        Mon, 20 Jun 2022 06:32:18 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.39])
        by smtp.gmail.com with ESMTPSA id l3-20020a17090aaa8300b001e08461ceaesm10473755pjq.37.2022.06.20.06.32.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jun 2022 06:32:17 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v3 5/5] bitmap: add trace2 outputs during open "bitmap" file
Date:   Mon, 20 Jun 2022 21:32:12 +0800
Message-Id: <20220620133212.35937-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.582.g270d558070.dirty
In-Reply-To: <xmqq5yl45lgm.fsf@gitster.g>
References: <xmqq5yl45lgm.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 13 Jun 2022 13:59:05 -0700, Junio C Hamano wrote:


> The patch adds new statements at a wrong place.  The block of
> declarations and the first statement in the block were separated by
> a blank line, but they no longer are.
> 
> These things tend to show up in merges quite clearly.  They do not
> cause more unnecessary conflicts but can make resolution more error
> prone.

You are absolutely right.
Will fix.

Thanks.
