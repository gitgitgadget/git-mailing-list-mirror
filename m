Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85816C433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 16:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238877AbhLQQLs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 11:11:48 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:43403 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238435AbhLQQLr (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Dec 2021 11:11:47 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 034C75C0105;
        Fri, 17 Dec 2021 11:11:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 17 Dec 2021 11:11:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hurrell.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=5udqMt16DRZ4s
        kB/Z+7/6zPBgeA8HRxniTupwdaaFyc=; b=DGnCfo9AYtoHeBir5HW8KgwfQTUAa
        c5w7Bn1nkpX6GJtoZGI8rFkMBY/tUN1FJQZgjD/pPZ+mP5H3iCgA5PY01UDzIe8y
        yecrxGttt1XEAaT51mePNdxVA3ZQz/icxV5plr+jvVJQ29xjWOwM4HcfPxCw2Eoi
        gS10LcH1MdCAPMbMAMIS6VCNK4BMsIRDhdrS0XHyXpHPJWJnMlvIYU/xw035oo1K
        rKwj21ikhFst5ckqFp5KE7n7GeZPZoU/N0Li+EXlTZD3JkyFurZM9CPYr3GR0Rcw
        iuyGgHt4nFRfvV2VSATMca+l7Rv8go27/q+SKJJk9veX5g7+1tRRs1m4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=5udqMt16DRZ4skB/Z+7/6zPBgeA8HRxniTupwdaaFyc=; b=aMWUyTb9
        iPYBDCfEgV9vsXxmorPiILieCLrP6WmIg440JQ63r4dGIhROXrbHCHJIUIkZgPty
        KNta7z/oxRUgrigdWku+7soUHj5PG5Ynofd2nNQcXDL15EDaE+w3WitJigeGnfTb
        CxInTa0rYyV2MfRkCH5IS/lP2qU66ljjsLCqacg0MDtaMtryxo2b0M5tWM1CEaA1
        3mZ21C+lkrh5P+CSHLHueczgTZb59ktWRSxU9VaxDJEwwK0Y+J/UND4/+4Iywe+M
        orbducbjvGUEtxgtIhuFCn/cVokAHO/mUZqqhnGhE+UU9wXU7KPZ/XzPSRm6DJRb
        4YLyZn3rPv7jTg==
X-ME-Sender: <xms:wra8YULwNuk1UDc_Zqa7odqAlG5x1QSUOvKPCHBs1eamRKtYjaGsAQ>
    <xme:wra8YUK0Danv4ko9t5WEb5n8CasRIL-82B3UiONlNgrEQ6h-57VOPSv172iSmZhFo
    00qZmKnHVc0E-wUJqE>
X-ME-Received: <xmr:wra8YUtkAavR2-YCcP81MoLtAYxgxDpK354sZm9JO1tWGZhzhSZqatf2Lv1z2-z6_0zHb57zA11_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrleeigdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepifhrvghgucfj
    uhhrrhgvlhhluceoghhrvghgsehhuhhrrhgvlhhlrdhnvghtqeenucggtffrrghtthgvrh
    hnpeeutedvieffudeggeehudehtddufeeljeehtddttedvteefhfevkeeuudelhedtfeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgh
    eshhhurhhrvghllhdrnhgvth
X-ME-Proxy: <xmx:wra8YRaCutMoxNOI4d4_pFmZJVxNDGDQLXm8wpJBSYyLT8cFuevjOg>
    <xmx:wra8Ybbr1PNyO7ObdLtz2kNfTFCPhhvjhZ1WvSQ2d_1PkJpimO6VGQ>
    <xmx:wra8YdB8HL5DSwu3FTaTBkYaEZ61iVauew-aPpqld7WqLxhNwlTXyg>
    <xmx:wra8YcCfnCSN74h7GU5FicbIxZ_mVOc-J38E4GMglOuCf1pgO3oNMg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Dec 2021 11:11:46 -0500 (EST)
From:   Greg Hurrell <greg@hurrell.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] docs: add missing colon to Documentation/config/gpg.txt
Date:   Fri, 17 Dec 2021 17:11:37 +0100
Message-Id: <20211217161138.14771-1-greg@hurrell.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <CAPig+cTfL3e28geHMG6aga-1zSSYSgXknQKO-62msn3LO=+iZA@mail.gmail.com>
References: <CAPig+cTfL3e28geHMG6aga-1zSSYSgXknQKO-62msn3LO=+iZA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just added a Signed-off-by and reworded the commit message
as suggested by Eric Sunshine. There are other fixes that could
be applied to other places in this documentation (eg. backticks,
capitalization fixes etc) but my intent here was just to fix the
most jarring problem.

