Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5106DC19F2D
	for <git@archiver.kernel.org>; Sat,  6 Aug 2022 21:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbiHFV0S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Aug 2022 17:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbiHFV0R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Aug 2022 17:26:17 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6975EF5A5
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 14:26:15 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id B757D320014C;
        Sat,  6 Aug 2022 17:26:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 06 Aug 2022 17:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1659821174; x=1659907574; bh=p+r0dAFmXb
        IKWVbGIRiE1kbMXEZwnxu6KCk+JGDLiSE=; b=MRKlawySMr2qhhgehLCt9QfSad
        NP45sTQr/rRK8RfssXEZFii7aegb/7xgfbCsH9Sem+D5RZrpVobg1ycfHnPLsnur
        x7j+tFmBUvizS9J0+fKmVZq4ZMno3B9lavP+jKkpeDwwQAo2kS0qqr2kiPUpqHK9
        RGkVP9s7NLA/zXjbse78YP7PBnlGU0oD5xGeSJaZK8PWxsdE2lJdY3DGOYrCBzal
        AMBCa2om+h3j7ONa2XqLiptmwfWhGfAMlcb+JIJbWq+16grEP9Fkxb7yfQt/RHj9
        Id59vXB5A/LrjeCOdbeelSZD+/RR1OlBK5Gp2XKe7EVsZrlHhzT24CFvCXtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1659821174; x=1659907574; bh=p+r0dAFmXbIKWVbGIRiE1kbMXEZw
        nxu6KCk+JGDLiSE=; b=bWQLpE5IbhvBrhisr5Gr/Y+G4KXT6aIQpi2TPUU+6mpg
        WWbM1PAGusj1OhLKZeScPY9U/RozlaUPEx6kXDd/uHbPE3faCujQFJsyPOuWOfQ3
        fp26nibvSMUlkrEhEfMGjJr8BqPuIdvaXWrpm5d0FJNE4CbSP1E1Q8z3L3jjxO4H
        c8bHoSlZvdxmMwLTbooSfQgYXWEHK+tIw3Q0Dl+QniejpHvgMPURw55aAVHZfQk4
        08YLTLoSj7GxOmdItyzUVM+mz7F2EcW4BgiIP84FaoGzrWOIM27IfvCns4BfoR8a
        IXm0qVx++JjyTsDzNYe+ZkH6nZQPUErAdIyntnVrGg==
X-ME-Sender: <xms:ddzuYr18N3_cmmPR3oFjoxvRuZvHD5_2SyKeNRODiZTJcfvwB1rlgw>
    <xme:ddzuYqEG5DChTGooOZdMe96t2iKahVOhdJi-CM7T_GrR4ZRerATuJpkcxdSXIVMXQ
    P105boiVSBXTwcDuw>
X-ME-Received: <xmr:ddzuYr7Q12CNX9_6NEczK28S27sniF1n349CFo1lslagBuMubSsIzR42FM2btLzAcChk60W5PAY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeffedgudeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefhvghr
    nhgrnhguohcutfgrmhhoshcuoehgrhgvvghnfhhoohesuhelvddrvghuqeenucggtffrrg
    htthgvrhhnpeffheevteefjeevieekheeujeeivefguedvieefleeuiefgtddtleelheev
    ledvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgrhgvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:dtzuYg0BepkfwVWzyH9bxqslY2Bpdgu6VT5m54zy7IV_SsmCfZRIfQ>
    <xmx:dtzuYuHkI3B2Y9tDf5cYQj203qBT2yOewLQkTlUUmN2IfYn1TLy5pw>
    <xmx:dtzuYh82PZ0152oqrKbAIckHXIEbjekvO_946VTmIycp6r81Pk58Mw>
    <xmx:dtzuYpMHO9y-X4vt2CCAz4tmtVKAA_w9-AK5AVunnF1bCHMgvihnSQ>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Aug 2022 17:26:12 -0400 (EDT)
Date:   Sat, 6 Aug 2022 23:26:10 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] vimdiff: fix 'vimdiff3' behavior (colors + no extra key
 press)
Message-ID: <Yu7ccuxYATwsJ7CF@zacax395.localdomain>
References: <Yu6zEiknXKFMJUVn@zacax395.localdomain>
 <20220806183757.72168-1-greenfoo@u92.eu>
 <CAMP44s1YegUqFzw8L==q2QOmh-6WCJdXYSXUvz8GPCrXuYRVPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMP44s1YegUqFzw8L==q2QOmh-6WCJdXYSXUvz8GPCrXuYRVPQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I will reply to this message with a new patch that, as discussed in the previous
email, will also work with crazy layouts such as "layout=LOCAL" :)
