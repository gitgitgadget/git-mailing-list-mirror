Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30C0C636CC
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 09:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjBDJZ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 04:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjBDJZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 04:25:27 -0500
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1992821E
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 01:25:25 -0800 (PST)
Received: from fencepost.gnu.org ([2001:470:142:3::e])
        by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1pOEnT-0001Um-Hy; Sat, 04 Feb 2023 04:25:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
        s=fencepost-gnu-org; h=MIME-Version:In-reply-to:Date:Subject:To:From:
        References; bh=fx7zGMquKlp0Lwq/nPc6J2cZjiKRQ2TM8EXke+pMteo=; b=Vbq16sHXZmT+8E
        JfD6RbUG/tZjPQK6q/WVDqG4dvgdjX2Vgs1X36EY+yzuXWH7KNcsd/gYRSGqPmWukzSbuJwTHQ5z4
        ELKGVH7eNtFIZdG8O/LgLgqoUilR3HAVo1dpclWV18TA4hIkPDEXidljpMTIqPV28WvaesWDpc2Rc
        BWUcnLD3gcQ38+U38hzHMtPXj18g/1ie5URPTYHPhAbT/+8lnuug1i2foAbKNdA7zSbvK1RU++G8u
        xGUzojG2FKFwSoMcVxjfOuiRdTHHw32hIMpuYC5PNkMclxXnexMB55q5EflezOlD5S40m8ImakLFu
        I2KHBYZa2aNnKrSOVoeQ==;
Received: from auth2-smtp.messagingengine.com ([66.111.4.228])
        by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1pOEnO-0005DW-5p; Sat, 04 Feb 2023 04:25:22 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id F018127C0054;
        Sat,  4 Feb 2023 04:25:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 04 Feb 2023 04:25:16 -0500
X-ME-Sender: <xms:fCTeY6vDCo2nroZBgvVF1eFsXpJhxLTx3_oxE5-oTloaFums_LXvrw>
    <xme:fCTeY_cN-6xHoJDs_ITff0gVFtCrEOsttEIml_3_DWTRbKxQQjqruIOz5T1_Rg4_A
    rt74agWQveTXg>
X-ME-Received: <xmr:fCTeY1w0hT4rIcbf3en23VLX8NaxL5pjM5p3svnswzYTEItezjLi8_D6PGBSrt01NEuyDtTQnOCYQOa3AzOvSUv-YKdung>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegvddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfhgfhffvvefuffgjkfggtgesthdtredttdertdenucfhrhhomhepvfgrshhs
    ihhlohcujfhorhhnuceothhsughhsehgnhhurdhorhhgqeenucggtffrrghtthgvrhhnpe
    dujedtheduvdelffejkeetgedvheelhedvueefhfeukeekkeehvdfggeegffevgfenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhorhhnod
    hmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdekieejfeekjeekgedqieefhedv
    leekqdhtshguhheppehgnhhurdhorhhgsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:fCTeY1NfdZ3_M7QYYm27P8Js0m6za-T7Z1_uOSFQy_sWqL-_vgIDzA>
    <xmx:fCTeY6_sZZVuv-_I1EUqZKvJjmsn9sq-AEwE3Nsn6apbus_6MBY4Tw>
    <xmx:fCTeY9WcRaP-TMv7L3iETO6tHgHLKKDJRywJ1hOMSSU7Zhn3N39PAg>
    <xmx:fCTeYxbo0iON3vrC4mi_nYe0Bcz54rjRCIG_uE5Eo8FhKZED1AI5Xg>
Feedback-ID: ib2b94485:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 4 Feb 2023 04:25:15 -0500 (EST)
References: <20230203232339.216592-1-rybak.a.v@gmail.com>
User-agent: mu4e 1.9.19; emacs 30.0.50
From:   Tassilo Horn <tsdh@gnu.org>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v1 0/3] userdiff: Java updates
Date:   Sat, 04 Feb 2023 10:22:18 +0100
In-reply-to: <20230203232339.216592-1-rybak.a.v@gmail.com>
Message-ID: <877cwxvl3a.fsf@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

Hi Andrei,

> Three patches to improve builtin userdiff support for Java features.
> Some pretty old features -- type parameters aka generics are actually
> older than Git, and some quite recent features of Java: records and
> sealed classes, released in Java 16 and Java 17 correspondingly, both
> from 2021.

Thanks for including me being the last contributor to java userdiff.
The patches look good from my POV and are safe-guarded with tests, so
I'm all for it.

Bye,
Tassilo
