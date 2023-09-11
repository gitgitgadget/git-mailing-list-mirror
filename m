Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAE4CA0EC3
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349055AbjIKVcW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244376AbjIKUOl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 16:14:41 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F72D185
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 13:14:36 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 408675C0183;
        Mon, 11 Sep 2023 16:14:33 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Mon, 11 Sep 2023 16:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1694463273; x=1694549673; bh=pXWKsmmUfUAimvdY9hgG5zuOT
        5TmeOnGDnyHY2GsrYk=; b=HKuiISJtWirNPptdXNZ3mhFVMZhiAQZY5tYg/fwtx
        ihQNtjZMeNzMyWvSdiMU2DolkpW5OW5wK5clFI5fTK4kqLkkLMr5zgtNoIJN4rGR
        wBqxXEruk5PMRYaHW/GkRM5rgfNX8NnlioTfU2vKPVeQW+OGXRWW/IZ107e9oXSe
        F3iKrWIp/YbAy7z+QByCS/bPBZ4wRXZwY4BvEvvK7rBqYB8v72hxfp8KirASKoXl
        pnCbCZ22uUDJDjAorpXzn8UGIgoz8e+mf16kN+jT6zK33FErbClXyQ2SFo+Q/anc
        k4ahVwr/nbIZIO2gbg0vP0iUG2p+v85I7fqibO7rQfqpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1694463273; x=1694549673; bh=pXWKsmmUfUAimvdY9hgG5zuOT5TmeOnGDny
        HY2GsrYk=; b=qVt+NotmBHpb/tQxNnGDEDQ0NfhLG7pPBt6wP0DiS6yU4RA/4fi
        oE5vCv0ELPaYgaz99y2faDI+9XKiM8RAczvh0JnvsAVsuUBPw/3iAp71wq6xDsco
        5msbdu6wbmaOMdHXEHLIzCPYKT0b56+utTVcXX/IU2GqU3eT+A25k+3lNh8BODT8
        ++Hd7cgb4FBWpBuB8Cy3QIB1CPAKIuXAshAZKwcz6lM1jBhqZDUDeKHZS2fIlTnj
        Gi6v8ZyH31Ss7bKhF0HI/WykLu2A0nfjkGaWEEbhQUcsAiKx5YG44sp2Ix17naus
        CX0POwjkSE3vIuQtPZJIu6S3LCjBUZRsuYg==
X-ME-Sender: <xms:KXX_ZENeRdedmo8N25RdBlbnbe2ONEGcr_L7117mphSUzjf6xgdU6Fo>
    <xme:KXX_ZK9w80LDU6naMpRUgamvEoLEtwy02hNQnknCAiNJO_fGyvHaVl0JhwNByck9n
    fmnJBFep_20Eewhzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeigedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    mfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssg
    grkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdeitddvteeltedvtedvieevhefg
    ieffueejtdduhfdtieegjeehheetheefheevnecuffhomhgrihhnpehgihhthhhusgdrtg
    homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegt
    ohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:KXX_ZLSMmNMBrwoYBxIKhUoDvdXDZWwVDtu2D2Wq6sJ0cm2BygnhKQ>
    <xmx:KXX_ZMsMMTmsPji9rqt9TZugV_B5_BhDjw6eRbfzmR_UhZurxmvWOw>
    <xmx:KXX_ZMeYyHwI7sMjgFyoB0C_lN8oxRNcIVrYBUW8R1ZxfzmZuo11dQ>
    <xmx:KXX_ZIHG8t8QMQsQ7ZBclcIic1y1xzeYs9e-WL_7km2Rf7X7JPgoxw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EBC9315A0092; Mon, 11 Sep 2023 16:14:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <568b853a-cf71-4262-86be-7b65cf066d93@app.fastmail.com>
In-Reply-To: <20230902072035.652549-1-oswald.buddenhagen@gmx.de>
References: <xmqqsf89e8wz.fsf@gitster.g>
 <20230902072035.652549-1-oswald.buddenhagen@gmx.de>
Date:   Mon, 11 Sep 2023 22:12:39 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Oswald Buddenhagen" <oswald.buddenhagen@gmx.de>
Cc:     "Junio C Hamano" <gitster@pobox.com>,
        "Phillip Wood" <phillip.wood123@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v5] sequencer: beautify subject of reverts of reverts
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 2, 2023, at 09:20, Oswald Buddenhagen wrote:
> Instead of generating a silly-looking `Revert "Revert "foo""`, make it
> a more humane `Reapply "foo"`.

Congrats on a nice series. It's very =E2=80=9Clean and mean=E2=80=9D=E2=80=
=94focused, not
excessive.

And I think I will remember the phrase =E2=80=9Ctoo nerdy=E2=80=9D for a=
 while. ;)

Maybe we will get this message template the next time we revert a
merge.[1]

> If you merge the updated side branch (with D at its tip), none of the
> changes made in A or B will be in the result, because they were revert=
ed
> by W.  That is what Alan saw.
>
> [...]
>
> In such a situation, you would want to first revert the previous rever=
t,
> which would make the history look like this: ...

=F0=9F=94=97 1: https://github.com/git/git/blob/master/Documentation/how=
to/revert-a-faulty-merge.txt

Cheers

--=20
Kristoffer
