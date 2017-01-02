Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06887205F4
	for <e@80x24.org>; Mon,  2 Jan 2017 11:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932866AbdABLPH (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 06:15:07 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43016 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751307AbdABLPF (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Jan 2017 06:15:05 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 103582095C;
        Mon,  2 Jan 2017 06:15:05 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 02 Jan 2017 06:15:05 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
        date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=D1V
        JaJ21Fzv1ODUarIcOTy0l9DU=; b=kInqfBldLfcD2QFVWaZOTC0xb+t4cx0zvnV
        vygyR/0HbyyamN8xXb7xoW9w1dkH82aEkSpsIt24SjdAkTy8Hxe7dYDHATU2ZhCM
        VrMi7QBXAFgGy5JZzo6LBg38T09mxZ722XRZo/gxuffv9cOA2V+W91GD0JUYS5Rs
        FTL4KB7w=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc
        :x-sasl-enc; s=smtpout; bh=D1VJaJ21Fzv1ODUarIcOTy0l9DU=; b=PQOXy
        7+6LIELQ3jJF7rDKN9xeqGmdb19mrXanhxG1VNBw/yt3TBDYGBvXYtVNOUq0NWM/
        NNr4N2zR+8qc9O1evDgu6Pz2J/qCrLpsgBvD2gxTLHOjqgqomYyuAFScu/CHlLZ4
        pZwsVNGQ0ft4PARQhdaYNUPw+lAgjraSPEVy7g=
X-ME-Sender: <xms:OTZqWGAI8TNRHGl8Modm7ZymojWh3Edt4N_N4aoQJCIa7C_a6WLo9g>
X-Sasl-enc: NRNbjb0v5JEfMlEvKIzqBEuIym/HREDLyAzlh+gJn2sb 1483355704
Received: from localhost (p5dc51a6b.dip0.t-ipconnect.de [93.197.26.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8D4F27E8D9;
        Mon,  2 Jan 2017 06:15:04 -0500 (EST)
From:   Michael J Gruber <git@drmicha.warpmail.net>
To:     git@vger.kernel.org
Subject: [RFC PATCH 3/5] error/warning framework framework: coccinelli rules
Date:   Mon,  2 Jan 2017 12:14:52 +0100
Message-Id: <da98fec6fa421be916f169ef62353339c4273e89.1483354746.git.git@drmicha.warpmail.net>
X-Mailer: git-send-email 2.11.0.372.g2fcea0e476
In-Reply-To: <cover.1483354746.git.git@drmicha.warpmail.net>
References: <cover.1483354746.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Provide coccinelli rules which check for error(), warning() etc. with
localised argument and create a patch to replace them with error_(),
warning_() etc. in order to fully localize them.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 contrib/coccinelle/errorl10n.cocci | 47 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 contrib/coccinelle/errorl10n.cocci

diff --git a/contrib/coccinelle/errorl10n.cocci b/contrib/coccinelle/errorl10n.cocci
new file mode 100644
index 0000000000..d62a440644
--- /dev/null
+++ b/contrib/coccinelle/errorl10n.cocci
@@ -0,0 +1,47 @@
+@@
+expression E;
+@@
+- usage(_(E));
++ usage_(_(E));
+
+@@
+expression E;
+@@
+- usagef(_(E));
++ usagef_(_(E));
+
+@@
+expression E;
+@@
+- die(_(E));
++ die_(_(E));
+
+@@
+expression E;
+@@
+- error(_(E));
++ error_(_(E));
+
+@@
+expression E;
+@@
+- warning(_(E));
++ warning_(_(E));
+
+@@
+expression E;
+@@
+- die_errno(_(E));
++ die_errno_(_(E));
+
+@@
+expression E;
+@@
+- error_errno(_(E));
++ error_errno_(_(E));
+
+@@
+expression E;
+@@
+- warning_errno(_(E));
++ warning_errno_(_(E));
-- 
2.11.0.372.g2fcea0e476

