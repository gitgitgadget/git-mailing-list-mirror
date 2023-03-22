Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA79C6FD1F
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 20:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjCVUIP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 16:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjCVUHv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 16:07:51 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D046A436
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 13:01:55 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 070735C01ED;
        Wed, 22 Mar 2023 16:00:48 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Wed, 22 Mar 2023 16:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679515248; x=1679601648; bh=EX
        XtL/c1GKNRs44wmvIQD0ebQiv82HrBdfMtNFkEsUE=; b=lShs+yQl1P4Ujd48Sm
        QJXZJJad9YaEidzVLlRG3bNqr6ly6FtuWBVHWrr/o7DXlTel8pJ0xyEoVRLXo/+i
        c5T1Wi5cYKg80HiJrv+ZZpRV4FgTpRAx/ovyhmovUY0UZn6vM5wpakq/qfSKMxHl
        gXcypwRWoXTcvzyS429cJr0DL1NkNeuMRatjrEa4w5wWUQ+fCll9cQK+jFR8gAay
        sK8u9zaJGKcWQlK9uy3bSnzeqH4s4yTtrxAJ6GJ7SDBBifp6aRT5xG1SSFnNE2RK
        PEjHuM+jJ8jq7/DV7twLQpVWya22WYI9uxBl5J2jlEtgUdKtfFWZLFV7RajKrrx6
        EieA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679515248; x=1679601648; bh=EXXtL/c1GKNRs
        44wmvIQD0ebQiv82HrBdfMtNFkEsUE=; b=k3XUueusuPceoAxh5gWeof0sFedXr
        mRxrBAqiX6Nq40N97TBko4zv+uwVTSQ2s+VCvoLpJelF6wXtWJR0qEB9LckZ3doy
        GwC1f0A5Sn21wz+7gDf5x/QjB0kMe+BhPKr9OHRFNTLFLG2qRQfsSkXTgIVUQoRt
        zLEiB76+fW0CIbJf6zFXc39qMJlgscXZE7+DukJ7G4e4I63pttdC/sVcgegbasRH
        ucC95ytYbv0DAdlmY2Wz/iQlJYqhexaYSyzbVr8gmgbKpK60wRhRYkxhxw0m0uOU
        XekorFT9BbCH0ryVn+EZzDQ2Smw8qPhlknkxobJFcsGrtnjA2sUwXJ9nw==
X-ME-Sender: <xms:b14bZAQ1aon9jzRI2oRYMCinuHvJwkh_SSXXC9HT8fKV60-cN0Y0764>
    <xme:b14bZNxGgI1TPVZgVB0S0jfA6d7d8Mra0Fd-829G1ViDTDRd34empvwctg-vpyuTS
    apTpL1t01zWG7J8xQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegvddgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruh
    hgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeeigeev
    vdetfeetledtieefheetgedugfehtddtledvhfejkefghfelvdegieefueenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgv
    rhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:b14bZN0reJGQBpeARdyND2b8lg6sQNSf8c0q6CV_aYJLfZtstiueSw>
    <xmx:b14bZECnMkLNQkO_JjqQSGOcXsO_E57IEF76Qp4ur_M2TKRIv7_CaA>
    <xmx:b14bZJh6GJ20NYd8Ih9rl0c8jISZZFxZHz-LYTTsy1kR5kayHMEDJA>
    <xmx:cF4bZJIH-iXEd531OqzSbZlqGYsg-m1J-0HYVnJK_d8E3it9GwtB0A>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B737A15A008E; Wed, 22 Mar 2023 16:00:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-236-g06c0f70e43-fm-20230313.001-g06c0f70e
Mime-Version: 1.0
Message-Id: <34c11cee-d73e-4de0-85f1-5ecd5fe54c71@app.fastmail.com>
In-Reply-To: <xmqq355wegsd.fsf@gitster.g>
References: <593742E7-F0FC-471C-AFF5-1E855A3788B0@mac.com>
 <CAJoAoZkKTGzgVyL2wM9a4VcFObx4YpjMSatH9Bpqcgyi=zzBrQ@mail.gmail.com>
 <3FC6072C-5856-437F-9B4F-BC182921426D@mac.com>
 <73af529d-e918-445d-b0ee-9506e28188af@app.fastmail.com>
 <xmqq355wegsd.fsf@gitster.g>
Date:   Wed, 22 Mar 2023 21:00:13 +0100
From:   "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To:     "Junio C Hamano" <gitster@pobox.com>,
        "Sjur Moshagen" <sjurnm@mac.com>
Cc:     git@vger.kernel.org
Subject: Re: BUGREPORT: Modified files on a fresh clone on M2 MacBook Pro
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2023, at 20:18, Junio C Hamano wrote:
> The attribute file says "assume everything is text unless otherwise
> noted below", which you probably should not lose.

That was to illustrate the issue, not to propose a change. Sorry about
not being clear.

(But it also so happens to be the case that I know very little about 
`.gitattributes` :))

On Wed, Mar 22, 2023, at 19:47, Sjur Moshagen wrote:
> I will add this and other missing extensions.

By the way, when I first cloned the repository on commit 357c7cf01950
(text, 2023-03-21), those two binary `txt` files showed up as dirty for
me (before you removed them in 6b0acd78f9c9 (Remove accidentally added
files with uncomprehensible content, 2023-03-22)). I guess it was the
same for you.

-- 
Kristoffer Haugsbakk
