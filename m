Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EAE81F453
	for <e@80x24.org>; Mon, 24 Sep 2018 15:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbeIXVT7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 17:19:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43053 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbeIXVT6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 17:19:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id z14-v6so2589042wrs.10
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 08:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TxFfGOjxdIO6gmXJ6t39Wsh90FK65LrQnpIBkPj1uR4=;
        b=qWGMo73PhmKyANt1hQp4oRIq/d4pqyUtAtK404UXe0rMJnpc6HCm505FmUNBKyInjy
         U623SEyU97FdjJ03D6ddAr+qMIvzXKe/RorVgE9hXcZ3ng0VXi8QjHWE2Rjjjqk6eAws
         NeYuwCPnNVhWJaA24OBCkDZhQ7EgdumsldNOTb4+c7fICC/xBwXo0JO6xeW/rsPh0Zsy
         ey2/ZwvkZzZiD0cVAKUZmFD+UM8HZTZDVepuFoorp+nnozpoJcfHe2rNuFLRS34HJflB
         3Jz2XfY6ivsQfa1FVFc5ifQu7Lk8tN1RAPhSKnNCso2exXypEUZUUraYbe0WQ21lYCLV
         pr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TxFfGOjxdIO6gmXJ6t39Wsh90FK65LrQnpIBkPj1uR4=;
        b=Wjv8IkHPeH3i3cKZgWAQWWOlYa39nfAbtTATZPoWZZk+yET5c7ihShl05xev+D5d8x
         bb4tZK9bxMvJ04Q5qKHT+2ClYnMUwIHquaGAo7r1OAyk0eHoM7JCEM8Z4r8oQrX+VDLa
         QtqGDSlkd4iOVwfi4CC842EjmtEOvb0eCLHEl65+fbjYAKvtSX5+u5vuzn7id9qnIfgW
         lgl1dHgTDCsOirlXs92ta3Bn3cFcBTba4wabXFV+LWrcx8eH9lYFFEHX3sUme/GRSLkx
         +lr/jUOZwICgcXDLLj3ycKubOu/Qb8GUKPbFWINdcXyagmtT42ykeVnNedAhfNExDgfV
         u0Yg==
X-Gm-Message-State: ABuFfoh1x80t67LwUBDBoIEoa2VgHcgZGBz0SMsntf8vNgDy+MldbBTH
        yHgfpgOifpJzLaHxLgsLOMI=
X-Google-Smtp-Source: ACcGV63igaYXbyaGq2oyuMLmCjr1+CUvqnReVg+m5iA0HMQs9nSHxbZImzv0leQtuRRbpzuYTLpbnQ==
X-Received: by 2002:adf:9142:: with SMTP id j60-v6mr9581025wrj.180.1537802236718;
        Mon, 24 Sep 2018 08:17:16 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t2-v6sm29231813wre.96.2018.09.24.08.17.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 08:17:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        sunshine@sunshineco.com, sbeller@google.com
Subject: Re: [PATCH v2 3/3] transport.c: introduce core.alternateRefsPrefixes
References: <cover.1537466087.git.me@ttaylorr.com>
        <cover.1537555544.git.me@ttaylorr.com>
        <6e8f65a16dc0be84234d2be93bb4a5c9a585dd57.1537555544.git.me@ttaylorr.com>
        <xmqqbm8qv9hy.fsf@gitster-ct.c.googlers.com>
        <20180921213753.GA11177@sigill.intra.peff.net>
        <xmqqtvmitsi4.fsf@gitster-ct.c.googlers.com>
        <20180921221832.GC11177@sigill.intra.peff.net>
Date:   Mon, 24 Sep 2018 08:17:14 -0700
In-Reply-To: <20180921221832.GC11177@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 21 Sep 2018 18:18:32 -0400")
Message-ID: <xmqqftxzsz5x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I was suggesting that check_everything_connected() is not strictly
> transport-related, so would be inappropriate for transport.*, and we'd
> need a more generic name. And my "either way" was that I could see
> an argument that it _is_ transport related, since we only call it now
> when receiving a pack. But that doesn't have to be the case, and
> certainly implementing it with "rev-list --alternate-refs" muddies that
> considerably.

Even after 7043c707 ("check_everything_connected: use a struct with
named options", 2016-07-15) unified many into check_connected(),
there still are different reasons why we call to find out about the
connectivity, and I doubt we can afford to have a single knob that
is shared both for transport and other kind of connectivity checks
(like fsck or repack).  Do we want to be affected by "we pretend
that these are the only refs exported from that alternate object
store" when repacking and pruning only local objects and keep us
rely on the alternate, for example?

In any case it is good that these configuration variables are
defined on _our_ side, not in the alternate---it means that we do
not have to worry about the case where the alternateRefsCommand lies
and tells us that an object that the alternate does not actually
have exists at a tip of a ref in an attempt to confuse us, etc.
