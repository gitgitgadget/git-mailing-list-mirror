Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF9DC433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 19:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348663AbiEZTEu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 15:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiEZTEs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 15:04:48 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A2CC8BD4
        for <git@vger.kernel.org>; Thu, 26 May 2022 12:04:46 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c93so1568620edf.7
        for <git@vger.kernel.org>; Thu, 26 May 2022 12:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=l78BRZVlEOd6GXoz43lhEmGqR4LdMnog8fJJFOKT0bw=;
        b=Xbuv/RVgcaAdtdR3QHNOcGguSQUBDEnaGpCTJyZ9hIirEErOsPCXJPBDWdW68kgjF9
         CgYav7SDB6t5CaHgCoywjJ1j2Ov803LDtOkebt4wARfQuQ4/IFCKu81duZ2gx2bdCMIU
         Aio4NjrLoy6TWI5/8lYNMW5TQehX/4AO3g6kLsCpf/xvkRwH7gjjJMHUdIQ0BoClRXKv
         9mQqj2dOTyZ3tCl7EsSMDbqYFtqen+RjOAfkzzIjAia1JrIeGnX8oX8S/9GXsC8sXpXW
         YXj1UdVE6pOFG3elVDc5kmWvIaKFodoYrk1eYdCrDmbz1kbrXxQyh7BuISih6BiRmwjO
         InJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=l78BRZVlEOd6GXoz43lhEmGqR4LdMnog8fJJFOKT0bw=;
        b=qIsgeui5XVImZK3FnrR4AtSoQrtaa8ekr+79BwYATiq3XRGmaHkckeSWfOyLXXP8tt
         FP8VKpSjRIwWmiRnU/xTZ36JJfy1W+yfxFfYuHjq+4Ei4T152A6hyw8YdkSdp5s86za7
         uZFq+cE4hZf1z0sMSjDcxmmU275ed+Lrfpr1OItMLkchGWCfeIwMnnEtiI1EQZUwEpbm
         Xu+IHumDxX1A1IigGEBejacdiZX1biKXBZC9TTThs4vN66uYsISWsiHLa9mUSz+Y+O6b
         xGWJ0SPaHMF6ce17keChFcWe3jfJqRxk2JwNfJkN5UZZwIsgsfhpvrL5Qj3mnjQAXEB9
         KsoQ==
X-Gm-Message-State: AOAM532sXo2gKrwRJWntEuNbu9sj9ummO7Piu2Fy3bv65OTCbEKKtVHG
        NoWzCyWWHYlxe6/yoCzljzg=
X-Google-Smtp-Source: ABdhPJxMT3v2ZNGML1c1k0FtCgV88a0TUSkz+bhS7tQSI5EFen3T0eaZZWbKXaMM5WMi8FbSqWrKeQ==
X-Received: by 2002:a05:6402:329c:b0:42a:bfc9:98b4 with SMTP id f28-20020a056402329c00b0042abfc998b4mr40936392eda.3.1653591884870;
        Thu, 26 May 2022 12:04:44 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id h17-20020a05640250d100b0042bd6f745fasm1148886edb.92.2022.05.26.12.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 12:04:44 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nuImp-000GEF-FE;
        Thu, 26 May 2022 21:04:43 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git-packagers@googlegroups.com, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Carlo Arenas <carenas@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        git-packagers <git-packagers@googlegroups.com>,
        Tim Harper <timcharper@gmail.com>, Jeff King <peff@peff.org>
Subject: Re: [PATCH 0/5] core: update our SHA-1 docs, use
 sha1collisiondetection on OSX too
Date:   Thu, 26 May 2022 21:02:54 +0200
References: <cover-0.5-00000000000-20220422T094624Z-avarab@gmail.com>
 <xmqqv8v17xrl.fsf@gitster.g> <220519.86k0ah2ryh.gmgdl@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <220519.86k0ah2ryh.gmgdl@evledraar.gmail.com>
Message-ID: <220526.86ilps3yk4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 19 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Fri, Apr 22 2022, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>>> I wasn't able to find any on-list references to it being intentional,
>>> but it appears that while we made the sha1collisiondetection variant
>>> of SHA-1 the default in early 2017 we've never updated the OSX builds
>>> to do likewise.
>>>
>>> I don't know what various git packages for OSX to, but our vanilla OSX
>>> distribution definitely uses Apple Common Crypto, and won't detect the
>>> https://shattered.io attack.
>>>
>>> This series changes that, and while doing so in 2/5 updates our
>>> documentation and Makefile interface for the SHA-1 selection. Our
>>> INSTALL file was still claiming we used OpenSSL's SHA-1 by default.
>>>
>>> Then since we'd made sha1collisiondetection the default we hadn't
>>> changed the code's default fallback to be that, it was still
>>> block-sha1. Now our fallback behavior is "error" instead, which makes
>>> it less likely that we'll get some foot-gun like the "OSX not using
>>> sha1collisiondetection" again.
>>>
>>> The 4/5 and 5/5 then remove the PPC_SHA1 implementation. I submitted
>>> this before as [1], and the range-diff is to that submission (it
>>> wasn't picked up). I think it makes sense as part of this general
>>> SHA-1 cleanup.
>>
>> Thanks for this effort.
>>
>> I'd like to see somebody with "building Git for distributing to
>> macOS" background to comment (I am assuming that the mailing list
>> git-packagers@googlegroups.com is the way to reach them).
>
> *Bump* in case anyone there would like to chime on this bit of OSX
> portability.
>
> I also sent an off-list E-Mail to Tim Harper today, and addresses which
> I gather (from some old git-security@ traffic) are involved in packaging
> the Apple Git shipped with OSX itself.
>
> In the meantime do you mind if this topic were queued up? If there are
> any lingering portability concerns getting it into CI and exposed to
> anyone else building on OSX would be a good thing.
>
> I don't see any reason for why we'd decide that OSX out of all our
> supported platforms should be the only one where we're not mitigating
> the SHAttered attack (and similar future attacks) by default.
>
> So aside from any finer details of OSX portability the direction here of
> building with sha1collisiondetection by default on OSX by default seems
> like a safe bet, just as we do on the rest of our (checks out
> config.mak.uname) 20+ supported platforms (per `uname -s`).

Update: I didn't get a reply from Tim or the people I E-Mailed
@apple.com a week ago.

Junio: I still think it makes sense to just queue this anyway & finally
get the OSX build to use the SHAttered mitigation sha1collisiondetection
gives us by default.
