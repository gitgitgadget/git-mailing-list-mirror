Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1527AC77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 07:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240075AbjELHaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 03:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240057AbjELHaO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 03:30:14 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996FF19B0
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:30:11 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 0E8DA5C0457;
        Fri, 12 May 2023 03:30:11 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Fri, 12 May 2023 03:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1683876611; x=
        1683963011; bh=e5eq6jqqrHFACouLv8je0yfK/cUUwcJTb5rTQoTDm9w=; b=I
        4rPI11uO+95v4Dc1o9SiFZWIfuJESVCsWmuQZoK9PvGApM0vfccArn9/3M9umvnb
        lfGgH8xEQ/Sfh5mmN177/h/zsBQzQryMxo92k6zp5/8J/hmf5EVyciz1KMcNpTXZ
        +teXjT8kY+L5sYvxUdCzzE0gSSYGCiCDfpAzN2XVVTsLTyAAsR6Wo66/QHxRKhKM
        0Rvx83sGLlNegO5ut9HgOlw5rDKJ1elmkvlYl6pxpR9b4fIm57A2Bq3nC2kCIRwt
        foV2wXuVSsxv2dibOlcn2fBpscsyCZnJHq+nG4H7ZwY2wq5kKDIEwXFUun3/EAgd
        4cU1gaD9zMfZukgyQaajg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1683876611; x=1683963011; bh=e5eq6jqqrHFAC
        ouLv8je0yfK/cUUwcJTb5rTQoTDm9w=; b=Dc7nA0Qr56+lURPDLtZq0Ug44Tne8
        EG/T++nJcPn20KRyE+Fa4LfFMhv0o8jwVjDSITc/QS3lQ+dcsUgkOnhnzx8YYlIs
        pSo+OPavvKrBtY1YOC2/jo8x748PQRJdS6UwYgVEjFI4qLmGea995PN5fa/D8ioe
        JZ+14ut+CDKHKxY/uMXmyXnSMU2NUcq7figpVpatl+Ane+HGsl+sYMbRXpdRhP2r
        wL7YRXu+t2dsXbzlgaIN1vSzw2xU95pOyug7J+gJbW8Ko04MHhFzWzekyg2qZ0xg
        R4m4LvkMSX5oK3ClwwrHR5N23gNLANFQq9FPvt4+tCEQtRKLebCR3H5KA==
X-ME-Sender: <xms:AutdZEDAH-BWJLNDFzfsGboOJKYvLMqlM70UsopifcOEHNQe0AyHUBE>
    <xme:AutdZGh3NPeJ9YykLZ2cOq_JGi3b8oAoa52W6QBudLwOij_HM5AFNIaBElCHmZwgD
    0IGj2OaFJ9t7BplJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegledguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedtkedtjeeiffelteffheeiheeufffg
    heelueeftdejkeeufffgiefhgeekffffueenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:AutdZHmf3p96fs6vta4yMfr2wu4AMzxzGfpEgHJc75mG3Njlr73hCA>
    <xmx:AutdZKwIgEv47Hbj1b0dJQPIvDjpUvFT50zXD7r_BGe4astvo3Qznw>
    <xmx:AutdZJT9IZDo9RB644IWbpPkswMluzZy3NHqGG-uL8OmgThs4eUB9w>
    <xmx:A-tdZLfmM8cZoG5gDQfOaLLHjz2eiCBhURgs4WeJcUxzSqMTvHaHIg>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7F42215A008E; Fri, 12 May 2023 03:30:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-415-gf2b17fe6c3-fm-20230503.001-gf2b17fe6
Mime-Version: 1.0
Message-Id: <cc3775ba-bcfe-4984-a391-b37c0382f50d@app.fastmail.com>
In-Reply-To: <20230512040746.2069-1-tenglong.tl@alibaba-inc.com>
References: <2908b005-9478-4c59-ae8e-150be44a15a9@app.fastmail.com>
 <20230512040746.2069-1-tenglong.tl@alibaba-inc.com>
Date:   Fri, 12 May 2023 09:29:50 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Teng Long" <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org,
        "Junio C Hamano" <gitster@pobox.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v9 4/6] notes.c: introduce '--separator=<paragraph-break>' option
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Teng Long and thanks for the explanation.

On Fri, May 12, 2023, at 06:07, Teng Long wrote:
> I think --no-separator maybe a better name, means that not any separator will be
> append between two paragraphs even a newline.

That makes sense. Using `--no-separator` seems very consistent with
other commands.

-- 
Kristoffer Haugsbakk
