Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D787C71153
	for <git@archiver.kernel.org>; Mon,  4 Sep 2023 17:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237816AbjIDRo7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Sep 2023 13:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353065AbjIDRo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Sep 2023 13:44:56 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BBDE6C
        for <git@vger.kernel.org>; Mon,  4 Sep 2023 10:44:51 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 4D1C45C016A;
        Mon,  4 Sep 2023 13:44:49 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Mon, 04 Sep 2023 13:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1693849489; x=1693935889; bh=cSiUUQ8Ky6NY7JZvI9UlZlU1k
        hdKQTdw8/2zyXgoz9E=; b=McKRg7p5l2RRY4s5c29R36YHVUx0/yE6TXxwCLhsd
        FYoHb6/wFX8RsRlx37qIjHSDZFB+xuVntMJ5F2vv+Pz74Hp7cHVNyBJI787TrZ1F
        8JrGllk4Gfwn4DyJskcIMU7+7g7/QaFcrIw0KOxY2jXtci7h6q02CqCRIVDyM54F
        eJB5M8Sib9+m4bALLkwmYBOSWyvCDeZStXfMkSQEfp3wpWcLwN5EUqkIpRqiELFs
        4j+moJjyBeEmb86UOYO1H9+xky3DWxlCbRaVNqaa2+iwSOaSWW498ksWqcYGvQ9A
        R4wHranMoAjlFXVX97sJPr19gJkVLxZgN4o32jLd5p4SQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693849489; x=1693935889; bh=cSiUUQ8Ky6NY7JZvI9UlZlU1khdKQTdw8/2
        zyXgoz9E=; b=1UXIuEQOa/6Nu3t6vtFR0WrUdx8R1FqUajlEaumcAam0yckvj+B
        R+NoeoBnmdRoNd1lxE32kw2wcVhPqMB/l7vt+bn/S9Hdm2ZANPHmsiOJkddO+Ceb
        2axyyzGR6od37KpDhwno8ZEOg53o24qhVZfSOgjpcT7uITQHLZ64DObiNWrrZQOp
        8XFUpv4PLYIhwrd/g1rSXCeQe/AYOfRE+kD0scLdraFtPugs8nBBod6qp/lWwAl7
        jocCWDRRDUpQYlqDmySL3nTYSYRatMtMUYkALO/I8GxBuiyUsItnkbrTkboTzm4g
        Cy46S4+FPQyd5DOR74e5e8UF6oLYZbWqpyQ==
X-ME-Sender: <xms:kBf2ZEzfqucByEzmemmLHs6VQvg_gFvZ3J2lUkDBoFoBVPzgxzyaJkc>
    <xme:kBf2ZIR3ZTKxKQtusTSILn9UmxCMZPH6A-1zlZZGvib1q-pCPD_AiulW9M7bjKLuQ
    -Saq2vvxkoMzolQfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudegkedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    mfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssg
    grkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnheptedvfeefgedtgfejvdefvdduuddu
    heduveetveeujeegjeeigfdtgeegueduvdetnecuffhomhgrihhnpehgihhthhhusgdrtg
    homhdpshhtrggtkhhovhgvrhhflhhofidrtghomhenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrg
    hmvg
X-ME-Proxy: <xmx:kBf2ZGXTpDur5KTztyfz_Z3X7hCKUeDEIBgCwjwd4nX_Po40wfy-dQ>
    <xmx:kBf2ZCgsGje3HNJjcSGCDOY1iLV8jzSxSt0at3gwHDLkE4ze1QsXhA>
    <xmx:kBf2ZGCB9JprpSwaERREWrBwwLol_RVY6LWswWHqgUYZqFrKcFzJBw>
    <xmx:kRf2ZJNaiuXTT3oZ2uyBbGWuRj7I7kvnR8Y46Wc05ATtgIBiVRfDsA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B4ABC15A0091; Mon,  4 Sep 2023 13:44:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-701-g9b2f44d3ee-fm-20230823.001-g9b2f44d3
Mime-Version: 1.0
Message-Id: <fa25f0d3-392f-4fc5-826c-a19ed3cdb7ca@app.fastmail.com>
In-Reply-To: <CAPMMpohpKJdopSpZu+ehE0MZrH8cksgtY1NEHFyZz2jj+LOKhA@mail.gmail.com>
References: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
 <CAPMMpoj7s=ewXJfJyxvrcHjpmOOWEWBvZ94OOuVmYs2UQ482HA@mail.gmail.com>
 <CAPMMpohpKJdopSpZu+ehE0MZrH8cksgtY1NEHFyZz2jj+LOKhA@mail.gmail.com>
Date:   Mon, 04 Sep 2023 19:42:29 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Tao Klerks" <tao@klerks.biz>
Cc:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        "Taylor Blau" <me@ttaylorr.com>, "Patrick Steinhardt" <ps@pks.im>,
        git <git@vger.kernel.org>
Subject: Re: Is "bare"ness in the context of multiple worktrees weird? Bitmap error in
 git gc.
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 4, 2023, at 17:29, Tao Klerks wrote:
> On Mon, Sep 4, 2023 at 4:59=E2=80=AFPM Tao Klerks <tao@klerks.biz> wro=
te:
>>
>>
>> [snip]
>>
>
> And to confuse matters further, I just stumbled across
> https://github.com/git/git/blob/master/contrib/workdir/git-new-workdir
> - I don't understand when you would want to use that vs, again, a bare
> repo with one or more worktrees properly attached via two-way
> references, their own indexes, their own reflogs, etc.
>
> Is it the case that this contrib script predates the current "git
> worktree" support?

Yes, according to VonC[1] and the 2.05 release notes.[2]

=F0=9F=94=97 1: https://stackoverflow.com/a/30185564/1725151
=F0=9F=94=97 2: https://github.com/git/git/blob/22aca1b3ac10af7188dccf03=
3b44a36926f04d4b/Documentation/RelNotes/2.5.0.txt#L25-L27

--=20
Kristoffer Haugsbakk
