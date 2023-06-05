Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F72C7EE23
	for <git@archiver.kernel.org>; Mon,  5 Jun 2023 10:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjFEKIG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 06:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjFEKIF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 06:08:05 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F17E3
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 03:08:04 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 77331320091F;
        Mon,  5 Jun 2023 06:08:03 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Mon, 05 Jun 2023 06:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1685959683; x=
        1686046083; bh=F95zjqc5pnsaYyKI4/ZwJNdUiQ8xpC2JQzOJdpZNmPs=; b=A
        aRhJ8QcrDOqAx0HCj+XHGBz6igRn5VYUZVs7ElO+9WC5pw1cvzxQI8MHRhaqG2F8
        Kn7z2IIV4TxNZZvt6KeEwPyVSWM6E3YL0Up3CNHEJY+XxYGpWOIW86bg0T5sdqeX
        ZnQVnAGGf4Z6LcU27kRrW+9sJfCDJlbUwfrlZR/P108QTrQYUiQxG6OymIh/uw0f
        38K69Tipi5iqbywpeRrviEf4dC54VTUTBz0sPUgWy1Z1Hj9qdXBX0/C5QtUZEUaq
        9RNptpJuHamtmwR4q/aWxzjFntT4MEJ31JlcLvjKN5dcSeLeajCrp8S/yrVB8kNk
        DEOunavhs9IRJAmz8K6Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685959683; x=1686046083; bh=F95zjqc5pnsaY
        yKI4/ZwJNdUiQ8xpC2JQzOJdpZNmPs=; b=RRKqbzWjGoSLG7KYn7XSjuYGEq9yQ
        5+rio2xWQEJ9omFJC02mX51k5Fe8D9xRkopkFfBIPLI56+5kqEsG3021qfg9NaBy
        BfLPQVY0tOjSAswHtTQNIngoN1C/ggjbF7HvMQWB1YB/xY3n+GIG9rppF5kWrgPb
        i16qINk3wtbqJ13Fts/4xkGboBk3AMeCHONC+AwzaFJ1+D2LbnSo1xy+ioaX8MZj
        xmKKE8yQaxv91vFvSbX8nNmGDAiiCPJalOlVbwJRUnc5R3ihDWXKUfe96BBQSru8
        DfoT2I4ZQhx6nmrF87LEhUF65hzhzRGZBJFSPaS786N+IHBm+GOZNq1jg==
X-ME-Sender: <xms:ArR9ZDyJx8GjLToFPvjtJ3qbpL5Ljxt5csMcU_O-1ojw_1JNpjIx0Sg>
    <xme:ArR9ZLRyh5o03j7C40O6zDNlyayDRBY1uiNYqRWgDjS5L8Lw7kEu5-_UvRws1Zc87
    kjQmTfTZjaWIK93mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdf
    uceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpe
    dtkedtjeeiffelteffheeiheeufffgheelueeftdejkeeufffgiefhgeekffffueenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskh
    hhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:ArR9ZNXmCUqAF9JHQYz36DutaeIktNPkA3dTKfiHVg__uhao8lxQvg>
    <xmx:ArR9ZNgS2jK4bvLKyrHGwQ2Bc2_P3vUSzJ88tLJgfuzqCgDMrTXq7w>
    <xmx:ArR9ZFDaK3_QQ4P3ZA-bByFkM3K7AP8pw2WXVEO3FL8df8PqVnlT9A>
    <xmx:A7R9ZIopu4G238NWfsnlfO_TdUm6ro9EGZyDcmAo4_MCD5dk-TwSsw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D52FB15A008E; Mon,  5 Jun 2023 06:08:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <35a072c1-c9b5-4aa0-b798-4e86f14571ca@app.fastmail.com>
In-Reply-To: <20230605045042.GA66000@coredump.intra.peff.net>
References: <b3829cb0d1e36a5ebb44a315fe32037f2a3f6c7a.1685526558.git.code@khaugsbakk.name>
 <cover.1685904424.git.code@khaugsbakk.name>
 <99c88c74ceab751c0540b51d98bf339bffc098ef.1685904424.git.code@khaugsbakk.name>
 <20230605045042.GA66000@coredump.intra.peff.net>
Date:   Mon, 05 Jun 2023 12:07:42 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Jeff King" <peff@peff.net>
Cc:     "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] notes: move the documentation to the struct
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 5, 2023, at 06:50, Jeff King wrote:
> This is better, I think, but...
>
> [snip]
>
> ...what I had meant to suggest was putting the documentation next to
> each field, like:

That make even more sense. :)

-- 
Kristoffer Haugsbakk
