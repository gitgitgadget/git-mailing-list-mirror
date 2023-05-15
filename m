Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6CFC77B75
	for <git@archiver.kernel.org>; Mon, 15 May 2023 20:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245384AbjEOUa6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 16:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245382AbjEOUa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 16:30:57 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9FD10E66
        for <git@vger.kernel.org>; Mon, 15 May 2023 13:30:55 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 6459C5C0161;
        Mon, 15 May 2023 16:30:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 15 May 2023 16:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1684182655; x=1684269055; bh=NudkUrf8Rb4MhWezmN+4cDapd
        opFWgdvDlNPeDuHPIQ=; b=xGgSiOattE1QQx/XwXHnMnTgMNYgXO6egxzgjcUjF
        OjGWtxX9U6jYkos3KWsq0S/05VkAqz9yK7KsToQwhJ8BB/czgLB1si1WwZXXc9E7
        vkXwiY1APBlVVvUSTyu+g/RslFVlVJEuqo15qsobDjMv21YtsC7bbChsrsq3Y5TU
        oVD55eaMlXZrbJRyO78ONhp9dwQB3cVHqFvZoR8nXyKjmE1AInqePCFeS5YU11i+
        132fDt1QRo6khUp0ZhMYjL8TxgXWf8tSH4mZGbp82PSysFT0kSIpagZn9wqhZLvl
        0GAZ3aIJvyZO4U7DWYVouV1RSrerhy2GrbytMCSQR9rxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684182655; x=1684269055; bh=NudkUrf8Rb4MhWezmN+4cDapdopFWgdvDlN
        PeDuHPIQ=; b=Azz9ISuhnAYOxwgDB4iT+wfri8cqvbeI/xRiVsHWJEeU3GowLaP
        qrfDujCTGdvvT/vyHAkCYAeILgcI3EqNv/ohfZbEswf3mi8zmtflN8wBd9ZrHUJc
        C7O2Xm6OuLMbuGJMus6G6FgNR2b0KyOZbXf493SoTONbAQXABfu9EX6Ve9qw/OQN
        yjOTSbtmjx5AsFNckfe/nXbBQQvH6jEXydfd3Abz0wywVkI6f6BAHjLpARBzLhvu
        PiRVwPwRnA+yhxlVImjcxvKW95cjGfJp2mCju91krQoGUWuHl3E+m4STQgJAOtt6
        KSow/5p3lsbOPCrehuH4JOPx3YAJweA07VQ==
X-ME-Sender: <xms:f5ZiZF3mFlXCDJEREZc5q9Oyt-4bCYQucks527YkQdlHHJcTPRBnT9E>
    <xme:f5ZiZMG_aRnmTB059JuHLYL0QMHvzUR0-8UZP-bADgrgmcv3wf_YU5VaIWmKuIeJB
    MgD4FzeIUgaY3uAZw>
X-ME-Received: <xmr:f5ZiZF5jmu9w3pkFyBtXdFHtyxAix3Q75DXsO6g9g2aLBr5NB6jwvnAkOg3VHmsoZY11JSuNE2CjBK-NDLnfxd7Iii_FYwnjgwGbml2WcZaFbETTeXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehjedgudehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
    htkeertdertdejnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcu
    oegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepue
    eiueffuefftefhhfefleelhfeuheettedtheevgeejteehgfevffeugffglefhnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:f5ZiZC0vjh3tjo8J4zQO4KHtZhmuxt9-fp4pEZg3Q0TLQ6WrsJmjNA>
    <xmx:f5ZiZIFIrBOM0Kdpm9ed2nR4CWFhQOC7MVD9lJK4rlidcMKWMrZrJA>
    <xmx:f5ZiZD9hUV-INcOnnOmNbj0TtRjvc7WMdTBJvHHdO1RPxJA7pfBQgA>
    <xmx:f5ZiZNSEreAmaP6a1CePwZBRnrFgM2DbU14-tp2_Qqa_c83mdH7j9g>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 May 2023 16:30:54 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 1/3] doc: tag: document `TAG_EDITMSG`
Date:   Mon, 15 May 2023 22:29:33 +0200
Message-Id: <0e0e592853d272a28fb04c5183784339d7377547.1684181855.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684181855.git.code@khaugsbakk.name>
References: <cover.1684067644.git.code@khaugsbakk.name> <cover.1684181855.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document `TAG_EDITMSG` which we have told the user about on unsuccessful
command invocations since commit 3927bbe9a4 (tag: delete TAG_EDITMSG
only on successful tag, 2008-12-06).

Introduce this documentation since we are going to add tests for the
lifetime of this file in the case of command failure and success.

Use the documentation for `COMMIT_EDITMSG` from `git-commit.txt` as a
template since these two files share the same purpose.[1]

† 1: from commit 3927bbe9a4:

     “ This matches the behavior of COMMIT_EDITMSG, which stays around
       in case of error.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    • I changed (from `COMMIT_EDITMSG`) “will be overwritten” to “may” since
      I don’t see the point in giving a guarantee
    • Unsure if I was going to put this before or after “NOTES” as there seems
      to be no precedence
    
    Suggested by Junio: https://lore.kernel.org/git/xmqqy1lqaxln.fsf@gitster.g/T/#u

 Documentation/git-tag.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index fdc72b5875..46e56b0245 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -377,6 +377,16 @@ $ GIT_COMMITTER_DATE="2006-10-02 10:31" git tag -s v1.0.1
 
 include::date-formats.txt[]
 
+FILES
+-----
+
+`$GIT_DIR/TAG_EDITMSG`::
+	This file contains the message of an in-progress annotated
+	tag. If `git tag` exits due to an error before creating an
+	annotated tag then the tag message that has been provided by the
+	user in an editor session will be available in this file, but
+	may be overwritten by the next invocation of `git tag`.
+
 NOTES
 -----
 
-- 
2.40.1

