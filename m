Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3941C6FD1D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 16:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjCOQRE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 12:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjCOQQf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 12:16:35 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4A12A6FA
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 09:15:50 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 1D2455C053C
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 12:04:32 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute1.internal (MEProxy); Wed, 15 Mar 2023 12:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1678896272; x=1678982672; bh=RwWKnxt/jmnCj5vHVwg9peFYh
        ilk5paQ8RpganeQ9TM=; b=lVa68hhfaNpcu32YBfKqNjBZVDarpFGp91Kg5UimL
        JctVh3PcdGkK6oBzuPchWMS9oSzMJIGDXdCdvQb+aSJTDXBeaec0BqYtHFWsYnR7
        9YAHP1CSuR5Qx8284pLinlOxsCnnH/8PBLFDMk45s2g5+R0TxTrZhViJUsknRnCl
        fafEwHT8AjTG1bdfs56k8tS6sR4eXYVuG1oJKAogtf1auIcTTDchD+TI/d2PH3Mh
        6QgV3rEuww7uaebuBi9kzsOdZ/zVGyd7GXXb+qm2t35GXeS0Z5Qrc2LZi85+PNMZ
        mjcyzxw7E96ZfhvFze8HUduUqBMqWHRtf19mC7xOVosTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1678896272; x=1678982672; bh=RwWKnxt/jmnCj5vHVwg9peFYhilk5paQ8Rp
        ganeQ9TM=; b=UW6iHbjEdQ2h1avr5Kx+ZHN8yqSFv/hut5fs0wwDr6SZXFyDZc+
        7QxvVWveQGMJspE8coYdCI7Yu6WApzT3yRcMI7DjIVn2aVJLMR6OyG6kP3x7sh+5
        esOFqZfAtBBnkS9ZWuxxKhz6NeJEK8E+RONr6xu6xA3FbxdW5lRFxSLIURtnZSq9
        zVtd0YKafdbe1NbdkmrTbyQSpa7S0D6mM8OGMzHpxpZoihSsZKrJOX13xCGJ4FPk
        +xZdIhDjeH4u48dhAErAoxRV5NETlCAn234FVoSvxhhxOvSws+4mN4L2QHUtrgTy
        YKOAhlSoKgZm57h6jjKZdvru5AEBB7usRrg==
X-ME-Sender: <xms:kOwRZNwGRxr0L8rqkSdmH51taQF7p7QbxCQyvPONPqphgUwIKGMpkQ>
    <xme:kOwRZNMUrYNZGm8PUnRQ3NO7_8TuUUK9x5Uk0VSfe4GuvtPkk9KQQ_CKLb3t13mDr
    nygUt98EGqp5JBd5QE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvkedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedfofgrthhthhgvficuffgvgghorhgvfdcuoehmrghtvhhorhgv
    sehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeduuddvtdfhvdduvddvfeduff
    ffhffhueelgfdviedvteefgeffudegteevgeefvdenucffohhmrghinhepghhithhhuhgs
    rdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrthhvohhrvgesphhosghogidrtghomh
X-ME-Proxy: <xmx:kOwRZENlEF_6_iEkfjHgUOcxhbXHW55xqPGDMXEyZzCeTdgMlGpR9A>
    <xmx:kOwRZHQ8ZGpbyaZGOBr7nVpEhRTG42OtJLEozY2dCXwi1R_Ovb0-Pw>
    <xmx:kOwRZOD-7LzjsTSp3cvILi1vnog8YOjHd7L14xp3t4nhAN2tC-1obg>
    <xmx:kOwRZF19GHJUM8L7EDzNDvt2WiTRpTFdn45xvkX7hM_3leYoQqHb3g>
Feedback-ID: iba91467a:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 067FD2A20085; Wed, 15 Mar 2023 12:04:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <4c02cd71-8bfc-4b6e-9ec0-3d98598a695a@app.fastmail.com>
Date:   Wed, 15 Mar 2023 11:04:12 -0500
From:   "Matthew DeVore" <matvore@pobox.com>
To:     git@vger.kernel.org
Subject: Buggy `git log -- path` behavior
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I think the below terminal session demonstrates a bug in git log. Notice the first git log command gives no output. Any thoughts?

~/src$ git clone http://github.com/torvalds/linux
...
~/src$ cd linux
~/src/linux$ git checkout v5.15
~/src/linux$ cd Documentation/vm
~/src/linux/Documentation/vm$ git log -n2 --name-status --oneline -- pagemap.rst
~/src/linux/Documentation/vm$ git log -n2 --name-status --oneline -- 'pagemap.*'
1ad1335dc586 docs/admin-guide/mm: start moving here files from Documentation/vm
D       Documentation/vm/pagemap.rst
41ea9dd36b6b docs/vm: pagemap: change document title
M       Documentation/vm/pagemap.rst
~/src/linux/Documentation/vm$

Thank you,
Matthew
