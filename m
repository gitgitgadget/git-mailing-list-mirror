Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADB6CE7A89
	for <git@archiver.kernel.org>; Sat, 23 Sep 2023 22:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjIWWO6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Sep 2023 18:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjIWWO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2023 18:14:58 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C71A180
        for <git@vger.kernel.org>; Sat, 23 Sep 2023 15:14:52 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C17CE5C010F;
        Sat, 23 Sep 2023 18:14:49 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Sat, 23 Sep 2023 18:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1695507289; x=
        1695593689; bh=hF9TZP++m0/vTqVmNnJQRWvRFDD9mUARscuS4f/ETfQ=; b=b
        aS/yjEgunzFe7O+n+j73XeZOEz6ik3Ab40FCfp8lzktt0kPxwBASJhm+XLwCekKX
        UweIssMaOSuF+SKKyOPZBEbkIlRVzb/mz98+rsVtkZkTxUFJh01LA/8GA1lIwCBT
        K6ZtGN2q5cm/xdnELqPewfsJnvxUInOV5oIriCVxa+sGf/8uv29eLjP6S3y1c3z/
        4uN5TgkwCfZJ+IRg+EgMzUiOgwCy+3ODuO86fvYRBzoTzGww6cvt4IRIwU8G6CFt
        fA3lgVMo3H3r4LLeG0eqaXerKkzppc38nB/yoONwSyGre1YdxnZB75G/vvIOOCZ3
        LKMW341I1AUb6aj06wysg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695507289; x=1695593689; bh=hF9TZP++m0/vT
        qVmNnJQRWvRFDD9mUARscuS4f/ETfQ=; b=EgViYSsZsSTBf52FV3mCHh7nOUESX
        PiDjjrncwvOQkehKEIiWEFYOSgS5dg1eHPXXgRuLMcr2JYZsBXZdMhSC6ZcrA/tq
        kR++3LuO4Bw6aEjoSM1CMhF0sbk7wv9YkyUAPDG9fBNsS4jsUv8hLowtYM8pYixl
        qspJDqcK94qJ8oClkAhBkiEfC6eLjvXjkrYxmiUtnAOy1oM5P+VqfPS0NhQg3fYD
        snZm4rf/k2BdHIBUpvrNDnRTrsSu5MGNG6de5n8xP1IOCJ5u5KLLkDz/umnnGdY+
        mJXw0PI8pOvjD0KTsYye68pnDayxE/9BcUpJEUP9C9eWhYU/AjLJNaRYg==
X-ME-Sender: <xms:WWMPZd9Enoaj4xpKhOh5VT1gvuTjlLpaLXAbsQ2C3PQpoeUIepYVxAA>
    <xme:WWMPZRvJzap_aaM_kBczcf6P1BtR9b4PPiKv2USW3xySZ4J-MYsielkSlV-J5Elap
    l5v2FD-BLz8qu3zZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeluddgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnheptdektdejieffleetffehieehueffgfeh
    leeufedtjeekueffgfeihfegkeffffeunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:WWMPZbA6kWK7HMR72YZOaYZArcRhU4HihhAFXRRYQRXg5h6gnObTMg>
    <xmx:WWMPZReJs3E3Cm27Pts-j6ffC82WNdR8-vcAad3uFUrHiEyUcPPvLA>
    <xmx:WWMPZSPNE0YAdl3SgEiKvYdg0oYOCUCp912joBh07tohoMwy5U8sVw>
    <xmx:WWMPZfr5FcFUf0opaVsWyikLOQH3EUOgHU7k-QTFIqq1drnXRgL7-w>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3A48B15A0091; Sat, 23 Sep 2023 18:14:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-761-gece9e40c48-fm-20230913.001-gece9e40c
MIME-Version: 1.0
Message-Id: <a1920050-bedc-49d4-840d-350b8fd3c003@app.fastmail.com>
In-Reply-To: <20230821170720.577820-1-oswald.buddenhagen@gmx.de>
References: <xmqq1qg9qmyq.fsf@gitster.g>
 <20230821170720.577820-1-oswald.buddenhagen@gmx.de>
Date:   Sun, 24 Sep 2023 00:14:28 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Oswald Buddenhagen" <oswald.buddenhagen@gmx.de>
Cc:     "Jeff King" <peff@peff.net>, "Taylor Blau" <me@ttaylorr.com>,
        "Derrick Stolee" <derrickstolee@github.com>,
        "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] format-patch: add --description-file option
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 21, 2023, at 19:07, Oswald Buddenhagen wrote:
> This patch makes it possible to directly feed a branch description to
> derive the cover letter from. The use case is formatting dynamically
> created temporary commits which are not referenced anywhere.

Thanks for implementing this. I've just written cover letter text in
separate files and copied them into the generated files every time. (I
don't use branch descriptions.) I've wanted some convenient way to feed
these messages in, and if I end up writing a cover letter again I'll most
probably be using this new option.

Cheers

-- 
Kristoffer Haugsbakk
