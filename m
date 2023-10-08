Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E12E95A67
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 22:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344751AbjJHWRR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 18:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344437AbjJHWRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 18:17:16 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3525A3
        for <git@vger.kernel.org>; Sun,  8 Oct 2023 15:17:15 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 488693200A16;
        Sun,  8 Oct 2023 18:17:13 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute1.internal (MEProxy); Sun, 08 Oct 2023 18:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1696803432; x=
        1696889832; bh=OrVLyleiVG7qRaf9C+PVDvejiBjC9gVFjJfhhLnwRKQ=; b=F
        Ggu9ru7ijfrOkXkaZHii6A5Jq4M06ZlrnqpVbDXU9CuVhMYJJfDks4rD3hkjWPXG
        i2eMfdcenj201Ipccpw6yUKo7FHUQFrmzSr0pC5lPO96dfSPfcCA++Gmm/7qNald
        ZiaAcpc917F67cm9wPSxGDAZdMmm3WcNe5qrOdi2mZEP9GnJ7wCivHRQ+zo5XTBf
        WqkuDZwnhoy9Gdbyr81GCng86jR5lVqxNgcLvN56zqUyOrku0lBSHNQLOPgydTl8
        0UDE1thSXTIhYK7qfE2WmG7gXzOPd5Q9K0dJmmz+sGK2T0avOi9ESCzO9Tg7nkb9
        Ih/LepCRiiy6cJO1oXkEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696803432; x=1696889832; bh=OrVLyleiVG7qR
        af9C+PVDvejiBjC9gVFjJfhhLnwRKQ=; b=XPjY/OxbD/W1hoZRx0H7FlRpGUhJh
        lVT1jfUbxbw9LtbBRG1g9YQgUIv9lDDCFuRhUFpO1TeDgimwIN/FHIXk57ux94eL
        qOhnMsSwzyQlbiB8nxDSU2T9NFaO/R+NWc9KqxF9ZffVc8SR5k1MyZD5nuywQFnK
        dLVe0r4QAK/Ne+VVA3s6DVeEgjIEdSi/lvghGHri3mJqZWNwt+2AlCj/BAPgu7sm
        q4+R/a8heBo826xS6p4cKA7yGlTehCCvo7AZXW4yDXk7/jdGYqm1lAfgUucjFccA
        VDvBd6oKLIXN0Rf6mtH8hzh57/i3ae57kSm6qj/NZJ11gwVv1eoqbzfRg==
X-ME-Sender: <xms:aCojZUhI20wiTZCxiam3n4gLtpMpmbHiGalRz-zmHuWx0s_qbVRQLVg>
    <xme:aCojZdCSpBbReqiGclQVZCVGAB6mP5AmVr-jK1oYPPUWIiK1QkfRXkxGEvij2OX7c
    xMVd6JfgU8oKoJe5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrhedvgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtsehttd
    ertderredtnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcu
    oegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvd
    euleegveevkeejgffghfelvddvtdehffduveevvdffjeejheeguddukeelheelnecuffho
    mhgrihhnpehsthgrtghkohhvvghrfhhlohifrdgtohhmpdhgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvges
    khhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:aCojZcG6GS9t9ii3Rxbgw10HFPUeZa83EOd10zVc_1fNAoriH7BfWg>
    <xmx:aCojZVRWjfhNMhCAOBP8yWPntp3dzgTdwEYo3O7u6weNKdoTCTjNNw>
    <xmx:aCojZRz-cHnQDVlj-HW_lsDFTwV42RMFHCXO7_KdAIUJWUwB0zlxJw>
    <xmx:aCojZatPOvqGfi_d_ITWB-xt4K9c-3eW9PbwqTAe4-phmMaaG4fFjA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7B35D1700089; Sun,  8 Oct 2023 18:17:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <e22b6211-8534-417f-a647-e36cb00eee61@app.fastmail.com>
In-Reply-To: <CACS=G2xBNMMTSCSsVFe3M3jFN0m0pZ-j_TAz3r6xmQrgdRujfQ@mail.gmail.com>
References: <CACS=G2xBNMMTSCSsVFe3M3jFN0m0pZ-j_TAz3r6xmQrgdRujfQ@mail.gmail.com>
Date:   Mon, 09 Oct 2023 00:16:39 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Naomi Ibe" <naomi.ibeh69@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [OUTREACHY] git send-email issues
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Naomi

On Sun, Oct 8, 2023, at 23:59, Naomi Ibe wrote:
> I've used the --smtp-debug tag, checked the official docs and other
> docs too, plus stackoverflow,google and even chatgpt, but nothing
> seems to be working. I've even had to change my gmail password tonight
> but it still doesn't work. Any tips at all would be greatly
> appreciated at this point. Thank you

Here [1] is a good resource for setting up Gmail for git-send-email. It's
a bit of a chore to set up but that resource was enough for me to get it
working. One of the things that you are going to need is an App password.

But have you considered using GitGitGadget instead?[2] You can make a pull
request on that repository and then the program (gitgitgadget) can send
the emails to this mailing list for you.

[1] https://stackoverflow.com/a/68238913/1725151

[2] https://github.com/gitgitgadget/gitgitgadget/

-- 
Kristoffer
