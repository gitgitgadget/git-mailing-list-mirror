Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05530C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 21:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238083AbiCAVKE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 16:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238302AbiCAVKD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 16:10:03 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF32B43ED2
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 13:09:21 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d3so22483241wrf.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 13:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k8s7QusNTSNvXtO4exhsMcLl2fMrt1Zo3vTcO28pSpQ=;
        b=GhXCGl8CRexkxkNl4WxHWkEsL9px171++/ozNVpIGUOGlFT7KA0CVq9c2iUdmmK9DZ
         kkZChyr8+PT8UaHVuCBklnmzEGLabkgejdUOHbTliY58C229IRAKlWkpQ0H695Z2kNWo
         LPV/N6SM/p3Thi3vk/GiRn0S1A2DLO3zsGhj040DU/5ax9mb9jM5KPynEE0t2bT1ijII
         GNIJhCJDvmkMsyzXLOmXVPkWVEFs2aD2MmjQYcrXv4mL5VScfkxZVkSJgYVSEPicfhc8
         m1i9PhkJVwAlZSsQ1Gbav4dPTTn4gTiM3ciH7Swv6xq0FsFxoAztoT8Tb+OaPD17DDor
         ueIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k8s7QusNTSNvXtO4exhsMcLl2fMrt1Zo3vTcO28pSpQ=;
        b=GP0WiY7iuesdZK2I5xQvfejWXx9gx0lxkIfrHnsT+VI8meBwaggFjKF1KN0IW4FvPl
         AoDyupB22bvYvm5zd1TydMeG1J/1FTpPoFuXAEZrLKwe39cHkaIzTzLe/ww5C4WUttmY
         B/jIH9bSdd1zFozWydJ7dAtgm8HPwh0V025dhFYJa9RfQxsHbeyi4DSXIkjhN6MHyhS9
         rmXrgBfRc5Qo6HxOKJbe271T6Jts2+7Owqkhmd5TIuvwWIQ6C8DfEx8Vq1QEUC6fk0Wn
         6cZYX4yxMA5inlIkbWkWLNcL9ebaYGVroIS8ZrtfuG/24btx9D5oJ+1Y3HNACauMqaCY
         kCCw==
X-Gm-Message-State: AOAM532JPGjgc1g84LZpeUiFYDu41s9hw6D2bv2MYsBOCeRzIWHTDzzp
        7a+6qvZ6CAi0jGD12e6L5p12/vKssJsU22+mZ7psgqQSn2y+Pw==
X-Google-Smtp-Source: ABdhPJzXpvEPyXiPERj3hRQOkopMYH7Z7M8bUl0HDUwjnJ7idg0vqlDeKNBC4OhW04pZDr4/RiadpQjpMojdT32z8fs=
X-Received: by 2002:adf:e746:0:b0:1ef:8476:dab3 with SMTP id
 c6-20020adfe746000000b001ef8476dab3mr13459658wrn.449.1646168960154; Tue, 01
 Mar 2022 13:09:20 -0800 (PST)
MIME-Version: 1.0
References: <CAFVSqg1arVNwWMANwR6CDP++5hXAEW1a_ajekNe+TXNpSSZFPA@mail.gmail.com>
 <20220301175334.ctem25nxckynnvco@meerkat.local> <CAFVSqg3i_ANc1sTmEHaxjxxdkkN9HbUEUwejV5S5V5tM2fhWWA@mail.gmail.com>
 <20220301183040.rvj6jb2mfc46kv6t@meerkat.local>
In-Reply-To: <20220301183040.rvj6jb2mfc46kv6t@meerkat.local>
From:   Ed Warnicke <hagbard@gmail.com>
Date:   Tue, 1 Mar 2022 15:09:08 -0600
Message-ID: <CAFVSqg2zp+BeYQ_JaBXVfJ0csmNtF1N8avCZ52gq1Twtw4_zyQ@mail.gmail.com>
Subject: Re: URI Scheme for git object ids?
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Exactly... anybody who wants to be able to say "This is a git object
id for a thing" rather than "this is a random sha1" (or perhaps
someday, sha256), and more importantly... if presented with say... the
same contents outside of a git repo repeat the computation of the git
object id and see that it's referring to the contents they have in
their hands.

That had been my original thought around including the 'object type'
(gitoid:blob:sha1:261eeb9e9f8b2b4b0d119366dda99c6fd7d35c64) because if
presented with an array of bytes outside of a git repo, if I want to
know whether or not it matches the git oid, I need to know what git
object type to put in the git header prepended to the contents.

I have a tendency to generalization though, and so its'1 good to get
feedback from folks closer to git as to whether that makes sense or
not.

As a side note: in case I'm being unclear: there is no conceivable
universe in which I'm advocating for git to change anything it does
around this conversation.  I'm just seeking 'advice'.  Among the space
of valid advice being: "don't reinvent the wheel, these folks already
have a perfectly serviceable wheel"

Ed

On Tue, Mar 1, 2022 at 12:30 PM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> On Tue, Mar 01, 2022 at 11:58:01AM -0600, Ed Warnicke wrote:
> > Konstantin,
> >
> > I suspect you read a bit more into my question than I intended :)  I
> > do appreciate the breadth of your thought about it though :)
>
> Ah. Sorry, my perception is understandably tainted in the past few days.
>
> > Mostly, I'm just looking for a way to express the git object id as a
> > uri scheme so completely outside-of-git things can refer to it clearly
> > (ie, know to prepend the object header before hashing to see if the
> > contents match).
>
> Okay, I understand -- so for purposes like adding to sigstore or other supply
> chain tracking systems?
>
> -K
