Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A02981F403
	for <e@80x24.org>; Mon, 11 Jun 2018 18:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932355AbeFKSuu (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 14:50:50 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46072 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932081AbeFKSut (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 14:50:49 -0400
Received: by mail-pf0-f196.google.com with SMTP id a22-v6so10701705pfo.12
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 11:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nWTIS5afMLTAt3dTG8q4F3/KI+BrKYFKU0aZ57mWcCA=;
        b=Tp1v/+/vTNNQif1Ar+QxoNahxx2aoP8oWvtQF6kBEhY/cbVWvvj9lKHz+84eSo8aGE
         Oa4gwbEQ91D6fJjHLikNgY3x0KillmgGiWVKGK38cpSUPoB5cjFazOVAHk+X5p2hXjao
         DeRFuD2JIOxom8m4JXl8lijjO1hHtEhyPV6NHaKlURp/at0XT2IS5AS5rF5hImfG/u5j
         aZ7+eUPY8G8hbvO2AhQRaCYLhZYsCxEI6o7bEu2dWrsJDszAvJT313w699C8pVW2CC0l
         lWrd4P6r3/jtLwVtozhFYa5npELt/yP87Q5ptoSfEz6eksb04kSUM/2a1gSXpj8oQJ7s
         NcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nWTIS5afMLTAt3dTG8q4F3/KI+BrKYFKU0aZ57mWcCA=;
        b=AgFeqJ/HOP3JbgmEIx2XcJMi+9aLyclZOu1RS3N4l3jo/O0V3iEmOQ8qLCqAiRWbJm
         4t4c9dNSY0UvtKd8LG8A5+80aQU33Pt6aF4yzgBsutuGCwJYv1UoagDpvRG8TSOw+Tms
         KCKbUQU3pgA8zH83tdBbLvzofPV+Jw8Ms4Ym+bNBdgDmpFXeU061LSmHr/e6jVYO8Vtu
         kIEwE7dAKiW1+vUsRuAz+jbxsGv2eNIDu3LIKgIEHugdY1B6hNuD80O4maAlvsxy+Qj7
         t8PKNywlNp90fuypO21I5z1vqul5Dn5orC6Mtr3bjWOZlql/UkbMOVqb5A9reEsyeTV+
         qtUg==
X-Gm-Message-State: APt69E3bA0BDjidiPV/yvWBDgjle9L9Sn7u8ptGRhRit5EW5V0yFBVvs
        hRsxsLxu/h1sOEi92WuKf9KUYQ==
X-Google-Smtp-Source: ADUXVKJHfJ7z0h9pykaa7gUOAFLIT6zTyJv+Cl6K95f/lY1fWIDgadyRcA3dkLQIkFfCFszH53VRJg==
X-Received: by 2002:a62:66c6:: with SMTP id s67-v6mr336007pfj.139.1528743049093;
        Mon, 11 Jun 2018 11:50:49 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:15c:2e4:700:e67c:8726:af4f:3e3d])
        by smtp.gmail.com with ESMTPSA id h16-v6sm7083044pfn.80.2018.06.11.11.50.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 11:50:47 -0700 (PDT)
Date:   Mon, 11 Jun 2018 11:50:46 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 1/2] pack-bitmap: remove bitmap_git global variable
Message-Id: <20180611115046.d03f8093347dc6c0e9b116fc@google.com>
In-Reply-To: <20180609060437.GA30224@sigill.intra.peff.net>
References: <cover.1528397984.git.jonathantanmy@google.com>
        <d4d4fec265c1c53e14da465904d93e559ff2c17d.1528397984.git.jonathantanmy@google.com>
        <20180609060437.GA30224@sigill.intra.peff.net>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 9 Jun 2018 02:04:38 -0400
Jeff King <peff@peff.net> wrote:

> This function used to be idempotent, so any code which wanted to use the
> global bitmap_git could call it "just in case". After your patch, it's
> not. I think it's probably OK, since such functions would generally now
> take a bitmap_git argument and use that (e.g., rebuild_existing_bitmaps
> works that way after your patch).

Yes, and I've checked that the existing callers do not use bitmaps
twice. I've appended an extra paragraph for the commit message to this
e-mail below that will hopefully clarify things.

> We probably need to free(bitmap_git) before returning NULL here (this is
> still in prepare_bitmap_git()).

[snip]

> Ditto here (and probably other error returns lower in the function, but
> I didn't go through it carefully).

The contents of the struct also need to be handled, and I wanted to
handle it all at once in the subsequent patch. But you're right that the
commit message should explain that.

Here's an paragraph to be added to the end of the commit message. I can
send a reroll with the exact same code but with the updated commit
message if Junio requests it.

[additional paragraph begin]

This patch raises two potential issues: (1) memory for the struct
bitmap_index is allocated without being freed, and (2)
prepare_bitmap_git() and prepare_bitmap_walk() can reuse a previously
loaded bitmap. For (1), this will be dealt with in a subsequent patch in
this patch set that also deals with freeing the contents of the struct
bitmap_index (which were not freed previously, because they have global
scope). For (2), current bitmap users only load the bitmap once at most
(note that pack-objects can use bitmaps or write bitmaps, but not both
at the same time), so support for reuse has no effect - and future users
can pass around the struct bitmap_index * obtained if they need to do 2
or more things with the same bitmap.

[additional paragraph end]
