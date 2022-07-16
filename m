Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E460AC433EF
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 14:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbiGPOVC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 10:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiGPOUv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 10:20:51 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7395A1FCD3
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 07:20:49 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t3so9678545edd.0
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 07:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=55UtAhGoS+bpHew+H29a5+gaKPDOPJ9bwTqKJxmytcU=;
        b=PA2lDm9awtvWfMQ9jG3TdJzh4ZoC0SCnxa61FscHvzZ2EQ1fut9QxSQDRUprUxMY8Y
         EyjLVeF+p6hupHjrpYRrT7UfDbUUgd9diHLubC3RGQ0ZxmIJTb2vs4EYLDo0TlkLJ20u
         dua1vaCttgkigBcfOmZRJl2jKuaCdl+f6NuYY82Zg48WlUYtsJ1IP+wbRUN+Ds9axZpb
         44PvUdc+oL7Y7BOoxzYEO67+fUArSWFldFSBvZvsiHXW9pEvyGtY5Tz7cFzsws9J2ZfG
         Y3ykLQKd1jtZkwb9fegEiDlialLEmdKa/H9CwoLoJYv5bgOhixuPqmfOsK3k+KhGinLv
         Sr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=55UtAhGoS+bpHew+H29a5+gaKPDOPJ9bwTqKJxmytcU=;
        b=GUVtgpx3yLscILF2WxMr8+fYycv0Uo3jj+v/QC8kq6b5ued1vRbu3jHVTNdrZ9kLa9
         TNpsIeMfqfhAJpae0dQcH/zEnLDJ7mMhb29unXwlk7RzZKcKP2rdgx/cbLa96Nm07U7Y
         2G8Gstb+p5z3Cs+i0Bml28K5dSMfcBPGT96kA2b4AmSAWmaiVfpKE6lj1nnts/sSIEE1
         Hf1I93oT23raiaH9e57p/NO9ZwKZVOwfY4qXTzf9VqO3yvoee1dt3o8RlYY4Qkhb4saX
         ENFLJFGzYlSgj8xg3e5ZB7hEuwChwUl9LCyUW/Y6wV0WxFJhXexmu+6B/HK8bAKDIJ2B
         WtyQ==
X-Gm-Message-State: AJIora9MtWreNCEeNij+2UKVHXE9vUHf/YmWADtzkDtbs6EsmVmj+PDb
        kajKsA2qvO5prWpMesIMTNHlGrSymvc=
X-Google-Smtp-Source: AGRyM1vIYIxpsqIh70BCJZ6LRA4GUqKooRcQ3Uz48ZqwSCMSLQNz2tcmvy70DEvaT+DPfhFUmPrGhg==
X-Received: by 2002:a05:6402:5c8:b0:433:545f:a811 with SMTP id n8-20020a05640205c800b00433545fa811mr25887093edx.101.1657981247436;
        Sat, 16 Jul 2022 07:20:47 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ez7-20020a056402450700b0043a87e6196esm4774585edb.6.2022.07.16.07.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 07:20:46 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oCiey-002v8q-0Y;
        Sat, 16 Jul 2022 16:20:44 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: Can I use CRoaring library in Git?
Date:   Sat, 16 Jul 2022 16:16:26 +0200
References: <CAPOJW5x4McofC5fxBvsRAzum28wmeDJCMTMRmY_0oy=32JjKqQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAPOJW5x4McofC5fxBvsRAzum28wmeDJCMTMRmY_0oy=32JjKqQ@mail.gmail.com>
Message-ID: <220716.86y1wtxhok.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jul 16 2022, Abhradeep Chakraborty wrote:

> Hello,
>
> I need the CRoaring[1] library to use roaring bitmaps. But it has
> Apache license v2 which is not compatible with GPLv2[2].
>
> Is there a way to use the CRoaring library in Git? Taylor told me that
> contrib/persistent-https tree is also licensed under Apache License
> version 2.
>
> [1] https://github.com/RoaringBitmap/CRoaring
> [2] https://www.apache.org/licenses/GPL-compatibility.html

As a replacement for git's own bitmap implementation?

It's one thing to have differently licensed code in-tree that's built as
a separate utility (like that persistent-https tool), but another if
this is going to be something linked to git itself.

My understanding is that such a thing could not be legally distributed
as a binary (e.g. by Debian et al), so the users will be limited to
those willing to build the two pieces from scratch locally, i.e. similar
to ZFS on Linux (which I think is still the state of that ...).

But I'm not a lawyer and all that.

Another possibility is to get the library to dual-license itself,
running "git shortlog -sn" on it it seems it's mainly written by one
contributor, with a relatively short tail of others, perhaps they'd be
willing to dual-license at the prospect of having git use it?
