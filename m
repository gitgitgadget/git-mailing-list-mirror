Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2184C433FE
	for <git@archiver.kernel.org>; Sun, 16 Oct 2022 21:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJPVWs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Oct 2022 17:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJPVWp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2022 17:22:45 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD122B193
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 14:22:44 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id E537E3200437;
        Sun, 16 Oct 2022 17:22:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 16 Oct 2022 17:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mcclimon.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1665955363; x=1666041763; bh=KN
        63kFs6N2oVvrOopcI3OQ854cS5tmwFrPiDQ2c6PRA=; b=THILfRLaiXc6O8CxDe
        Rrd0+Bdd39tGrw23Gm4O2dS9dky5j4+/N5Ra7T3g4b4P3y8Gj7tI821uh0s5XXob
        lTdkRNIYi2UvSmKFKFfzQriUUIYfxYmbcFHHu732Agl8oHSo9hq/Capvik6iwUCx
        85tvGPF2HqVil+ejHCCVM1T7WZHbAHDZkcGkwT5iqvycfch5k/TLx2D2qmgXKNxT
        /RfqN4yLfNJSDbMJpaQ1nMEoh+gj1gQRKTa0hoCVIkwfV3f1E4JRkel5yeXnikn1
        oH6tFdULgskfbwYLtKmaSdOaqUQS5lZMHeLE8oUKZE8mK6YYc/gzw5l6fcSPqAx8
        3aXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1665955363; x=1666041763; bh=KN63kFs6N2oVv
        rOopcI3OQ854cS5tmwFrPiDQ2c6PRA=; b=tvty8ZDueD5538QK92iGwDONZDDEy
        nb7fDmcV7NKQAlGQq2nPcFKM4yiFKDjoHO2f9yO4btnqkX/OOpwcUq8VNoQYFDhB
        oYv1/R5EXjQFwkv3XFVrtdHyqWzVv+z3eOxg+D6ImUZdLLAW4uJtRy+B8D3HDFlO
        hJQS7nk7AZhaYr95lcHH1gnqZEY2+RivizqPg2AwiS0mxocbhoMhKvTyezFtYfcr
        StALORRJXErfq0fqMjTu4Y360fyhIMI67POB4IdGeDaTmKOKn5IPj0uOI+MiGL2S
        0rPSbD4aUIpsUst33l4mGzgZyYSL09O1zMwovx4N0BLP24UfbtyCaFCNQ==
X-ME-Sender: <xms:I3ZMY2EMTXOPXXyvh-vhmCZbsTbMeEIcUwe0CDZpA3kkhHV0ehrI8g>
    <xme:I3ZMY3WHTyAsLnlKIKUanhZcBmHsclHJ_uUBA6nG_Tr7LP8o_Oohm70EpXmwRbV81
    qSj4cfBu8FRN5RqjZw>
X-ME-Received: <xmr:I3ZMYwIjzIJZ1DLV9YXkrLwafOxlO-HjbRzNKVYrcNN1WnC2EtCDvX2hkmSE4BtrHbw1By6UiLKs4erPVt74aVo5hzhimJ9sB49i42dgIBNW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekjedgudeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomhepofhitghhrggvlhcuofgtvehlihhmohhnuceomhhitghh
    rggvlhesmhgttghlihhmohhnrdhorhhgqeenucggtffrrghtthgvrhhnpeeggfeuheeive
    fhvdeufedufeeuieehtdehveefhfduheefgeevieejjeekffehvdenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepmhhitghhrggvlhesmhgttghlihhmohhnrdhorhhg
X-ME-Proxy: <xmx:I3ZMYwEgGl9_8sz26NdPrIRX1XK6EUX8M4kmdOt2jQAw7qoQEDoNVg>
    <xmx:I3ZMY8VKEJJ0xLwbB8I3yjSoTr9UeAHLtfbsvI2qMZLxr9wbdkTOFA>
    <xmx:I3ZMYzNwnxhnDn5esErnNRLqU-cHsmyznTPT1lQhLGGnKcBtHaVQ3Q>
    <xmx:I3ZMY1fepRszIpuLQXYnaIoIR9uxtL_Q2H3zX1zYAHoEh46TLcEhsQ>
Feedback-ID: i9dc944d1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Oct 2022 17:22:43 -0400 (EDT)
From:   Michael McClimon <michael@mcclimon.org>
To:     git@vger.kernel.org
Cc:     Michael McClimon <michael@mcclimon.org>
Subject: [PATCH 1/1] Git.pm: add semicolon after catch statement
Date:   Sun, 16 Oct 2022 17:22:36 -0400
Message-Id: <20221016212236.12453-2-michael@mcclimon.org>
X-Mailer: git-send-email 2.38.0.83.gd420dda0
In-Reply-To: <20221016212236.12453-1-michael@mcclimon.org>
References: <20221016212236.12453-1-michael@mcclimon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When attempting to initialize a repository object in an unsafe
directory, a syntax error is reported (Can't use string as a HASH ref
while strict refs in use). Fix this runtime error by adding the required
semicolon after the catch statement.

Without the semicolon, the result of the following line (i.e., the
result of Cwd::abs_path) is passed as the third argument to Error.pm's
catch function. That function expects that its third argument,
$clauses, is a hash reference, and trying to access a string as a hash
reference is a fatal error.

[1] https://lore.kernel.org/git/20221011182607.f1113fff-9333-427d-ba45-741a78fa6040@korelogic.com/

Reported-by: Hank Leininger <hlein@korelogic.com>
Signed-off-by: Michael McClimon <michael@mcclimon.org>
---
 perl/Git.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 080cdc2a..cf15ead6 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -217,7 +217,7 @@ sub repository {
 			} catch Git::Error::Command with {
 				# Mimic git-rev-parse --git-dir error message:
 				throw Error::Simple("fatal: Not a git repository: $dir");
-			}
+			};
 
 			$opts{Repository} = Cwd::abs_path($dir);
 		}
-- 
2.38.0.83.gd420dda0

