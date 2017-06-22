Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E42720802
	for <e@80x24.org>; Thu, 22 Jun 2017 22:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753397AbdFVWKM (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 18:10:12 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34853 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752429AbdFVWKL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 18:10:11 -0400
Received: by mail-pf0-f196.google.com with SMTP id s66so4796371pfs.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 15:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pDeRoyRN6mvIMlF5tqWe2vamh8xrR2A/Yg46wL8r1nM=;
        b=qvscXFqeRfTwyOlLNe4IvQoxm+vbUkWmm+xQMXifhVyzZLgRssC9GJsopPfRNtIUnD
         RlKZbs5b0b0YtMOe7CQpecuszyHAvhwcR5l7wxGoBw5Petc3UfgJAStqehEDu5/RovGD
         G1chjiWHGFU3cw/RzRz0XbEugyGr2X0PyIcf5EntCv/5DC8OQ2DIG7k+1UkDrBKFmH2+
         mJhFslty2fSHsm5tWN6CH1ipUROwW9GSJZF5iZ0QrY5tabyLUH571Kj+hBBJMAnleJ2T
         elcFavOVhEE/fBjT1FpIL0gC2FwywSRj5wEMtgguYVbbdy3gf8EBthAfoMdKYqBclN2q
         4Sng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pDeRoyRN6mvIMlF5tqWe2vamh8xrR2A/Yg46wL8r1nM=;
        b=qkQcoENiu7/akSt3snG1E7lRPXhcuwoDtP7jt7el1KoVB7minKCdpy9LXbbO7PjPX4
         MN8lQXPzPT8XhqvYnibEAsFP9rd0rePu1+KYeQqFuZ95RHyylsDM05+fOp3daBBiubx0
         kqO5r9M4omKObeHRrt9MGLauFJaFmga1uVyp5aRp5jWQk9J8avLGhzgNXT/ZyWgCZMyX
         xMjf+0emV5//B4TETYhADDtADnGVW0f3vpONg9ROvhcCzTtzxAEOehs51OsGbRS6ef46
         33B7Li6MBM5QD4WX0+I9FzRONJe8PX5bwly3++BD0cPmYD+W0HnwfIy6ZA3MXyMiByK4
         EZhQ==
X-Gm-Message-State: AKS2vOwYz3aUEeJDgPL+QgXOSlQCn1TukyR9FuvBG507Oe+4UYSSZK70
        mF5EB/3gj1e6/xTpG3g=
X-Received: by 10.99.125.8 with SMTP id y8mr4639643pgc.267.1498169410348;
        Thu, 22 Jun 2017 15:10:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id r12sm398302pfi.61.2017.06.22.15.10.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 15:10:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        jacob.keller@gmail.com, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, peartben@gmail.com,
        pclouds@gmail.com, peff@peff.net, git@jeffhostetler.com,
        avarab@gmail.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 15/20] repository: add index_state to struct repo
References: <20170620191951.84791-1-bmwill@google.com>
        <20170622184348.56497-1-bmwill@google.com>
        <20170622184348.56497-16-bmwill@google.com>
        <xmqqshirixrt.fsf@gitster.mtv.corp.google.com>
        <20170622203511.GB124061@google.com>
Date:   Thu, 22 Jun 2017 15:10:08 -0700
In-Reply-To: <20170622203511.GB124061@google.com> (Brandon Williams's message
        of "Thu, 22 Jun 2017 13:35:11 -0700")
Message-ID: <xmqqziczhdxb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> That makes sense.  While at it, would it make sense to ensure that the
> 'struct index_state *' which is stored in 'the_repository.index' be
> '&the_index'?

I was imagining (read: speculating one possible future, without
thinking things through to judge if it makes sense at all) that
conceptually most of the current API that works on things in the
current repository to be implicitly working on the_repository
singleton instance in the "repository object" world.

When that happens, the_index can become a CPP macro that translates
to "the_repository.index", I would think.

