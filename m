Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481D5C001E0
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 20:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbjGMUda (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 16:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbjGMUd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 16:33:28 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904A72117
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 13:33:27 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 09B9F5C0175;
        Thu, 13 Jul 2023 16:33:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 13 Jul 2023 16:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imap.cc; h=cc:cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1689280407; x=
        1689366807; bh=vd32e6CITefvYxcdqjmc8u6lKI9WjGlWxD6ipXfFnoQ=; b=e
        PaSnPvFQLYAcpLvd6i5xgFK1wM+1KlcWBk7gUDaQpjYqmbRQXipWHYaM51XZCGfF
        QcG7ChRzlsluULwNnSl+NXEpciz3d1uZnAp54m+XsUJk0lePhia9DrbMD336mED0
        V/A/VV6DOF7gsYW9VTwCup/2OSPHjNusYLA6Ob1ixjoHO8QGDNqK3/7UzE5p3NMb
        22lbqFNv8T6AvKSW+jrs7Pz8GsuRsvX2Oz2JAwJ7zuCjOTt36j3wqm/pjqKcG4YP
        rU4Tt7X/LqT+VUmdKs2VIqaeEi6t+em/T4j9BiUuFuF9+spxYp6qBEHStLjQ/oqF
        Yw2gbY8+h9BpRdUFgKwEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1689280407; x=
        1689366807; bh=vd32e6CITefvYxcdqjmc8u6lKI9WjGlWxD6ipXfFnoQ=; b=L
        mi02H+KHQOxz1jFv+j6wGuy4ldQKK+hX99Z8F7cO6yig+a8QcuKK34OkqWCAtZFB
        Orpo1JXJ6SKA641Mz02fd+pO2BZJGmZUSPn7GI3SNadrm55SEDAqG1cHtUry6EzL
        iuzHGtgYnwbeOBRbEt8rzEJw4UTYIABRbv3DG+JyFNRSaPjT5Qm+Co6OvTIh/GNz
        AEtNRhlPHEGjoaniOdUT/bILZah4l6afD44p7cwxlfpQHqU3iIvfYgJDxtONqHb6
        RvnQhAk/mw801XsQ2oao4l7+MO1RhOGfQwzJG3TVy5bHlFNjKq9NVWHrRAYELt9q
        h1xj3X9qy8zo0wCBdY8ig==
X-ME-Sender: <xms:ll-wZDTyG9vRiHLuEcEw3mC-DvFl2--pDTkFa_zVMlkUrpgcvVrsjg>
    <xme:ll-wZEz0Zg7k0pe4Y-lxySAN6-_UtpIbrU7gzgII9W4yBCFhUfamEGkIQoGw4xor4
    GJ7mxuabG-vUOwUoA>
X-ME-Received: <xmr:ll-wZI2kwrbxYJUXVCbVluyH2xOI_bIPmu9Le8-7aO857WlWu94VTGhSepHKRGwQCRon5GguTrLAJFNc4-bSQAcKjV3_iArFeJA4pEkQ_m0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeeggdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfedtmdenogetfedtuddqtd
    duucdludehmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhr
    ohhmpehpvhhuthhovhesihhmrghprdgttgenucggtffrrghtthgvrhhnpedtuefhvdfhtd
    eugfffieejieduheeiuedthfevtdekgfevveejjefhffettdelieenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpvhhuthhovhesihhmrghprd
    gttg
X-ME-Proxy: <xmx:ll-wZDAqlu2QxkvvkLfdezgLvPMniqMy-hVA23d2RzoUp1nUYkhJnQ>
    <xmx:ll-wZMjaWtO_WPsCaXwc-XunTaWCPEj1Y0OdJHByWb1LyJA4KzygXg>
    <xmx:ll-wZHpzhT92Em2X7_MboPgiQR6VieIeGKBX-4YPBQS1J2skYyHgXA>
    <xmx:l1-wZIZL1uhkMqtp-4coqWsB8qiQHhTqDkYmwq0m-FCwcIWuBnChrg>
Feedback-ID: iccdf4031:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jul 2023 16:33:26 -0400 (EDT)
From:   pvutov@imap.cc
To:     pvutov@imap.cc
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH v4] docs: highlight that .gitmodules does not support !command
Date:   Thu, 13 Jul 2023 22:34:21 +0200
Message-ID: <20230713203421.1061589-1-pvutov@imap.cc>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713193342.1053968-1-pvutov@imap.cc>
References: <20230713193342.1053968-1-pvutov@imap.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Petar Vutov <pvutov@imap.cc>

Bugfix for fc01a5d2 (submodule update documentation: don't repeat
ourselves, 2016-12-27).

The `custom command` and `none` entries are described as sharing the
same limitations, but one is allowed in .gitmodules and the other is
not. Instead, highlight the limitation of `custom command` only.

Signed-off-by: Petar Vutov <pvutov@imap.cc>
---

Changes from v1:
Don't delete the documentation for `!command`. Instead, highlight
the differences in the limitations of `none` and `!command`.

Changes from v2:
Improve phrasing.
Add the bugfix blurb in the commit message.

Changes from v3:
Keep the description of `none` unchanged and just move it up.

 Documentation/git-submodule.txt | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 4d3ab6b9f9..b3303afb8f 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -160,16 +160,14 @@ checked out in the submodule.
 	merge;; the commit recorded in the superproject will be merged
 	    into the current branch in the submodule.
 
-The following 'update' procedures are only available via the
-`submodule.<name>.update` configuration variable:
+	none;; the submodule is not updated.
 
 	custom command;; arbitrary shell command that takes a single
 	    argument (the sha1 of the commit recorded in the
 	    superproject) is executed. When `submodule.<name>.update`
 	    is set to '!command', the remainder after the exclamation mark
-	    is the custom command.
-
-	none;; the submodule is not updated.
+	    is the custom command. Note that this mechanism
+	    cannot be used in the .gitmodules file.
 
 If the submodule is not yet initialized, and you just want to use the
 setting as stored in `.gitmodules`, you can automatically initialize the
-- 
2.41.0

