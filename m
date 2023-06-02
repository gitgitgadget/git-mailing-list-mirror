Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7FAC7EE24
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 10:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbjFBKHL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 06:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbjFBKHI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 06:07:08 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEDAE7
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 03:07:06 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id E8A73320077A;
        Fri,  2 Jun 2023 06:07:03 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Fri, 02 Jun 2023 06:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1685700423; x=1685786823; bh=Iz/o/Ot+oOqRwrOhCavXi10Q6
        alj6g4S6AeM0bOnKFk=; b=acTWPpQleDBiwvxqKKxMj/SC22oKCJ4Mr2DOJ7l0A
        4l6cwrOM/uKjLGQacq7bttvWjhoWUdVLI0BLPufpwY5SfxQCfzGTu4G0PoIi9lGa
        BluuqAXZFMPRtR/k3XGV7JLD9sMEZP6Np/MRO/vLf91tEOzmH8o61EIf0sxIhvKh
        jWgVcRrIIWNeQUCuCP21m/akMj1JOh2vb5NYOfdqWhhPBqnCDEYeHGOtcWEKv0nB
        XgQx+ibUBOvnUWDml2DS3DGu+2qXU9+2JaebP30L0qUIFF3xVNxRmbz5O85SdC0o
        HyLoseQ57WSc2tza5K8K2Gp5T4Xj1TIlc3R+d+vNKsIzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685700423; x=1685786823; bh=Iz/o/Ot+oOqRwrOhCavXi10Q6alj6g4S6Ae
        M0bOnKFk=; b=ty6ATkvJtzMg4/GbzyubJUfHUoisQm4xD1hJ8OBzSOj3PaJDJGX
        QvhGWbYDxAZoBXm+stIuFhxUooOnbMpe0pTgfggnzFtR5YttU99GJaqYGZrgdVJM
        TZdPkqypNHooMmdekZlkbIb23sqsz663SSFZVqNt9J8Xv2ZMG+Gd8gPVGH69IdW1
        IDMKhDhc81Y6sF2HGvwtDvStYXknaqDklQpxj/mPUhRvTwnaleL/FX8ymMhG4thJ
        mNP6z6PK+lSsLGVGUam7TSG5/G1GhFkqBn/bqKEn2qtLlEGYjyS137jxztSKTvuQ
        qgCjEl2PF9pMrkHeROcAydC6TSNHnjB48Sw==
X-ME-Sender: <xms:R795ZGJaGcLQYdLYk4c1q32NZKky6fKMJ3we2YzUNODYXxCUPx4oo58>
    <xme:R795ZOKjTQL-11UCBekqFKEMO6upTfuwPSFav9Tz_KK3-iCHByYFqLt8DWOHOXtwE
    Ynm6x5Z_uJPUd-F0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelfedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedtkeduvedthfelueevheffhedvveei
    ueeiheehudehveegueetteduuddtfeelueenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:R795ZGsrBMSxYgBhrax8ajggxBli2LhcXi-hAf74naUzvQhayLlVpQ>
    <xmx:R795ZLYKUEq54gbeFc6mmLI0B6PBIvvfAlFkFNKZxlSPs9bEDFfmmQ>
    <xmx:R795ZNbXv31zamqNCcHP7kfkaLoMYgz-mE0sfl3zb8k83hFn9BuvMw>
    <xmx:R795ZMx2nfxmCYlBKKx1nQ6EC8j_UA5zw-C0P5BC-BRd1iFPXnSpcQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 43B3015A008E; Fri,  2 Jun 2023 06:07:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <8f434f16-de65-40c2-80d3-28d123c7be7f@app.fastmail.com>
In-Reply-To: <20230601182020.GC4165405@coredump.intra.peff.net>
References: <cover.1685441207.git.code@khaugsbakk.name>
 <8cc8eddfced1b64156008f7f923c430981d472af.1685441207.git.code@khaugsbakk.name>
 <20230601182020.GC4165405@coredump.intra.peff.net>
Date:   Fri, 02 Jun 2023 12:06:16 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Jeff King" <peff@peff.net>
Cc:     git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
        "Denton Liu" <liu.denton@gmail.com>
Subject: Re: [RFC PATCH 1/3] range-diff: treat notes like `log`
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff!

On Thu, Jun 1, 2023, at 20:20, Jeff King wrote:
>> This can=E2=80=99t be how the user expects `range-diff` to behave giv=
en that the
>> man page for `range diff` under `--[no-]notes[=3D<ref>]` says:
>>
>> > This flag is passed to the git log program (see git-log(1)) that
>> > generates the patches.
>
> Yeah, I certainly agree that the behavior of range-diff is surprising,
> and that this is a bug.
>
> I'd have expected the solution here would be for range-diff to stop
> passing "--notes", and let "log" decide whether to show notes (based on
> specific --notes=3Dfoo it gets from other_arg).

I tried that (removing `--notes`) but it didn=E2=80=99t work out for me.=
 I=E2=80=99d had
hoped that `--notes` was just a holdover from a previous change that
wasn=E2=80=99t needed any more, but it seems according to my testing tha=
t `range
diff` needs to pass *some* notes-related argument to `log` in order for
the test suite to pass.

Thinking about it again now it doesn=E2=80=99t really make sense in the =
isolated
case of `range-diff`. But maybe it=E2=80=99s needed in conjunction with
`format-patch`.

A relevant series is =E2=80=9Crange-diff: learn `--notes`=E2=80=9D by De=
nton Liu
(f3c7bfdde2 (Merge branch 'dl/range-diff-with-notes', 2019-12-05)).[1]

On the commit before that merge, `range-diff.c` does not pass `--notes`
to `log`. Denton describes the behavior in the first cover letter:

> When I was using range-diff at $DAYJOB earlier, I realised that it
> includes commit notes as part of the commit message comparison.

So just like the default behavior of `log`.

However, the next version (v2) is about teaching `range-diff` to pass
notes down to `log`:

> This patchset teaches range-diff and format-patch to pass `--notes`
> options down to the `git log` machinery. This should make the
> behaviour more configurable for users who either don't want notes to
> be displayed or want multiple notes refs to be displayed.

So apparently `range-diff` couldn=E2=80=99t pass on/down `--notes=3D<ref=
>` before
that.

That series also teaches `format-patch` to handle notes in 5b583e6a09
(format-patch: pass notes configuration to range-diff, 2019-11-20).

[1] https://lore.kernel.org/git/cover.1574125554.git.liu.denton@gmail.co=
m/

>
> But...
>
>> This behavior also affects `format-patch` since it uses `range-diff` =
for
>> the cover letter. Unlike `log`, though, `format-patch` is not supposed
>> to show the default notes if no notes-related arguments are given.[1]
>> But this promise is broken when the range-diff happens to have someth=
ing
>> to say about the changes to the default notes, since that will be sho=
wn
>> in the cover letter.
>>
>> Remedy this by co-opting the `--standard-notes` option which has been
>> deprecated since ab18b2c0df[2] and which is currently only documented=
 in
>> `pretty-options`.
>
> I'm not clear on whether you're actually fixing two separate bugs here,
> or if they need to be intertwined.

I guess it depends on your perspective. ;) I would say that they are so
intertwined that fixing one also fixes the other.

> It seems like passing --standard-notes means that format-patch's
> range-diff will still show the standard notes by default. Maybe I'm
> misunderstanding the problem, though.

No, that should still work. See the test `format-patch --range-diff does
not compare notes by default`.

That kind of thing seems to be handled by `log.c:get_notes_args`;
`--no-notes` is sent to `log` if no notes should be shown.

Cheers

--=20
Kristoffer Haugsbakk
