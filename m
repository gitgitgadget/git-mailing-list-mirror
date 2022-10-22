Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EBBC38A2D
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 01:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJVBUN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 21:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJVBUL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 21:20:11 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD669DDAC
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 18:20:04 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D5BFA5C00D4;
        Fri, 21 Oct 2022 21:20:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 21 Oct 2022 21:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mcclimon.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1666401603; x=1666488003; bh=PN
        yJWGcyU5D1GMcfCQpJ9WIiIrBIcghEeyWy0Pxcweo=; b=HB6NLlgrh2b96OfBc5
        CXVAX83iysps0RV3PaBo+K3ihA03xwY5ehnlDoadTfMPEyx2bCQx0OwTKCslEe/y
        UnujRzm/Ya/yWZXsieHCyXCenyCbXZWPoGMxN2dcnVMaTOx3Ia7j5T9Mc8sreTM5
        s+c5JyQyZKl0heK38LRvUrjcoJs8O07ssl1Y2WBvriQR9AlJqta9mDFfxVx+J6uc
        0LeC2dRuJzqm9soP0QottrlBVwXoOhF7i8xIzclWT2IeifFsc3vzuJfKhfHIT7ae
        J1hQR81RJ9EM8PkC8UWXBtUV8xXnIWxVwhPDmr1jJl8ooMQE0Tn7sU9YzlWvJ5HS
        myBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1666401603; x=1666488003; bh=PNyJWGcyU5D1G
        McfCQpJ9WIiIrBIcghEeyWy0Pxcweo=; b=efu/lRswwvAIlMnwJ5bOtohWaI4un
        8u+XTrJFxtjH0woi3Dy1RL+bj7gvuDAmyfQRxfjQqEJus3+15GSqbQEngGeVnyqQ
        gNnvcEZ5kD4WuXbszqAXkewWCzFTEZQFq1XNN98K3CaC9bJ7Ax7mVhAsovG5k/eO
        L5ZJ3n/jSJfsvsrRAXM6V9Lv422RjU/nXvIRWe/uaVqXtvQiSU9N5Ha+uDoNcl/9
        LT1AvxA8vhxj0iWCgKwL3c/7+B4hvaUWobiQ91/jmk/eiZ0m17rwsofZ4gWLA6gZ
        CuJU/o/ix0jwVbELJDA4/0nyIDZMaffWQ5iVHK3LYQoRa81eP7yHwCakQ==
X-ME-Sender: <xms:Q0VTYzD3gJ-RbB5kvSMYb_F7GoGckTGTNt8Jp9v29d_PbpW0ng_C4A>
    <xme:Q0VTY5h7NJDTrb48VZ0FHGRLgOLs3RgMjg2G57acSwrOyLFz51vnq9kCfEKisYOMA
    Mts8WO0YtT4P34XdUg>
X-ME-Received: <xmr:Q0VTY-mH40RYjz_HhHrfevgz-5UUpxsOTFVX5mJesGgFQhD7I3d851hnbeCm537Bl3BtvdxYBWOq6buk0rM_DOFINXVPHJ3E3LokVoOXtFXj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelledgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofhitghh
    rggvlhcuofgtvehlihhmohhnuceomhhitghhrggvlhesmhgttghlihhmohhnrdhorhhgqe
    enucggtffrrghtthgvrhhnpeeggfeuheeivefhvdeufedufeeuieehtdehveefhfduheef
    geevieejjeekffehvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhitghhrggvlhesmhgt
    tghlihhmohhnrdhorhhg
X-ME-Proxy: <xmx:Q0VTY1ygq17KPEERR6_Kdi7u_lGgNtRqVYxFSXAGMpIlnQZ6kL8o3w>
    <xmx:Q0VTY4SzOVqlFfHgxZXqicDQ5GZrvpaV70qSmFX-WUYZbJSYLnCesA>
    <xmx:Q0VTY4ajcLg0BIgwotKxxAISRqEXDFE6jpmitfVMvBRVv5Awas8lwQ>
    <xmx:Q0VTYzLbWzm2DJecinuY2uEp4WfeSfjq6ZTFS6z2l2bo_sA0OXFPCA>
Feedback-ID: i9dc944d1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Oct 2022 21:20:03 -0400 (EDT)
From:   Michael McClimon <michael@mcclimon.org>
To:     git@vger.kernel.org
Cc:     Michael McClimon <michael@mcclimon.org>,
        Hank Leininger <hlein@korelogic.com>
Subject: [PATCH v2 1/2] Git.pm: add semicolon after catch statement
Date:   Fri, 21 Oct 2022 21:19:31 -0400
Message-Id: <20221022011931.43992-2-michael@mcclimon.org>
X-Mailer: git-send-email 2.38.1.130.g45c9f05c
In-Reply-To: <20221022011931.43992-1-michael@mcclimon.org>
References: <20221016212236.12453-1-michael@mcclimon.org>
 <20221022011931.43992-1-michael@mcclimon.org>
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
2.38.1.130.g45c9f05c

