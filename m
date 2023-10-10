Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E7DCD80DB
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 14:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjJJOKp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 10:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjJJOKo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 10:10:44 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6BDA9
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 07:10:42 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 6A1FC5C01F1;
        Tue, 10 Oct 2023 10:10:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 10 Oct 2023 10:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:cc:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1696947041; x=1697033441; bh=Tt0BsYA65dQ2WB7is9hudrEXBfeHJW9hD0R
        X5mZ+F9Q=; b=NaYBhhF9dliIdMUQxoZ+wHFa/8nyxnBChxprIYvI+NXnqsTLENe
        FA3S9MT3Fp4wvxX07Ijxaqg19JWPGglNlvjn6iljFWZIR/jymLzwlOxwMyjO/GMS
        dMqrNm1lp6ob2xRY7+vtDtkX/yPuikiADnSUpOGr4P8vGD9IBnWNhz/b3J6d204b
        Qj4T5H3LneGIdbpB3ahl2EjxHED87V2d2Rm8LZPBpblC7gTpyHvtDZwHg2DKoDF6
        3nCsYgMllInYDC6sN7Hft+KhuFyuY0f+k5DFCwublD0qnmxPXcWxMQlsfxtsxpTc
        j7SWcOfyKtK4olp3K2fz5Ls72Xw839pcN9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696947041; x=1697033441; bh=Tt0BsYA65dQ2W
        B7is9hudrEXBfeHJW9hD0RX5mZ+F9Q=; b=SroXP28LaIGEt6oCOyiBRqxv11LJ1
        pHGEKQfCnAufEzhTlGdM9iCLf9ZcIGQiq3KyAA5haIZitiWr9gJC2O2VXQhW1XEP
        KWSjDRuvhGOOnQP9wqnnW/TjoOLKhgkuFa5EkE+UoaWryaf8VSLsHPBx5vc0RLmw
        srDmFukiw8ONfOiydVUVycHZdRGI2qdPumuOr8wYz9gv25Ln/cXsGirNdiyj6xFT
        aOFH6ci6QnYbMJWgedr+r0HENMYdLNk5Kv1t9LF8Ow3p2QvogON9Nv8l52OYyM9V
        RPO4HekkaGR9Rz6jJVADHcCpxxDDvdanFHapGecr23Ylh2wFj95LEoAgw==
X-ME-Sender: <xms:YVslZRkAtpgCiJGhxMYYOF8G9CJ4bZjeNprGHGgQcKviPlpXsCBt4A>
    <xme:YVslZc2clpZi5uv7ZgvrcfZFmnjKaaXVy1nl6dpGB0RyVIqiyTwpIqbATbht8khv8
    HP7XCrhM2wWR1KdoeI>
X-ME-Received: <xmr:YVslZXpJXbmKnKDBEzDdQb70_KXRqxJ4ylfjkOv-QQjWvbbFkfElezWtOpfK9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheehgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeflohhshhcu
    vfhrihhplhgvthhtuceojhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudeigeehieejuedvtedufeevtdejfeegueefgffhkefgleefteet
    ledvtdfftefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgh
X-ME-Proxy: <xmx:YVslZRlRF4oWhVdO3yoMWOtUQysoUMa1j5B-a5CA2rWP_tw6zpW0AQ>
    <xmx:YVslZf3BGWw7GP5P0qdNoZEE6J53YopXAEec44kTTAdu0YzKTgCgqA>
    <xmx:YVslZQuDY-fO3jJ2ctmk96jHYDrbCLKn_qNlWWI6eCAlKxLLAsDMog>
    <xmx:YVslZY8GVKMGR8VZE_ksV48mXbVZF6HOxQn6zkjN4UU3eUtyGqqzcg>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Oct 2023 10:10:39 -0400 (EDT)
Date:   Tue, 10 Oct 2023 22:10:25 +0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     Sebastian Thiel <sebastian.thiel@icloud.com>, git@vger.kernel.org
Subject: Re: [RFC] Define "precious" attribute and support it in `git clean`
Message-ID: <ZSVbUSRUQlNy0bj-@localhost>
References: <79901E6C-9839-4AB2-9360-9EBCA1AAE549@icloud.com>
 <98387b86-1732-42bc-9ac5-d64a6617b2db@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98387b86-1732-42bc-9ac5-d64a6617b2db@app.fastmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 10, 2023 at 03:38:51PM +0200, Kristoffer Haugsbakk wrote:
> Hi Sebastian
> 
> On Tue, Oct 10, 2023, at 14:37, Sebastian Thiel wrote:
> > This highlights precious files by calling them out, but doesn't change the
> > behaviour of existing flags.  Instead, the new flag `-p` is added which lets
> > `git clean` spare precious files.
> 
> Why can't `clean` preserve precious files by default? And then delete them
> as well with something like `--no-keep-precious`? Is there some backwards
> compatibility concern?

While I'd love for it to default to that and require an extra option to
clean away precious files, I'd expect that that would break people's
workflows and finger memory. If someone expects `git clean -x -d -f` to
clean away everything, including `.config`, and then it leaves some
files in place, that seems likely to cause problems. (Leaving aside that
it might break scripted workflows.)

It seems safer to keep the existing behavior for existing options, and
add a new option for "remove everything except precious files".
