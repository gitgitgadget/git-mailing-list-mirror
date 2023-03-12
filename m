Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7736CC6FD19
	for <git@archiver.kernel.org>; Sun, 12 Mar 2023 18:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjCLSUS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Mar 2023 14:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjCLSTz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2023 14:19:55 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83BE23DB4
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 11:12:50 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 56A4E320046E;
        Sun, 12 Mar 2023 14:11:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 12 Mar 2023 14:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sebyte.me; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1678644684; x=
        1678731084; bh=9l6D18LENxMsprqsrHRXQ7uNCMY9LeINw4xoG+93GkE=; b=J
        iNNCO3/ZRo8l+sIR+EXapS59+ztJB/EDl85TOJWAhpzd6VruZPizyJe5lGiGi49+
        MUtgpHYGJEbPPipcuMGh5FGS1RkutpGkm5F7MXsxkb9cEDIdUDncFHwK1Q7qyfUD
        aG+DWF8Cg25RB5MAxloT/NGD7EieNE7waHPgEkNur+ZjlRtJkUXJp4bero3EKbxC
        FPAXrwSzKLXGErZwRBFL2Cm6qVhLVcloDa8tumGwUsWRslVWaZ2VjToRdUoSKEUM
        2fhYkgDXnNm1EMfWDfPHLWApQBh5M4Fohu8hnab4/1Xc4RUh25Ya2qN2AvbvMN1n
        cFsQXeiYE/r3ApMSy1V0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1678644684; x=
        1678731084; bh=9l6D18LENxMsprqsrHRXQ7uNCMY9LeINw4xoG+93GkE=; b=j
        E1ZoxewlxZi6OVGnPfZNucrINY8m1i0z2C5Z/b1KQoFwBTEBDVXSLlwJVPBOJXiE
        4fsI9Z+tAgXYWWkeDxvqLpKV/dje/A5yuwBJAMz36T/ZIx4DD0j7lpapxR+6SlOi
        yBnvN+cwkRNAUESmcyJRtxvnTdRscmZCSF1LxcbJPFuUKe/IfPE7j/cEM4EO1BvW
        ZV32EoOTjcU60rtxnNMjZBVP3mfXJ6Trj5N2VxGtw7u2W70fktta8vobbddFKXFr
        PHBGHi4jxErXRY9TDn8LIzK1VRFYA0Qngdi11Jt5uYUWz51SWjeWJ6vm/EkX1c17
        +tx4O+eazR+BF5GZeT5mg==
X-ME-Sender: <xms:zBUOZAQO0fwXmHtsyu8Djq8QEXkO0S3ECH3NBdX98pDT7BS-L7qSmg>
    <xme:zBUOZNyrQCNWQISmpsxf0-YiNsai8nRkNyWXckEfm3_ZHpHjTO37v_gbKdK8NGo42
    mnfFVUXQntNb9lTiw>
X-ME-Received: <xmr:zBUOZN0sIUtET1pJCZIB77-c-NF4-yFqKvHu9LrIsRujlVaCXP2jurtEJrn1fvN0EAhaolI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvvddguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufhffkfgfgggtgfesth
    hqredttderjeenucfhrhhomhepufgvsggrshhtihgrnhcuvfgvnhhnrghnthcuoehsught
    sehsvggshihtvgdrmhgvqeenucggtffrrghtthgvrhhnpeefjeefleevteejgedvheeuff
    ffvdevteeftdfhjedtveffteegudehkeevieduvdenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehsvggshihtvgdorhgvthhurhhnqdhprghthh
    esfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:zBUOZEAUDhI3OoBOdKuYIrF-7wkGsrucKtyO4IfRFwz3kdu1tOrt4Q>
    <xmx:zBUOZJjjc70E-Sa_jCLE03z__8EeCt3q6Ze11zPxqTFVHJnKaCJ_tQ>
    <xmx:zBUOZAoU2ekL5V2gkYUpLaI898_skWZw0Kf9EBu7T-LHUaSNbi_-Hg>
    <xmx:zBUOZJIoYjFEMbFI7wpX0S_JBSLuHoE9M0L2h9EZB2GDKfp1kjNI2g>
Feedback-ID: i9e78401f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Mar 2023 14:11:24 -0400 (EDT)
Received: from sebyte by balor with local (Exim 4.94.2)
        (envelope-from <sebyte@balor.gnukahvesi.net>)
        id 1pbQAE-001aOM-RS; Sun, 12 Mar 2023 18:11:22 +0000
From:   Sebastian Tennant <sdt@sebyte.me>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: How to mirror and augment a git repository
References: <87ilfgemkb.fsf@sebyte.me>
        <ZAWfkkmrPUqNmrtu@coredump.intra.peff.net> <87fsaf9oa8.fsf@sebyte.me>
        <ZAlOnTovp0ncZopf@coredump.intra.peff.net> <87o7oz7eer.fsf@sebyte.me>
        <ZAyWUS27M+degQxj@coredump.intra.peff.net>
Date:   Sun, 12 Mar 2023 18:11:22 +0000
Message-ID: <87pm9d6drp.fsf@sebyte.me>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Quoth Jeff King <peff@peff.net>
on Sat, 11 Mar 2023 09:55:13 -0500:
> On Sat, Mar 11, 2023 at 10:47:40AM +0000, Sebastian Tennant wrote:
>
>> Here are the actions I'm taking to configure the mirror:
>>
>>  $ git clone --bare https://url.of/project.git
>>  $ cd project.git
>>  $ git remote rename origin upstream
>>  $ git config remote.upstream.fetch\
>>        '+refs/heads/*:refs/remotes/upstream/*'
>>  $ git fetch upstream --prune
>>
>> At this point there are no refs under refs/heads (and very many under
>> refs/remotes/upstream).
>
> You'd have refs under refs/heads at this point.  They were created
> when you did the original bare clone (since bare clones fetch all
> heads to start with, though they don't set up a refspec).

I see the refs under refs/heads at last!

My mistake was looking for them in the file system (instead of in file
=E2=80=98packed-refs=E2=80=99).

> And they won't be deleted by the pruning fetch, of course, because
> you configured the refspec to limit itself to refs/remotes/upstream
> on the local side.
>
> If you don't want them (and I think you don't), you can just initialize
> the repository directly, and then fetch, like:
>
>   git init --bare project.git
>   cd project.git
>   git config remote.upstream.url https://url.of/project.git
>   [and then configure refspec and fetch --prune as before]

This is precisely the behaviour I've been wanting (and mistakenly
expecting).

>> Here are the actions I'm then taking on a client:
>>
>>  $ git clone --bare mirror:path/to/project.git
>>  $ cd project.git
>>  $ git remote rename origin mirror
>>  $ git config remote.mirror.fetch\
>>        '+refs/heads/*:refs/remotes/mirror/*'
>
> This bare clone will do the same thing. So you'll end up with a copy
> of all of the heads created in the earlier step. Worse, they won't
> be the current state of those branches, but stale ones left from
> when you created the mirror repo.
>
> I think you want _two_ refspecs in the clients:
>
>   - one to fetch the client-local branches stored on the mirror. That
>     is:
>
>       +refs/heads/*:refs/remotes/origin/*
>
>     and those branches just appear as normal.
>
>   - one to fetch the mirrored upstream branches from the special
>     namespace on the mirror. That one is:
>
>       +refs/remotes/upstream/*:refs/remotes/upstream/*

Yup, this is what I want, and actually what I already have in place,
configuration wise.

The problem was in my partial understanding of the consequences of
passing option --bare to =E2=80=98git clone=E2=80=99 (and in my not thinkin=
g to look
in file =E2=80=98packed-refs=E2=80=99).

Thanks again Jeff.

Sebastian
