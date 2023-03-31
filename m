Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22129C761A6
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 18:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjCaSRN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 14:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjCaSRM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 14:17:12 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5F1DBF8
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 11:17:11 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id D73095C00CA;
        Fri, 31 Mar 2023 14:17:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 31 Mar 2023 14:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1680286630; x=1680373030; bh=v/EJuD6hCl//r3IQ+wFhqinGw
        iMhVtIxd9p+/SwHfGY=; b=a7AFCnkM37X3tvkjWNCMO/zbK4yIYQOucr6TbOCWv
        K2AIr3ry7VtoMmGJwgGh/WtmjziWP5SwEVZbp3t7MvBP0wjyGQAlKeiHo4RL6jGM
        /cVSM2T0jgFDbpIx6Q7XjjDo6PQD4gqUVvZnqZUDI/+fCprSsF0gegwo7fnPw7RS
        nCecVKtB6EQdmS/RgxvlvoM1Om7yUHq6p9JYJYPHw9mehx9KPqTXHEGJhtv/tbiz
        E38T4jXwDnUxzlRGHpdHj6CjWkgyzrl7RYsxpbATIT+9FRQvjgoWmjGfM+4r6OF8
        d2SpwEEMZjii84nUGE7Un0UkFmT81eMVR0OR5eaGkoiwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680286630; x=1680373030; bh=v/EJuD6hCl//r3IQ+wFhqinGwiMhVtIxd9p
        +/SwHfGY=; b=hXe7TXw5dlC1AoRT07r88siVgRM8vCOUb98QSO7FgezsDupykg8
        4/JZsRWyNC/pzd82tV7Swi47kTsSlpkCXqK0Oqe8KUCAyLulkTgBhgLURibF+XR0
        BZz46L9MTLRoCjtwDDAryruyNe344PlTJepb67u7J3qMcJATb6Zu0Ft0hQTo5G+F
        HLBfuz97OyUOQ3HY/fmjkeLxqdghKItbTMuw1bARzYktzGPH11TuNw2q8OZU96dN
        MLxAfMgk/5qisk6CijjvduNxB2x9IUfqZKQ260pLCCjLaCi8lsMBUxwINf5ceX5e
        VN9fTmIzZliYomnOyu24J4Ft1BByGvnxnZg==
X-ME-Sender: <xms:piMnZHcvlxSJw3s4j_Lk9MAFjdjstdXPWWOyZ-Y7FIEH5mnn6aBUMRc>
    <xme:piMnZNM7rtSs9EmW8JorMSYHPWUH5CDfUkGgwMD5OhsAC8BsGtR8Taye2W8cazK6z
    u9fBUtcD2qUFLjlIg>
X-ME-Received: <xmr:piMnZAhj0y9pNqGmPpjHtAQhf6_-vxKKvYCPICUDnf82KxGgYvH5pGQ_U22e_WGr3_Kh7TQGRbC-CD-9gZCztQtPrLsTW4tXyrTzWh7kKyl3MNyUse8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiuddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
    htkeertdertdejnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcu
    oegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepve
    fgleevieekgeejieekueevhfelieduvdelgeefkeejtdekvedttefgffevtedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhh
    gruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:piMnZI_GPcgjWAj4700osPyryck9ANN3TT_DkG94PzpM4WussW7h9g>
    <xmx:piMnZDvJyQzWp13iTY221ariPmnvcIVFl5e9Ag0bzBilD-1dJASsnQ>
    <xmx:piMnZHFMAOpt8oKVLtbzvg_MlmbxLGDSpy01W5_P2yrS4aoFrQvumg>
    <xmx:piMnZMV0S82u_RSLuE_hgxp01Ig3PsXeSzS5YjPHvV04uIByTArUqQ>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Mar 2023 14:17:09 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/3] doc: interpret-trailers: fix example
Date:   Fri, 31 Mar 2023 20:16:52 +0200
Message-Id: <20230331181652.15729-1-code@khaugsbakk.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230331180817.14466-1-code@khaugsbakk.name>
References: <20230331180817.14466-1-code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This command won’t output anything if you don’t give it an input and/or
a `--trailer`.

Cc: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-interpret-trailers.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 792d61ae7b..2aa190fd3f 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -326,7 +326,7 @@ $ git config trailer.sign.key "Signed-off-by: "
 $ git config trailer.sign.ifmissing add
 $ git config trailer.sign.ifexists doNothing
 $ git config trailer.sign.cmd 'echo "$(git config user.name) <$(git config user.email)>"'
-$ git interpret-trailers <<EOF
+$ git interpret-trailers --trailer sign <<EOF
 > EOF
 
 Signed-off-by: Bob <bob@example.com>
-- 
2.40.0

