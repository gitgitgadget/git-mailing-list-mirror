Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BE7C4741F
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 22:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ED4C206FB
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 22:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Waej1HRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732129AbgKDWCm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 17:02:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54201 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731688AbgKDWBj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 17:01:39 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 71655A3DFB;
        Wed,  4 Nov 2020 17:01:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1KDYPii22Uag3cdFxkcQQZXhvTQ=; b=Waej1H
        RV/ZQzShIDkj/5TzdPmw+KUT+9xuJKfI0N7GhUGcZgmax3MeevejCtr8tQSgP7u7
        1BUbcQGEyopnALJa8s91IwE50L4NH7Fh2998hwXt0qAUcjLJHdHmMjporBTdnXgT
        luKNJqAdbSduiYo5t9tv9CZzixHcLz4PnEo5U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CZ4C1mw2o4WgQktTPKvNmNEXEWtUVWL6
        G9jNn0NelkSg3r3OB9WQ+z6ExH54Aog0z9ZccIG38k1dMaDkvTaQLl/p2BBnOfLt
        IVreo10vSKkccDTnMamXXozZxNVD4sSLj1giP1CPkF1LeuYQI/bFXrY06VS6t9jw
        q5gjalPOj/Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 69741A3DFA;
        Wed,  4 Nov 2020 17:01:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D974FA3DF9;
        Wed,  4 Nov 2020 17:01:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v2] doc: clarify that --abbrev=<n> is about the minimum length
References: <CAF7CYk51BC0KcsBb0KjKWAj17AMU2c9Y6Y81ddwX6oOAFYhT8w@mail.gmail.com>
        <xmqqk0v1q60l.fsf@gitster.c.googlers.com>
        <xmqqblgdq4k0.fsf_-_@gitster.c.googlers.com>
        <b7d6ea51-6aaa-bf74-2e19-1d1283001489@gmail.com>
Date:   Wed, 04 Nov 2020 14:01:37 -0800
In-Reply-To: <b7d6ea51-6aaa-bf74-2e19-1d1283001489@gmail.com> (Derrick
        Stolee's message of "Wed, 4 Nov 2020 08:24:35 -0500")
Message-ID: <xmqq8sbglr26.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4FBF9E76-1EE9-11EB-83C6-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Early text written in 2006 explains the "--abbrev=<n>" option to
"show only a partial prefix", without saying that the length of the
partial prefix is not necessarily the number given to the option to
ensure that the output names the object uniquely.

Update documentation for the diff family of commands, "blame",
"branch --verbose", "ls-files" and "ls-tree" to stress that the
short prefix must uniquely refer to an object, and <n> is merely
the mininum number of hexdigits used in the prefix.

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Thanks for your suggestion.  I decided to use "the shortest
   prefix that is at least <n> hexdigits long".


Range-diff:
1:  01c62c8d6f ! 1:  4f8524079c doc: clarify that most --abbrev[=<n>] are about minimum length
    @@ Metadata
     Author: Junio C Hamano <gitster@pobox.com>
     
      ## Commit message ##
    -    doc: clarify that most --abbrev[=<n>] are about minimum length
    +    doc: clarify that --abbrev=<n> is about the minimum length
     
         Early text written in 2006 explains the "--abbrev=<n>" option to
         "show only a partial prefix", without saying that the length of the
         partial prefix is not necessarily the number given to the option to
         ensure that the output names the object uniquely.
     
    -    Luckily, the text written for "git describe" in 2011 explains that
    -    the output is made to name the object uniquely using at least <n>
    -    hexdigits much clearly.
    -
    -    Model the explanation and update documentation for the diff family
    -    of commands, "blame", "branch --verbose", "ls-files" and "ls-tree".
    +    Update documentation for the diff family of commands, "blame",
    +    "branch --verbose", "ls-files" and "ls-tree" to stress that the
    +    short prefix must uniquely refer to an object, and <n> is merely
    +    the mininum number of hexdigits used in the prefix.
     
    +    Helped-by: Derrick Stolee <dstolee@microsoft.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## Documentation/diff-options.txt ##
    @@ Documentation/diff-options.txt: endif::git-format-patch[]
      	Instead of showing the full 40-byte hexadecimal object
      	name in diff-raw format output and diff-tree header
     -	lines, show only a partial prefix.
    -+	lines, show <n> hexadecimal digits, or as many digits
    -+	as needed to form a unique object name.
    ++	lines, show the shortest prefix that is at least '<n>'
    ++	hexdigits long that uniquely refers the object.
      	In diff-patch output format, `--full-index` takes higher
      	precedence, i.e. if `--full-index` is specified, full blob
      	names will be shown regardless of `--abbrev`.
    @@ Documentation/git-branch.txt: This option is only applicable in non-verbose mode
     -	Alter the sha1's minimum display length in the output listing.
     +--abbrev=<n>::
     +	In the verbose listing that show the commit object name,
    -+	use <n>, or as many hexdigits as needed to form a unique
    -+	object name.
    ++	show the shortest prefix that is at least '<n>' hexdigits
    ++	long that uniquely refers the object.
      	The default value is 7 and can be overridden by the `core.abbrev`
      	config option.
      
    @@ Documentation/git-ls-files.txt: a space) at the start of each line:
      --abbrev[=<n>]::
      	Instead of showing the full 40-byte hexadecimal object
     -	lines, show only a partial prefix.
    -+	lines, show <n>, or as many hexadecimal digits
    -+	as needed, to form a unique object name.
    ++	lines, show the shortest prefix that is at least '<n>'
    ++	hexdigits long that uniquely refers the object.
      	Non default number of digits can be specified with --abbrev=<n>.
      
      --debug::
    @@ Documentation/git-ls-tree.txt: OPTIONS
      --abbrev[=<n>]::
      	Instead of showing the full 40-byte hexadecimal object
     -	lines, show only a partial prefix.
    -+	lines, show <n>, or as many hexadecimal digits
    -+	as needed, to form a unique object name.
    ++	lines, show the shortest prefix that is at least '<n>'
    ++	hexdigits long that uniquely refers the object.
      	Non default number of digits can be specified with --abbrev=<n>.
      
      --full-name::
    @@ Documentation/pretty-options.txt: configuration (see linkgit:git-config[1]).
      --abbrev-commit::
      	Instead of showing the full 40-byte hexadecimal commit object
     -	name, show only a partial prefix.  Non default number of
    -+	name, show only a partial prefix that names the object uniquely.
    -+	Non default number of
    - 	digits can be specified with "--abbrev=<n>" (which also modifies
    - 	diff output, if it is displayed).
    +-	digits can be specified with "--abbrev=<n>" (which also modifies
    +-	diff output, if it is displayed).
    ++	name, show a prefix that names the object uniquely.
    ++	"--abbrev=<n>" (which also modifies diff output, if it is displayed)
    ++	option can be used to specify the minimum length of the prefix.
      +
    + This should make "--pretty=oneline" a whole lot more readable for
    + people using 80-column terminals.

 Documentation/diff-options.txt   | 3 ++-
 Documentation/git-blame.txt      | 4 +++-
 Documentation/git-branch.txt     | 8 +++++---
 Documentation/git-ls-files.txt   | 5 +++--
 Documentation/git-ls-tree.txt    | 3 ++-
 Documentation/pretty-options.txt | 6 +++---
 6 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 573fb9bb71..706c69bc82 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -446,7 +446,8 @@ endif::git-format-patch[]
 --abbrev[=<n>]::
 	Instead of showing the full 40-byte hexadecimal object
 	name in diff-raw format output and diff-tree header
-	lines, show only a partial prefix.
+	lines, show the shortest prefix that is at least '<n>'
+	hexdigits long that uniquely refers the object.
 	In diff-patch output format, `--full-index` takes higher
 	precedence, i.e. if `--full-index` is specified, full blob
 	names will be shown regardless of `--abbrev`.
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 7e81541996..34b496d485 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -87,7 +87,9 @@ include::blame-options.txt[]
 
 --abbrev=<n>::
 	Instead of using the default 7+1 hexadecimal digits as the
-	abbreviated object name, use <n>+1 digits. Note that 1 column
+	abbreviated object name, use <m>+1 digits, where <m> is at
+	least <n> but ensures the commit object names are unique.
+	Note that 1 column
 	is used for a caret to mark the boundary commit.
 
 
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index ace4ad3da8..adaa1782a8 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git branch' [--color[=<when>] | --no-color] [--show-current]
-	[-v [--abbrev=<length> | --no-abbrev]]
+	[-v [--abbrev=<n> | --no-abbrev]]
 	[--column[=<options>] | --no-column] [--sort=<key>]
 	[--merged [<commit>]] [--no-merged [<commit>]]
 	[--contains [<commit>]] [--no-contains [<commit>]]
@@ -194,8 +194,10 @@ This option is only applicable in non-verbose mode.
 	Be more quiet when creating or deleting a branch, suppressing
 	non-error messages.
 
---abbrev=<length>::
-	Alter the sha1's minimum display length in the output listing.
+--abbrev=<n>::
+	In the verbose listing that show the commit object name,
+	show the shortest prefix that is at least '<n>' hexdigits
+	long that uniquely refers the object.
 	The default value is 7 and can be overridden by the `core.abbrev`
 	config option.
 
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 3cb2ebb438..cbcf5263dd 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -19,7 +19,7 @@ SYNOPSIS
 		[--exclude-standard]
 		[--error-unmatch] [--with-tree=<tree-ish>]
 		[--full-name] [--recurse-submodules]
-		[--abbrev] [--] [<file>...]
+		[--abbrev[=<n>]] [--] [<file>...]
 
 DESCRIPTION
 -----------
@@ -153,7 +153,8 @@ a space) at the start of each line:
 
 --abbrev[=<n>]::
 	Instead of showing the full 40-byte hexadecimal object
-	lines, show only a partial prefix.
+	lines, show the shortest prefix that is at least '<n>'
+	hexdigits long that uniquely refers the object.
 	Non default number of digits can be specified with --abbrev=<n>.
 
 --debug::
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index a7515714da..db02d6d79a 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -62,7 +62,8 @@ OPTIONS
 
 --abbrev[=<n>]::
 	Instead of showing the full 40-byte hexadecimal object
-	lines, show only a partial prefix.
+	lines, show the shortest prefix that is at least '<n>'
+	hexdigits long that uniquely refers the object.
 	Non default number of digits can be specified with --abbrev=<n>.
 
 --full-name::
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 17c5aac4b7..27ddaf84a1 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -16,9 +16,9 @@ configuration (see linkgit:git-config[1]).
 
 --abbrev-commit::
 	Instead of showing the full 40-byte hexadecimal commit object
-	name, show only a partial prefix.  Non default number of
-	digits can be specified with "--abbrev=<n>" (which also modifies
-	diff output, if it is displayed).
+	name, show a prefix that names the object uniquely.
+	"--abbrev=<n>" (which also modifies diff output, if it is displayed)
+	option can be used to specify the minimum length of the prefix.
 +
 This should make "--pretty=oneline" a whole lot more readable for
 people using 80-column terminals.
-- 
2.29.2-287-gba574db674

