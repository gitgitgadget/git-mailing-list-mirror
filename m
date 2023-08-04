Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663A0C001DE
	for <git@archiver.kernel.org>; Fri,  4 Aug 2023 17:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjHDRNh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Aug 2023 13:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjHDRNg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2023 13:13:36 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC03198B
        for <git@vger.kernel.org>; Fri,  4 Aug 2023 10:13:35 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 844B25A336;
        Fri,  4 Aug 2023 17:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1691169214;
        bh=omAEOJkhJ4BGsbHCE9VbgdZVKccDwbKz7kIFRIgDbaU=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=0C/7hfaxFB3CGjyeQ0OC7B2Tpzk3oTzVrCFf9YOv5kAHURdB0NjSO8J+NEO98Qy3I
         bGLaRD4PC+t50B6IwgQ2J+4Y9NMwrDsOYREP6jLj0gXRLw353b9zHtLebNmlDqatlh
         OIN69/hRFjwGau7JknuJcyJ3VmUV/mMI4Fax0Ga553zfzcOZmGts/GLHX2qFlitekd
         uoXKhw88v26OPsBNllGWzSLF5hb8d5OZO9pk8Mco1z6GWJ33GTkARDEeOlS65AHmwS
         poQdY3iovMzfK9/Rz2M59Onp7XBCAyozmpvVsdlJ3ri8DzC2uWGg3nncsgTDS08Pvn
         3M9Cg8d18TA1xh7vXvOlCXr84KvV4oaFYApwn3OEdXpm4X8u/E9kpnJxSPHnPqtLBP
         EVsKyjUTOs1aasDXa2rs/6MdmtGv8tZ7bcHY5cttlhEJx4qJdq6RzvT3fwuigtRmcw
         D62zXiCWcQYYLZfOQsnRvWnZ946D9xU04JkZX/qF1EbA3+7JVHc
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH] gitignore: ignore clangd .cache directory
Date:   Fri,  4 Aug 2023 17:13:28 +0000
Message-ID: <20230804171328.1737188-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <bk2204@github.com>

In at least some versions of clangd, including version 15 in Ubuntu
23.04, a directory, .cache, is written in the root of the repository
with index information about the files in the repository.  Since clangd
is the most common language server protocol (LSP) implementation for C,
and we already support it using the GENERATE_COMPILATION_DATABASE flags
to make it functional, it's likely many users are using or will want to
use it.

As a result, ignore the ".cache" directory to help avoid users
accidentally committing the data.

Signed-off-by: brian m. carlson <bk2204@github.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index e875c59054..5e56e471b3 100644
--- a/.gitignore
+++ b/.gitignore
@@ -222,6 +222,7 @@
 /TAGS
 /cscope*
 /compile_commands.json
+/.cache/
 *.hcc
 *.obj
 *.lib
