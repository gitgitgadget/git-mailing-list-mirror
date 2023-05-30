Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764FAC77B73
	for <git@archiver.kernel.org>; Tue, 30 May 2023 10:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjE3Knl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 May 2023 06:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjE3KnX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2023 06:43:23 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5A5129
        for <git@vger.kernel.org>; Tue, 30 May 2023 03:43:10 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id CF88332009B3;
        Tue, 30 May 2023 06:43:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 30 May 2023 06:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1685443389; x=1685529789; bh=HxHgms+T1t0JKEllsLURjpclD
        02V/XJ4wlbJSf3Ejhw=; b=x+kqPaJZ7uj8UwxRKLk3FMTA+ZT5ABcdg0QRoSq9c
        MjdQ4wEBdZ+ksOGQq4giIThIFH18H3FgULtI1jzPngQJPw9B8+h4SIItiTz88nUs
        mNEan7boeapXMB9gTbpx6atK6fZXUm+YjEgbYFBVmDqv/GH48U+a/pZFn+0P3Dkr
        C11p2WT1wYn8/JXHye9E7fCfVoxmtyuFXw5BHbs9rBAMz5OgJFrCrpA68uncCJ3U
        BEAOj625Z73SzG1bT0JpKgnJM3eMKCYREW5fhBJYZpZpefL+gGy12tNxE7yAO1iO
        QqE8crttBeoll0Dohsnje5vYI6tBLWGnMGEm31U25zd6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685443389; x=1685529789; bh=HxHgms+T1t0JKEllsLURjpclD02V/XJ4wlb
        JSf3Ejhw=; b=O4qEmOfrDf44iy9A5EzcE+ch1MSItwqnfPrC9mfp36EVFH+2EPs
        XzwNZNfq2PM80a5fowDBrbaPMQ91ldsGOQPBhuEKDR25jgrRZrJJksK/JPM74xyn
        S9ZpQvm2cchcq6Hz5CaVAQnzvAJkLR7JmTplxWCAYKXAi/poEpqT48VAQpGdYYsc
        BSxT8JT0KdlWPmyKppOrPXZMwVIOHGB/PnLIowZ6SLeJIStdYImaVAtsu1a/bTeK
        Q4r3bavpnuCFg47sB8KmZfumreI0iDbGekqaJCZ8k6FHC26llyJG3VsGk1fxXSTh
        UzNzBLJ9bVnJ32u74wEpdvOfbQDekTr/DIQ==
X-ME-Sender: <xms:PdN1ZLDoZ5dhzMD1-X8i22z_l9faEjUxiBdoDjI2J5FSD2qK3BMVYug>
    <xme:PdN1ZBhPgjzEtSdwdeEbrnKuQv_jeNkYCvGKQ0rKqF0X9kKWmenj42Q7DcNP9KYSJ
    IshkclL-zgbPV2vZQ>
X-ME-Received: <xmr:PdN1ZGmVC4gRZheWiGBvs5PhKnJ6JAdt9Wi3ofzUKdifQqVHpkdU5UUPhj363WakJrTeTLRvQ1ZTvyeQO7YpY3_OS0Y41OPZzHUGBxYSFnjApAB6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmrhhi
    shhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepvefgleevieekgeejieekueevhfelieduvdel
    geefkeejtdekvedttefgffevtedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:PdN1ZNxf2mSWjaxR3WMjfbttSh8RhH4t5YVkNfGJ6MwIoYf4wY6mlA>
    <xmx:PdN1ZAQ9LoYOgamX00YfoQTJzjZw1huxWDrnaoQqTSUtaWtrBXQZvg>
    <xmx:PdN1ZAYvGOW0UiRVMdNT9ABch065ccpDFGSPjEENrH2NMJZQ6EhXzw>
    <xmx:PdN1ZGcv2fgHDNVrxVlIS4CuPofmzL1fzq2nLUKEO3IvoZ_4JVyb6g>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 May 2023 06:43:08 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: [RFC PATCH 2/3] doc: pretty-options: remove documentation for deprecated options
Date:   Tue, 30 May 2023 12:41:30 +0200
Message-ID: <8fa6600ae84096d8aaad8de387015a9352702d9c.1685441207.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.41.0.rc2
In-Reply-To: <cover.1685441207.git.code@khaugsbakk.name>
References: <cover.1685441207.git.code@khaugsbakk.name>
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
2.41.0.rc2

