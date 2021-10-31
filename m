Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5045DC433EF
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 00:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34D8060F92
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 00:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhJaAO6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 20:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbhJaAOt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 20:14:49 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9320EC061746
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 17:12:18 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j2so28781511lfg.3
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 17:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Zq8sUjDokxvEHkYMJ+/tdbLsP8yreMGdcecGSqdZ/I=;
        b=hKIOiOjv/kYRxntuD3iUKrzUg8UsEULjs3IeXmVaE6fb+nWrnVt5m5jR1g2vOv41Aa
         KMWh9K2LXqqpthZvLw6QcJvz4oI7lPxRAIJmMpZQHimQwi6L97Q+bnFnVLv4rwkNwhI0
         d2Nmt6/PTmis/MiWSR25tqtkn4q3TkldexiiCL8FUYK87pMZaWOZHa8Aa3hhCt8CtrEH
         4ock/Nc+ovO4kJIuOe+Yx0NF683GBftEPK9Sx2MKRdi4B+LKm/THVI5Bih/RfJbE+TRA
         xkekEJ95Ok4cnmZf2ery4Pv/iGPbvIdmwG5Abf2kJ8cl3SsxhOZa4FjEpzR90X3mtDDd
         faJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Zq8sUjDokxvEHkYMJ+/tdbLsP8yreMGdcecGSqdZ/I=;
        b=jf/J85phHayLIxPegjNQtz6643YekTcf49wD86G+vsDklZvZnLO6SHkEpZyHEIqFZk
         cfnhxGxYxtdJXXuiUwcCso8eftCtmjL4lzJwxdQEBWQZ0OznxJn5aXfDvZP49GTOOoK+
         J7THyk+HMeZX3XU9WlK8pycRp77uBy4btg2UI58F9xTobZlI3KKn6vlteVR27XCcalFx
         KiIHJz1j41gW4rH38SO66zdxJeZkyhZZU2EsO31lowXM2TZIqE59BsbJtZQF7q9Mh8GS
         P4kY288D20ZvEBZibOu27+2PDrSjm3DOD1VRp10XzFuZPY+hv/AbPh4HF0/Ypaik2C7T
         GZUg==
X-Gm-Message-State: AOAM5339H+mvA6zA5v3pIqhkf8m1rmMby/gnaaihDSMEa1pitzaoCXZa
        yiAyXFeUjI3hoFMMWt1TuH8RcvL+3S34uQ/YF2s=
X-Google-Smtp-Source: ABdhPJwM1qQlFbUHu6FBQqYxXrjirP3FbvijAMA6ESw0QGEreEUWQWiO/8CdHldQPfAgY/Owerr7HFFuNLXTx1dM17U=
X-Received: by 2002:a05:6512:5c8:: with SMTP id o8mr19347441lfo.339.1635639136919;
 Sat, 30 Oct 2021 17:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211027233101.GA762862@rhi.hi.is> <211028.86wnlxwnqt.gmgdl@evledraar.gmail.com>
 <20211030231514.GA1086559@rhi.hi.is>
In-Reply-To: <20211030231514.GA1086559@rhi.hi.is>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Sat, 30 Oct 2021 17:12:06 -0700
Message-ID: <CAPx1GvfJcmUQm515U9fWW9fKKZihoO+PiM08G_xiARtiG_Eb6w@mail.gmail.com>
Subject: Re: "git describe --debug" does not show the latest tag for "groff"
To:     Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 30, 2021 at 4:24 PM Bjarni Ingi Gislason <bjarniig@rhi.hi.is> wrote:
>   "git log" on the console shows the tag "1.23.0.rc1" to be the first
> one.

By this, do you mean that `git log` shows the tag on the HEAD commit?
Or do you mean that this is the first tag that `git log` emits?  Note
that `git log` walks complex graphs in a funny order by default; you'd
need `--topo-order` (and usually `--graph` too) to see what's really
going on.

>   "git log" directed to a file does not show any 'tag' in the commit
> lines!

That's normal if you have `--decorate`  set to `auto` (many do: it used
to be sensible ages ago, and I still have that set in my own default git
config).  Tags, in `git log` output,are decorations, and
`auto` means *if going to terminal*.

Chris
