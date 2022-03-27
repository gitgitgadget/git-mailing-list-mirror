Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F533C433F5
	for <git@archiver.kernel.org>; Sun, 27 Mar 2022 15:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbiC0P7b (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Mar 2022 11:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiC0P7a (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Mar 2022 11:59:30 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CA638189
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 08:57:51 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z92so14345977ede.13
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 08:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=GXI39y9nczdPgEptz4hXpxjQ1WXY1wPwPLsD8u34LYI=;
        b=Q+Wd/9dIhFwlFrl+I6fpJpmp52q3N6O9rQtPulEWWXrAp1lrMJNPzgLaIncBYikqPq
         5NDyrWZqc56qFyBJDPqb5UAb17h+uw3GmQgXmOaAFirq6fVeH2Oh2Rv2xK7P4akhu96i
         5HjKvf5hoH+hNi6o3RupZIDfwfvweJMZZeCPgsx/1rixGfL244GpNmAdzutOsgVb6uEC
         +OHyn0CwxtbHgPzV/ZlpFmeQVNz/po+xhqIoFp5fPbZ+49S37GaGM5mM9YbTN0wM7UmP
         2YbeaoOJy4r987DdKFmOrWtZryfW+HYkjHkPxkcgfqCm3+5idf1JxyNQ8kmMNsnWJC7F
         I+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=GXI39y9nczdPgEptz4hXpxjQ1WXY1wPwPLsD8u34LYI=;
        b=S4JkSIH55C6IqLjamnj6QUan9aeW6PZjMUQksFQ/FiIrd4HpUzNW3l+C1S3TPK08CA
         fktCwbQRPBQFljPWofn8VPN1mpDxfzI1F8iDxSDXyN+z/3oqigCFhl84JWnnfNmS1zp9
         hrqCgFGZv9p6yihxgZk8jJIsaS+cP1Jd/pZFoemu3+z9xcW+Zreq255wkArN2sbJzLVx
         YuXmXIncQ8cvwgYQUVak2ZW4gbsP2+XBksMjpYQM8Q4YJ5zpWdd4awvOtvT3W73a+hO1
         +rPP39Naq1fagF/cCnyyaqvox2i0n0CTmYBwelkRaR8MctLAr2dpSDBdUm6AtFcLz5kn
         ccaQ==
X-Gm-Message-State: AOAM530YMucx85vpL9UXMoUq749cZKKMXUWHgywELUcR/X3RGMiiI2M1
        J+QW9Hg31fgwykFDldjXiFM=
X-Google-Smtp-Source: ABdhPJyPlIX2Cg3MAallK+aMzSBKBqzk4KPkajx8O07AXV2jNOA83VNwb4nbkdxqATjnpM1gD5NLSQ==
X-Received: by 2002:a05:6402:1259:b0:418:e674:5718 with SMTP id l25-20020a056402125900b00418e6745718mr11011292edw.69.1648396669710;
        Sun, 27 Mar 2022 08:57:49 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v2-20020a509d02000000b00412d53177a6sm5934748ede.20.2022.03.27.08.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 08:57:49 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nYVH2-002tpn-Il;
        Sun, 27 Mar 2022 17:57:48 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     John Garry <john.garry@huawei.com>, git@vger.kernel.org
Subject: Re: [Question] .git folder file updates for changing head commit
Date:   Sun, 27 Mar 2022 17:48:24 +0200
References: <6fa76f28-063b-8964-c0a2-642dae88f1b3@huawei.com>
 <YjuCSpAHD6xHkb5G@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.11
In-reply-to: <YjuCSpAHD6xHkb5G@nand.local>
Message-ID: <220327.86tubje6bn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 23 2022, Taylor Blau wrote:

> On Wed, Mar 23, 2022 at 03:19:06PM +0000, John Garry wrote:
>> For building the linux perf tool we use the git head commit id as part of
>> the tool version sting. To save time in re-building, the Makefile rule has a
>> dependency on .git/HEAD for rebuilding. An alternative approach would be to
>> compare git log output to check current versus previous build head commit,
>> but that is seen as inefficient time-wise.
>
> Having a Makefile recipe that depends on $GIT_DIR/HEAD seems strange to
> me.
>
> Presumably your Makefile rules would map out which parts of your program
> depend on each other, and would get invalidated when the source itself
> changes, no?
>
> Perhaps you also care about the commit you're building from in order to
> embed something into your program. But it seems like you could inject
> the output of "git rev-parse HEAD" when you construct the version
> identifier whenever you do need to rebuild.

Our very own build process for git.git relies on this, see how version.o
needs a GIT-VERSION-FILE, which we generate by shelling out and
including.

It is unfortunate that we don't have an advertised way to do this, with
the ref backend I think trickery using $(file) to read the HEAD will
work to do it in pure-make, i.e. you'd need to parse it to see if it's a
symref, then depend on the target it points to.

Or you could recursively depend on a glob of the whole refspace for
generating the version file ...

It would be nice if we had a way to guarantee that we'd write some file
on HEAD updates, AFAIK not even the new reference-transaction hook will
do that (due to "git reset --hard" and friends).

And yes, this does actually matter. There's a huge performance
difference between a Makefile that needs to shell out for every little
thing.

I've been optimizing our own Makefile incrementally from running in
~500ms down to 100-200ms for noop runs over over the last few
months. It's possible to get it down to 10-20ms at least by getting rid
of the remaining shell-outs.

That makes a big difference when e.g. using "make" with "git rebase -i
-x".
