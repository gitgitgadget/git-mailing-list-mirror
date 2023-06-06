Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDD2C7EE2C
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 09:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjFFJPv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 05:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjFFJPt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 05:15:49 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A3D100
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 02:15:48 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 758D63200A59;
        Tue,  6 Jun 2023 05:15:47 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Tue, 06 Jun 2023 05:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1686042947; x=1686129347; bh=LSEgASmT3/DwgRjrXfwU4QWV3P3/GwXvx3f
        3qnoEf5c=; b=SCOndLWJijJzlTWYoFVw6i7616l+qI8EycCbHXCDmmxT/3mLVv8
        iX1OxdOiotbwhKDgIufZKD8morT8ENXlrMs4fSix04oNFXSNaDuiSHbpZ9GEvHdS
        9Qu1jIPvXC9st2MA894UgjEKnhJguSR/HKoBpV8TmOIcUnxidItL8ljBr6rDCh9p
        IjZGb1AlzdQTkBb958a3KsOLJmoQlaOBFaUNXUsFdbpgo01bqEqAnSBabcf8j/K7
        eIDxH9Nxn8lFkLhFFDU4tLTzje/iSAx2v2CdAp0pPTFJVlJXtwbXrWXM51VX1peA
        3CC9OFUuDwz5Bs+zM9VNWk6/hCSHpSpR9ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1686042947; x=1686129347; bh=LSEgASmT3/DwgRjrXfwU4QWV3P3/GwXvx3f
        3qnoEf5c=; b=Ajl18+FcG8flCID2q9w1LZPC/xTyKpRx5WjtlUPGCBm+nQPLk3N
        DxxQ8EiaUmIgjf+R44OaBTG5HFbHIa4U0rifJ/wJYVEMPtheTrILldmjtJ32dG7d
        +cW39PyFIYQtQizhmF22g0AtN3AHBqM41HGRoiAofssIHpmkmE6O7LSebHQq1wKZ
        RLAiyhla/wXEiuP4vu00SzZ15V8KRTX5ANrnH5AekbXRUVEg/3X78WR3T+s7GSWT
        drxZlAqFgRF7vGg+dedThAj+ErLXq08rl/oyRYYK591kByQBVzw8136DxDzNwvYT
        7Ib7w2wjbfTKh4zc606cSV+0ZeFBzCjhW9A==
X-ME-Sender: <xms:Qvl-ZAFfeLfhkwce3-wkg4oaVKc629zXFlogZfHdEIERuZ6YuNlg8Yc>
    <xme:Qvl-ZJV1ff5T9d1KfEAElmU4cbE2Qc2TF8WJo3PuD_Xq5ONGbnm29PHdIBcdEOloL
    Q96OyExr6NzGi6psA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtuddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgfgse
    htqhertderreejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhk
    fdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    eqnecuggftrfgrthhtvghrnhepgfejleegjeffffetfeffvefhhfekueeffefgkeeuudff
    ffeuheelkeffveefteehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgv
    rhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:Qvl-ZKJGy6V-BBH4Jmq0GcXnonQxDZfLD8qiIil_4VwapdlllX5qWA>
    <xmx:Qvl-ZCELPhfbeoO4Fml5rpz1SCJu5mDwbIXqB0qYGgrhpCAdWbg1HA>
    <xmx:Qvl-ZGUnGsC1i5Tjm9LZWcfKaR_Fr-rCF1RnNNiKvNVhk3APL4RQfQ>
    <xmx:Q_l-ZPfVyZu6U7OxetCxtJ6pRrqLkpIJUFh6fAqrhqz4NB3pCdiqjw>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CAFD815A008E; Tue,  6 Jun 2023 05:15:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <158e0823-3b1a-4b38-9dab-7b7ca8a93331@app.fastmail.com>
In-Reply-To: <xmqq5y814aw8.fsf@gitster.g>
References: <xmqq5y814aw8.fsf@gitster.g>
Date:   Tue, 06 Jun 2023 11:15:10 +0200
From:   "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     git@vger.kernel.org, "Jeff King" <peff@peff.net>
Subject: Re: What's cooking in git.git (Jun 2023, #02; Tue, 6)
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 6, 2023, at 03:50, Junio C Hamano wrote:
> * kh/use-default-notes-doc (2023-06-06) 2 commits
>  - notes: move the documentation to the struct
>  - notes: update documentation for `use_default_notes`
>
>  Will merge to 'next'?
>  source: <cover.1685958731.git.code@khaugsbakk.name>

Peff posted this a little bit after What=E2=80=99s Cooking https://lore.=
kernel.org/git/b3829cb0d1e36a5ebb44a315fe32037f2a3f6c7a.1685526558.git.c=
ode@khaugsbakk.name/T/#m94bafe1b04d551130558c5d7aaf20b1a353cab46

--=20
Kristoffer Haugsbakk
