Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E12C83F01
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 10:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245064AbjHaK7A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 06:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244623AbjHaK6y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 06:58:54 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82188CF3
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 03:58:52 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 021193200681
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 06:58:51 -0400 (EDT)
Received: from imap45 ([10.202.2.95])
  by compute3.internal (MEProxy); Thu, 31 Aug 2023 06:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693479531; x=1693565931; bh=0WMDM11A86GxXG7yjW+GoSTeQ4w2LXoKAzL
        XLYKx/Ac=; b=vMMDc05VcxeoeYyL6+P2SyJi3Lh4pnJI6ucNWQdaDv8yZnHEM9y
        W6f1lCFY3ssk2b8AaG7jkF7XqawaKOY51VUEI3xwEj0Qsu1B3CdulSouQeq9ke2O
        xntbZErdQ3Zh1RSpf1JwNyfahUptUcJ0P9fbAhm+4iiX6LVJ2xjv4BMwYH1C628t
        3VvVqtT5P1wZ9hhV12Zc3rvX4eHLGCyPLGpC54sjgv0J9W5qTFPbYDPFfi8SFR/D
        zpHMO3w6hPI13dWRj+ldnRgpCi7M5qclPNjYgIEoD/0/U9HArpPSjWPQIIHVSba+
        By6PqzEm1gpkaKTaBHEtmwGyLyYkb6MIL4Q==
X-ME-Sender: <xms:a3LwZOYN5kPgDArvalzp-QgWP643T2c7aCGl3EXBANVXeR2lEr_cjQ>
    <xme:a3LwZBarbiUko-x0i5qo_KTzY_2BYHMsps1UDUOtsaqGGry5rAK3b_d5jV2QsESlr
    -K1ZdSyVF4etYNpF9c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudegtddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedfifgrrhgvthhhucfjrgihvghsfdcuoehgrghrvghthhdrhhgr
    higvshessghithgtohhinhdrohhrghdrhhhkqeenucggtffrrghtthgvrhhnpefhtdfgie
    ehgfekveeljeehvddvkeeludejveettdeggeejkeevgeeuuedutddvjeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrghrvghthhdrhhgrhi
    gvshessghithgtohhinhdrohhrghdrhhhk
X-ME-Proxy: <xmx:a3LwZI_0fCFERDdO_zP_W6g6RhGGlRF7q65ZKUbP8hncRZKcJ2lbgA>
    <xmx:a3LwZAoHpEAkCKrjDwVRt-_jqOfaFc7knEYr7A6bTCeyCemOL3ZZmw>
    <xmx:a3LwZJq_pUk4EOVoBQ01pxqfpqa2VWJix3sz71iShSppxXXX48vrFw>
    <xmx:a3LwZG0P2AvhwTPz9iNA9mOILgME8UtYysYzjbdQqKy7U1FqsUHPlA>
Feedback-ID: iea414692:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 38D44272007B; Thu, 31 Aug 2023 06:58:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-701-g9b2f44d3ee-fm-20230823.001-g9b2f44d3
Mime-Version: 1.0
Message-Id: <0de414f8-f409-467f-a504-06a78f088981@app.fastmail.com>
Date:   Thu, 31 Aug 2023 18:58:30 +0800
From:   "Gareth Hayes" <gareth.hayes@bitcoin.org.hk>
To:     git@vger.kernel.org
Subject: Problem: `fatal: too-short tree object` when executing hash-object on tree
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Problem: I'm trying to reproduce the identifier of a tree object using `git cat-file -p <tree object identifier> | git hash-object -t tree --stdin`

This results in an error:
`fatal: too-short tree object`

To replicate: 
`git cat-file -p HEAD`
`git cat-file -p <tree object identifier from output of above> | git hash-object -t tree --stdin`

This works for other object types but not trees. What am I doing wrong?
