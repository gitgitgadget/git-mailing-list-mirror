Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1A041F597
	for <e@80x24.org>; Thu,  2 Aug 2018 21:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbeHBXH2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 19:07:28 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:51155 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbeHBXH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 19:07:27 -0400
Received: by mail-wm0-f49.google.com with SMTP id s12-v6so4060290wmc.0
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 14:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=trzEbwrCXjAjjXNzl1UEXdIpw26hng/ZffcBZ5VBO3E=;
        b=EQ/D+7osIkvzRlOw47M03rjd3RZszUvEvRpLUjWuQPC1wooBv2gi+crNaW+2EdGy3W
         owm2rIiHC/3j8n0JtAwT8zH01OpKHCsxxPY/V9jm0AfivlIhLC7O3ecvAxAx92DRVrU3
         ymthtKCWGITQE+Ky2EGmKaUYku6JnNH2cKaD961L9ZYNRSRMrWWwTvYScjq98WpTEZGo
         1MaARSFCb1fR8568fxOY3RyNQeZW70/AeL5ZDSszlF9OaY+eHC2kn9PF2tiBZIjqP44D
         THgLGKd7qfnyFuas+2ACl6HBI/53oZpABv6uYL+Lelr3o++17EA8CFtCM3vED3zZTuYT
         oxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=trzEbwrCXjAjjXNzl1UEXdIpw26hng/ZffcBZ5VBO3E=;
        b=CBNZmzdxtDlNbGMfAQi/cyyXmsqrxKwUxMHXsnQ9PYX9ebuoG2W1Ok9A4TG6UB306j
         rYICD8GJtXufGMU4nfZL3yVGzGAhOfheY6KoookZ5GD6+B/OPgScDdnVhKbsxQrt9gTQ
         +a5Rn09hbbtsPti/n9TWYIGZ5S0o8n5Qv6KiK/KBqJ9Us6Vr61mtqc3ntc+H9vq0A/b5
         fs4ADoCHA4JmCJp8Jjd6+3WTDl49rVQ56bVctScFFu87iuJFHYEiwq6sSv/36BKZOf/X
         o3UGwxtcO3ALyNL4hEN6IHKePF4yHaYK436i1zCx1Xak8oGzWQGFlz1JDLDBnaTwcVJk
         0OUw==
X-Gm-Message-State: AOUpUlGpZDGHuw/jdTj6CrgGh+gm15pKHX9zE2Y8/GFQ+yxk/b3886Yr
        MB4ccVG0zzu8dx5cpjsntzfCqJet
X-Google-Smtp-Source: AAOMgpfC0biQkEE6OGWCv65LyILWOzaNolOa4Z2lEUnWRHui5ZMYh7TZyoudAoA3OXhGUzrDrzfp/Q==
X-Received: by 2002:a1c:91c7:: with SMTP id t190-v6mr3233272wmd.2.1533244471778;
        Thu, 02 Aug 2018 14:14:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d8-v6sm2261583wrv.68.2018.08.02.14.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 14:14:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?Q?Pawe=C5=82?= Paruzel <pawelparuzel95@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH/RFC] clone: report duplicate entries on case-insensitive filesystems
References: <20180730152756.15012-1-pclouds@gmail.com>
        <CABPp-BG+nB+ifRbCdMpXnnxQ+rzhM8W-=sfQf8TYmXvuPy5WXg@mail.gmail.com>
        <xmqqo9enb4n9.fsf@gitster-ct.c.googlers.com>
        <20180731192931.GD3372@sigill.intra.peff.net>
        <xmqqva8v9nc1.fsf@gitster-ct.c.googlers.com>
        <20180731203746.GA9442@sigill.intra.peff.net>
        <xmqqin4v9l7u.fsf@gitster-ct.c.googlers.com>
        <xmqq1sbh7phx.fsf@gitster-ct.c.googlers.com>
        <CACsJy8DFX2=CaTomc33uuHQ-nBvgfutVbaQ2DxT_p8-hzj6PsA@mail.gmail.com>
        <xmqqpnz03f9o.fsf@gitster-ct.c.googlers.com>
        <20180802190644.GE23690@sigill.intra.peff.net>
Date:   Thu, 02 Aug 2018 14:14:30 -0700
In-Reply-To: <20180802190644.GE23690@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 2 Aug 2018 15:06:44 -0400")
Message-ID: <xmqqmuu4zd1l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I also wonder if Windows could return some other file-unique identifier
> that would work in place of an inode here. That would be pretty easy to
> swap in via an #ifdef's helper function. I'd be OK shipping without that
> and letting Windows folks fill it in later (as long as we do not do
> anything too stupid until then, like claim all of the inode==0 files are
> the same).

Yeah, but such a useful file-unique identifier would probably be
used in place of inum in their (l)stat emulation already, if exists,
no?

> PS It occurs to me that doing this naively (re-scan the entries already
>    checked out when we see a collision) ends up quadratic over the
>    number of entries in the worst case. That may not matter. You'd only
>    have a handful of collisions normally, and anybody malicious can
>    already git-bomb your checkout anyway. If we care, an alternative
>    would be to set a flag for "I saw some collisions", and then follow
>    up with a single pass putting entries into a hashmap of
>    inode->filename.

Yeah, that makes sense.
