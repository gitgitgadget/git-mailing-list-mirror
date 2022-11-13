Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F73BC433FE
	for <git@archiver.kernel.org>; Sun, 13 Nov 2022 12:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbiKMMs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Nov 2022 07:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbiKMMs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Nov 2022 07:48:26 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AC512AA0
        for <git@vger.kernel.org>; Sun, 13 Nov 2022 04:48:21 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 75C535C00B9;
        Sun, 13 Nov 2022 07:48:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 13 Nov 2022 07:48:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vladh.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1668343698; x=1668430098; bh=l67pcCn9l6
        vU+gm7whuF7XWasnaC+00k/7GHhg9/z5Q=; b=RE8Sy1Pyy5d8ywe9SAr9Ivk+68
        Era2q+ZkfdvnDsrM5WEKibGqWfBMHVbBgQNmEDrxpr83rqpPYiBOfhB4olIrw0CZ
        NP8K4czmNPZDTCthD8AxS5fK+T0JvJg70Uwig/PKJxyQgJKgbrSFhHA9HsV9M9BW
        SDEqDjLRr81dfV5abFJUhYkV5cTVH1fZhNgSDwNS/dQIUfpcdrb2+y1MZ66JQl0L
        GeZZT+GLWOfEr6o8MH8uBhWE+iwu6z5WtTVgMcK7MiHX/TMuW/Y+sCZBJ7yHZ5rb
        vBHTRuzEhtsqEdWVbmlex6+UL+Ec4cUFtRoVdayDU71oYKi0fWjmIJ+W7AbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668343698; x=1668430098; bh=l67pcCn9l6vU+
        gm7whuF7XWasnaC+00k/7GHhg9/z5Q=; b=UE9oz+Eabz093fEq5Ys9hz6ulh6Z5
        9rhCrszmz7w0gM22Rd0JvUN7KlK4vCgQguGdk0yXaaq3h8EL5bQ7PzWgUJLsZCIa
        HUb7ZaEnzXXuIxfFbiVWdXVkoNNnwF2KZJWiz37w/gfUSJyKFriuurOTAnfzxa/v
        2+t8aB9+Be9jMH6IKikqPurFdvR+QWxU/C+4QrSYLzxHgqBdsolWCVjCCPP4JyVs
        pJwoYtgJ4XO52Yq6n4UDLDu8cBIVRaFbuOBLk/lbOPsLwsqTyT8CebfAH0sy4Wwf
        GVMDonl2e6SGQVhNUJ8ArSLaRh/fjAqu5qusjoWDMJolLDs7oLhQO79SQ==
X-ME-Sender: <xms:kedwY817kWdhXEkJsmM-Yoi_A99uC_3XkpVJ-MjTt_aTJwM68ZQ7Ow>
    <xme:kedwY3EAHv0WF3IXOOT0MwO_GV71RAVu4biELqKWEnG4I5wRICy0gwv92A7u0YXyA
    4M8CcnHkbAaUvvoCA>
X-ME-Received: <xmr:kudwY04OuBfEO-q_azUDI4TP5_IhNKA0JFD23uPWjng2Dan5qvMPyZs93SI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedtgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofggtgfgsehtkeertd
    ertdejnecuhfhrohhmpegglhgrugdqufhtvghfrghnucfjrghrsghuiicuoehvlhgruges
    vhhlrgguhhdrnhgvtheqnecuggftrfgrthhtvghrnhepffeiheetvdehheejhfffjeegte
    efhfdvhefhjeettdeftddvffetlefhgeekvddunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepvhhlrggusehvlhgrughhrdhnvght
X-ME-Proxy: <xmx:kudwY12XA4-OJVdhumjRjG_AOYn4B-uVDZT1iNdl5p6m1h-LRrJwHg>
    <xmx:kudwY_HEhIrz6XOdb1LZQ_gH0f0iBB8-Kx5GHQRy4YAcVwp4nscfiQ>
    <xmx:kudwY-_8ilA88ia6LDFI7y-wdebBSv9Gd6OmuyCKdBweb5DL7y2rUg>
    <xmx:kudwYyNnLwvsFh_0oJswKIii1dRYJkN6EkZNJ-j_bU0Mu5O1aidKLg>
Feedback-ID: i03f94506:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Nov 2022 07:48:17 -0500 (EST)
From:   Vlad-Stefan Harbuz <vlad@vladh.net>
To:     git@vger.kernel.org
Cc:     Vlad-Stefan Harbuz <vlad@vladh.net>
Subject: [PATCH] Documentation: fix typo
Date:   Sun, 13 Nov 2022 12:48:09 +0000
Message-Id: <20221113124809.12169-1-vlad@vladh.net>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Vlad-Stefan Harbuz <vlad@vladh.net>
---
 Documentation/MyFirstContribution.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 1a4be8ee0a..ccfd0cb5f3 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -736,7 +736,7 @@ the {lore}[Git mailing list archive]:
 2022-02-21  1:43     ` John Cai
 2022-02-21  1:50       ` Taylor Blau
 2022-02-23 19:50         ` John Cai
-2022-02-18 20:00   ` // other replies ellided
+2022-02-18 20:00   ` // other replies elided
 2022-02-18 18:40 ` [PATCH 2/3] reflog: call reflog_delete from reflog.c John Cai via GitGitGadget
 2022-02-18 19:15   ` Ævar Arnfjörð Bjarmason
 2022-02-18 20:26     ` Junio C Hamano
-- 
2.38.1

