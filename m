Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E820C433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 18:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbiAMS3B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 13:29:01 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:40679 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230289AbiAMS3A (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Jan 2022 13:29:00 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 07AD15C013B
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 13:29:00 -0500 (EST)
Received: from imap43 ([10.202.2.93])
  by compute1.internal (MEProxy); Thu, 13 Jan 2022 13:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mrkennedy.ca; h=
        mime-version:message-id:date:from:to:subject:content-type; s=
        fm1; bh=yv0lnU3kO8wEwn2QrDdxDEWOr2lUaeefFuCzjKnHo0g=; b=Uw6Gi1vr
        7+vVcgnsqpBSwPvLZYBlGz8psH6aN263Ch3rDpmfbladcWE4GmM0EI68XQcU3HtI
        Fptiu00Lf0+VHrXTtPZWYkqbjpLpFh6pVhBIKoFvLC0ezUq8ZA+NWch+JbPqsXNU
        JxpENmkE6r/yR437jhWhYrN/HYGZ56eX/WeDCYXfcOf7B5AJtPznysFDjP6xAUwb
        J7uysbBwQhqRyji8EbJDSuFEjATnaF169KrZfFlPp1iv0bL49992F/44g29Mtwv9
        7PoKSkNysZcWiLjocWfeF3XDSMP2WoMVeo5e/PhsuvxYO1mJXlbynqRTrGqljJj9
        clLX2huzknrpkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=yv0lnU3kO8wEwn2QrDdxDEWOr2lUa
        eefFuCzjKnHo0g=; b=XhaMsincMnCztTJlKEiNbLetAIWMfsYfJty4UEGlRymm9
        5mFYJYNLU8C9MmTyV/sDQiC3Md1U341ausEr2rVXcwgQ6YC1mh5vie8bl+R7LU2y
        I7df6wlafsd6e6nV++XjBQpDs8d/O3zm0edCvOLDU6jqbuULhxY2SmTx1kDjendW
        mLRc11anftT+wha6Kk21ynOoSjE1Git/A840pUudYUqJdxMSfPyTNzkXH9Y0gr97
        vjRuE7T3OqG9f0XTAklZtWf+SUrwOx1jvWL6FRsOIS6Psz39OBuPLc5c9d2BhMgj
        OMUXQ42PzPAWcTjP+ULb4+EWwWJlLsGQZkZ65w3NQ==
X-ME-Sender: <xms:a2_gYaofWulShFTDQkOB__21g0VAVoxgKajUEYbRLzMEJOZbBRDphQ>
    <xme:a2_gYYpTgDji_fxQXEJc4U9gjWFdVIol3T58E9a2BOWJituQ2qTVUW6VHZ7jeF1M7
    UTzeKRsIv6rKDdVj1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrtdefgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedfveholhhinhcumfgvnhhnvgguhidfuceotgholhhinhesmhhr
    khgvnhhnvgguhidrtggrqeenucggtffrrghtthgvrhhnpeefgeejtdfhieehffdtveevle
    fhuedtvdevvefhffehvdevffffvefhiefgjeffkeenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpegtohhlihhnsehmrhhkvghnnhgvugihrdgtrg
X-ME-Proxy: <xmx:a2_gYfPlSQDR1hGYYk8OdyDq5oCDa5ds3Y3nqkCxGBhLQCtNmoCQMw>
    <xmx:a2_gYZ6m9n4gJWLoqih0Rw2Wsn19b7OVIyrOCF1k1-qPMjcWPsUf0w>
    <xmx:a2_gYZ6pooIHMDAAPdnVCQYe6zRDlZEaGf5ssFOc64bbRy3tgLJbHA>
    <xmx:bG_gYbEVK8SHU9uwu8NwIvbE2E9kqrrxmaY--7SYVj2pIRIbIrLzvw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B0051AC0E99; Thu, 13 Jan 2022 13:28:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4569-g891f756243-fm-20220111.001-g891f7562
Mime-Version: 1.0
Message-Id: <1f4e1634-a59d-4dc8-9863-90c525896e7c@www.fastmail.com>
Date:   Thu, 13 Jan 2022 14:28:39 -0400
From:   "Colin Kennedy" <colin@mrkennedy.ca>
To:     git@vger.kernel.org
Subject: feature request: add [-n|--no-checkout] to git stash branch
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Current syntax for stash branch is: branch <branchname> [<stash>]
Proposed syntax: branch <branchname> [-n|--no-checkout] [<stash>]

This allows the stash command to more meaningfully place patches into "correct" working branches without users having to first clean up their working branch. It lowers friction on my own most common use-case for stash and stash branch - to sensibly park small pieces of WIP that I come across while working on something different.

I submitted another proposed flag on stash branch, and similar to last time I'm happy to take a crack at this if people think it's something that could be merged.

thanks,
Colin
