Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5175C6FD1D
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 19:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjC0Tox (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 15:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjC0Tou (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 15:44:50 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D872D77
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 12:44:49 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id CB9645C01AD;
        Mon, 27 Mar 2023 15:44:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 27 Mar 2023 15:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1679946288; x=
        1680032688; bh=lX6NSTSNbMPdjKMppbDGBWdqGUPSsFuE3SMJl6aj7rA=; b=c
        kOZL891vyrZGu9xFJ430Tk2QvByp7gPME5mWcySVclN6+Re2lalsLJr30Woxwwtu
        Br2BD+LBPV5YXz0FsKODbIqnz69VtXtFwfC/KFn0tGX9de9FedTj7wPIaZHYLta8
        OK8Ozwid9rdH6xR+03vLJhZ3NY1nFah2N9xkZ5qQ7YvSX5jFlpWIa0hKoRqyv9rc
        SFtZCL1K74qhDHZVssb8nDTjfuof9ik3Dvg3xNdrkOk84yL7rTXvvPtaPeNaglq1
        yERb/osII9tgpOJNIPczrAhCQfozmO+mE1ogsxIOcQMnNIlmOUcATdPv6BMyPBpS
        Gp9Rj6c+ihgTfHd2sX0YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1679946288; x=1680032688; bh=l
        X6NSTSNbMPdjKMppbDGBWdqGUPSsFuE3SMJl6aj7rA=; b=HtWiqlb2A70Q3xuIc
        mXzJccnfkkP4z2rTRy291TDIdxcAN6YZLzHf12/GjkFnjnz7RH8il0QzQrP8Qo0d
        YsJqS8MJ13lRNvB78Mk2bpN+CpKFmj4ir1L+gRmTZZcvL4JAgkr/lpOUTGlx7817
        pjntG0p1x3yNsuN00SlEfL4phYVotCI+BzSKML9n/gMrnVz/SOOAFiJw797NsWNr
        8hYdwGZfArdt3TQhlVhcW16iky0CvZQvDxdaOnT5lSt05y5un7sGzVa/amMnffT6
        9+09IDXj2bD7Ff1HgjU+kJIrHo1hy/QKJWBjEEjMNBOJfYW4xOHCvzetxfo2Nce4
        PLmCA==
X-ME-Sender: <xms:MPIhZIaLn8pSnx2IlQvmwBUUsxspLhJY8yHC1jxPuNU8GP2SiBGktA8>
    <xme:MPIhZDboxrgg9i9BX6jsQR7lamnPo78DbTQTVb7m2upNJDcWJt36ytBLzPf3BHFx2
    WXx6yVTraNBSpZIwQ>
X-ME-Received: <xmr:MPIhZC-7eT5oxPlKL67UxOneIkahjTCb4Jm4_XkOIiYaL2wl_ykXMXcJ69X0KPbSkWMayh-_-azxf1EqgEC7dvF_FpFNt8z-ZdhGDPYuBAWxDCneyxs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehvddgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofggtgfgsehtke
    ertdertdejnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegt
    ohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepgfdvhe
    fgffekgfeiheeivdetffelkefhheeitdejhfelhffhkeevudfhleekvdeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruh
    hgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:MPIhZCpZOI5ypPR2IYlIYgvtttKUIo8DmuaeG9Vj8wuWAgOQ7eMVqg>
    <xmx:MPIhZDp3FQmj7Cv27RTed6XVCV5GSwi1K2koeVKosPZs7LNsYapH4A>
    <xmx:MPIhZAR8oN0jcJ-XKMucnfRo2yqSvDJDLa6texA1n8MHKLrlQO1RCA>
    <xmx:MPIhZCRvCxDBySI5rtNPFZUMk-9D_GrEoNoxCO7FAkPeTpcalcLUhA>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Mar 2023 15:44:47 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH] config: tell the user that we expect an ASCII character
Date:   Mon, 27 Mar 2023 21:43:44 +0200
Message-Id: <20230327194344.12910-1-code@khaugsbakk.name>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 50b54fd72a (config: be strict on core.commentChar, 2014-05-17)
notes that “multi-byte character encoding could also be misinterpreted”,
and indeed a multi-byte codepoint (non-ASCII) is not accepted as a valid
`core.commentChar`.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 00090a32fc..ae68c0f736 100644
--- a/config.c
+++ b/config.c
@@ -1683,7 +1683,7 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 			comment_line_char = value[0];
 			auto_comment_line_char = 0;
 		} else
-			return error(_("core.commentChar should only be one character"));
+			return error(_("core.commentChar should only be one ASCII character"));
 		return 0;
 	}
 
-- 
2.40.0

