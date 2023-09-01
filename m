Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B33CA0FE5
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 16:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345152AbjIAQUu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 12:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345151AbjIAQUs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 12:20:48 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A75AE7E
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 09:20:45 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id EDDC95C01A9;
        Fri,  1 Sep 2023 12:20:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 01 Sep 2023 12:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1693585244; x=1693671644; bh=JpFkWEMpduKWrr8v1N/4dWocQ
        7pF2gIKe01gQl6OwhI=; b=cbOnPudld+a+2TG1sE5NwCV/9V3SJivVwZtQD0u8O
        NHu6dy9rBILeRjck1n/Ip3/KH82nG0ZkygQOGMyBiXdJMxbQVMxHEKcxSy2W3A1z
        wHDzC82zpd3VKORTxRWYIRfwziFViSqtXCw4W+o5FUun6KZVzlEMlCg0PAyU3Jrk
        8KqcgwNjDcKTY4mtRqGIdoGybzlSpUdH+L7yXsiRFNnHA2h7lGlKbR2N3hxwWP5o
        P+pzPuqhBgjGhGBIoZFqv9QKdob/tG8dozDI0b73G0tpG/sogVE12Ab/U1J3tEMi
        arvtZban1lRzmsUiqgTo+MgMKsRuJrY8FYtmSHwp8oLhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693585244; x=1693671644; bh=JpFkWEMpduKWrr8v1N/4dWocQ7pF2gIKe01
        gQl6OwhI=; b=RQs3oXKIH3pLS54fFgQvOj7U62TuNb1lGOotY8YYtjiH6XHKvnW
        gZ08JSQEo2nRqCU6DF9WS3t4TUmUH8So/BQr9KMMMnHXBvNVgc7LBzWkFRBUYi9P
        8/jVZAZAREuN+ietVdP+pyXD8KtapOO8+i4IKimK92gQ6Zowt3zWWQJST3tpLeTk
        He+F/CrWsL7X0itaijCIFOyR9mdPEGHlkiH6uI7GolEsyTLiJFkSzhBVhOtb+xPj
        1NQnrTwBEawO8bHC9GVeo4nN7p3ih4YImFFwSzXl3b/3sK1YmyI5ESl3vhg7m96C
        eaT8Vf9ZPh7dOH8QQp3OOgc9IAJVUnf2Evw==
X-ME-Sender: <xms:XA_yZPZqq6Q6n_lMRlNmeZYNIcJ0e1HDB39Ta5QNCxU7-hlctkEt3xA>
    <xme:XA_yZOaq01UL6Vc6lSm0hRdzoLRdUIEhuf7C-gOi7kN1b2MFl1yQvRTGMYLLxCrqo
    rwPOaPtoQuPbtqMIQ>
X-ME-Received: <xmr:XA_yZB_AEq75bZDgsnD0FpATCQgdTVzZJTxWJjGe2OtsAFQaqAqUyOI4j5P0FQUKM9YLoRhvG6YckrbQSsCkEFKa33DCgYcFMQHwIJDwgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudegvddgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmrhhi
    shhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepueeiueffuefftefhhfefleelhfeuheettedt
    heevgeejteehgfevffeugffglefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvges
    khhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:XA_yZFoTDzr5xT9D5N0bs1S3GgvHFFhSfkcNCWw_Q-n4NAAIy5uNHw>
    <xmx:XA_yZKrdCWNVsRp6CepeHtbJuqBsHPz4rvMTAPSIhrahNYqg4CGQoQ>
    <xmx:XA_yZLS5-E2C2SATFzqpvhcsUKyBoGUUm4WzZJCbBWLyUBUDRVrEAA>
    <xmx:XA_yZNUhExG8hmIZmvYEOqIj6xD_pHyyQCHtEJKzzlH5AbygcLbOjQ>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Sep 2023 12:20:43 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2 3/3] revision: comment `--no-standard-notes` as deprecated
Date:   Fri,  1 Sep 2023 18:19:02 +0200
Message-ID: <80245bbb7e5467c6d4dd056eff9f12b810ba7129.1693584310.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693584310.git.code@khaugsbakk.name>
References: <cover.1686505920.git.code@khaugsbakk.name> <cover.1693584310.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`--standard-notes` used to be deprecated but is now (since 6a4fe606cf[1])
used internally. Its negation `--no-standard-notes`, however, is still
deprecated even for internal use.

Mark this option as such.

† 1: range-diff: treat notes like `log`, 2023-05-19

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    • Move comment: https://lore.kernel.org/git/xmqqbkhk724x.fsf@gitster.g/
    • Tweak commit message so that it's clearer why we are only commenting
      “no” as deprecated and not the other option as well

 revision.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/revision.c b/revision.c
index 64aebc014b..44a04004a7 100644
--- a/revision.c
+++ b/revision.c
@@ -2501,6 +2501,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 					     &revs->show_notes);
 		revs->notes_opt.use_default_notes = -1;
 	} else if (!strcmp(arg, "--no-standard-notes")) {
+		/* Deprecated */
 		revs->notes_opt.use_default_notes = 0;
 	} else if (!strcmp(arg, "--oneline")) {
 		revs->verbose_header = 1;
-- 
2.41.0

