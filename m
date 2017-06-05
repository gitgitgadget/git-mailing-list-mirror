Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53B1A1F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 17:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751686AbdFERff (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 13:35:35 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33224 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751677AbdFERfc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 13:35:32 -0400
Received: by mail-pf0-f169.google.com with SMTP id 83so28451165pfr.0
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 10:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0XGlGqz17m+0Pcf5pkI/yjSbguZRTkwb+nue08O9XKQ=;
        b=stZQvvB+VGOUyZTHk9j5vJabbQtgtluky9DI+dZGWIcy+7b4Sf4McJXSuVBO70QiyX
         O3vk1vG/EQsNgBQwIH19OvI4HwmdFRe1JfxPLnA9N4tK/tTkDOcLg61g85Niw/BDMP5H
         zb2pwjtVIKvuYkr0Akd8y5qlVoQ3yhHmOwlcQEQe3Gjvc+nI66eG/Ic4C8t+Ca1rGx6A
         sRXrup0Po3Q55RRDnYSyHrbRQT5XT+VO/RiL2tBY9CrHXG5KA5R/1U+fnsqRbxYx8gLF
         tJ8j4GQPavFk852VPgotxSkdRctMPB7sQQU3Locj29jlQpo7ZVmK+CcTyULhz2z07yC6
         /SeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0XGlGqz17m+0Pcf5pkI/yjSbguZRTkwb+nue08O9XKQ=;
        b=FT5sPNcULKcCsSajAxQmv9bW8XNaG3iNrkWjSgqAB5XtGG5IK6twrDJJTyoSdK7Tbm
         CcLNYqBYhc8836hvTVGnB1eqbFhqi3D0iA/HPaOhs/DjcfwDN8ctmxpfaOM64KD2UCIo
         KtoKZxzB+P1SFUY1qW1qfM+Jfg+X8Bh3fNYg2WjmzB4gEhtR13hKp3gYdmmNKH8v/2K8
         3VyDP11hFTWVtK00YURnuPZ+6If433PvcZ5ucCimujxSNqDK7JFJIKSH9MaqAcSuHoaX
         eEBhHCWN+906nHhHMs1mMX7eZAvJbkQGqiki4r8dyif/eO+fnj8ncRHIVAGVLfZyivpL
         2J0g==
X-Gm-Message-State: AODbwcALFBADMPPapWVrYeNCj9HQf5qGa8RNixsJm8xqW6hhVt/FRj5O
        oHdq6TxWtniJKDE4
X-Received: by 10.99.185.5 with SMTP id z5mr18220318pge.231.1496684131187;
        Mon, 05 Jun 2017 10:35:31 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:e08c:b56e:781e:900b])
        by smtp.gmail.com with ESMTPSA id h28sm61051867pfd.55.2017.06.05.10.35.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 05 Jun 2017 10:35:30 -0700 (PDT)
Date:   Mon, 5 Jun 2017 10:35:23 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [WIP v2 0/2] Modifying pack objects to support --blob-max-bytes
Message-ID: <20170605103523.190c9f16@twelve2.svl.corp.google.com>
In-Reply-To: <20170602221645.nsz6r6tgfndulc6c@sigill.intra.peff.net>
References: <cover.1496361873.git.jonathantanmy@google.com>
        <cover.1496432147.git.jonathantanmy@google.com>
        <20170602221645.nsz6r6tgfndulc6c@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your comments.

On Fri, 2 Jun 2017 18:16:45 -0400
Jeff King <peff@peff.net> wrote:

> On Fri, Jun 02, 2017 at 12:38:43PM -0700, Jonathan Tan wrote:
> 
> > > Do we need to future-proof the output format so that we can later
> > > use 32-byte hash?  The input to pack-objects (i.e. rev-list --objects)
> > > is hexadecimal text, and it may not be so bad to make this also
> > > text, e.g. "<hash> SP <length> LF".  That way, you do not have to
> > > worry about byte order, hash size, or length limited to uint64.
> > 
> > The reason for using binary is for the convenience of the client to
> > avoid another conversion before storing it to disk (and also network
> > savings). In a large repo, I think this list will be quite large. I
> > realized that I didn't mention anything about this in the commit
> > message, so I have added an explanation.
> > 
> > I think this is sufficiently future-proof in that the format of this
> > hash matches the format of the hashes used in the objects in the
> > packfile. As for object size being limited to uint64, I think the
> > benefits of the space savings (in using binary) outweigh the small risk
> > that our files will get larger than that before we upgrade our protocol
> > :-P
> 
> The rest of the pack code uses a varint encoding which is generally
> much smaller than a uint64 for most files, but can handle arbitrary
> sizes.
> 
> The one thing it loses is that you wouldn't have a fixed-size record, so
> if you were planning to dump this directly to disk and binary-search it,
> that won't work. OTOH, you could make pseudo-pack-entries and just
> index them along with the rest of the objects in the pack .idx.
> 
> The one subtle thing there is that the pseudo-entry would have to say
> "this is my sha1". And then we'd end up repeating that sha1 in the .idx
> file. So it's optimal on the network but wastes 20 bytes on disk (unless
> index-pack throws away the in-pack sha1s as it indexes, which is
> certainly an option).

If we end up going with the varint approach (which seems reasonable),
maybe the client could just expand the varints into uint64s so that it
has a binary-searchable file. I think it's better to keep this list
separate from the pack .idx file (there has been some discussion on this
- [1] and its replies).

[1] https://public-inbox.org/git/777ab8f2-c31a-d07b-ffe3-f8333f408ea1@jeffhostetler.com/

> > > Can this multiplication overflow (hint: st_mult)?
> > 
> > Thanks - used st_mult.
> 
> Actually, I think this is a good candidate for ALLOC_ARRAY().

Thanks - I've made this change in my local version.

> > > This sorting is a part of external contract (i.e. "output in hash
> > > order" is documented), but is it necessary?  Just wondering.
> > 
> > It is convenient for the client because the client can then store it
> > directly and binary search when accessing it. (Added a note about
> > convenience to the commit message.)
> 
> In general the Git client doesn't trust the pack data coming from a
> remote, and you can't corrupt a client by sending it bogus data. Either
> the client computes it from scratch (e.g., the sha1s of each object) or
> the client will reject nonsense (missing bases, refs pointing to objects
> that aren't sent, etc).
> 
> I know this feature implies a certain amount of trust (after all, the
> server could claim that it omitted any sha1 it likes), but we should
> probably still be as strict as possible that what the other side is
> sending makes sense. In this case, we should probably hashcmp() each
> entry with the last and make sure they're strictly increasing (no
> out-of-order and no duplicates).

Good point.
