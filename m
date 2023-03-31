Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FB9C76196
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 18:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjCaSWW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 14:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbjCaSWT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 14:22:19 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF69522911
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 11:22:11 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 27D1F5C0129
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 14:22:11 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Fri, 31 Mar 2023 14:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1680286931; x=1680373331; bh=vlI0tJP1UhqNx8aj92eusmVqL/keQGSv2To
        hIgku7ZA=; b=SCiUKkJdI5rAX2qAsdI+fFZZhmQFlwpsO5qBetL/YqRFt1ucded
        TyI/pkcy5ku7fzQLSniMxpmhwbLoQjx+ji41knBbivik4iMhxvmge9xULon8J8on
        tyg88o09fD6qJ/2NFHmZ0tuXZM/5NC8VnbHV00wIwJJmmf8jrm2ELJ5CMLqK2QMR
        ZR+gQFIb3+9sfDtwXvpbLFWuIBYDA7UxVGgkaxnaFJmF6L1Is5erKhLZhm35PUTi
        0HEuEVe2s/3KpNQxChDQJqY/qrSpJZ4DbG3/zz2YgZIhy+rFMYStSkjIyQKotoWT
        p0AFP68zWOLOqRPsyXFNckxZheBr8E7Ptzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1680286931; x=
        1680373331; bh=vlI0tJP1UhqNx8aj92eusmVqL/keQGSv2TohIgku7ZA=; b=g
        u/o886uGo3iQyemZNEsnK17eiOmwT67R2Efyp0s0UDVAHnvNRrjB3MLJn+YAEqyi
        vJVTNdpDr7hkkiozVrR17TIGUzftvhaMvG8tWBC/eztQI7ttkuBU6IDHWnz+3H9T
        IT9lbXR4u82UyT+eR+/c/w3/9/JRjASY+vwkOOKRzvQHqSu4E3NDsHB0Ut1cjS6n
        QYUnXQWR6fNDNGjxKzejb1grQ6Ft+kodcwp1NiYIdgpIwpp0JqYueCybIsiWxtVG
        4ocgBG+USaiUpFIMvQLVsRirTQDSBquCXQyfibnU7Egkd3YQqojXCOhWC0zUlxF/
        71c+pznVCxHE7874XMn0w==
X-ME-Sender: <xms:0yQnZITqScCGBq6vIDzDnSJwN-h5HcPbw-24wcILHXq80gF4NMEe1Fc>
    <xme:0yQnZFyO0TmFgsAEVt6MGWK87TdR2J-hpa-BQhH-p3vNbEidXDcSR8ZUmKRS23L43
    grW-GrCDL8iQrU6Fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiuddguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvffutgfgse
    htqhertderreejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhk
    fdcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnh
    epudejhfehveejfedvvdeufeelteeghffgveejueeltdduiefhfeeggfduvddtuddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvse
    hkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:0yQnZF2dUOAe-CYiSz9pvkoOKNQwoFWNNzFALklg-A1U4lG_iA7sCw>
    <xmx:0yQnZMD6U-zKptL5Lljyd4qGEB-snItYZpQx8WBe5vrKT74jdIumXg>
    <xmx:0yQnZBgITvjXk9e1D_AKTjJyNmJ3h_nKI_GFB_LCNgSTv3t1Y8D9lg>
    <xmx:0yQnZMuhkx8a1hbNGI7Bu7bIlUTnwDMCJR3rY4LozuRF8rbA9LZ0Cw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F405915A008E; Fri, 31 Mar 2023 14:22:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <e1d11808-3740-47ca-bbea-24858d09bfef@app.fastmail.com>
In-Reply-To: <20230331181229.15255-1-code@khaugsbakk.name>
References: <20230331180817.14466-1-code@khaugsbakk.name>
 <20230331181229.15255-1-code@khaugsbakk.name>
Date:   Fri, 31 Mar 2023 20:21:16 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] doc: interpret-trailers: remove trailing spaces
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 31, 2023, at 20:12, Kristoffer Haugsbakk wrote:
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>

It seems that my cover letter got denied since it contained non-ascii in=
 the subject.

I=E2=80=99ll re-roll later.

--=20
Kristoffer Haugsbakk
