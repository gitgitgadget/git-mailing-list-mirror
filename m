Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C14C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 21:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiKHVEC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 16:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiKHVEB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 16:04:01 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48ADC20BD8
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 13:03:57 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id r81so12496387iod.2
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 13:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HBcd2k0ARVFLSTbC+7Q2KltcEucKLrWyvQdu38knPfk=;
        b=BNkvFy3ahvsFs48dvwx2h8/j90sIWFV72wKccdAUhU+M3fmZHr1hoXezE9LyMwbXF7
         JojMN6W5X2KhO5p7kDI/d+AShztbjYRwDRiPm7oBaKgg5A4ZC/z5/lzWkjJXhY+lRQ9H
         oTw3INLSds+ZcwHLFXDd9xU9TMOR2Inj2Y23/4VRd8jUglg6A45ax8aVZLjLSIoN37PI
         1genos3yZyIPZP//j9CEQ9E4rZ+gXsvOXBOrWg8F/TZCDtvz6IcIzgAnLOAxv6+3ZdSB
         gbb8Z9oY1lITIhQMZu6WNf7Oq+mqCDl7+65fW/DPKABl8ch8a4FtA0BDEvfA9ETQVeyY
         NntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBcd2k0ARVFLSTbC+7Q2KltcEucKLrWyvQdu38knPfk=;
        b=YGvlPx9AWOTIBwjzW/np3dPnr/uudpxQLOFpX3XeuFCH5/1p/cPfzLGY9fIUtpXvad
         Bl2egyG2tYHrk5yuqy6pUp9icXSZ/3QMR7SsIw5Nqw+z1VA0zDzMtNSnNENdULXSh0jD
         +TAcdRSezbkPx+4yEOPYq69DADtfkw3fae91nn8fg3LTc4rlhgyP73H4asqnvvrpSA2h
         YET2O3K3c0HiKXGtEnAh54Ib4ELp6Gir2Bf6wg6rK+DpHZUPaykCy8IH5Uu7Oi/jcqQw
         xO1UFW+NxL0gZuNHHJUk/S66BJ9cBlGEd7RmgxS5pOEpHr7585BQo1EGNsFQ24MIzahc
         I2kg==
X-Gm-Message-State: ACrzQf2UGkGIJuWBOT6/yjNdzJpcbbSELStbuvNLQTc9rmiKURhEbC2f
        MB1l38jBT1C5BNsOBuhgEqRYpQ==
X-Google-Smtp-Source: AMsMyM77MTGNtbYq4+tJ0BLrIiV3c8pTbR814qwfa7ePRS0HUnKMNV/+2IHHr5lPr3ahcsKgzCdiQg==
X-Received: by 2002:a6b:8b0e:0:b0:6a3:8925:be51 with SMTP id n14-20020a6b8b0e000000b006a38925be51mr1053399iod.51.1667941436611;
        Tue, 08 Nov 2022 13:03:56 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s16-20020a056602169000b006c3fc7101fbsm4674082iow.3.2022.11.08.13.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 13:03:56 -0800 (PST)
Date:   Tue, 8 Nov 2022 16:03:55 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     M Hickford <mirth.hickford@gmail.com>, git@vger.kernel.org,
        Matthew John Cheetham <mjcheetham@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Subject: Re: The enduring popularity of git-credential-store
Message-ID: <Y2rEOxgEskE0seAs@nand.local>
References: <CAGJzqskRYN49SeS8kSEN5-vbB_Jt1QvAV9QhS6zNuKh0u8wxPQ@mail.gmail.com>
 <Y2p4rhiOphuOM0VQ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2p4rhiOphuOM0VQ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2022 at 10:41:34AM -0500, Jeff King wrote:
> So if you're asking "should we stop shipping credential-store", I'm not
> _completely_ opposed, but I do wonder if its popularity means it is
> better-than-nothing for some folks. If you're asking how we can nudge
> people to better systems, that seems like a pure win. But I also don't
> know how to do it. ;)

GCM is such an alternative, but I don't think it necessarily should ship
in the contrib/ tree. I don't love the idea of a banner nudging people
to use arbitrary software in Git's ordinary output, either.

So, I think my point is that there are easy-to-configure alternatives
out there, and they are certainly worth using over what's in contrib in
certain circumstances, but I, too, don't have a good plan on how to
nudge people to try them out.

Thanks,
Taylor
