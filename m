Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97B4B1F404
	for <e@80x24.org>; Fri, 31 Aug 2018 15:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbeHaTbV (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 15:31:21 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:53749 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbeHaTbV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 15:31:21 -0400
Received: by mail-wm0-f50.google.com with SMTP id b19-v6so5627310wme.3
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 08:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=jCQkjv2mBQnMUgwQn6M+PwF8a/uGtPfiTraE0ifSKyg=;
        b=sEdr6W/9XYTMsnkz+S8wUypKYG1VPCvhJqI6LO1yTOKeYfAgYTyigMfscb1QkOSnGM
         xkZ1Yx5Z0hnTRLEqgyB96KndP+syFSUuRgl1FyT3VthsSLlPpPH1G6joSMe96xSNihJA
         NIEdzv57ONcbgH8I3hrVF6cEz/tkMAYyjAHDvTxUcx6LkFIHfa3LVfv78mhogfd6w/pB
         gkKSpkXTbYlWXJsv/TLzRT9TbylIvex4YQVzpVAgnRaP4Wi1pTLyJgdtAor+AKfg3v/s
         1Apyqlwm7K5lodGd+BIledkl2orxNN39gAit9RwQMkwiWCXwPD2uQmjsb3gs2FS/3q4L
         uErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=jCQkjv2mBQnMUgwQn6M+PwF8a/uGtPfiTraE0ifSKyg=;
        b=JLB8D0onswXP4hseu4pRUPdinqfL9wqrjT07ANfPyzuu9cJZlzzraVJhEx6r8aish5
         V8tuc6mdn8Gc9iGm5jUMq36s1cO8TFuxMYcfDABj/pxGwKVnqcL5+SNqz6AnKxxFHzeg
         XqxJbCMsTJEYrMKiM4AJScyCit1PyNhyPjrNCkWHjNc6LnQDpgTJEk+LRY2UuwGlwqAK
         yEk8FmmLnN2Nw2D+IUjRFI+3BxyDbHMhe3A59dB4t0rEPbjBwf1n2G/WOGkSKjRscApK
         EeGWh0Q471+vvavP4XJtnP4xu7YMmuYfcVYLBujf4gZMDHErXoNJeFmnG0yiTmXClWSu
         FSPA==
X-Gm-Message-State: APzg51BxXg63cIg/ymH90L+1u+KGmD+m5HgpLXjfpCtl57sjPEWUUwFS
        yrpE4BFkzEg4khQXnzfcKTN78t9wr24=
X-Google-Smtp-Source: ANB0VdZEGbvl6ql2gtrp1X7Y/5ny01EfYXlfO1QT9zdS7zA4GoUAmkVYSDk0O//bULFUl4ieKltDcA==
X-Received: by 2002:a1c:9e89:: with SMTP id h131-v6mr4924832wme.13.1535728999620;
        Fri, 31 Aug 2018 08:23:19 -0700 (PDT)
Received: from evledraar ([5.57.21.50])
        by smtp.gmail.com with ESMTPSA id e5-v6sm3705458wmh.29.2018.08.31.08.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 08:23:18 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] pack-bitmap: save "have" bitmap from walk
References: <20180821184140.GA24165@sigill.intra.peff.net> <20180821190701.GE30764@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180821190701.GE30764@sigill.intra.peff.net>
Date:   Fri, 31 Aug 2018 17:23:17 +0200
Message-ID: <8736uud0gq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 21 2018, Jeff King wrote:

> +int bitmap_has_sha1_in_uninteresting(struct bitmap_index *bitmap_git,
> +				     const unsigned char *sha1)
> +{
> +	int pos;
> +
> +	if (!bitmap_git)
> +		return 0; /* no bitmap loaded */
> +	if (!bitmap_git->result)
> +		BUG("failed to perform bitmap walk before querying");

Some part of what calls this completely breaks pushing from the "next"
branch when you have local bitmaps (we *really* should have some tests
for this...).

I don't have time to dig now, but just on my local git.git on next @
b1634b371dc2e46f9b43c45fd1857c2e2688f96e:

    u git (next $=) $ git repack -Ad --window=10 --depth=10 --write-bitmap-index --pack-kept-objects
    Enumerating objects: 616909, done.
    Counting objects: 100% (616909/616909), done.
    Delta compression using up to 8 threads
    Compressing objects: 100% (146475/146475), done.
    Writing objects: 100% (616909/616909), done.
    Selecting bitmap commits: 168027, done.                                                                                                                                                                           BBuilding bitmaps: 100% (338/338), done.
    Total 616909 (delta 497494), reused 582609 (delta 467530)
    u git (next $=) $ ./git --exec-path=$PWD push avar next:avar/next-push
    Enumerating objects: 1330, done.
    BUG: pack-bitmap.c:1132: failed to perform bitmap walk before querying
    error: pack-objects died of signal 6
    error: pack-objects died of signal 6
    error: remote unpack failed: eof before pack header was fully read
    error: failed to push some refs to 'git@github.com:avar/git.git'

Removing the bitmap makes it work again:

    u git (next $=) $ rm .git/objects/pack/pack-496088d9464cd79dfcac50dd0d72dcd6faee8253.bitmap
    rm: remove write-protected regular file '.git/objects/pack/pack-496088d9464cd79dfcac50dd0d72dcd6faee8253.bitmap'? y
    u git (next $=) $ ./git --exec-path=$PWD push avar next:avar/next-push
    Enumerating objects: 2834, done.
    Counting objects: 100% (1799/1799), done.
    Delta compression using up to 8 threads
    Compressing objects: 100% (591/591), done.
    Writing objects: 100% (1390/1390), 430.11 KiB | 15.36 MiB/s, done.
    Total 1390 (delta 1100), reused 1072 (delta 798)
    remote: Resolving deltas: 100% (1100/1100), completed with 214 local objects.
    To github.com:avar/git.git
     * [new branch]            next -> avar/next-push

Today I deployed next + my patches @ work. Broke pushes in one place
where repacks were being done manually with --write-bitmap-index.
