Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3248BC77B75
	for <git@archiver.kernel.org>; Tue, 16 May 2023 17:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjEPR4l (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 13:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbjEPR4h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 13:56:37 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91E9272C
        for <git@vger.kernel.org>; Tue, 16 May 2023 10:56:35 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 35FBB5C01C1;
        Tue, 16 May 2023 13:56:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 16 May 2023 13:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1684259795; x=1684346195; bh=HfdWM7fhrIi6lJ4mjm+Ay7PeK
        uIYlgz2OsqGLwcfRIY=; b=pJfz2j6glVZwuiSFvA+OOGP8XveoJPF61ufOfoTON
        /py9meWUURofqCWrEMw1jk1jk4g4aYyCkI0dLS9SZfObiNlZ3+9HR12tIwfGeYOp
        ajNaqM/oqS+7CZXbpNQQWyBm7lC4iENZMmRG50GXcbGJQ72FboExDItpB6C/eOnF
        R6trz78tTKvTO5wYGDUPTi5OTNUkROAV42JSKwb6dkX1TmqcSbhvQA4buU6UcW2N
        TrF+JNjV6DKrTDuybREDDCWrAKauqaaR+u+So8wnxUf/8ZA3plDtDi//0cnMddpR
        7kS4wq1apGNiRX1MVN+L7Y6X3Qorp8v/tZr7ghdcNmrNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684259795; x=1684346195; bh=HfdWM7fhrIi6lJ4mjm+Ay7PeKuIYlgz2Osq
        GLwcfRIY=; b=iKfQjcFREG6sb5/zrgnMzQOyuPT+5h7ROn6bjBKP7yJ1boZ0bxD
        6Ymgm/GlDEcHnaAL1380xri3cWhvWVRWGSDkl5uAnPUHFMsyju+UbmIqVpoPvdaP
        nkyFWXdO5Z1CeoNUphXWH6kekcFzusa2/2AJHsXHmbCDqnQpE6641IsuyjsCuOWT
        9iuOkvVfXwHk7coKG18vF1odJyGzd0Goe70PdwdjzESHZavlSVWcMsMWTTe1/giY
        ONTl7i1aQg5ZT23nMr/YMPj82QuYlX4eH/g9W7rKcDSHon5QyIY93lyhD/D1O6/i
        yPMZ1eHehWzGoMb5yRXI8OsqUJgabvIEv6A==
X-ME-Sender: <xms:08NjZFbijB-AFpyF3GMuImL4KOgsCOgN4oEnOXTcPS1WI0TK27ENXd4>
    <xme:08NjZMa-k4XdjuIjrS3v72gtgOP2gNOju3PA4YjIaD1GhIa1R7urlg0G88fyMFtZ2
    b97K6pnm5jjl3HjXA>
X-ME-Received: <xmr:08NjZH92NicQdxhUZSWLLE6ezTJnvI4-9vVAWIQaOmHi7Ji6rrlQ0MZ5VIZLA5MxR2u8SjNnGeXb9e91_F5tXOX3OhjgvWqYlogi1oALshvUDQWH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehledguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
    htkeertdertdejnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcu
    oegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepue
    eiueffuefftefhhfefleelhfeuheettedtheevgeejteehgfevffeugffglefhnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:08NjZDr6nUSCrOpU3wuOc5xkcYz9cgCwHR0FVz4k5yI80N9fOF1HLg>
    <xmx:08NjZAprz1vdtDFsTIL7VleKQOeTCA3cpCjASUowx_Nu12WAOuzuYA>
    <xmx:08NjZJQrmkvbeaEX-_Eq24Oug9gul3bjrLYmgZbSwwv1SW35PnatAw>
    <xmx:08NjZH0PdRQEM1nBNnUbXfVz4ARPLbeCt2caGFwAeRx52Iju2gQo_g>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 May 2023 13:56:34 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v3 1/3] doc: tag: document `TAG_EDITMSG`
Date:   Tue, 16 May 2023 19:55:44 +0200
Message-Id: <882008e32a482d4b05d522430abf3419476f2302.1684258780.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684258780.git.code@khaugsbakk.name>
References: <cover.1684067644.git.code@khaugsbakk.name> <cover.1684258780.git.code@khaugsbakk.name>
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
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    § From v2
    
    • I changed (from `COMMIT_EDITMSG`) “will be overwritten” to “may” since
      I don’t see the point in giving a guarantee
    • Unsure if I was going to put this before or after “NOTES” as there seems
      to be no precedence
    
    Suggested in: https://lore.kernel.org/git/xmqqy1lqaxln.fsf@gitster.g/T/#u

 Documentation/git-tag.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index fdc72b5875a..46e56b02455 100644
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

