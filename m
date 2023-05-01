Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF777C77B7C
	for <git@archiver.kernel.org>; Mon,  1 May 2023 22:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjEAWIf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 18:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjEAWId (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 18:08:33 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A96B2114
        for <git@vger.kernel.org>; Mon,  1 May 2023 15:08:32 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63b8b19901fso3578901b3a.3
        for <git@vger.kernel.org>; Mon, 01 May 2023 15:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682978911; x=1685570911;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSR23OfnElhtG9jI9KnmolzhsTcPl7XOH+iZvVrE/PA=;
        b=W1LkbQhCij65VQtgTCekhXwbYJICtlWUHyPNiMtQz1lHXtOfyp9+l2T9xyreFUqRT3
         UmEVCb/qGU9x6SDQ+vYeNH9MAOSt/87UVVpJkU5HbxjKMcG5pPicGgQmbz4Coc52ABwT
         twtGqTDNBQv/Xb/8QoN7EmIkYLfQGa5+pX0DO31dFYU93cmSbRECzU5ZW55DR76lknaQ
         80oOqvKuBv70EdEO0h5BYm4LFSOfrPaLML/W32AngfXCWOnlODhdmQdFnantoI2hvPI4
         ESoKrfGBW/0EHcKfc2gPsT+OLr2j3dMH+BBY7u+IXP0+8UV8+G3kxuwlweoz6wvlhHiz
         +mow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682978911; x=1685570911;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gSR23OfnElhtG9jI9KnmolzhsTcPl7XOH+iZvVrE/PA=;
        b=YZ9DomL4wU6+bSh/v6AXElHaEjLxfqRR/gM2/S2DY8F1oMNN0Y1Od+rmsBKiBg8JDw
         yzOrQq768EvVUSSEe11fTR2lpVAktNRgfMB+3moAhD5oDgBlBG3cXsmOJy6n5XMpZxQG
         7rmguDfXiC4TXghhikjmnbjYgjuaXVZ+iqvYBQNZs7JmdAhT/jVSjaE8uItz3l3iGXfb
         wWYutsSh/i3u61T5PB5PfKKZXd06pnZ+CxL8bLNHyThDtzY9g5Gf35/N/xs+A70q6d3s
         ZmpJaeM/rskfQ56cQMb9MSY2xFqQzxwh15QxWw17xgzcYC0E9YqTMY80GHdNaFNFDIdD
         DWKw==
X-Gm-Message-State: AC+VfDwtN1IU84/tWlnJD79XLp5UadqS9feHgyrxF09PTok8PD2AUJga
        XmVa1H2azHkBzhfMHWcvCzg=
X-Google-Smtp-Source: ACHHUZ7adghsn6h2BRnXDhPFLrwBK+J3FFJ0mit88QM0UnfB5JUomIppw0rZR/oLVt70ht3jaCwn/Q==
X-Received: by 2002:a05:6a00:ccc:b0:63f:125f:9595 with SMTP id b12-20020a056a000ccc00b0063f125f9595mr21333320pfv.9.1682978911430;
        Mon, 01 May 2023 15:08:31 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id i7-20020a056a00224700b0063b7c42a072sm21027730pfu.13.2023.05.01.15.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 15:08:31 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/3] pack-bitmap: boundary-based bitmap traversal
References: <cover.1682380788.git.me@ttaylorr.com>
Date:   Mon, 01 May 2023 15:08:30 -0700
In-Reply-To: <cover.1682380788.git.me@ttaylorr.com> (Taylor Blau's message of
        "Mon, 24 Apr 2023 20:00:17 -0400")
Message-ID: <xmqqo7n33dsx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Here is a short (but dense) series that I worked on towards the end of
> 2021 with Peff.

The topic gathered interest on the day it was posted but after 24
hours or so activities seem to have quieted down.  Are we expecting
a polished version?  Or did it open a can of worms that is a bit
larger than we want to deal with and the topic is left on backburner?

Thanks.
