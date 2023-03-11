Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A351EC6FD1F
	for <git@archiver.kernel.org>; Sat, 11 Mar 2023 10:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjCKKrs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Mar 2023 05:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCKKrq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2023 05:47:46 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5EF23C40
        for <git@vger.kernel.org>; Sat, 11 Mar 2023 02:47:44 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 7750C5C00A1;
        Sat, 11 Mar 2023 05:47:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 11 Mar 2023 05:47:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sebyte.me; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1678531662; x=1678618062; bh=FMH6SHspDE22l7Gcg0WDPh4xDUGrMN94Dfm
        HKwfd1Wo=; b=0WE/5XPPmz7JZOeaaG1WI7Ba765PZ0M+GWc/e9n4syifNJ6/M3o
        43GbAcEzPqG+UCYt6FjTqJb80ksIz+KyLuMYMh79nkYPZxAZ/lSWLc+KsTdZEB7u
        Z3M94bFA0/FS1dPHmyjXjcIp/p+v15oFo7+LupIt2w73wsWqA1U2pUL0vOkum3Mb
        GehOehpqpz4USkJPSe9p7VR+NVhAZps8QhDJcmc7e8FMNqvIrHLI/PtWQdVvFX72
        BFvE2wonl6Kh4SKJftsxo9sTpLsisYjMrk0oqQoLEwRClvZSCzP2rdHgj42/+Wih
        tAlx3rn9cwiN2gWpgv+mdjni0xQJwW/WhVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1678531662; x=1678618062; bh=FMH6SHspDE22l7Gcg0WDPh4xDUGrMN94Dfm
        HKwfd1Wo=; b=WKwgwOwLvL5rjk8dr3x3PA/UrsJhWc/zVL07etnujNKkOvcJDX1
        8tx5JytlQcZH9tjc0gYiha4GJ4jlP7fkA42+8L/7/mfICoPkVHg4OFXgkuyOYW8b
        ZGcXinuZMaWrFrPrpkeskfIK/nJOiAKaPdIuc0rNFxmNv6338hXfleX17t3BaRQF
        o05iFaaAMb2lClZPGbVzpLKzI5eWNJsbFPIc0b8AB4XvEXKAOhWSmC4Z0ylX7B4a
        TWMEyfw34j7+iEAxKc1WycSvPFhUgYSBXMXQrjYOFmgjWYymQyS44yGKV7Noe12w
        IU3h4iJehavv/1jQsbdD9SpTUz4x1IlksQA==
X-ME-Sender: <xms:TlwMZA7YQku29O13ULZzsYrlAP9i19ycBVLKAe63hdedPgUVddQHZw>
    <xme:TlwMZB6ucLJ82N0BbSAkBpQC2iuVB49GyaDL6vkrz49ocrMNsynehGlrNsCEwH6z8
    R9r1bMLtK039qvMsA>
X-ME-Received: <xmr:TlwMZPducbWsbqRSVs9n64K8RJuxLEHjuZ7o_KlhnWDl2gWykm6A_3XAaOLZ09Hl42RDS0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdduledgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufhffjgfkfgggtgfgse
    htqhertddtreejnecuhfhrohhmpefuvggsrghsthhirghnucfvvghnnhgrnhhtuceoshgu
    thesshgvsgihthgvrdhmvgeqnecuggftrfgrthhtvghrnhepkeeufeeuudefleegkeejfe
    euhfegffdtteffleefvedvkeeigeejueehtdevudfhnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepshgvsgihthgvodhrvghtuhhrnhdqphgrth
    hhsehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:TlwMZFKVle0YwFvmGq4M_zElEsD3PLPKRkTuZ1kcmzY06rZw-7eE5w>
    <xmx:TlwMZEIEtIxTyoBzC4I2QKVMB_ShQQKczh7cYttNf4uImW0RDaeHkA>
    <xmx:TlwMZGy4N07q6WioVfk3E0ycQSOmQAgeniT4P5r3-5zLrxRN-8V7Kw>
    <xmx:TlwMZOzTinLPMZyI3ErnXE9ONpIPANH76ea_SyMv8YpujAuvNbfbpQ>
Feedback-ID: i9e78401f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Mar 2023 05:47:42 -0500 (EST)
Received: from sebyte by balor with local (Exim 4.94.2)
        (envelope-from <sebyte@balor.gnukahvesi.net>)
        id 1pawlI-001VPJ-T7; Sat, 11 Mar 2023 10:47:40 +0000
From:   Sebastian Tennant <sdt@sebyte.me>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: How to mirror and augment a git repository
References: <87ilfgemkb.fsf@sebyte.me>
        <ZAWfkkmrPUqNmrtu@coredump.intra.peff.net> <87fsaf9oa8.fsf@sebyte.me>
        <ZAlOnTovp0ncZopf@coredump.intra.peff.net>
Date:   Sat, 11 Mar 2023 10:47:40 +0000
In-Reply-To: <ZAlOnTovp0ncZopf@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 8 Mar 2023 22:12:29 -0500")
Message-ID: <87o7oz7eer.fsf@sebyte.me>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Jeff,

Alas, I thought I understood fetch refspecs, but it appears not.

Quoth Jeff King <peff@peff.net>
on Wed, 8 Mar 2023 22:12:29 -0500:
> On Wed, Mar 08, 2023 at 04:54:39PM +0000, Sebastian Tennant wrote:
> [=E2=80=A6]
>> Indeed.  To fetch a known ref, a client (also with the normal fetch
>> refspec) would have to do something like this, for example:
>>
>>  $ git fetch origin\
>>        refs/remotes/origin/<ref>:refs/remotes/upstream/<ref>
>>
>> Alternatively, they could add an additional fetch refspec to their
>> config:
>>
>> [remote=3D"origin"]
>>  ...
>>  fetch =3D +refs/heads/*:refs/remotes/origin/*             # normal
>>  fetch =3D +refs/remotes/origin/*:refs/remotes/upstream/*  # additional
>>
>> This would have the advantage of fetching all the upstream refs on
>> the next update giving them a better idea of what's happening
>> upstream.
>>
>> Is my understanding more or less correct?
>
> Yes, that's exactly correct. In some ways it is cleaner than using
> "refs/heads/upstream" because it leaves the whole "refs/heads/"
> namespace intact for local client branches. It depends on how much
> of a pain it is to configure the extra refspec in each client. :)

I decided to go with the cleaner approach.

Here are the actions I'm taking to configure the mirror:

 $ git clone --bare https://url.of/project.git
 $ cd project.git
 $ git remote rename origin upstream
 $ git config remote.upstream.fetch\
       '+refs/heads/*:refs/remotes/upstream/*'
 $ git fetch upstream --prune

At this point there are no refs under refs/heads (and very many under
refs/remotes/upstream).

Here are the actions I'm then taking on a client:

 $ git clone --bare mirror:path/to/project.git
 $ cd project.git
 $ git remote rename origin mirror
 $ git config remote.mirror.fetch\
       '+refs/heads/*:refs/remotes/mirror/*'

At this point, both mirror and client have a normal fetch refspec,
i.e. no additional refspec has been added to the client, yet when I
run:

 $ git fetch mirror --prune

on the client, all the refs on mirror under refs/remotes/upstream are
fetched and placed under refs/remotes/mirror on the client.

My understanding of refspec:

 +refs/heads/*:refs/remotes/mirror/*

is "fetch only those refs under refs/heads and place them under
refs/remotes/mirror", which in this case should mean that no refs are
fetched (since there are none on mirror under refs/heads).

What's going on here that I'm just not getting?

If I add the additional refspec to the client:

 $ git config --add remote.mirror.fetch\
   '+refs/remotes/upstream/*:refs/remotes/upstream/*'

and fetch once more, I end up with all the refs already under
refs/remotes/mirror duplicated under refs/remotes/upstream.

Sebastian
