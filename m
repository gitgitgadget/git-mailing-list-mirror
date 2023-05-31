Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD7FC7EE23
	for <git@archiver.kernel.org>; Wed, 31 May 2023 12:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbjEaMPp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 May 2023 08:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjEaMPn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2023 08:15:43 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E8012B
        for <git@vger.kernel.org>; Wed, 31 May 2023 05:15:39 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B74BD5C01C2;
        Wed, 31 May 2023 08:15:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 31 May 2023 08:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1685535336; x=1685621736; bh=JyYFiaZIzL1QO0TyhUvlsIb3w
        rYg71/5QYLbXWmMGw0=; b=wU1Y8Ho5Jh+JPzJDOvYbvQ/dFTHQ/qpqe0iWUjK/n
        UK5x2bU0ZR2bv/b7r3mcmYBiZA/eTCKdcr0Ll6QXZYNDgt7S2P7p4SJbmMLZiDEM
        7s5m4dNTd7nQuZ+a6xLSMZuMzVJsbCmTNNV2gpnsYICmSRr6rKyU/RvepUvUq44E
        r6EL0DSTi5o224IDoaGfLjKdjWqtywxC8e85CHViMUgT/5wtX4A6fwpV/2yktwtm
        5ICLUeevFv2uexIlUaDTBkM8bsy9/V03BxVO7nl5kyP6fC4vfXx2OoOkKXXKp4yQ
        oqtC7bqCkC5BOw/vLkXDA7nqv3d1kwUjn2edj8QoBft0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685535336; x=1685621736; bh=JyYFiaZIzL1QO0TyhUvlsIb3wrYg71/5QYL
        bXWmMGw0=; b=i7nl8hK4cAErM33jw9xHVco/P9wF7nRRliB7KjJmoR6OhAXNDY+
        vdvDtmy9SAtw4oikgcJEm+yNJ8AJTKgvAcZaJEVn9KuGWbI7ZmSWCOJ3Od2LkVDH
        sUPiwTCU+ouVboI6+09W+5Cccr66WtwQu+ykIqbV/ymH9dier6JPJKYIM3wrkZvA
        FmZrlHlt2GQZVBlKMDY0NYQBFZnEeiqbyRNz2IInJ8ji5Wl6FiI3EuzDFvhvS9l5
        sdORn1TXQQMcvyriRFGic5YftnGXUc6iWq5tTfICCGrZQ7fhuxOjt8EPQAjZt1U+
        AHmq42vwJXYavOWC+JRAGyId3JbsARSsqFQ==
X-ME-Sender: <xms:aDp3ZG3M3JfusS3z_ibtSzlwPeWRFqloIYHWSRc2jtQuqX5gb9Xq5EI>
    <xme:aDp3ZJEUH0vu37vkBEImiIx9rDGQKPr8P6AUBdE3N1uH1DDEt9bFu5OvJhXGJzOvI
    OhVEDVDZ516yj0BfA>
X-ME-Received: <xmr:aDp3ZO5fwpNz0JbB5DWBWP6hrjlxt1HWc4ocTmELVPKE4GICn310ZDyPeaprxnTYtAbhE2Xtto9VSxIv2GnrMTVSFoi92Gs0IMexrdPl8H593SJG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekledggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeevgf
    elveeikeegjeeikeeuvefhleeiuddvleegfeekjedtkeevtdetgfffveettdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrg
    hughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:aDp3ZH0YPqT2uNQX1-8a2kFAZfBa_NPI0DR3gJDhSeUCgfFBRqJ7SA>
    <xmx:aDp3ZJF_8O3UoRM8J30Hk0cxuUw_mSwVzJ2LGGAaCA_lLiDgyYk1Zg>
    <xmx:aDp3ZA8zlTr-wJY5ny4YoM9uHaKVMWO40-c4gWkaAJkJSJe6tTl8Xw>
    <xmx:aDp3ZHPWngWTYBrU13UjF9iHab1Z_QwPRIOlbOJzpaEcBWyNhpSF4w>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 May 2023 08:15:35 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2] notes: update documentation for `use_default_notes`
Date:   Wed, 31 May 2023 14:14:21 +0200
Message-ID: <3c757bcb3d5c8b597b7f267549f90e1a021d229a.1685535115.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.41.0.rc2
In-Reply-To: <b3829cb0d1e36a5ebb44a315fe32037f2a3f6c7a.1685526558.git.code@khaugsbakk.name>
References: <b3829cb0d1e36a5ebb44a315fe32037f2a3f6c7a.1685526558.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`suppress_default_notes` was renamed to `use_default_notes` in
3a03cf6b1d (notes: refactor display notes default handling,
2011-03-29).

The commit message says that “values less than one [indicates] “not
set” ”, but I think what was meant was “less than zero”.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    § v2
    
    • Fix sloppy typos (sorry about that)
    • “default notes” instead of “default refs”
    • Don’t drop “it” (“treat it like”)

 notes.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/notes.h b/notes.h
index c1682c39a9..826a2595fa 100644
--- a/notes.h
+++ b/notes.h
@@ -286,8 +286,9 @@ void disable_display_notes(struct display_notes_opt *opt, int *show_notes);
  * If 'opt' is not NULL, then it specifies additional settings for the
  * displaying:
  *
- * - suppress_default_notes indicates that the notes from
- *   core.notesRef and notes.displayRef should not be loaded.
+ * - use_default_notes: less than `0` is "unset", which means that the
+ *   default notes are shown iff no other notes are given. Else treat it
+ *   like a boolean.
  *
  * - extra_notes_refs may contain a list of globs (in the same style
  *   as notes.displayRef) where notes should be loaded from.
-- 
2.41.0.rc2

