Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948EFC433E3
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 18:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CB8F2065F
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 18:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nt4YQm8m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgGOSUQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 14:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgGOSUP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 14:20:15 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC9EC061755
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 11:20:15 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id m22so3455266pgv.9
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 11:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ASWJFvHQgQeOvj7p2QaLxPDGDC5IFjDmVSXZ3tEko3Q=;
        b=Nt4YQm8mFLWB9cgPvDHY8vaXmf0Xx0ZRqXqL4JaPnJHYRQ3UaZjaG2ppkpO7YwiJlv
         X+MFBQ6kwQ2lkN991ZLI2cL0LCETP0FcgA+EsRAVKMvLV57vKiYrsCsVoMXD0TkOBfEu
         2wz1hcgHsxls9bLB4T8HVA+7iY/WY1e1ebSBL4hLlQDZt7ytWViuLw3UvFNP7rwenu++
         0IiGsX/xGzdc6I6+Vos8N4G6fLWqngvUoxJaq81v6plJrT5u5wo3vi9bcfHoDM6nNlcv
         gPXkLt3YETjK3y1t6up8KxPkqSf4r68/gcswHNOzM4oGgpK45wS3CrFcVUNkrXXiL6kB
         ELiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ASWJFvHQgQeOvj7p2QaLxPDGDC5IFjDmVSXZ3tEko3Q=;
        b=klY/6SmdIyu5RuV3OPzf+AQbhPX7G2VC9q72/fnbEUC1wXpAJlMMtq5+PnM5SdzdcS
         7cjOe6x8VZQHwQB2TEZKWHufXL4Zxs4ZJQtOEO+2fexb6C0RkBYx5wX5FHEx/qWNMuL+
         2cWKNmT0p3mS9ue9rfXuCXQ+IN2VscZSJcWpqQZZQrBRwIYw8Y13kny43lY3poe6GNdB
         3X6YGjlnbX1iC/mAPsmI7MYbuzDfCfJXJ5gbsbPSfoZZHpfonuImC6BBzPoWIOcy4XW1
         0GRiCwLa8WeAB0KXEgJjdEkjFqgYKA7tFag87yaaT1fIEuNYh+unezQCGIUXUekgIyHS
         zBRQ==
X-Gm-Message-State: AOAM532SmLYl5Y3EeztAUR++RdDafAX0ApcihZpIMBimT53sDQDk8AZg
        GrNxOStqVHFbzFFV6cC4X9o=
X-Google-Smtp-Source: ABdhPJx1hd5ekkRo321C6TxkANO6W4SWpB1Zxj+UGB5uXEaC8rnnnnTvS4zpRLtTPbPXmU8beZfMlA==
X-Received: by 2002:a63:8c4a:: with SMTP id q10mr834995pgn.431.1594837214624;
        Wed, 15 Jul 2020 11:20:14 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id oc6sm2868942pjb.43.2020.07.15.11.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 11:20:13 -0700 (PDT)
Date:   Wed, 15 Jul 2020 11:20:11 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, delphij@google.com
Subject: Re: [PATCH] setup: warn about un-enabled extensions
Message-ID: <20200715182011.GA2950865@google.com>
References: <pull.675.git.1594677321039.gitgitgadget@gmail.com>
 <0bede821-139a-d805-934a-142004abaa4c@gmail.com>
 <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet>
 <xmqqzh82ktgm.fsf@gitster.c.googlers.com>
 <xmqqpn8wkben.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpn8wkben.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:

> It seems that there is no quick concensus to go with your "different
> endgame" and worse yet it seems nobody is interested in helping
> much.

Sorry for the delay.  I do want to look at this this afternoon.

[...]
> I'll shift my attention to other topics that should be in the
> release for the rest of the day, but am pessimistic that I can tag
> the -rc1 today, which won't happen until we at least have a
> concensus on what to do with the (apparent) regression due to the
> "upgrade repository version" topic.

Ah, I hadn't realized an -rc1 tomorrow instead of today was on the
table. ;-)

I'll do what I can (in other words, expect a patch from me; but also,
I am very interested in analysis, proposed patches, etc from others so
that we can end up wit ha good fix with the solution space well
explored).

Thanks,
Jonathan
