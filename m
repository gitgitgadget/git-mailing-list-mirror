Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66946C64ED6
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 14:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjB0ODO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 09:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjB0ODM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 09:03:12 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AA04EE3
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 06:03:10 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id C800532008FA;
        Mon, 27 Feb 2023 09:03:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 27 Feb 2023 09:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        timculverhouse.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1677506587; x=1677592987; bh=YMdn3N++1+FpFIiLzcfJ4uLzZ
        48cFqezvZby1lwxNr0=; b=RJUbg0reEL9KSWd2SLePywyngik9hHcZWvwHONCRp
        4M/SjTCNlDOqfl3stR4becKT59XaHZmFuTZRLE0BfS6K1waIMXK0qP5yeb+qzXPc
        IkS56YwIxORXcIqL9edzcZR8UrGQtcF2kGHduttzuJUEli5CwHlvP7FOCVyIyu/s
        vgOUNfPoRMWpXPI3JXb8VwYdS0Xy8Tgqx+iDyF4NiCsiYWwpczKM5eBgxQBBJFFu
        GVn84huZ37dQoshVmD+ohhcR04MRJqc/TjWG49fUD93J/WTle4xIY4izWangqZcZ
        0u8gQmwbNJ0MtnuqiHoF/T7zsQopiUHXGT4TOmdTfvnPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1677506587; x=1677592987; bh=Y
        Mdn3N++1+FpFIiLzcfJ4uLzZ48cFqezvZby1lwxNr0=; b=jrAIIZ0QEFSRvaJ3w
        Bbwj3luomoL0KBHR90pIhjOuVhhCje3lEcuUCF7alacfMmzZE3svTPOEb6baPjxJ
        p/2S8Sgr4s4kR++dpaQFCxuYPvgoDd2qh+XKeYZ5709WqsU4y1+5/j12Q46UJoQJ
        DZmPSEjHKht3cZyfZM4g1oay7o5sAxt+KgaXwCuqUGgxAM7h/63bhCo1pn4IGcfJ
        y4++oQBRH5PYPQogxPgHbyDll2SSvvGusR0hwVHMnmrNH5vV+59Hgtj+5Y5NgKKC
        7CbCI4hXFG6knKk0ovNRdq1rA0VJcc8KEJp4FWlYo4IlnHJ6QwZMPHH0ro26gwEK
        hB1og==
X-ME-Sender: <xms:Grj8Y9VZ9J0C9qwx2WG3TLGHZm7104k6SqS_MLNl8V0Zll08Ge1Bcg>
    <xme:Grj8Y9m5EZg2z8rC12xXjRPzdi6LPshv93k04si6eerWIsTNYF0lraNpM9tppujnS
    jTE_I03sr5Aejv6gik>
X-ME-Received: <xmr:Grj8Y5Zv8SVIaVcbj2USg9bkoPeUQnoA2-bk_Ys3pjk2lI8Ou1dmgkzEjZbWHf928hlAY-aLEa_UfiQUUWphPF1ugPrTwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeltddgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpegggfgtfffuhfevvffkjgesthhqre
    dttddtjeenucfhrhhomhepfdfvihhmucevuhhlvhgvrhhhohhushgvfdcuoehtihhmseht
    ihhmtghulhhvvghrhhhouhhsvgdrtghomheqnecuggftrfgrthhtvghrnhepkeehveejle
    fhiedtfeeigeettdetffduueehgeeftedvleejgffhgfdvhfelvdeinecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhimhesthhimhgtuhhlvh
    gvrhhhohhushgvrdgtohhm
X-ME-Proxy: <xmx:Grj8YwWzOEkoOfi97LwJeTjMewKorupHiBY3PZWnQcsjThbhcpPjmA>
    <xmx:Grj8Y3l72rhc6zKWTDu_VGO3mfA3mv5WmWcOebZBZDCwqgFrzgkgVw>
    <xmx:Grj8Y9fkZ0Jn1PaefIRZBFeroF_l3N3l9RputRY5RQQ-avUMrH3kVA>
    <xmx:G7j8Y2upaEspufhzmYA_Y_c1vtv100i5pPY7A3bLM_l1_LzB4XeG8w>
Feedback-ID: i3ad947a1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Feb 2023 09:03:06 -0500 (EST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 27 Feb 2023 08:03:05 -0600
Subject: Re: [PATCH] hooks: add sendemail-validate-series
From:   "Tim Culverhouse" <tim@timculverhouse.com>
Cc:     <git@vger.kernel.org>
To:     <robin@jarry.cc>
Message-Id: <CQTEEHZA7IWG.I7NYXWYIBLBE@spunky>
In-Reply-To: <20230103231133.64050-1-robin@jarry.cc>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey everyone -

Bumping this one again and adding my name as someone who would greatly bene=
fit
from this feature.

--=20
Tim Culverhouse
