Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB4BC7EE22
	for <git@archiver.kernel.org>; Wed, 17 May 2023 19:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjEQT6j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 15:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjEQT6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 15:58:24 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4A4E67
        for <git@vger.kernel.org>; Wed, 17 May 2023 12:58:23 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C537F5C00D4;
        Wed, 17 May 2023 15:58:20 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Wed, 17 May 2023 15:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1684353500; x=1684439900; bh=Ndmh+FUrVdd0I+MtDgcQeuKC6
        SBIhhmQUW3M4UWhNjQ=; b=WBNxMScZ07ra9X8ZHRriiEm3rpDDnqp+CQ67Ea+9m
        70/0T0cfx6ag3N/tsprhIPvsB5Ib5AOKOfcz+y/OsnU+fBOwGYf22vy+s02oMpvl
        SMCuXFXaPD5AIwUHDYE08lIfFAawrA+9MSDBoRd3fc0YXuOaROTDRlVb3E7ih4Y7
        cF4ekHiY643UGkpOoDBs9rGPMhDZzZqFQWKI55VWhsXCtk8CaeMkis4jV40b1D5G
        CHrJubXeHW4JtmM5lJvaGX+xbobuKa5duFHaqUfJvyaysg7GM0nVU6fLdOKoKK0+
        79eNLNvHclsJrS0SRKaxAq+1+EbnWv+NT9nLhFVfAo8yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684353500; x=1684439900; bh=Ndmh+FUrVdd0I+MtDgcQeuKC6SBIhhmQUW3
        M4UWhNjQ=; b=KzrtPebOCi9+FDaLGByqJqCMKxdfe56XsNUSzf3wB4f1n/Dl208
        VeW70OqSgDTVXeh2SyAyuVruE2NWnDEQ+zm4T9qJ2A8fs0CMAkrEzFoHrF8SJmWY
        ISOleXO1x2c5BnbDAxJWN4SNJgyA8Jmx/5ndWoU+y/frVR91URzq9FMKg7PETHPq
        KOo8USDVUpnD+z9e3YpVke4SOjggSUwlMjH+A3tY5GiYS9BvyUbWiZ2v8YYwgkBI
        b505eWKq0ICCfsuRuJk+SbrIjgTSZv9k4jOKYK+D4/+hJD8e3XCD4VEsTDRI6lqA
        0VSsRNmCRb8q0f1RY+XeoYRzmciERyep3Hw==
X-ME-Sender: <xms:3DFlZBX6JXO5J_OiwUTJQ6mVA4A__xJW27pZAPMzMPu48zv-SSpeQHU>
    <xme:3DFlZBl1LC-eph84w3JKkdsySgiozp9SNTCAa9kGTXaVvDX0WNoaNCooSC8rmk01A
    ealwjdM5_no58z1Uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiuddgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtgf
    esthhqredtreerjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghk
    khdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrh
    hnpedvveehiedufeehffdvteeuveekhefhleeigfektdeifeduteeuheeufeetffefuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvg
    eskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:3DFlZNapjp_Gx0zZj2DSOTR3Qivs9Nm6DHJ1FUdigZ1C26-M9EIY5w>
    <xmx:3DFlZEUAgIabndM34V3KMpvwaFPvZYXWf4iTXP1I9HD5tNAYl5icBQ>
    <xmx:3DFlZLnfnZbKrSViJfHrI-VqT8GMJY0Gumijhr0DPrPZ_QTxSkvhqw>
    <xmx:3DFlZKvrGsvhRaRn5jJoLodSs_n70aBl1J9XYq-3EaQABF70CdtRfQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 865B815A008E; Wed, 17 May 2023 15:58:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <970f3420-13b8-455c-bee5-284a79893c8a@app.fastmail.com>
In-Reply-To: <20230517093214.GA527234@coredump.intra.peff.net>
References: <cover.1684067644.git.code@khaugsbakk.name>
 <20230517093214.GA527234@coredump.intra.peff.net>
Date:   Wed, 17 May 2023 21:58:00 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Jeff King" <peff@peff.net>
Cc:     "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] tag: keep the message file in case ref transaction fails
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2023, at 11:32, Jeff King wrote:
> It has definitely been a while since that one. :) I agree what you are
> doing here is in the same spirit as that commit, though there is one
> small difference. 3927bbe9a4 was about saving the message file if we
> failed to create the object, since otherwise there is no record of it.
>
> Your patch is about saving it from a failed ref update. But in that ca=
se
> we _do_ have the data saved in the object. You can find it with
> git-fsck:

I didn=E2=80=99t even think of that. :) Too much tunnel-focus on that te=
xt file=E2=80=A6

>
>   [after running something like your test script]
>   $ git fsck
>   Checking object directories: 100% (256/256), done.
>   dangling tag b9bde516952a863690027a611575a79d4c786b8d
>
>   $ git cat-file tag b9bde516952a863690027a611575a79d4c786b8d
>   object 8b1e708e32ae3af17825b3c713a3ab317824b932
>   type commit
>   tag foo/bar
>   tagger Jeff King <peff@peff.net> 1684314980 -0400
>
>   my message
>
> That said, I'm willing to believe that most users wouldn't figure this
> out on their own, and saving TAG_EDITMSG might be more friendly.

The current error says:

```
fatal: cannot lock ref 'refs/tags/release': 'refs/tags/release/v1' exist=
s; cannot create 'refs/tags/release'
```

As a user, I have no idea if anything (the tag object) was even
created. The error just says that the tag couldn=E2=80=99t be created. (=
As a
user the ref pointing to the annotated tag object and the object itself
sound like basically the same thing.)

I might be able to guess that it *had* created something tangible like
an object in the database since it got all the way to update the ref to
point to it (just one more step=E2=80=A6). But that feels like a stretch.

> But one other alternative might be to mention the hash of that tag
> object, and possibly give advice on recovering it.

That could work. Like:

```
hint: git tag <new name> f73e152cb1560aff1446b208affba4cdcf5bea36
```

So I copy that into my prompt and update the name. All is good.

But I might decide to be just copy the hash, press =E2=80=9CUp=E2=80=9D =
in the terminal,
copy the hash at the end, and change the name:

```
git tag -a release-it f73e152cb1560aff1446b208affba4cdcf5bea36
```

Next I=E2=80=99m in my text editor again. Not sure what that is about bu=
t okay.

*closes it*

```
hint: You have created a nested tag. The object referred to by your new =
tag is
hint: already a tag. If you meant to tag the object that it points to, u=
se:
hint:
hint: 	git tag -f release-it f73e152cb1560aff1446b208affba4cdcf5bea36^{}
hint: Disable this message with "git config advice.nestedTag false"
```

> It's too bad we do not have "git tag -c" to match "git commit -c", whi=
ch
> would allow us to say something like:

Sure. I appreciate that kind of symmetry. (I guess that=E2=80=99s not th=
e most
precise word in this context.)

> I dunno. There is a certain elegance to telling the user about what
> progress we _did_ make, but if there isn't an easy way to turn that in=
to
> a retry of their command, it may not be all that useful.

As a user, the only expensive part (potentially; refer back to footnote
=E2=84=96 2 of the CV) is writing the tag message. So fudging around a b=
it with
copying the backup text file into the new message (I would probably just
copy it into the editor) is not a big deal. And retrying the command is
just =E2=80=9CUp=E2=80=9D and a little line editing.

> So I'm not really opposed to your patch, but mostly just brainstorming
> alternatives.

It=E2=80=99s very much appreciated.

> I gave v3 a brief look, and it seems OK to me. It might be nice to
> factor out the duplicated advice message, but since we cannot share any
> of the other lines (one spot calls exit() and the other uses die()), I
> am OK with it as-is.
>
> -Peff

I=E2=80=99ll make a function for the message in the next round. It=E2=80=
=99s nice to not
have to duplicate such strings/message ids, I think.

Cheers

--=20
Kristoffer Haugsbakk
