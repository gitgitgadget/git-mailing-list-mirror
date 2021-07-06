Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E6BC07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FFFC61C94
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhGFVAh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 17:00:37 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:41857 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229781AbhGFVAg (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 6 Jul 2021 17:00:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 684C432007F9;
        Tue,  6 Jul 2021 16:57:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 06 Jul 2021 16:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=furrypaws.ca; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=/DvXM314rg3oo
        o+DmNH2JPLUT+ENNmo40PX/DZbCCus=; b=dd+6SaJPTCSZO3x4KHn2XUkdyKI3D
        OAgr82NzPEtLVOODZOZpb6fukSAUnyji0jo2HEFzB5nQ9V2y4XurPygWSM+a3Kfz
        BhPxnVdjSHeQEB1fUK0bymd6lGeFVBk0v8djVOOaQPUN1GpJVdI4CSSY9ZgGs9Iz
        yK+w7WGM3HW5QrC564zG0Vddhk+Nz7Q74JbJxih4WHnP1ChCxIN8Rq/M+r43xlPW
        UPwxyJQzpe5ynxc5AUN8FPFSepZMQs7Y1Qj/8OTbpI9AasRCgfvlhNOGRo9dCzPK
        EgbLD5hgwYNZCa03h8EKuLQx7teBiE3PAItitzREGWT0y6Mj5dscN9uqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=/DvXM314rg3ooo+DmNH2JPLUT+ENNmo40PX/DZbCCus=; b=Vh/iaH1O
        P2Z4HFQC3Vaxv8fETeOGX21qLLMHFWSpX1ftCQBIBV5eozkwEiVidnfDGiDW0imn
        yyL1lxLFDjXDNHVtSHRmIFQxG1HjnFqZmCNobvnf68evF1tgGCbPHu35sgaGc4n8
        udMQyKkcY6kC03ikrMuQydovjFeVAtVghsyhFdCWgvI2CJiJnjNtVuS6JqPmOfZQ
        7EeCldPMQMoPqVD9+2VyJ+OINLJLTXIHgT82TPnpvtaula8BwQhj/ATd5LJvLq5R
        P/iSe8Vf8aRiw+fFasNRYEJzKQeBjPsZstj/lm2vL9ve88UmkNae/yI7uVTyfZIX
        GxufOvvyRkgMXw==
X-ME-Sender: <xms:1MPkYKcfjWQ9n102QxhsD_T6g3seC8gEb7tJMVatpA_n6AsSZtyztg>
    <xme:1MPkYEOgcOIu3ONDycNfVb2RGaopH1DKRE8xzZ18WqpOEsKDyCwY863WfltHfGM7T
    VhL3MM_He9N9-jBtQ>
X-ME-Received: <xmr:1MPkYLjGFGkJOyDc5vlLaS4ycgoyPHq8y2MYkTOHVALMAXEL8H-NxkbYB29WCFCaPmxkFI2cpJ49i1hSoW9T1m-fCGr62CUD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrtddtgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifuceuvghrrhihuceorghnughrvgifsehfuhhr
    rhihphgrfihsrdgtrgeqnecuggftrfgrthhtvghrnhepgeelgfehtdeiveeuudegueeike
    ejvedvlefgkeekleevkeejveegjeejteeugedtnecuvehluhhsthgvrhfuihiivgepuden
    ucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsehfuhhrrhihphgrfihsrdgtrg
X-ME-Proxy: <xmx:1MPkYH9Y5W5TV0MxmSJdzqa40ye9XGWkC7RQelf89v2cA83BdIN11g>
    <xmx:1MPkYGuMgDjlSaDM9YpDkEk6qZIRlwPgGMmMY5aqZCflpPalhhSbZw>
    <xmx:1MPkYOGHbkoM8a4wqF91ngQf8zVEPIuOOFAdhJ81UuasKTjvTaqUdQ>
    <xmx:1cPkYKi8LUVu2yXHoYK9RLVabjy8bZX4S1Wpx6GCdQIuAxzkvb0l-g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jul 2021 16:57:56 -0400 (EDT)
From:   Andrew Berry <andrew@furrypaws.ca>
To:     git@vger.kernel.org
Cc:     bagasdotme@gmail.com, gitster@pobox.com,
        Andrew Berry <andrew@furrypaws.ca>
Subject: [PATCH] docs: .gitignore parsing is to the top of the repo
Date:   Tue,  6 Jul 2021 16:57:12 -0400
Message-Id: <20210706205712.75270-1-andrew@furrypaws.ca>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210706205439.75015-1-andrew@furrypaws.ca>
References: <20210706205439.75015-1-andrew@furrypaws.ca>
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
 Documentation/gitignore.txt | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 53e7d5c914..af8f231cc1 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -27,12 +27,11 @@ precedence, the last matching pattern decides the outcome):
    them.
 
  * Patterns read from a `.gitignore` file in the same directory
-   as the path, or in any parent directory, with patterns in the
-   higher level files (up to the toplevel of the work tree) being overridden
-   by those in lower level files down to the directory containing the file.
-   These patterns match relative to the location of the
-   `.gitignore` file.  A project normally includes such
-   `.gitignore` files in its repository, containing patterns for
+   as the path, or in any parent directory (up to the top-level of the work
+   tree), with patterns in the higher level files being overridden by those in
+   lower level files down to the directory containing the file. These patterns
+   match relative to the location of the `.gitignore` file.  A project normally
+   includes such `.gitignore` files in its repository, containing patterns for
    files generated as part of the project build.
 
  * Patterns read from `$GIT_DIR/info/exclude`.
-- 
2.31.1

