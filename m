Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B174C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4571E61C9A
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhGFU55 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 16:57:57 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:53103 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229781AbhGFU55 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 6 Jul 2021 16:57:57 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 879BE32009BB;
        Tue,  6 Jul 2021 16:55:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 06 Jul 2021 16:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=furrypaws.ca; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=Mqfwb09508S6h
        DeYzdyWqxVrdBXdN2WIQZLZ69UYrgM=; b=V0+FCWMk/pNlcRAPp1aRtc9Qochhl
        f9vV/CCe9KdAyKXVibL7ECiWPeB/GI2BWL1TDU6WUpNcaKHebVBI/PCDLQp2Xcp5
        xK0a9by3pE123/7gFYZEEWlsj584RH6NXm/LY7liyJOUDfj70uQKhVZqb55hkkSP
        bt/shARLIl/ROJi+aLW1zq1LOsBP88Z98T0M6h8EEsBWDLD2ewNkTEmzPcMtrkqw
        7tpBr9ydQUPEar+ZDlvCu7SJJr5Xu6s0eD37cbvMUCInzPi+MFgW0wPn+tOshb1z
        hqw//NIs2Icu05n6BVKqt0hnik3VRAenI4sGDwt1INr0VQM/mrQJVTcrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Mqfwb09508S6hDeYzdyWqxVrdBXdN2WIQZLZ69UYrgM=; b=ufSk/jM2
        S2ipffmRabGIp680rqSoRiUQobYUNNtVTVkSO+ax7M1jh8u+vxW+f9YJQAXShrfW
        +RGRGgIPPai6fRawv39oI6NDKeS3yaquNwEp9JD/qUJ6N1By1yfb+KJkm8iJBveD
        Kdr8l3O5NXy+L5AEvtqZB09h7W1M2QuT72ij7/TJC1AOiyJnq+b1SixbayPlIPrW
        /FQnVlMGy9hFp9W2R96j6j4O6eqjA5CYYwIMND6OGoYwPg7Nb0Ro12lE5xNy+b0U
        9C/OeuXHvZZ93zQouGM7n2h7Pxc8XM8JozZJZX1ywKZAs6HNfZmUkm7aHBcvgvXt
        FkImaalP5lIVMQ==
X-ME-Sender: <xms:MMPkYC9wexhWKX5xX5AaCGxVnTdBXF9iLzEitr1nvPxGnxJDBhzO9Q>
    <xme:MMPkYCsao8iYXHZ6klbLV3bAO4T5tnBPQRHego69Ut0NrEFEiRG65wyHobIisOaWn
    lT73pF4ahmjl7ZU-Q>
X-ME-Received: <xmr:MMPkYIAe-VfWkTVJFLXg7LSlnKX3ZqBlDVuQedZzRyE1DPY7ifwWCqwwRNjtf7qI6uBAyj5xJaQT1koI4XXnFYfCBW51ThP4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrtddtgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifuceuvghrrhihuceorghnughrvgifsehfuhhr
    rhihphgrfihsrdgtrgeqnecuggftrfgrthhtvghrnhepgeelgfehtdeiveeuudegueeike
    ejvedvlefgkeekleevkeejveegjeejteeugedtnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsehfuhhrrhihphgrfihsrdgtrg
X-ME-Proxy: <xmx:MMPkYKdoXKllh49TbUrGbcqc-pkwcnfUr_L8qO57TGvT2x8XIauGoQ>
    <xmx:MMPkYHNdlqrcU7uYMx0CO2AP0baNlpvaAxtkxTpIA4xw7HZItVlbqQ>
    <xmx:MMPkYEm45RqEK8Y1B4QIReA4N6hpeuYNHUFMqeNuoY8tQx_QrkSBtg>
    <xmx:McPkYDA_8U7JMlftmiKOPjLA3quOQdfRI92GjFc9oBP8bJdYcqXEUA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jul 2021 16:55:12 -0400 (EDT)
From:   Andrew Berry <andrew@furrypaws.ca>
To:     git@vger.kernel.org
Cc:     bagasdotme@gmail.com, gitster@pobox.com,
        Andrew Berry <andrew@furrypaws.ca>
Subject: [PATCH] docs: .gitignore parsing is to the top of the repo
Date:   Tue,  6 Jul 2021 16:54:39 -0400
Message-Id: <20210706205439.75015-1-andrew@furrypaws.ca>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <xmqqczrvl8kl.fsf@gitster.g>
References: <xmqqczrvl8kl.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current documentation reads as if .gitignore files will be parsed in
every parent directory, and not until they reach a repository boundary.
This clarifies the current behaviour.

As well, this corrects 'toplevel' to 'top-level', matching usage for
'top-level domain'.

Signed-off-by: Andrew Berry <andrew@furrypaws.ca>
---
 Documentation/gitignore.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 53e7d5c914..534cda5747 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -27,10 +27,10 @@ precedence, the last matching pattern decides the outcome):
    them.
 
  * Patterns read from a `.gitignore` file in the same directory
-   as the path, or in any parent directory, with patterns in the
-   higher level files (up to the toplevel of the work tree) being overridden
-   by those in lower level files down to the directory containing the file.
-   These patterns match relative to the location of the
+   as the path, or in any parent directory in the same repository, with
+   patterns in the higher level files (up to the toplevel of the work tree)
+   being overridden by those in lower level files down to the directory
+   containing the file. These patterns match relative to the location of the
    `.gitignore` file.  A project normally includes such
    `.gitignore` files in its repository, containing patterns for
    files generated as part of the project build.
-- 
2.31.1

