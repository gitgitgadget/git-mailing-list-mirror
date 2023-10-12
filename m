Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C40BCDB46E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 07:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343700AbjJLHpe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 03:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343632AbjJLHpd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 03:45:33 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CA290
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 00:45:31 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 7E01032009F5;
        Thu, 12 Oct 2023 03:45:30 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Thu, 12 Oct 2023 03:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1697096730; x=
        1697183130; bh=Nw1hJaxXSd0CNc0fJs5iz9lQYSMW/gVlL/ll7ssj3d0=; b=O
        a6CB2ylCCvuwYLzN5lGcRW8ucvcsM/t2PUkJve0MchWjL1JQJ04zYJ/l+ZBVHalX
        up5h8J1HOT830ztGQEuMqQINLN2iPhu+TfeP55AlaD2ong9LN+Sk2z/RjpW5p9sm
        nPlIjE9UZb3qg2ep2LUeMphlYCz2ckCti+IBox1XswGiLa5G6PCYp3JiAePAlZvc
        IwI14Y0SRDuJDAuWGypclnKuBxfL4yyVrM37/WXTmQmzBbN9P2f8gw3vK4StxJZS
        SsX+Y/JmFDECx7RmvQp9RLKbtUMd2f0y3Kj5/sdyFsvEWwYXt2wgrpZTrj8zlMqN
        IfTzF/09LHRMHnG9kWX6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1697096730; x=1697183130; bh=Nw1hJaxXSd0CN
        c0fJs5iz9lQYSMW/gVlL/ll7ssj3d0=; b=jkX3yOKP1f+WhnTMbESpKtZVNC97k
        /sGQNs0SpghiHjuS+DDvdaFCVBs2KndqcdNKr6LU58l+gqjuVcCgIQ6FFXdQi2Lr
        5Pjww9LSraZC5I2fC849OImsfdeHWBZWuth9yamocMKh6gkl/qXQAmH5iKfuwRL7
        FEIlwBoxSPOrmpzwyZbULGPZEc6C5CqJVeum3ZaR66gfT4WSdlBb0jZGIX8EHwpY
        fpTbq7gt09nW1EDD+JMxwR7y5KlDGfHTSBSZSXm5f9/cEhWyhmgYzYxUw4QLioSj
        9EmRHNp0IMmEDnJv1MSJMAdpB8BZiBBRXkKymjWC6Izk41bexrcSqA6Xw==
X-ME-Sender: <xms:GaQnZQn8x0dPLWjHU_JmTIzDFbBeZSf9Jg-WFmRijLbf29il_UuChwM>
    <xme:GaQnZf2B2KqYIFHViD4W1pUYA6y0OFTroAAzZ2mOxQ6MB4ZJGitnfpTTei_EptRD9
    DXOxfXxilfshkHoWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheelgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnheptdektdejieffleetffehieehueffgfeh
    leeufedtjeekueffgfeihfegkeffffeunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:GaQnZer-lHWn901B7aNDcyabfHjF0wtdv95IghB3o72JkOcbJCNFSw>
    <xmx:GaQnZckxEh72ujU0NNm1ljd5i1UrwRDRcsTBowMPDIMhvsrZ1oBjsw>
    <xmx:GaQnZe2MCZbbdEgQWW1it7DwmiohkBvQc6vMbpn73zGp5LunkG2S0A>
    <xmx:GqQnZT9Ppwj_StbLGfJTGaAyYpx-3oQDTkzu-Cq-K0SUdO1GDnpqlA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B7A4715A0091; Thu, 12 Oct 2023 03:45:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
MIME-Version: 1.0
Message-Id: <724ff75e-1557-4d87-85a6-a3a58d41af1f@app.fastmail.com>
In-Reply-To: <4c5fef38-a671-dd6b-4b10-a531e1ae254a@emailplus.org>
References: <ZSeYzdx07Cj67lR4@dorcaslitunya-virtual-machine>
 <4c5fef38-a671-dd6b-4b10-a531e1ae254a@emailplus.org>
Date:   Thu, 12 Oct 2023 09:43:55 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Benson Muite" <benson_muite@emailplus.org>
Cc:     "Dorcas Litunya" <anonolitunya@gmail.com>, git@vger.kernel.org
Subject: Re: [Outreachy]Introduction and Problem while installing Git
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 12, 2023, at 09:28, Benson Muite wrote:
> You maybe able to get these from a package manager, for example on Ubuntu
> sudo apt-get install curl-dev

This didn't work for me on Ubuntu 22.04. I tried the OpenSSL variant which
worked.

    sudo apt-get install libcurl4-openssl-dev

Now I can drop `NO_CURL=true`.

Thanks :)

-- 
Kristoffer Haugsbakk
