Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D0FEC873E
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 16:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbjIGQR0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 12:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239502AbjIGQQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 12:16:58 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7104225
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 09:07:24 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 7D6695C00EA;
        Thu,  7 Sep 2023 11:08:24 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Thu, 07 Sep 2023 11:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1694099304; x=1694185704; bh=AQpFEcR0/+vlgu2RTAcrVOus/
        SK4B8PXscPKn80UlBs=; b=NQ5/oEmd9w4q5XTy2TIMRRhwQa4k9y3d8DFHDQmqI
        zy6ZwQBmKSPd4zXRnHfsfQ9YhavCnIbczL+Dv2bsj4dZWIFlN5PjV9f/D3I+6C/b
        fGO3V/4pOMl3zGx92FTpQYOjQ4G/MMsIbT3l07MunBroJ8MhdICYB5vAdnzfcpbG
        +4ZC3YBwxcXPZeZGCC7s6THSY52ADlj6CEOpcU9hZkWBC4QlpUWXquJKgZ280QcF
        vWetgYnInrXlvk8HxbYEFVC38UgW+kDUL6XQZ40yjfJL/o9mq5M5J6jZR0fCqtx4
        6u0bDXtHSxPpHskLmHiOZdNG8K26lyQ/vhQVhHC8OZ6Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1694099304; x=1694185704; bh=AQpFEcR0/+vlgu2RTAcrVOus/SK4B8PXscP
        Kn80UlBs=; b=1gULLPwMl5EicacKGsrkZUGXsOG5vLa9q1gVIg3O8ixNIzoodDT
        OvXZoFHOZcEtnElapSxB6CrEu/muXLiLUNpfBlhbmo799s0Sj+Ivqpzk+vMPp07A
        YyQynTh2C+/vO3bVJv/RhEuRwuoKG22s6ZYuyYFHZh+LUnvFHcdM1kNX9UcojIt5
        pxQ6ClIctUBqwtl93pxGZS2Wv+eWqftG1yor5V6vRiqAGV3VlcajT52JsBMexlAQ
        BMsXc3JC2Ae7ciY44vQm9UKEAyUSOdbHjcDfUdFFeeEQXrxUxwRLR/lfzVNCqZcY
        /y+b5bC7RO3/EgPbpaWndv7dyFAp/lcxpcQ==
X-ME-Sender: <xms:Z-f5ZO8vt7rsfhlTxfSAH4wwO4RSFur-wY03U0sfk35eIIN72Nkg3CY>
    <xme:Z-f5ZOs-Ws-phygcbEl2tyNx3ga4_SKxPjytVyugtkbEg8uEn_Yl0Zioo75APKbtL
    lFMvCIPbkEw722fdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehhedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:Z-f5ZEBE-B-YYH3NJM-D2LZj_R3r84TbMoOHjsy8fER38pzmCcycIw>
    <xmx:Z-f5ZGf76Vml5zi3efQhP_rW0eBvI75HXbDMCCRrTMbZne-uhnY1Lw>
    <xmx:Z-f5ZDNZttH6_rgSA5sG8ndJ8Q-6pog3imiwXKwh6nmvBV7j-5eipw>
    <xmx:aOf5ZO0_LNKfTq2Gb1MgBsRPcgADAVVV1cPZm7O9aXS27uFltyzyfQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5ADD715A0091; Thu,  7 Sep 2023 11:08:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-711-g440737448e-fm-20230828.001-g44073744
Mime-Version: 1.0
Message-Id: <d59a97e7-81fd-472b-9a18-32d993f8c1c8@app.fastmail.com>
In-Reply-To: <xmqqledjm4k2.fsf@gitster.g>
References: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
 <b5833396-7e04-465f-96f6-69d5280fa023@app.fastmail.com>
 <CAPig+cQoiqeZF52Jr45an+cZF+ZQbHPXtLVn+VmyegjMQaJqCg@mail.gmail.com>
 <2ba66542-9ae2-4b13-ae6b-f37dec6b72c7@app.fastmail.com>
 <87edjbuugw.fsf@osv.gnss.ru>
 <c0a10738-86ba-4b3a-9e74-2568cc407621@app.fastmail.com>
 <CAPMMpohgkH3h1zC_Q7O-07gYw8_7mdSsyX7vu1K1u5+CxKUaUQ@mail.gmail.com>
 <xmqqledjm4k2.fsf@gitster.g>
Date:   Thu, 07 Sep 2023 17:07:01 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Sergey Organov" <sorganov@gmail.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        "Taylor Blau" <me@ttaylorr.com>, "Patrick Steinhardt" <ps@pks.im>,
        git <git@vger.kernel.org>, "Tao Klerks" <tao@klerks.biz>
Subject: Re: Is "bare"ness in the context of multiple worktrees weird? Bitmap error in
 git gc.
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi again Junio

On Wed, Sep 6, 2023, at 22:26, Junio C Hamano wrote:
> Tao Klerks <tao@klerks.biz> writes:
>
>> I like the nomenclature, I like the simple "zero (i.e. bare) or one
>> inline worktree, zero or more attached worktrees" explanation.
>
> We have used "main worktree" to refer to the working tree part (plus
> the repository) of a non-bare repository.  And it makes sense to
> explain it together with the concept of "worktree", as the primary
> one is very much special in that it cannot be removed.  You can see
> that "git worktree remove" would stop you from removing it with an
> error message:
>
> 	fatal: '../there' is a main working tree.

This gives the same error if `there` is a bare repository. Is that
intended?

This goes back to my point about missing nomenclature: it's weird if the
=E2=80=9Cmain working tree=E2=80=9D can be a bare repository.

PS: Is it correct that the error message says =E2=80=9Cmain working tree=
=E2=80=9D instead
of =E2=80=9Cmain worktree=E2=80=9D? (See cc73385cf6 (worktree remove: ne=
w command,
2018-02-12.) I was thinking of spelunking the history further but thought
that I would quickly ask in case I'm missing something obvious.

> It probably does not add much value to introduce a new term
> "inline".

The reason that I like it is because it lets you describe a bare
repository with linked worktrees. Not because it would replace =E2=80=9C=
main
worktree=E2=80=9D.

Although in light of Sergey's post about inline/attached, the =E2=80=9Cm=
ain
worktree=E2=80=9D term *might* start to look a bit anachronistic. But I'=
m not
sure.

> Here is what "git worktree --help" has to say about it.
>
>     A repository has one main worktree (if it's not a bare repository)=
 and
>     zero or more linked worktrees.
>
> I applaud whoever wrote this sentence for packing so much good
> information in a concise and easy-to-understand description.

I agree that it is very elegant.

> Perhaps we should borrow it to update the glossary, like so?

Certainly. But although this looks like it completely describes everythi=
ng
that you want, I still think it is good to explicitly mention something
like:

  =E2=80=9C Note that a bare repository may have ...

Since although this can certainly be inferred from the text, it's good to
have some redundancy when it comes to non-obvious cases.

Cheers

--=20
Kristoffer Haugsbakk
