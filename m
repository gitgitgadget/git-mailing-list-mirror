Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7B9CE79A8
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 20:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjISU1c (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 16:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjISU1b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 16:27:31 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9F9BD
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 13:27:25 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 6E6B33200413;
        Tue, 19 Sep 2023 16:27:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 19 Sep 2023 16:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1695155241; x=1695241641; bh=lo00tzFbmEUYro2tW0rkxiLxz
        fdGOk/sQqd1oUeirqY=; b=LJCB/X9TFit8Pvep6yhAqui59fYi7T+SPA7CI16D0
        MddM1+qumeXFQTMKNWq851DmtXaaXGP6FdGdPYNV4i4n9Er2yK/50afwCMPxy8Jk
        kox1sRFAZCjo3+tfxOIctBAaa3VnmKw59XA6pW0S6zMLW299TumMuXykodiluWoj
        7tpDAPJIpg8tsSeKmEmzbB7onW3/LZmE4RkCOL5qfsl0ECQJTRYgQxWuw4iCEVHT
        MN4I2ASdHAPb/giRSNz/Hnzwf1QMcjC9Cd36bUkL9Xbw8Ef7FMYx+vB9c6NdSkux
        8wDJDLHji21MYK+NPIWqoSAM9fwESbRjW/rmeYY7g7QWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695155241; x=1695241641; bh=lo00tzFbmEUYro2tW0rkxiLxzfdGOk/sQqd
        1oUeirqY=; b=lutlYF/WcVda+rmu5JkttBbzq3fnLdDijUhxhfO2L891nvSfEeu
        lViqGR4cvCMx/8em8vpP7CAEGHo9GWiyLoo5GTnJI0NR4LzUVEkuQNb4PHnAd+hA
        /W4z5Lu0+ejMh8pZGS7AYiBVrdgv0XY8/e4cXPsoG/TqPYZTbPSIdkj8KFyUWwwF
        RahKfBMC/8k3+RQNoReIz6geAFtFO3TWsFQvy43jL2NxE8SvxKfLKn4pw8qUIm30
        ZrYiWThQVibhCs6pUVxvdXbaWrOCxPpJ2sXP+tBvS+Rr8W1HVvqL9c/qDtCXCPOt
        3hUiqVZVtihF9conLGP6JZtqjr8lBDR0SgA==
X-ME-Sender: <xms:KQQKZfHkK9G3HEw2DhbklzBvG5e5ze7BOaFTm1h_yuu5l7E0dkCs7JI>
    <xme:KQQKZcUcg9Om6bDgNBmSdDg0KMTE2ddHBfqSJc_xlQ7FAHX62VwMDFX7FvJaVzBuH
    KUUh24Awc7Q-xvz9Q>
X-ME-Received: <xmr:KQQKZRKWqC2cWwATq7D1ElXkejBA1ueDcVlhSxjypMDYqzJOBNNhUD7yhnGnzIXVqULRmF8JlBwYNqNobuJc_L_Ws1xDEhgUjkRfVdzMTPHhFAnWbRseDd8ZMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekuddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkuceotghouggvsehkhhgruhhgshgsrghkkh
    drnhgrmhgvqeenucggtffrrghtthgvrhhnpeevgfelveeikeegjeeikeeuvefhleeiuddv
    leegfeekjedtkeevtdetgfffveettdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:KQQKZdF9FyF2Wr3gHfwPkJmWT0CSSXjETJNw1DZ2cIK3M7j9EVf1wg>
    <xmx:KQQKZVUc-qh3kO3uB2txKvHpZZ2ODzuG9xBlEi4-CLca6tKG5Vwfxg>
    <xmx:KQQKZYMKNf3ANAStyt0GmwoWlv8GotYJbcTP6SZqYJsjNBV4sKIlzg>
    <xmx:KQQKZYQd9VytGUXtJj9qasUnEqMOZY-wHOWUxjxFrSNSEXbI-kdXvA>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Sep 2023 16:27:20 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v5 0/1] range-diff: treat notes like `log`
Date:   Tue, 19 Sep 2023 22:26:49 +0200
Message-ID: <cover.1695154855.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695144790.git.code@khaugsbakk.name>
References: <cover.1695144790.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

See the previous cover letter for context.

§ Changes since version 4

• Remove “Root cause” section from commit message
• Doc change according to feedback

Kristoffer Haugsbakk (1):
  range-diff: treat notes like `log`

 Documentation/pretty-options.txt |  4 ++++
 range-diff.c                     |  2 +-
 revision.c                       |  7 +++++++
 revision.h                       |  1 +
 t/t3206-range-diff.sh            | 28 ++++++++++++++++++++++++++++
 5 files changed, 41 insertions(+), 1 deletion(-)

Range-diff against v4:
1:  244e102cc46 ! 1:  6e114271a2e range-diff: treat notes like `log`
    @@ Commit message
         Remedy this by introducing `--show-notes-by-default` that `range-diff` can
         use to tell the `log` subprocess what to do.

    -    § Root cause
    -
    -    8cf51561d1e (range-diff: fix a crash in parsing git-log output,
    -    2020-04-15) added `--notes` in order to deal with a side-effect of
    -    `--pretty=medium`:
    -
    -    > To fix this explicitly set the output format of the internally executed
    -    > `git log` with `--pretty=medium`. Because that cancels `--notes`, add
    -    > explicitly `--notes` at the end.
    -
         § Authors

         • Fix by Johannes
    @@ Commit message
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>

      ## Documentation/pretty-options.txt ##
    -@@ Documentation/pretty-options.txt: message by 4 spaces (i.e.  'medium', which is the default, 'full',
    - and 'fuller').
    +@@ Documentation/pretty-options.txt: being displayed. Examples: "--notes=foo" will show only notes from
    + 	"--notes --notes=foo --no-notes --notes=bar" will only show notes
    + 	from "refs/notes/bar".

    - ifndef::git-rev-list[]
     +--show-notes-by-default::
    -+	Show the default notes (see `--notes`) unless subsequent arguments
    -+	are used to display specific notes.
    ++	Show the default notes unless options for displaying specific
    ++	notes are given.
     +
    - --notes[=<ref>]::
    - 	Show the notes (see linkgit:git-notes[1]) that annotate the
    - 	commit, when showing the commit log message.  This is the default
    + --show-notes[=<ref>]::
    + --[no-]standard-notes::
    + 	These options are deprecated. Use the above --notes/--no-notes

      ## range-diff.c ##
     @@ range-diff.c: static int read_patches(const char *range, struct string_list *list,
--
2.42.0
