Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B6CC77B70
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 11:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjDQLWV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 07:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjDQLWO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 07:22:14 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388384C37
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 04:21:27 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 5F86E5C019D;
        Mon, 17 Apr 2023 07:20:16 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Mon, 17 Apr 2023 07:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1681730416; x=1681816816; bh=Zf7iDk+DiW+zPYNO7hau0XW02
        tfk8rgxxSa1MeNE7TE=; b=wd8eODwQodxJRAR6rnS4D0WwYJjz5guWb9jQjKPkJ
        l0xFPSDknuzRTP7T2uOfhOYn3f0mK9UCOfQVOd8pmCOOlAtIQKskcR+ax79yx0eb
        xfqXNUtOlcnK+hB+Fc0wQu2IJiOe6QeGVL+MOiH4OvG1/YwhWvS5IDQPhD4NjZKO
        WLmaMy4l4OyQVEpHSwduO4xk4HptZXtUiloETR7RUOG4iAmENdvA/XdhcJ4inaA6
        Y++XKIlOWv4ZDvVYQTe0F715MtXJcD5ilyXe9T0BxOySq6SQnz8dlx52z6wrSB2/
        MEBDRkMIntlodwNOIlNpbeQBe0PgkFqGqmB+lQT1yCRDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1681730416; x=1681816816; bh=Zf7iDk+DiW+zPYNO7hau0XW02tfk8rgxxSa
        1MeNE7TE=; b=I/pGZzrtMxTWr4yb6qKIPCQVaMUVzH0zkuFdvjnW3mbV1zIcxUI
        Aml+/zabKRZHci8r6Yp+BhRXtG5b/hWbRfWpZa/FvSXJbX6SqqeEhChGSIKUNFqM
        ihdLxnmBkRGdCespEQSSl/prhL6eX/zroUjIl9zKUHPPHeW1hy0af7azYwKa8ffC
        77XVty1QcnxOoJ83t1dcYUwzav45uNfwts5cTY7tGQmR6kg1kiw9kzJW3s6gp1rW
        4BSfCESU8mqkmjYPzhQ8STs5W/mTzYtZ8A8DVuudJ6V9Fc9DZXztwZhfYUiAdLCS
        V4X2Yz1V9j/pL2knm2yb0hfNCA//TeVF8Yw==
X-ME-Sender: <xms:bys9ZCzylB5iSknd8YDDW3ySenPOISQBkqYIObAyqSEiL9WPbHODLTY>
    <xme:bys9ZOTAhIezoTWR6684u5QWyTVOYFRtAyl5_JlgdqWBeQ4Bgq6ZSHHV9eirQBsSX
    e3u4fbpDSgrll_Mgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeliedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgfgse
    htqhertderreejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhk
    fdcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnh
    epvdevheeiudefheffvdetueevkeehhfeliefgkedtieefudetueehueeftefffedunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvse
    hkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:cCs9ZEVRY3pkpjPXqgUgaWW-v0_pa1TQIZYmQMRwhZfRWQNH32vqVg>
    <xmx:cCs9ZIgEzV2-acD4bwE2TKg0WLYX364MCLjQi2TciBbzJsotYUi2FA>
    <xmx:cCs9ZEDiAHyLKjnJuUm2W8xu9gORASNV7r5yG5hdiYCDNjHtQSSGgA>
    <xmx:cCs9ZD-soth4f2PomTDsINgCbYytOah64O_AzkyPivIfCyDOOlJFIA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D590C15A008E; Mon, 17 Apr 2023 07:20:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <7a9bf99c-8a28-4842-ad65-97ce4a75e72f@app.fastmail.com>
In-Reply-To: <AS8P194MB1575B12A6A11E3CBC6537C26E29C9@AS8P194MB1575.EURP194.PROD.OUTLOOK.COM>
References: <AS8P194MB1575B12A6A11E3CBC6537C26E29C9@AS8P194MB1575.EURP194.PROD.OUTLOOK.COM>
Date:   Mon, 17 Apr 2023 13:19:55 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     =?UTF-8?Q?Berat_=C3=96zdemir?= <Berat_Oezdemir@deichmann.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug/Weird behaviour with git pull
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

On Mon, Apr 17, 2023, at 12:34, Berat =C3=96zdemir wrote:
> Hi there,

What does your Git config for `pull` look like?

--=20
Kristoffer Haugsbakk
