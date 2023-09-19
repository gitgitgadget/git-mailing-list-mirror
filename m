Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A727CE79A8
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 19:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjIST3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 15:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjIST3q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 15:29:46 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C4A9D
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 12:29:41 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 9A1A4320096C;
        Tue, 19 Sep 2023 15:29:37 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Tue, 19 Sep 2023 15:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1695151777; x=
        1695238177; bh=uIqezK9PvoiKVuHm0J7yBN4rzWpoiIJtKyf1o0AGGT0=; b=v
        SF2wB6fXmSIv0nK0O0xwbnM6d7hgd4egeANI/1UcLiVZs0QiDNGr4jzxMu0ugYfv
        xbaeOFYCdy3SJiUNz/YvmflEdxiN+Pcw0aSbjixhBA2mHXUq/7sGPEmNO3+CwP5a
        dUWQS1om++8FJwKq4jJjFWXlDjL4nSr95fGRx/6sa8TU+zODllbVnwmJ3C62hnLN
        +Vqk0qHkD68xVGuzfQNFOGcUFkCsp5eWtEOjCCF//t2x7eY90jNhlH60T2UAvwTy
        9ulMGMFDNekbslxqdQECH5fthEnKQ5UhrtvfqQ6sRUgf+aO92sbOHGqYQbF24orx
        SuD6szfucBLL1Jk0D7LPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695151777; x=1695238177; bh=uIqezK9PvoiKV
        uHm0J7yBN4rzWpoiIJtKyf1o0AGGT0=; b=lrI5TvtGrfAedbKW9F3UnukWA0XoY
        HW080X9fuc6PZ0Rx1xd5g9iY7Uf3YIMhQ+NfBNSfrvEf6vEJ/zrHf224sWoOuObX
        CyHt6k91yYzoGQEbf54fYImXqtv0TeHHgi89pTWL9Lhj+nX9rkFj6CfE1lnxm5R9
        8q9UKAeWUfoXjXdh8+pG4irHfUsDLmeu1tadlCKMNRGfEySbTIconL1EuQlIpfjF
        iJ1kvPuR0Y0zclSZye3rSgT9nixJrqzQnt2sZ6XsCMJYPpJGUso3N2HuOWff68pP
        qEYkDcryprdFrn4ZNipsjTypg6uU7uc7qllJh+M2EOm/zwAYIcm8UXWcg==
X-ME-Sender: <xms:oPYJZfLpakK-de1u-OqUvY8KUcFDdQ0PQqvIwZLGgEiLELNyzQvnhQg>
    <xme:oPYJZTIkwyQlDBvRL_VHpNAS7xFNp6JsBHNz77pYf5Iv-kNf_QJQRvdCMioGN9cJD
    HLFuZMT0ecDFgm47A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekuddguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedujeefvddtkeefvdevveeugeffgffh
    iedtkedukefgudejiefhjeejtdekudetheenucffohhmrghinhepghhithhhuhgsrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:ofYJZXutE6vZvGOFW5F3zJxU5ONWTUg_beUxcTlh0ipOXbcSEtPUug>
    <xmx:ofYJZYbLhGEdbTMdiKrJJo_n2mYTb-VNVIPaCsj-G7svhk4-sKaNjQ>
    <xmx:ofYJZWbQMORgUXA1woOJpUY21Z22K2EM_Q8CNMFykZFzydRXi8RH3Q>
    <xmx:ofYJZZyBO8wPz6qhl72QDpdb-Zing_HSiKHi7K8y0gxQf8x39unMAw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D52B915A0093; Tue, 19 Sep 2023 15:29:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-761-gece9e40c48-fm-20230913.001-gece9e40c
MIME-Version: 1.0
Message-Id: <9f9610fa-f1cc-404a-9496-d8b77ca05d5b@app.fastmail.com>
In-Reply-To: <244e102cc4693bb6291e03cffea6df05cdb29df3.1695144790.git.code@khaugsbakk.name>
References: <cover.1694383247.git.code@khaugsbakk.name>
 <cover.1695144790.git.code@khaugsbakk.name>
 <244e102cc4693bb6291e03cffea6df05cdb29df3.1695144790.git.code@khaugsbakk.name>
Date:   Tue, 19 Sep 2023 21:27:57 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        "Denton Liu" <liu.denton@gmail.com>, "Jeff King" <peff@peff.net>
Subject: Re: [PATCH v4 1/1] range-diff: treat notes like `log`
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The original CI failed.[1] Then I rebased on `master` (d4a83d07b8c (The
tenth batch, 2023-09-18)) which also failed.[2] Problem in t5559.

So: fair warning. :)

[1] https://github.com/LemmingAvalanche/git/actions/runs/6238806624
[2] https://github.com/LemmingAvalanche/git/actions/runs/6239585493

-- 
Kristoffer Haugsbakk
