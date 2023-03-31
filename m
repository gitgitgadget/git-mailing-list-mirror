Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6887BC76196
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 18:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjCaSN1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 14:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjCaSN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 14:13:26 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7586FD52B
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 11:13:25 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E275B5C00AE;
        Fri, 31 Mar 2023 14:13:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 31 Mar 2023 14:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1680286404; x=
        1680372804; bh=kFRlj3FrcBZBMmTOrXeDHIZbFiEA9ziwGeikLhYIsqk=; b=U
        IqiTSMORrhDsyIV6tTOT/Ihky8m3Uty+FldFwKL1tkvLYyo7nByjHSBWsoMHn8EH
        cHUDeJua3H4SlCQeY7qeKb9CJ7x5Cf8DjXh7IdKXc/WPkufF8c76ozGbhsidj79C
        URIJxSsBoMV/Q+GeQK4B6x2R+iJ0n6u55vrBQxhif4myW/l2iPweA/JwLctnbwi0
        oxmttn4DcZlTGkVyfVwSCaVIb+8ZiSg2TTMQIPQKAUXlPzivjcBPZe+72WsA2lk1
        h1qIGxTev7s35CVoxB1JVI0uy9LPbi0bviiwNefF89lxSATfUft910+xq4KuLxFb
        ao/UFKND+IJBegGS+p18A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1680286404; x=
        1680372804; bh=kFRlj3FrcBZBMmTOrXeDHIZbFiEA9ziwGeikLhYIsqk=; b=D
        sGnOd4Ho8Pvk4elxJc50GtArcaDrTcXEW/+oX7SXGEAVcxyKFqjzWnF9ykEs5GWY
        kqzVHn+EPqm16vtH2TxtB+mBqnJomX1t0j5JK9aOqG47l2xx8u70x7xrzkLxmGw+
        t/CI0/kP9XZuWsyme9fpHjQL5vVkSoSrRmra1Pvvv165C0ExkTmkP6fD2/LZaqTJ
        QadPU0FjZuXcbzyff8r3SQvCLe6NJ5eNc5mQkiEXqnvoSChhEtTRp5RjoVXouQWa
        DCvez826rZUdiEOyUCQFbr/D/QP/c+nb8wn8C0r2uGG2Guyufgr/7Sfr9DwJrjv4
        wOW1oIFlCTJbsg4RJOCHA==
X-ME-Sender: <xms:xCInZPTQdeK8SpSv6u8aujt8ZPr9SqjS-CuPVNPi3Lu74MgmH9BJmg8>
    <xme:xCInZAxMy8b6fnZQjYdYeLmOTyw8_RzuivyX78zGqQdsxhQ4QHvTZeoHBcjkzeJIP
    -9O6OfuuFLGyPMqJA>
X-ME-Received: <xmr:xCInZE2BUsX_45Nf1Dl0P2rwq2vHBbvOmrJbKHBE08Q-86hHivD0uzPuyf28CplZE5IehMZ5Zi2RGZjdXHq-PkEETj1Jo_vaYjp_Bht-3mewt0myHPE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiuddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeetud
    eiheeguddtgfduveekhfevudeiieetjefhffetiedtgeejieehtdfhjefgteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrg
    hughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:xCInZPCnK2IA_ksNo-umOVlJbQYSalEX5Mqs84kMbq899bj3AGU2vQ>
    <xmx:xCInZIjl-zKYnzSO91JhkCnWOYuv6MccbKjXZJV4eWvciTU9WSqUVQ>
    <xmx:xCInZDqHvw92JV9P9F30Sae0TroOB-c8fhq7BYeI01DkuMrRf4KEqA>
    <xmx:xCInZAKbX1l2ZAYnaBLgL-QC9UBRgRA24-jP94ftsTsA2PMuv9zQBg>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Mar 2023 14:13:24 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 1/3] doc: interpret-trailers: remove trailing spaces
Date:   Fri, 31 Mar 2023 20:12:29 +0200
Message-Id: <20230331181229.15255-1-code@khaugsbakk.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230331180817.14466-1-code@khaugsbakk.name>
References: <20230331180817.14466-1-code@khaugsbakk.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-interpret-trailers.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 22ff3a603e..787332771e 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -408,9 +408,9 @@ $ git config trailer.see.ifMissing "doNothing"
 $ git config trailer.see.command "git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \$ARG"
 $ git interpret-trailers <<EOF
 > subject
-> 
+>
 > message
-> 
+>
 > see: HEAD~2
 > EOF
 subject
@@ -429,9 +429,9 @@ See-also: fe3187489d69c4 (subject of related commit)
 ------------
 $ sed -e 's/ Z$/ /' >commit_template.txt <<EOF
 > ***subject***
-> 
+>
 > ***message***
-> 
+>
 > Fixes: Z
 > Cc: Z
 > Reviewed-by: Z
-- 
2.40.0

