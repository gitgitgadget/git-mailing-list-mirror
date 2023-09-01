Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A9BCA0FE5
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 16:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345132AbjIAQUq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 12:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345150AbjIAQUp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 12:20:45 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB7AE7E
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 09:20:43 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 78F765C017F;
        Fri,  1 Sep 2023 12:20:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 01 Sep 2023 12:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1693585242; x=1693671642; bh=1enFD0WngmeG7+NMz5PRljdde
        HCc153LFVFmXvUwjz0=; b=EjKJT9RYPzGsZ0vOfeAv+LST+iLSyj0c3i1hKERIX
        UVBTWNFy1mBy1lntYn62uZNL4unXrI9C7B5KD2sZ5sd5Hp4BtGPwIsCPBm5myfwB
        Dqt7Dhhqi0hJHBj826MCTGYOg17wVv/NKvKF40zMEocE8Xupg8br84FYplXWOTeX
        9TCI2JqfwPv3W6L/7aEBQbsXQMfQPPPVKhnIG6y1mYimBzufaXNLGOuyeLTUBUok
        AlsdKM7bY4oWp8w/pkiUCG02LvtVwFucvUqzGeHIf5NeZnTiKWM9K5asMVhf7PkB
        kS4xyrF6lJcaUF4RqK8TSrdP7CvWk0BHF3fV9yAOlKOeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693585242; x=1693671642; bh=1enFD0WngmeG7+NMz5PRljddeHCc153LFVF
        mXvUwjz0=; b=t1QpupkkYg2ta2k+BOHpdGX+hhQJJ0ZDuerVhbYGDSwOsMUhAP/
        WSKponYCiulOhXuejU8YRXNrx890sjUEfdvgBeSgru+oR6cehF4U4lhzTJLohOkW
        rzJUDV94p60hzfjkqqnp3QpIM3v/9NtmimqBKVc9I2P5XKsm1UkcWJkBADBmLYJW
        OTgpfvIBZBi4SuYrnEj1SdACA4Ylvfaf+/L5XDeqEjHM0AEKE7+VFixJJJww9gnE
        +43gfi1FeG9niIItkIDpFztMJqcx6jghCvALB+FBJPQB9l/W80GGT2AaxoVspOyI
        Z6H25m0EvctwpTo2raKx4nFt98i/QyX5tRg==
X-ME-Sender: <xms:Wg_yZMtwZ9MZIAty-k_HO4DD5K3MugGob-2W_tTRE1_xkup8GB0vRaY>
    <xme:Wg_yZJeEez9QD8-9_8S2GYucDD-fCd2sCQ3UbQgJAvtyWUdu4W_AMVSvg3K-VWQvy
    3W1tXxyocDWmbEL1Q>
X-ME-Received: <xmr:Wg_yZHx2SyXWpIXI2N-1TwHwLIsNwuC7AKDFvZ_FncZQkbw8k_psb7zE4rTj3aDVSFcX_H8akNUFT680DpK4ShGbj_JpEkgHqVLL5O8a0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudegvddgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmrhhi
    shhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepvefgleevieekgeejieekueevhfelieduvdel
    geefkeejtdekvedttefgffevtedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:Wg_yZPNGyLQWflOuDEi1s9j809lXJSizoy5LSXVlVFS7XzxcwgkvuQ>
    <xmx:Wg_yZM9LTEcHc7vp7iWkEFHi3wIN77H2vYB6Kv7EAvdY95zfB-irfw>
    <xmx:Wg_yZHXdUs13ImwKXsq4S6D81AWb0bw0L3tL02DLDfNN2fbSlEx0Hw>
    <xmx:Wg_yZLacy4FcvvxdXmHCirvIs7gUrwqA4b1uILZEUcoOMyivhRl4NQ>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Sep 2023 12:20:41 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2 2/3] doc: pretty-options: remove documentation for deprecated options
Date:   Fri,  1 Sep 2023 18:19:01 +0200
Message-ID: <f7308b7abf767828c8c387704dcc5dd775f1c066.1693584310.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693584310.git.code@khaugsbakk.name>
References: <cover.1686505920.git.code@khaugsbakk.name> <cover.1693584310.git.code@khaugsbakk.name>
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

