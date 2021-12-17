Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D895C433FE
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 16:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbhLQQRj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 11:17:39 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60169 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235558AbhLQQRi (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Dec 2021 11:17:38 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 221C95C017C;
        Fri, 17 Dec 2021 11:17:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 17 Dec 2021 11:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hurrell.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=J0dv8qVsCkgtM
        erPxNnU9fVB4LxSH5vuXgPMYQFKNW0=; b=dP835N2iL1SLnTV+6pb1eIG8PvTjT
        ZKvNkFib/CGeQ+7a+TTwwaAx75uKJJdg3TsKKefNYX4PZqktTq1+rXsSs9QsW/UH
        eGVSFqJ9ahtLGK2K8nX+Sp9QCtPctlVsyMhmKmrUrLEaVxR6Th9VyDE0BuLZwjss
        IvzfYU3FDTem3YBeqsbPxRPWYaPHKEV2+wfF0Z3bgeaSZ07mjc+RuMHaoBLln+au
        bX+zA1DTtHOWPoxQZw5b5FnZ06ozoRXFHb5maOYgbos7TYKRDiTENTQK77/p2eB3
        b+7dHEPmy2u5BMWQydAboVwBGaUAWgMmI0yEtqRGijcOJu8Yw6h1XM8tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=J0dv8qVsCkgtMerPxNnU9fVB4LxSH5vuXgPMYQFKNW0=; b=esPDARJJ
        LdyZ41w85y3Fcc4fOyZd6cKvxX+y6pTb50qqgomrVUeef0mx4asljazBmz/EuOc+
        kTlUnZn51gce86THDStZdec98Cf6HoMtZjPCuk5jrtrRQvoadG9SRLIgg6/EdIoK
        x2hUgdVuIiwjnax4op7QfMAfRzmmeyB4iV5mq889DSTKLMV/udRxgNFafNjYQoSX
        QGrF7JpQsROnqbzalW+23dZVQMdckPEwh4Zcc/uv+DnUsd9k050I5jnSofPt7Qx+
        /ZYIha0x8bfJoVanGHwUHA65c8XLV6kYCCIYol98PuOVySzOjvHYvwBhRTf/OsGg
        sYLlSjrG0S5Cyw==
X-ME-Sender: <xms:Ibi8YfLNId86TWEZ4sxgyS13cfYbS83E4Mr0S8BjqX6P1Ck6ukFBEw>
    <xme:Ibi8YTI4el-EWj4MVlJqqpz9wYbaleqJTqHPxgokNGR4E3cmQV5apswx2k1aFAh6h
    gSZSKV4RExb5EbYGXw>
X-ME-Received: <xmr:Ibi8YXsx_5ZzZUg0LcW645hpt4nbCf_TMFwb1I1SDwJ3uaYqx6iEaP9o3uaxc43VH7-e-5xO5n5x>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrleeigdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepifhrvghgucfj
    uhhrrhgvlhhluceoghhrvghgsehhuhhrrhgvlhhlrdhnvghtqeenucggtffrrghtthgvrh
    hnpeeutedvieffudeggeehudehtddufeeljeehtddttedvteefhfevkeeuudelhedtfeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgh
    eshhhurhhrvghllhdrnhgvth
X-ME-Proxy: <xmx:Ibi8YYb_Yx1lS2xlusfIty5u_5iQcVsPdACd4B86SEo6FnWigS97aQ>
    <xmx:Ibi8YWb08VreIckAqRYoFS4Mr25Nsb4R8gwnOBIxBN0m3icS8U0rKw>
    <xmx:Ibi8YcBPh10jty0hxYpFEb6PmtWMt2o1rlzyibBGuVNnATxF-1y0cQ>
    <xmx:Iri8YZw1TSlib1VxcjoO6UloVsIjhI_XwDi-TdcnKElDtZ4l3ansnA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Dec 2021 11:17:37 -0500 (EST)
From:   Greg Hurrell <greg@hurrell.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Greg Hurrell <greg@hurrell.net>
Subject: [PATCH v2] docs: add missing colon to Documentation/config/gpg.txt
Date:   Fri, 17 Dec 2021 17:17:18 +0100
Message-Id: <20211217161718.15767-2-greg@hurrell.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211217161718.15767-1-greg@hurrell.net>
References: <CAPig+cTfL3e28geHMG6aga-1zSSYSgXknQKO-62msn3LO=+iZA@mail.gmail.com>
 <20211217161718.15767-1-greg@hurrell.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add missing colon to ensure correct rendering of definition list
item. Without the proper number of colons, it renders as just another
top-level paragraph rather than a list item.

Signed-off-by: Greg Hurrell <greg@hurrell.net>
---
 Documentation/config/gpg.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
index 4f30c7dbdd..94eba373cc 100644
--- a/Documentation/config/gpg.txt
+++ b/Documentation/config/gpg.txt
@@ -34,7 +34,7 @@ gpg.minTrustLevel::
 * `fully`
 * `ultimate`
 
-gpg.ssh.defaultKeyCommand:
+gpg.ssh.defaultKeyCommand::
 	This command that will be run when user.signingkey is not set and a ssh
 	signature is requested. On successful exit a valid ssh public key is
 	expected in the	first line of its output. To automatically use the first
-- 
2.33.0

