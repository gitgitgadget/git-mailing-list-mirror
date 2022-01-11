Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED10FC433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 20:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243910AbiAKUkO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 15:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbiAKUkN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 15:40:13 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF32C06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 12:40:12 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z22so1004470edd.12
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 12:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=pfhb85mESNVGRIH1AhpAGiXUMPmLjIADRTrwSBWQYLE=;
        b=KewKDQDEkS7aPRNGqVQdpx2b+BTtOjV7b/NwWKZChMuMKer2QbvTJANkUGrv9VBHl/
         dM74U/CVNN0yXBkkcUy9RvDLsTEgWG2jmzieXCDqO6NstfR59mHrp5/rxzlT3QCLOxHn
         9qZI9i2bKaROLAERbj2RiLYcue3O7UjxKINeNdKW1ADvO7236sZo5FEz/PBwo4b8u2A2
         c6p3udRnxsxehl5CXnXb3EbMG9/4Xu8gWeTXGrVyPryWFe2c93zW4UCDMMcmllVj93RK
         h1jJA4Tu6yBDTvBn8YVPKg4SfdRjJaixjuHRthUfl5XCp+fZU2cCWAA49IOWbzSf6XRN
         OPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=pfhb85mESNVGRIH1AhpAGiXUMPmLjIADRTrwSBWQYLE=;
        b=FPtxSy0iZNCKdXRgRgl/snFV7q2spqSVVFZX7e1TzNtkMCUdg8QWbZX2ZyN4v5kaJM
         oqf1IiRXJMuYtg78tnDgczwh6g5xpZQ4BSoSEnr3t7chJEFj935Y7vdxx9PXJ2jBkqTq
         sge/MuRIe1FYXlAek68rDLkw8p8XpkGgGkZfhkCXqzlaqyZf28uE3G+mrrnugktRxojQ
         ACo9bMul17fPxf+5hpmT61MpFYts5UE80Pl88h7OKFw4zIuLwxoHjm8CjwPqv0vASdXf
         IBc5YsSiGGz6pVRyYL6+M32uZ4nq2xFjZ1O8ZdzEDLdvIcZulgMq7zOUF38i/v8G0WTb
         1wFQ==
X-Gm-Message-State: AOAM532f8nmZWTqnqCTqMgvCBu84ajZcnSyJtqmxXoz4nZKcIJJMQHkx
        LW5G5cSbIY2uHxvJnz2lFFnIwCUM1N/v4w==
X-Google-Smtp-Source: ABdhPJzWEPndKgcZxlSmNe+ChFpC/vgjy9lT6DHZBW68khB5Cvhu+jd6ioIHqOBT+dObgK1gWWy2NQ==
X-Received: by 2002:a17:906:2c0e:: with SMTP id e14mr26753ejh.174.1641933611373;
        Tue, 11 Jan 2022 12:40:11 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k8sm310598ejc.115.2022.01.11.12.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 12:40:11 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n7NwA-000hbL-Dw;
        Tue, 11 Jan 2022 21:40:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Teng Long <dyroneteng@gmail.com>, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v9 9/9] cocci: allow padding with `strbuf_addf()`
Date:   Tue, 11 Jan 2022 21:39:18 +0100
References: <cover.1641440700.git.dyroneteng@gmail.com>
 <8dafb2b3779715aa277eb825a94af87b72f3e093.1641440700.git.dyroneteng@gmail.com>
 <220110.86ilurzcxo.gmgdl@evledraar.gmail.com>
 <Yd2zXOrf+4qX8VLD@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <Yd2zXOrf+4qX8VLD@nand.local>
Message-ID: <220111.86iluqxaz9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 11 2022, Taylor Blau wrote:

> On Mon, Jan 10, 2022 at 07:00:59PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> On Thu, Jan 06 2022, Teng Long wrote:
>> > The original rule was introduced by commit:
>> >
>> >     https://github.com/git/git/commit/28c23cd4c3902449aff72cb9a4a70322=
0be0d6ac
>>
>> Let's refer to commits like this:
>>
>>     28c23cd4c39 (strbuf.cocci: suggest strbuf_addbuf() to add one strbuf=
 to an other, 2019-01-25)
>
> I find it helpful to have an alias like:
>
>     $ git config alias.ll
>     !git always --no-pager log -1 --pretty=3D'tformat:%h (%s, %ad)' --dat=
e=3Dshort
>
> in my $HOME/.gitconfig so that I can easily format commits in the
> standard way.
>
> I think that this alias came from Peff, but I can't remember.

Nowadays you can do this as:

    git show -s --pretty=3Dreference

See Documentation/SubmittingPatches

I use:

    $ git help reference
    'reference' is aliased to '!git --no-pager log --pretty=3Dreference -1'
