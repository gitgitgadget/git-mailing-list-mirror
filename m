Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D77C7EE23
	for <git@archiver.kernel.org>; Sun, 11 Jun 2023 18:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjFKSRW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jun 2023 14:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjFKSRU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2023 14:17:20 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DBFAB
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 11:17:19 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 2B572320090E;
        Sun, 11 Jun 2023 14:17:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 11 Jun 2023 14:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1686507438; x=1686593838; bh=1enFD0WngmeG7+NMz5PRljdde
        HCc153LFVFmXvUwjz0=; b=u/RyLiiZKdSUhLczXkh490AY1mOdwHJxpbG5ycGQt
        QQPnEU0Qhj7zil6eWCm43b11bPhmotHhdDqWX84AGcKBFFjou+qznDs8+AI4sq0b
        XHGLC7KvWigcGxNU9LjutVjyF9iptJmP1/BauExrUrnL4MVR4KauqaUsbxYomzhe
        jA6LwWw30mEsBIASGGXXrLQiK4wW2yOcGFaL/cszPQDShLsCfLuggi4e3I2nnoh5
        WjjERAjhIFGFEVHzXZ0OEvfpMtpyDC/zVJhfn6A2vgoSTE+OhC/xOoYaZNFcCm1o
        KRF9e5v4Ofxr8B6NNXgx5pCiZUhqtFc+iGpZh9j+BBXbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1686507438; x=1686593838; bh=1enFD0WngmeG7+NMz5PRljddeHCc153LFVF
        mXvUwjz0=; b=AP/maeMNJyUuMV7QUsxt0NoV3YBjRHzZ2w1AKjOt3/yGqjLV9D/
        QsbRDRnVKSgf4XPCuoFtbBcJ4CTexod92GwdhvgBytehFrzcy/cdigi9uo6+vT8f
        E9pX3Mo1sX1LADRR5oocOw/NGp5vhRqBXBxO9cG1XpdqYjEceq49YABTTVcg/3bh
        AdIuK/EoBiKf1/pqblD0Fo9/zsqX4BpLAlmlAY9vDG2gYa0ymHaFm9Dq2KtVaB/O
        e3keat8937whOC7cbw0z/C1u3eJiSiIKt4OlUhQgibF5jXwFExPE/HsqhLQIV8qE
        TYXGdJUiFJ6sfXyeCYKSZcZIodSLk1nxG+Q==
X-ME-Sender: <xms:rg-GZAr9X_ExIBhYcQmITe9lpGzpzsMRagrMPsDt9_SyJQr9b6lsqbk>
    <xme:rg-GZGrVYzy8zqQIA9yfZmP1N3z9vatFSvWH7xdE4biV5V4vo_E1lCQuDZ2RinS4x
    3wGJMiy0zZfqUdGwg>
X-ME-Received: <xmr:rg-GZFNyVwlxcC_eVAfXeBV9L7SRzQQNdGSod6XdTOrNQDLJyPnknQI2NIwsviaWrZO1VSHDNLYKIuObeUDyCWO3yiDsTSmS_gOb-8suJPdONswEdwY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeduvddguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkuceotghouggvsehkhhgruhhgshgsrghkkh
    drnhgrmhgvqeenucggtffrrghtthgvrhhnpeevgfelveeikeegjeeikeeuvefhleeiuddv
    leegfeekjedtkeevtdetgfffveettdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:rg-GZH6rWS7BIoIp64bc5Ut8e9gK1-Asu2Xe_ws9msd1we85BSZbvg>
    <xmx:rg-GZP78rORPMcYchdquFz5ENtfBynnob9C1kXNBKfXIxNXfuuEh1g>
    <xmx:rg-GZHiIAsjnJ0-51xZtqLX4Gq-VBoCd2hvggDTwdYdlF9injyILpw>
    <xmx:rg-GZBmFFoJnWmNjOyd9p_olkI-OQ96Ouicj7k54razKxI5r-egsjA>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Jun 2023 14:17:17 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: [PATCH v1 2/3] doc: pretty-options: remove documentation for deprecated options
Date:   Sun, 11 Jun 2023 20:15:55 +0200
Message-ID: <fbc1c47b92070de4f5d8fee1d031853fe0195ceb.1686505920.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1686505920.git.code@khaugsbakk.name>
References: <cover.1685441207.git.code@khaugsbakk.name> <cover.1686505920.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove documentation for options which were deprecated in
ab18b2c0df (log/pretty-options: Document --[no-]notes and deprecate old
notes options, 2011-03-30).

We now use `--standard-notes` internally for `range-diff` (see previous
commit).

Leave `--show-notes` as-is since we aren’t changing anything about it.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/pretty-options.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index dc685be363..8c982609c9 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -88,7 +88,6 @@ being displayed. Examples: "--notes=foo" will show only notes from
 	from "refs/notes/bar".
 
 --show-notes[=<ref>]::
---[no-]standard-notes::
 	These options are deprecated. Use the above --notes/--no-notes
 	options instead.
 endif::git-rev-list[]
-- 
2.41.0

