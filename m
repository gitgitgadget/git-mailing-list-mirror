Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F930C6FA89
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 16:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiIOQJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 12:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiIOQJm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 12:09:42 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA24DECF
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 09:09:38 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 700E113E832;
        Thu, 15 Sep 2022 12:07:07 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=6ncGciLzs6X7y72Rtb+4Q4eJq
        PQ8ORAWPEel98TW1Rk=; b=f36BKOGczy0mDmalGvHNdW3dPx91u7gC4fb3LLleM
        OWWttjpHZhDLUi5hToE4VRl4zZA847asujoQ+kPfdt6iPcMVJhWFqIUTqI7KEdlI
        ASH0sHYoi3jZz4eNiIQ64ls++w8ibWmwwVRLD2TzimbbBmnCgKOzAP/g7cbWoW9F
        qo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E71813E831;
        Thu, 15 Sep 2022 12:07:07 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 72CB113E82F;
        Thu, 15 Sep 2022 12:07:06 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/5] environ: explain Boolean environment variables
Date:   Thu, 15 Sep 2022 09:06:56 -0700
Message-Id: <20220915160659.126441-3-gitster@pobox.com>
X-Mailer: git-send-email 2.37.3-780-gd940517dcb
In-Reply-To: <20220915160659.126441-1-gitster@pobox.com>
References: <xmqq8rmkpsit.fsf@gitster.g>
 <20220915160659.126441-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 71E3C84E-3510-11ED-ADCB-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many environment variables use the git_env_bool() API to parse their
values, and allow the usual "true/yes/on are true, false/no/off are
false. In addition non-zero numbers are true and zero is false.  An
empty string is also false." set of values.

Mark them as such, and consistently say "true" or "false", instead
of random mixes of '1', '0', 'yes', 'true', etc. in their
description.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git.txt | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 1b7e37e79a..e2f61a1ec8 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -458,7 +458,12 @@ Please see linkgit:gitglossary[7].
=20
 Environment Variables
 ---------------------
-Various Git commands use the following environment variables:
+Various Git commands pay attention to environment variables and change
+their behavior.  The environment variables marked as "Boolean" take
+their values the same way as Boolean valued configuration variables, e.g=
.
+"true", "yes", "on" and positive numbers are taken as "yes".
+
+Here are the variables:
=20
 The Git Repository
 ~~~~~~~~~~~~~~~~~~
@@ -530,7 +535,7 @@ double-quotes and respecting backslash escapes. E.g.,=
 the value
 	When run in a directory that does not have ".git" repository
 	directory, Git tries to find such a directory in the parent
 	directories to find the top of the working tree, but by default it
-	does not cross filesystem boundaries.  This environment variable
+	does not cross filesystem boundaries.  This Boolean environment variabl=
e
 	can be set to true to tell Git not to stop at filesystem
 	boundaries.  Like `GIT_CEILING_DIRECTORIES`, this will not affect
 	an explicit repository directory set via `GIT_DIR` or on the
@@ -695,7 +700,7 @@ for further details.
 	option in linkgit:git-config[1].
=20
 `GIT_TERMINAL_PROMPT`::
-	If this environment variable is set to `0`, git will not prompt
+	If this Boolean environment variable is set to false, git will not prom=
pt
 	on the terminal (e.g., when asking for HTTP authentication).
=20
 `GIT_CONFIG_GLOBAL`::
@@ -710,10 +715,10 @@ for further details.
=20
 `GIT_CONFIG_NOSYSTEM`::
 	Whether to skip reading settings from the system-wide
-	`$(prefix)/etc/gitconfig` file.  This environment variable can
+	`$(prefix)/etc/gitconfig` file.  This Boolean environment variable can
 	be used along with `$HOME` and `$XDG_CONFIG_HOME` to create a
 	predictable environment for a picky script, or you can set it
-	temporarily to avoid using a buggy `/etc/gitconfig` file while
+	to true to temporarily avoid using a buggy `/etc/gitconfig` file while
 	waiting for someone with sufficient permissions to fix it.
=20
 `GIT_FLUSH`::
@@ -857,11 +862,11 @@ for full details.
 `GIT_TRACE_REDACT`::
 	By default, when tracing is activated, Git redacts the values of
 	cookies, the "Authorization:" header, the "Proxy-Authorization:"
-	header and packfile URIs. Set this variable to `0` to prevent this
+	header and packfile URIs. Set this Boolean environment variable to fals=
e to prevent this
 	redaction.
=20
 `GIT_LITERAL_PATHSPECS`::
-	Setting this variable to `1` will cause Git to treat all
+	Setting this Boolean environment variable to true will cause Git to tre=
at all
 	pathspecs literally, rather than as glob patterns. For example,
 	running `GIT_LITERAL_PATHSPECS=3D1 git log -- '*.c'` will search
 	for commits that touch the path `*.c`, not any paths that the
@@ -870,15 +875,15 @@ for full details.
 	`git ls-tree`, `--raw` diff output, etc).
=20
 `GIT_GLOB_PATHSPECS`::
-	Setting this variable to `1` will cause Git to treat all
+	Setting this Boolean environment variable to true will cause Git to tre=
at all
 	pathspecs as glob patterns (aka "glob" magic).
=20
 `GIT_NOGLOB_PATHSPECS`::
-	Setting this variable to `1` will cause Git to treat all
+	Setting this Boolean environment variable to true will cause Git to tre=
at all
 	pathspecs as literal (aka "literal" magic).
=20
 `GIT_ICASE_PATHSPECS`::
-	Setting this variable to `1` will cause Git to treat all
+	Setting this Boolean environment variable to true will cause Git to tre=
at all
 	pathspecs as case-insensitive.
=20
 `GIT_REFLOG_ACTION`::
@@ -892,7 +897,7 @@ for full details.
 	end user, to be recorded in the body of the reflog.
=20
 `GIT_REF_PARANOIA`::
-	If set to `0`, ignore broken or badly named refs when iterating
+	If this Boolean environment variable is set to false, ignore broken or =
badly named refs when iterating
 	over lists of refs. Normally Git will try to include any such
 	refs, which may cause some operations to fail. This is usually
 	preferable, as potentially destructive operations (e.g.,
@@ -911,7 +916,7 @@ for full details.
 	`protocol.allow` in linkgit:git-config[1] for more details.
=20
 `GIT_PROTOCOL_FROM_USER`::
-	Set to 0 to prevent protocols used by fetch/push/clone which are
+	Set this Boolean environment variable to false to prevent protocols use=
d by fetch/push/clone which are
 	configured to the `user` state.  This is useful to restrict recursive
 	submodule initialization from an untrusted repository or for programs
 	which feed potentially-untrusted URLS to git commands.  See
@@ -939,7 +944,7 @@ only affects clones and fetches; it is not yet used f=
or pushes (but may
 be in the future).
=20
 `GIT_OPTIONAL_LOCKS`::
-	If set to `0`, Git will complete any requested operation without
+	If this Boolean environment variable is set to false, Git will complete=
 any requested operation without
 	performing any optional sub-operations that require taking a lock.
 	For example, this will prevent `git status` from refreshing the
 	index as a side effect. This is useful for processes running in
--=20
2.37.3-780-gd940517dcb

