Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86547C2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 12:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241091AbiAZMOc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 07:14:32 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:37773 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233952AbiAZMOb (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 26 Jan 2022 07:14:31 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 3BD1F3200993;
        Wed, 26 Jan 2022 07:14:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 26 Jan 2022 07:14:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hurrell.net; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=DXhFgNBB+85q76
        9ebdJk8AAq4gzaxe++iazwB8vxXMo=; b=meakYZospfSFuNSQPNtzvNf2xGJEVw
        xCg8NtWFCaL3zIfq1XFKthOSNWp2BC7Rzrc9lSLN9SnAn7V5Bm47ErdFUIHnK/cb
        koonQGxJVSp2LMjdKZBNCx3PWpsbAerF53G2p8kXB7+7goD+CA/g44d1Tc+9P+Qk
        N6fDW7lC0ymgLa/YOCftIUXKhtDHRWQMUip0D6BmIigPOan1lI39bvE29FxGGa9C
        Z3SyTE7GDr+MuyynLD+JDXCFqs5qPtvdsslHuiM5jBlRKx/bVJwaYmUq5EVzMLcT
        XYqLl8Gk0t47rKvH29PBjd7wjKvaj08x2OkeuFOePj3NyMOr7iFNnAMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=DXhFgNBB+85q769ebdJk8AAq4gzaxe++iazwB8vxX
        Mo=; b=ETTY/FS01jPiB9FvQwrZ2QxC2t4W+W//FVLCwDd2B6c/eCAsmj7escCcN
        zZ1K+C22M1mHHgNq62FsnwTN4hH/GMzBPopzqbbGjlMuDTqZllQiFmgmFtg/iyNx
        tFQv7RcN2OqnrDKQivkIQJPq9EzR1iFlVcRIK9fFiIfN5HJ2O7+97jkCWwSjGl4h
        FSWR25/UZVY30vfzIexDK3W5bheOrW/1/GhWwuhyfjmPxspAKW6QuvTSiC8/rHp2
        Fw7xOhx/B01oK04pbLrkoMx8tAJdBW66e4PwC2jNsdqItIhga1YTRq/0HVi4kxbS
        O2MO2o9l8GEN9YXP4BeduNXSx4mPg==
X-ME-Sender: <xms:JTvxYRMnXpOsW2WIlealgxETn0P1IA3OI8dYKn2awLgOhaeB-Y1Xiw>
    <xme:JTvxYT_Rqx1T_H4SFvirhWtUHd2W0aLG-shIaylsRHz7UoI_QvAuc2cgypzzR-p57
    SPxtmbJIK7yyPAQNAo>
X-ME-Received: <xmr:JTvxYQQKm3_rHn53h1MrjZNgIu-KkazuDDtoMMfwnvC5LBD1lnWejDZddPlx7qNdZrjogoS9Z1ey_ybQNOtzp619>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfedugdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfgggtgfesthekre
    dtredtjeenucfhrhhomhepifhrvghgucfjuhhrrhgvlhhluceoghhrvghgsehhuhhrrhgv
    lhhlrdhnvghtqeenucggtffrrghtthgvrhhnpeetveehueeigedugffffeethfeigeelle
    ehgeeikeduvedtueegieffieekfedvjeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgrhgvgheshhhurhhrvghllhdrnhgvth
X-ME-Proxy: <xmx:JTvxYdtHlpiMw_DowXwE8KQSEgJvG3dpJDp2t-YaZMMOlTMNgqLYqg>
    <xmx:JTvxYZces2BNARCwXNGeaBTDAJiQFDo0ye30WrVwfUhEU2_Wo2c6cQ>
    <xmx:JTvxYZ1M2r9bZprfRm1QlBEcDeb5nuPuGKOjq5GkkCB49uayklDjeA>
    <xmx:JTvxYZnjFdU55LYrzlq3QP9tr5WXHOx42Rtrtgn3dNfUfoEKCIAhKQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jan 2022 07:14:28 -0500 (EST)
From:   Greg Hurrell <greg@hurrell.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/2] Apply minor fixes to Documentation/config/pgp.txt 
Date:   Wed, 26 Jan 2022 13:14:24 +0100
Message-Id: <20220126121426.53799-1-greg@hurrell.net>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <220125.861r0vhh8r.gmgdl@evledraar.gmail.com>
References: <220125.861r0vhh8r.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just applying changes to commit messages as suggested by Ævar Arnfjörð
Bjarmason:

> nit @ subject: I'd suggest:
>
>	Documentation/config/pgp.txt: replace stray <TAB> character with <SPC>
>
> Or something, i.e. the "docs" can just be replaced by the filename, so
> we don't need to put it at the end.
>
> As general style, we tend to not have the <msg> part of "<subsystem>:
> <msg>" start with a capital letter, i.e. "fix" not "Fix".


