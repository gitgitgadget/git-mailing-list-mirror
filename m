Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D90EB64DD
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 21:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjGYVVX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 17:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGYVVW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 17:21:22 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34022E69
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 14:21:21 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8BFAE5C00D2;
        Tue, 25 Jul 2023 17:21:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 25 Jul 2023 17:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imap.cc; h=cc:cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1690320080; x=
        1690406480; bh=jSlmUnjMCXsElNjDNJupCGRTyuCMNMQCjyZLM86XBAQ=; b=f
        AFMSFNxIx6SZwz0Q0AXPUCOXnY4O/G1lk0a10LsjabBMwfecbE9inCBec9P3VvwM
        6b0bIF3AQxLwz39oC0u6lj2fr78b6rL5Kz9/fkkG+ldDnSBLx69hRTI5njlY1CRH
        rh1j9C6q2ApSxL8n3/0eV1QpZommdZm7MfQ48+kRzVlskeXpXF8ioH5jmDZAWXu8
        0s6OYKzmmGcGzuAwuJwVDau1kIz14No8EVJrQfKKXLzTOnueF/aujFcwpMmqPLRF
        vQFxTknSuBSpJIFeFSHNbagw/Rsdp2KfeSmecmm1FtPBoCj9TWz9Bqan1rMW0IcU
        wtqeh9GOTvU2MVWhtixEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1690320080; x=
        1690406480; bh=jSlmUnjMCXsElNjDNJupCGRTyuCMNMQCjyZLM86XBAQ=; b=A
        UtsHNEpEHGiFafo1fZhgKqn7HUqt1a0qqGH4H5UKhtk8ekfm6O/I71JHslyT0uUS
        jZ7iXoJ92ltZw3oo9VpczqhVRFA44wt5C/bU2hh8eAQv0udna3To0LieCqcNOfjx
        BXT32fLm+pInxv/9478vRPtUJGtGPdWZ3e1j1/UoQwYL5mBNsAgSgDU7gna5Or2A
        oO176+9W3tKXslccMo5E+POWpOJloTRpB3C3BNq/aXQ+rfoPw9Jgz5lKrCc2RaZo
        FkzSLURLYrRqo+jZdRgLU5LjqOSuoxQi4iGaBolsw4rslVxDjyqmG1hj9WFyiz8t
        RDQkIGd9VPaCWsiyQJnjw==
X-ME-Sender: <xms:0DzAZB8s43WEx-ZhmvSSsKTtKH7xOGAZI9S-bLLvjdiSqeNtJvHY7w>
    <xme:0DzAZFu_5yGeCwi8bhlqRlj-CQsSujvXkJw6G73o2r9j7Gee_xDTIoqP1Ii-U1xzl
    SptsQ9MvIiGW9K2eA>
X-ME-Received: <xmr:0DzAZPCT3O4ryrRHGaCGpWXdBDACDKuvp1LZsmTNn2kl-SpXtSWMAdX7fFlAe6X-4eYGjPojXpiFRkAOShPhDTiIPRWjBoswR_GXy8otEo8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedtgdduheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertder
    tddtnecuhfhrohhmpehpvhhuthhovhesihhmrghprdgttgenucggtffrrghtthgvrhhnpe
    dtuefhvdfhtdeugfffieejieduheeiuedthfevtdekgfevveejjefhffettdelieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpvhhuthhovh
    esihhmrghprdgttg
X-ME-Proxy: <xmx:0DzAZFcJ-KbcTj8hI3yr34rtnpD1J_2qqH3Xg4yEmxUDwvheYk-sPw>
    <xmx:0DzAZGPodzpFmjYE0zlHXT3GVT1qW_4jdcSySoMhUk4e7ehfjHqmwg>
    <xmx:0DzAZHmAATYCLk-qD5oHqA9TfTMrV-9rxeG6V3KJXJaEhHI2m6wv4A>
    <xmx:0DzAZI1IsBHRyrNEFRco8nKk0yWpr0_h2l38Q7UXXg4J4HABtMfFSg>
Feedback-ID: iccdf4031:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Jul 2023 17:21:19 -0400 (EDT)
From:   pvutov@imap.cc
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Petar Vutov <pvutov@imap.cc>
Subject: [PATCH v5] doc: highlight that .gitmodules does not support !command
Date:   Tue, 25 Jul 2023 23:22:18 +0200
Message-ID: <20230725212218.711116-1-pvutov@imap.cc>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <xmqq8rb3n9du.fsf@gitster.g>
References: <xmqq8rb3n9du.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Petar Vutov <pvutov@imap.cc>

Bugfix for fc01a5d2 (submodule update documentation: don't repeat
ourselves, 2016-12-27).

The `custom command` and `none` options are described as sharing the
same limitations, but one is allowed in .gitmodules and the other is
not.

Rewrite the description for custom commands to be more precise,
and make it easier for readers to notice that custom commands cannot
be used in the .gitmodules file.

Signed-off-by: Petar Vutov <pvutov@imap.cc>
---
Combines the custom command description rewrite by Junio C Hamano and
my proposed changes into a single patch.

Apologies for the "From:" line at the top - I don't know if it is safe to
remove it, and I can't figure out how set my name in git-send-email so
that the line is not automatically added.

 Documentation/git-submodule.txt | 31 +++++++++++++++++++------------
 Documentation/gitmodules.txt    |  6 +++---
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 4d3ab6b9f9..695730609a 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -95,7 +95,7 @@ too (and can also report changes to a submodule's work tree).
 init [--] [<path>...]::
 	Initialize the submodules recorded in the index (which were
 	added and committed elsewhere) by setting `submodule.$name.url`
-	in .git/config. It uses the same setting from `.gitmodules` as
+	in `.git/config`, using the same setting from `.gitmodules` as
 	a template. If the URL is relative, it will be resolved using
 	the default remote. If there is no default remote, the current
 	repository will be assumed to be upstream.
@@ -105,9 +105,12 @@ If no path is specified and submodule.active has been configured, submodules
 configured to be active will be initialized, otherwise all submodules are
 initialized.
 +
-When present, it will also copy the value of `submodule.$name.update`.
-This command does not alter existing information in .git/config.
-You can then customize the submodule clone URLs in .git/config
+It will also copy the value of `submodule.$name.update`, if present in
+the `.gitmodules` file, to `.git/config`, but (1) this command does not
+alter existing information in `.git/config`, and (2) `submodule.$name.update`
+that is set to a custom command is *not* copied for security reasons.
++
+You can then customize the submodule clone URLs in `.git/config`
 for your local setup and proceed to `git submodule update`;
 you can also just use `git submodule update --init` without
 the explicit 'init' step if you do not intend to customize
@@ -143,6 +146,8 @@ the submodules. The "updating" can be done in several ways depending
 on command line options and the value of `submodule.<name>.update`
 configuration variable. The command line option takes precedence over
 the configuration variable. If neither is given, a 'checkout' is performed.
+(note: what is in `.gitmodules` file is irrelevant at this point;
+see `git submodule init` above for how `.gitmodules` is used).
 The 'update' procedures supported both from the command line as well as
 through the `submodule.<name>.update` configuration are:
 
@@ -160,16 +165,18 @@ checked out in the submodule.
 	merge;; the commit recorded in the superproject will be merged
 	    into the current branch in the submodule.
 
-The following 'update' procedures are only available via the
-`submodule.<name>.update` configuration variable:
+The following update procedures have additional limitations:
 
-	custom command;; arbitrary shell command that takes a single
-	    argument (the sha1 of the commit recorded in the
-	    superproject) is executed. When `submodule.<name>.update`
-	    is set to '!command', the remainder after the exclamation mark
-	    is the custom command.
+	custom command;; mechanism for running arbitrary commands with the
+	    commit ID as an argument. Specifically, if the
+	    `submodule.<name>.update` configuration variable is set to
+	    `!custom command`, the object name of the commit recorded in the
+	    superproject for the submodule is appended to the `custom command`
+	    string and executed. Note that this mechanism is not supported in
+	    the `.gitmodules` file or on the command line.
 
-	none;; the submodule is not updated.
+	none;; the submodule is not updated. This update procedure is not
+	    allowed on the command line.
 
 If the submodule is not yet initialized, and you just want to use the
 setting as stored in `.gitmodules`, you can automatically initialize the
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index dcee09b500..d9bec8b187 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -43,9 +43,9 @@ submodule.<name>.update::
 	command in the superproject. This is only used by `git
 	submodule init` to initialize the configuration variable of
 	the same name. Allowed values here are 'checkout', 'rebase',
-	'merge' or 'none'. See description of 'update' command in
-	linkgit:git-submodule[1] for their meaning. For security
-	reasons, the '!command' form is not accepted here.
+	'merge' or 'none', but not '!command' (for security reasons).
+	See the description of the 'update' command in
+	linkgit:git-submodule[1] for more details.
 
 submodule.<name>.branch::
 	A remote branch name for tracking updates in the upstream submodule.
-- 
2.41.0

