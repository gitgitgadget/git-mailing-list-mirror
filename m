Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F443CD54BE
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 20:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjIYUFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 16:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIYUFT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 16:05:19 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4BA10C
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 13:05:12 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 263EF5C273E;
        Mon, 25 Sep 2023 16:05:12 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Mon, 25 Sep 2023 16:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1695672312; x=
        1695758712; bh=pj4NSi9OTRCblIUG4CRywF1Wh2Wh3TJy7t+q6jshziQ=; b=X
        rGTcr8MdZkjl/K7dK9DBAHgkIWcQUxJPyphc0iUlwJhmp96rCDFXHASMYYYtx/3X
        TahEdwvwL5fzX0GCDJMppF6B6/p2LDL8zRutazOs+At/V1HMiMcAHyp00NO8o1mJ
        yU0FXOd5PlkFr9pbwPwNhrNR4LqtbH4XZF+Tc0/why6kH3gewZLKiMR6otgDmWw8
        D9ecX18CMkcA1LjKBj7SylNzxFnpkyKnRzhSDtR+Ce4OqWEWR7x4Qypw1Qcjosys
        sSjgjxmASgzRQrlDok+iSqQCsg7nTNeanF4ofj2KYGau9ceaK0CNSdd8E8sJGDy0
        nhGBQAxrv+Uf1iNaSr/Hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695672312; x=1695758712; bh=pj4NSi9OTRCbl
        IUG4CRywF1Wh2Wh3TJy7t+q6jshziQ=; b=lePoYHayoKUL8bxUyS9wQf8GXkvQF
        HxVyrbUIQ13CpasP2ZIHD1IHT07qSZ7NDi9Eov+2+hMMETyfjCAfr4Ez/p+pIZkw
        m7WgQm167H71a/LCiqicn+F63D663sWjy8QN1UlayRLrTb0hbbpwDmJtuKf1emie
        STyQ81JgvcszslEvMPcuQl5ggq9jxaxPdab3t2IqaCa7ry4jbI/U9rHG2Xp318GK
        u3KarO9OJORY085zsCvrX3BP8dnWnSIVzRPsFBk+6aBFPekQAEqJpel0+tLrD6Dj
        oZk4kCpGiO7l0BXbAvjyqraBEj7RzIPG5TEhJ/5bJAEoCsg5Qhsz/DLwg==
X-ME-Sender: <xms:9-cRZXXXKsJNmJtGtvxMe7cV4NuCq7BgQDhl8E-T5v0dFwcBv-V1has>
    <xme:9-cRZfn2oofLP7YYWUXYgW4L4JcQcTjIZpu3MAbTsygXzSl1N4s7TWcxWS5RSL8ai
    IGhzoAB67Cl57WRtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelgedgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedtkedtjeeiffelteffheeiheeufffg
    heelueeftdejkeeufffgiefhgeekffffueenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:-OcRZTY2M73w3GOcPsfp05MiFP1fe-6apDmBCIp_9dXjD5siJiHcPA>
    <xmx:-OcRZSUFLqRxypDtngdCSzvjRl5nikz3sbdRNqF0oRgqfzCeupnwYA>
    <xmx:-OcRZRkzl1BfCDoE4vj7c6MS_FyBgXfPhytJAD-WMUeDph52BPycHw>
    <xmx:-OcRZRuw0JNoefwX7T0tmHFZ0ZoDgr4yz7fhKJNiM_1Eyx6XX6WNXQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D6D6E15A0091; Mon, 25 Sep 2023 16:05:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-957-ga1ccdb4cff-fm-20230919.001-ga1ccdb4c
MIME-Version: 1.0
Message-Id: <f3081838-ca50-4a7d-b2fc-6f0f1f1364a8@app.fastmail.com>
In-Reply-To: <pull.950.git.1695391818917.gitgitgadget@gmail.com>
References: <pull.950.git.1695391818917.gitgitgadget@gmail.com>
Date:   Mon, 25 Sep 2023 22:04:50 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>,
        "Josh Soref" <jsoref@gmail.com>
Cc:     git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
Subject: Re: [PATCH] pretty-formats.txt: fix whitespace
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2023, at 16:10, Josh Soref via GitGitGadget wrote:
> From: Josh Soref <jsoref@gmail.com>
>
> * two spaces after periods for sentences

Where's the two-spacing convention documented? I didn't find it in
`CodingGuidelines` or `SubmittingPatches`.

Thanks

-- 
Kristoffer Haugsbakk
