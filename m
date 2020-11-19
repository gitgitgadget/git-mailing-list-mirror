Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2534AC63798
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 21:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC7C522242
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 21:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8XmoKq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgKSV3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 16:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgKSV3r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 16:29:47 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B8FC0613CF
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 13:29:46 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id q1so6716996ilt.6
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 13:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=eHiXaR1J+vzUhx4T9RfE2Qto+JUIlVKVl3iaiVkpKOg=;
        b=G8XmoKq7Mda+Hcqu8ZxVELWZAd86oLfl/mGIceDm5EqddiOVNK90wOBCz+4uJ2f1CG
         CO0qzxmczy8ov8kjDsYI5gbXStS9Po+B/bS+VgO0630uX2yQRCTi8XsSh+P7cdokC4I3
         Vrp6J03K45nBH4MYkGN5QkgHx2LUao8bbb827DZPKdBNFbiGwT4gBY/uQUxgq7WKopLM
         1QTH7MbErIJIVMD7KpKFRofLyCGF9BYOTAXYkGv+0gF1KAQrP14xXzC2OblY9Opf04bI
         7EMcXz9DIOW+ccP5lcapjrx6dR5rRF/6EH1v2Vxj4EPtzv/HJ0YbPOg1fmHpbeimTxUq
         vnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=eHiXaR1J+vzUhx4T9RfE2Qto+JUIlVKVl3iaiVkpKOg=;
        b=SU0Tlucp2BWYHKQ6+hxzSYjSj2TgoVvZ2MN/ivQeTBUUOLJfbN1G0giZOZvqYvEblm
         r4Jt23pzuNuzi+7A1lP++M6sW/8y53Xffs+hDW0TNWbzIRuLeNvtmEHSHhEI03M2Vw1v
         RxEfVYdTeZ8yDRJv1FnOBxjIDBrR8KW1ioPH9BAgBPY5UYbJJZDj6oODP3+Uu3/DZBEl
         JJs/8sxYdyZ6iruDWg6uD3evbpcU0hazcFjCUM49MNi8PcNUBqcnXpyunr+AqByqG82y
         NOjQyc5arcp0zLQUsjV0HgNCkMTI0n95I6vS7V5otT4VpwvlnPifac/7/sJcXgsuShVe
         x/uA==
X-Gm-Message-State: AOAM533a0paquZOfwVMz6PV1TsEWoLzidhES1WWD8lL2fOb6w21Yaabu
        NFHAaPNvad801afaC0oMIcTN2KZWsK4ADY9dtg0=
X-Google-Smtp-Source: ABdhPJxD8xk7pI3VS1uM+0Ow66+BKI8yzEMcujCO0103N5SCtX5my7eJZ2LOSK4t3wq/UTxwf+e6GvGU56hZCfKGzLo=
X-Received: by 2002:a92:de50:: with SMTP id e16mr22909978ilr.144.1605821386275;
 Thu, 19 Nov 2020 13:29:46 -0800 (PST)
MIME-Version: 1.0
References: <CAMP44s3BJ3dGsLJ-6yA-Po459=+m826KD9an4+P3qOY1vkbxZg@mail.gmail.com>
 <20201113010107.GL6252@camp.crustytoothpaste.net> <CAMP44s1U1FevS7NrAYxvgVyzfR5tnD9-+BbPdw5bKnaNHkyD+A@mail.gmail.com>
 <20201113051408.GA3985404@mit.edu> <CAMP44s3AeESm7VBKbar0ir_Py35g99ZW6bNX_=AK4N=OFkcrdA@mail.gmail.com>
 <20201113145802.GB3985404@mit.edu> <CBC2DBAA-A409-49CD-B932-AC82D3C20D55@kobil.com>
 <20201115034649.GC3985404@mit.edu> <CA+sFfMfWrSMKAogg-5dsaO_beXUV-JCBLBPeLZ5g_0jGqsom8Q@mail.gmail.com>
 <20201119133705.7q7yghymvvo7zeq4@chatter.i7.local>
In-Reply-To: <20201119133705.7q7yghymvvo7zeq4@chatter.i7.local>
From:   Brandon Casey <drafnel@gmail.com>
Date:   Thu, 19 Nov 2020 13:29:35 -0800
Message-ID: <CA+sFfMdHrapy2o8D53dpqA5b+a88VLOX126daLcC8Sash4rq3A@mail.gmail.com>
Subject: Re: The master branch rename, and avoiding another v1.6.0 git-foo fiasco
To:     Brandon Casey <drafnel@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Lukasz Niemier <Lukasz.Niemier@kobil.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 19, 2020 at 5:37 AM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> On Wed, Nov 18, 2020 at 05:02:59PM -0800, Brandon Casey wrote:
> > > This *really* is not hard; which is why I am starting to suspect
> > > people are really kvetching because their objections are really more
> > > about the woke/anti-woke aspect of the "master" -> "main" migration
> > > --- and they are using *think* the children^H^H^H^H^H^H^H users as a
> > > rhetorical device.
> >
> > So we're changing the default branch name from "master" to "main"?
>
> To my knowledge, there are no concrete plans to change anything at this
> time. All recent work was to remove any special-case treatment of
> "master" as the default branch name, so people are free to use any
> configuration they like.

Glad to hear that. That doesn't seem to be the perspective that others
have in this discussion thread though, especially since Theodore Ts'o
referred to "...the "master" -> "main" migration" in his comment that
I quoted above.

Thanks for trying to respond to my questions, but I think your
responses are mostly misdirected towards an issue that I was not
referring to. That being the configurability of the default branch
name, which I doubt anyone has a problem with, as opposed to changing
the default branch name for all newly created repositories and
possibly for the git repo itself for some supposed offensiveness of
the word "master". That is what I consider silly.

For example, when I asked "So we're changing the default branch name
from "master" to "main"?" and then followed that up with "For what
purpose?", the latter question was asking "For what purpose are we
changing the default branch name from "master" to "main"?", and then
"What problem are we trying to solve by changing the default branch
name from "master" to "main"?" etc.

-Brandon
