Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A6E9200B9
	for <e@80x24.org>; Fri,  4 May 2018 16:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeEDQeY (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 12:34:24 -0400
Received: from mail-ot0-f169.google.com ([74.125.82.169]:42760 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbeEDQeX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 12:34:23 -0400
Received: by mail-ot0-f169.google.com with SMTP id l13-v6so25143902otk.9
        for <git@vger.kernel.org>; Fri, 04 May 2018 09:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1Vww+4jTBiA4sfxK1XYOr8vHpQjl0oVgWpxNhBJumxk=;
        b=Kv75MOCpDdbPG3adEBCCi4gw4M8KMUaAKgb/gzHUvzXNiCQVNDKMdnGk/dwah0AQBC
         zEKFl+v5M/vf+qD7YBGk11EZHEXzHSHlaCpO36ffHQVTsr/8YREa0PJNiGldTI3d3Lh2
         RwoeVmU+hOjIYtB3xyk16VGavAcIc8JUvvDhYoS1vKkk6efCwPw3Rf6i1vvgTLu2IYeM
         WVrIHP3L5NqG2zpeMg6r0OWSxOzXP7JuvAJW2S7h+InHmEv2Re7Cz50E/qZ2h5NHd79h
         5dN4TLPTjaqd92O7QNds7BVnx5tjYrKXD2WpBpkF/d5tOhwCrrxGLlN9R4qEtQYonflb
         Nfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1Vww+4jTBiA4sfxK1XYOr8vHpQjl0oVgWpxNhBJumxk=;
        b=fbKw0YU4V81zu/BIlPe6fhyFOwG17Ylxr46LP0i6HjojzPnCsy+ibTmZCYlZ00uAOI
         GqFEUW9H6W1TGbZgDdyZi11kiHPdrcVGh2WVeN+51+GEq0/G25vZ9aFzEhhVIvoTroxq
         leIzWxSPonVtDIBi8cRlDsc2NVhuHNpS8WVgbe9Zuj2dpTbETa7TmUvFnUPs/mETzui1
         79jqLFt/x3BvSlnuC8mxrI8ekWRwB7g+SE3FS6ui3eXSs5qp6hCCzB5LxTsL0UbkR0tE
         5inVu0/WUei7FBaJCwYMDgh6tCpaYvUyqakjCLgCbWC+MCUm3fYyGGZxW5EqviWjOua9
         Qh9w==
X-Gm-Message-State: ALQs6tAcSgUZOTCTUU3D8Opr4lAElBXW6hvdVHowt7kD/uqjTPcxmvVX
        tYav9duvGYJJYIlOvhRoDEYKWBwlLalBJ5Chd30=
X-Google-Smtp-Source: AB8JxZrEhiVTFW2yWbeBMMgZNsL8hQEkqv0ukTw1zxaTCvXDIKWds/s9g0WGTjslnObWcmRBoAjaMyxv22u/CS6ZzQY=
X-Received: by 2002:a9d:1d92:: with SMTP id y18-v6mr19051314otd.304.1525451663207;
 Fri, 04 May 2018 09:34:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Fri, 4 May 2018 09:33:52 -0700 (PDT)
In-Reply-To: <20180503221802.61110-1-sbeller@google.com>
References: <BL0PR2101MB1106BA184260609DA69988A6CE870@BL0PR2101MB1106.namprd21.prod.outlook.com>
 <20180503221802.61110-1-sbeller@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 4 May 2018 18:33:52 +0200
Message-ID: <CACsJy8De2SUGj9hgq3h7pODm=9Wn+TkCKfJjrm1c=UxS9BZvTA@mail.gmail.com>
Subject: Re: [PATCH] alloc.c: replace alloc by mempool
To:     Stefan Beller <sbeller@google.com>
Cc:     Jameson Miller <jamill@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 4, 2018 at 12:18 AM, Stefan Beller <sbeller@google.com> wrote:
> I just measured on git.git and linux.git (both of which are not *huge* by
> any standard, but should give a good indication. linux has  6M objects,
> and when allocating 1024 at a time, we run into the new block allocation
> ~6000 times).
>
> I could not measure any meaningful difference.
>
> linux.git $ git count-objects -v
> count: 0
> size: 0
> in-pack: 6036543
> packs: 2
> size-pack: 2492985
> prune-packable: 0
> garbage: 0
> size-garbage: 0
>
> (with this patch)
>  Performance counter stats for '/u/git/git count-objects -v' (30 runs):
>
>           2.123683      task-clock:u (msec)       #    0.831 CPUs utilized            ( +-  2.32% )
>                  0      context-switches:u        #    0.000 K/sec
>                  0      cpu-migrations:u          #    0.000 K/sec
>                126      page-faults:u             #    0.059 M/sec                    ( +-  0.22% )
>            895,900      cycles:u                  #    0.422 GHz                      ( +-  1.40% )
>            976,596      instructions:u            #    1.09  insn per cycle           ( +-  0.01% )
>            218,256      branches:u                #  102.772 M/sec                    ( +-  0.01% )
>              8,331      branch-misses:u           #    3.82% of all branches          ( +-  0.61% )
>
>        0.002556203 seconds time elapsed                                          ( +-  2.20% )
>
>   Performance counter stats for 'git count-objects -v' (30 runs):
>
>           2.410352      task-clock:u (msec)       #    0.801 CPUs utilized            ( +-  2.79% )
>                  0      context-switches:u        #    0.000 K/sec
>                  0      cpu-migrations:u          #    0.000 K/sec
>                131      page-faults:u             #    0.054 M/sec                    ( +-  0.16% )
>            993,301      cycles:u                  #    0.412 GHz                      ( +-  1.99% )
>          1,087,428      instructions:u            #    1.09  insn per cycle           ( +-  0.02% )
>            244,292      branches:u                #  101.351 M/sec                    ( +-  0.02% )
>              9,264      branch-misses:u           #    3.79% of all branches          ( +-  0.57% )
>
>        0.003010854 seconds time elapsed                                          ( +-  2.54% )
>
> So I think we could just replace it for now and optimize again later, if it
> turns out to be a problem. I think the easiest optimisation is to increase
> the allocation size of having a lot more objects per mp_block.

Yeah. I also tested this from a different angle: memory overhead. For
2M objects with one mp_block containing 1024 objects (same setting as
alloc.c), the overhead (not counting malloc() internal overhead) is
46KB and we don't have any extra overhead due to padding between
objects. This is true for all struct blob, commit, tree and tag. This
is really good. alloc.c has zero overhead when measured this way but
46KB is practically zero to me.
-- 
Duy
