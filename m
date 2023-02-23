Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B193C61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 10:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbjBWKhq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 05:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbjBWKh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 05:37:29 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC055A395
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 02:37:17 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 7256A3200893;
        Thu, 23 Feb 2023 05:37:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 23 Feb 2023 05:37:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emailplus.org;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1677148636; x=
        1677235036; bh=YnXmHdHeP6mPFd7Y2SgiqeVukfmoYYLklPkqkq/4RmU=; b=3
        0kmMs2iJ5McIKQ/MzujYtKJ2Fhf1SM/LYH1jYCOKkrqlr74i7PnYLxlUEeK4sOXe
        8tHZnTofOOAEl565ollHU1ygX5+YIm3NuaGtdR77Re9jHkHD3Z/WX98xh2gLUZ4r
        L+HE4ZsMkQzj1mIxe79Ugks6MZXsCObbsa02U8XWV1op2NrEZtWZYzfghxHgZuOR
        D6YLI+QbX3wbgH0K+zQ3mk99a3vvNORK7nYhw26xxXIAvwO/4+yWhAkwCMQobKir
        v0mStulVEQTzQZUxDSlD6EtDpgruVNAODRiNo75DS9OyNswz8OS7R3AjwsEYIc5R
        1o7WlOBJ22BFBtruuHIiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1677148636; x=
        1677235036; bh=YnXmHdHeP6mPFd7Y2SgiqeVukfmoYYLklPkqkq/4RmU=; b=M
        /pvQ/zaC56sQMVgS1Q1mWjSkd8OKSfJm0I/1XZtKXg9DERde6ynLh8Kr8UwPtZPq
        F1rXoUKZuFpd88iy6NOn3VLraO9SEpcSvK9H7vkaXecrTi7U63oB/nnbDA4L2CbS
        6yEM9nn0N1o0x2rwsXi9DF+Q0c6tbTzBTOLs+R9s3LeR3zd6VIqvlGYWDQ/kSeAs
        GGzeDNlKL8+zuAwHgSwJAU5lZN8tdP9r0lA0TSsUZZFBxeGwo2tAxmAcV6PsNACN
        EQKSgmkKGjULd2ebpy1+DV/etLGtXQdZVh+vzkDexarPbNdZ7luF/rsJ0o2Ka/EK
        2d8vu5HP2b1qpyI+8/Xkg==
X-ME-Sender: <xms:20H3Y59UjyoA54IGbZSjN48CwmzeRcUDkYzXqTBZ8r8JFPCRcDcsqQ>
    <xme:20H3Y9v9lxFzanX8ve4XljVHtoTHnRQ_2-Tajp0FhxhtnrQXJsJr3YdY-rqR06P5Q
    6g7PhSjeUzXzJ4T>
X-ME-Received: <xmr:20H3Y3AwDvPJow44UgkXW_q00vNNdaElEFZW2L1PW1pkmMDp3INpR4LN2LvHsONlHLk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekuddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghn
    shhonhcuofhuihhtvgcuoegsvghnshhonhgpmhhuihhtvgesvghmrghilhhplhhushdroh
    hrgheqnecuggftrfgrthhtvghrnhephfekkeegteekjeeufeelgeelvddukeejheevtdff
    kefhfeduledvgfffueffuedvnecuffhomhgrihhnpehgihhtqdhsvghnugdqvghmrghilh
    drihhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    sggvnhhsohhnpghmuhhithgvsegvmhgrihhlphhluhhsrdhorhhg
X-ME-Proxy: <xmx:20H3Y9erskgaGbctnOEwx4oY3_CGnY5Vhw-UXnU_5o3Qd2VOdJPbcw>
    <xmx:20H3Y-MY7pIA2QrB3n4fo-4LnBy_dcqQOYuGd5NjqqquDR3RvCT87w>
    <xmx:20H3Y_km58WdHLPt3U7xZdJa46nQar5wXprTqhfbQyf-ue2yHKjSDg>
    <xmx:3EH3Y4XrZt1gPM8i-rBeNuBUgjmZFYJtImVkICjnXQqXcLZMDiSFvw>
Feedback-ID: ic1e8415a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Feb 2023 05:37:11 -0500 (EST)
Message-ID: <a191c829-dfd4-a180-114d-147787d88aed@emailplus.org>
Date:   Thu, 23 Feb 2023 13:37:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Vivan Garg <gvivan6@gmail.com>
Cc:     git@vger.kernel.org
References: <20230222011317.97943-1-gvivan6@gmail.com>
 <20230223082759.36021-1-gvivan6@gmail.com>
 <4de72b33-fb1a-ab8d-11b8-9e89554fa8ad@emailplus.org>
 <CACzddJqv=CX8LC55_RHVi46GOUuVqY7C0iMLHaFn24uNHzPf9w@mail.gmail.com>
From:   Benson Muite <benson_muite@emailplus.org>
Subject: Re: [PATCH v3] MyFirstContribution: add note about SMTP server config
In-Reply-To: <CACzddJqv=CX8LC55_RHVi46GOUuVqY7C0iMLHaFn24uNHzPf9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/23 12:20, Vivan Garg wrote:
>> Maybe https://git-send-email.io/ is also helpful.
> If you look at v1 of this patch, you'll notice that I added a template with
> instructions that are nearly identical to the generic ones in the link.
> I was told that it doesn't work for all setups. Although there are instructions
> for a few different setups, they most likely do not cover all of them? Perhaps
> it's best to leave it up to the contributor to decide what to do. Also, I'm not
> sure how credible the configuration settings for the other setups are.
> However, if the other setups are correct, I also believe it may be beneficial.
> What are your thoughts? I suppose I'd like to hear what other people think
> as well? Thanks!
Have not tested all of the setups in https://git-send-email.io/ The
Fedora instructions seem fine.  It can be updated through Git, so
contributions for other setups are possible. There is a nice way to test:
https://git-send-email.io/#step-3
