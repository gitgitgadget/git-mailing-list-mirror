Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE59D1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 14:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933337AbeCEOAV (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 09:00:21 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50292 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932563AbeCEOAU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 09:00:20 -0500
Received: by mail-wm0-f67.google.com with SMTP id w128so16090400wmw.0
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 06:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=yaE0J+fBP9QwbCKLX/0sLh8heV4NrUrCXYz/yb/Bd58=;
        b=mSlEDaecCNGS0FJnLJjTUPwHw2QmRQakmU/2GA8mHLHy+kRPMiXcUKrGVq/8qz/3NG
         Vmp1yjGLuocsxDhG9lQRVm6KdbzLIDpcb3WMOfwqbV7m5nXkiTYUu6f8FCUpvOt5mbd7
         q7kjiw36waf/wd8YZU1wS/2BZn8NS1YWpB1lbyVlBFSO7tNH7Wn7jOB1UofnxVzzryjc
         9qEzVvuLCRpla6Qigswm4LAP2nvB2cUF2mNH/McewdoJxeoBjsd9ED1pukrh3VZ6NrDO
         VO4ebgnRVcs9JBCc6F3d0tpk8e2I7jmKJvCNxiJawwkfYVmniHEVCJyHSJhFEjYFdCqa
         R9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=yaE0J+fBP9QwbCKLX/0sLh8heV4NrUrCXYz/yb/Bd58=;
        b=OtJV3Quw7wCV2K0E88P3TQm7WW0kiuJQFhBwJXPj/TBzdnLZD3+PN9MJuqo+7x/Zcw
         TfX0o2Vni+rj+eRD1YRkZiQymyiSo8OBlh554rLiOdR9zE7el5mcrLZXB80xzE0tmfau
         hE8+l/8HgppvPaCS6tlqSS9UdNaH8VS14j0MwYddEVon1g6pArLNuz/g1Ks2+kFKFfgs
         JGydd3Eww2eMERbGL90SKpi8sU5cypVbweAe5Ljpv7TDJRg0rjBcttdgf27R9dxih+6x
         OPW+svBK+/FazMhCIg8NAOBwb15PlfcMWYSS3dqc8xSIkIYdqawY6/cEyFP8I31LSEOP
         48dQ==
X-Gm-Message-State: APf1xPCEVohv2YFGwPqvOD+FnnPXFzOYPa7UdSsLuTT2NkVcP4HCboQN
        UpVXzEz/PZwDx4o1MuH2nYp14bl6
X-Google-Smtp-Source: AG47ELsxoFnwoqlFJLFi2bYZPPQeNwT7u5ZLd1H/egWNYNvbErBNbwhPit4YG5q/UYGEwDnTP8j0dg==
X-Received: by 10.80.154.6 with SMTP id o6mr18804642edb.146.1520258419179;
        Mon, 05 Mar 2018 06:00:19 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id l60sm5195907edl.15.2018.03.05.06.00.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 06:00:18 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH/RFC 1/1] gc --auto: exclude the largest giant pack in low-memory config
References: <20180228092722.GA25627@ash> <20180301092046.2769-1-pclouds@gmail.com> <20180301092046.2769-2-pclouds@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180301092046.2769-2-pclouds@gmail.com>
Date:   Mon, 05 Mar 2018 15:00:16 +0100
Message-ID: <87bmg2oc5r.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 01 2018, Nguyễn Thái Ngọc Duy jotted:

> pack-objects could be a big memory hog especially on large repos,
> everybody knows that. The suggestion to stick a .keep file on the
> largest pack to avoid this problem is also known for a long time.
>
> Let's do the suggestion automatically instead of waiting for people to
> come to Git mailing list and get the advice. When a certain condition
> is met, gc --auto create a .keep file temporary before repack is run,
> then remove it afterward.
>
> gc --auto does this based on an estimation of pack-objects memory
> usage and whether that fits in one third of system memory (the
> assumption here is for desktop environment where there are many other
> applications running).
>
> Since the estimation may be inaccurate and that 1/3 threshold is
> arbitrary, give the user a finer control over this mechanism as well:
> if the largest pack is larger than gc.bigPackThreshold, it's kept.

This is very promising. Saves lots of memory on my ad-hoc testing of
adding a *.keep file on an in-house repo.

> +	if (big_pack_threshold)
> +		return pack->pack_size >= big_pack_threshold;
> +
> +	/* First we have to scan through at least one pack */
> +	mem_want = pack->pack_size + pack->index_size;
> +	/* then pack-objects needs lots more for book keeping */
> +	mem_want += sizeof(struct object_entry) * nr_objects;
> +	/*
> +	 * internal rev-list --all --objects takes up some memory too,
> +	 * let's say half of it is for blobs
> +	 */
> +	mem_want += sizeof(struct blob) * nr_objects / 2;
> +	/*
> +	 * and the other half is for trees (commits and tags are
> +	 * usually insignificant)
> +	 */
> +	mem_want += sizeof(struct tree) * nr_objects / 2;
> +	/* and then obj_hash[], underestimated in fact */
> +	mem_want += sizeof(struct object *) * nr_objects;
> +	/*
> +	 * read_sha1_file() (either at delta calculation phase, or
> +	 * writing phase) also fills up the delta base cache
> +	 */
> +	mem_want += delta_base_cache_limit;
> +	/* and of course pack-objects has its own delta cache */
> +	mem_want += max_delta_cache_size;

I'm not familiar enough with this part to say, but isn't this assuming a
lot about the distribution of objects in a way that will cause is not to
repack in some pathological cases?

Probably worth documenting...

> +	/* Only allow 1/3 of memory for pack-objects */
> +	mem_have = total_ram() / 3;

Would be great to have this be a configurable variable, so you could set
it to e.g. 33% (like here), 50% etc.
