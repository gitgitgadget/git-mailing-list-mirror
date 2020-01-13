Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5361C33CA9
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 22:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF8F21556
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 22:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lvc2DyPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgAMWdg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 17:33:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65275 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgAMWdg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 17:33:36 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B8782192A7;
        Mon, 13 Jan 2020 17:33:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Hd/ijuj624av
        c7NJSKm96FdbtRc=; b=lvc2DyPb3OJVWfmAxBiddvydCdvl+uEhn1AXe3OPRlFw
        ERF5AAr8ekAw5BlIkCKExTOIUA1ZXts3Y6PoChqMVnzoDEP7pn4Nao4+J43TLPfW
        0hoL+YgfWvbql7ufxR9e6YMeUSqf3X+WEhygpx62a0I9F8bUu5NvAyUUNU+CvD8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=M6GaFe
        hssgAvs6rfxMhT/7l6eD77XXi9PKan0jUToLtYy8mIdKH+mM3+6T93u+rzTfwqD4
        l95r+L6QpCTYD/J9racfJgg0sEXHbezB8+zqswgMM6gDQFyC/3eJ6uNkizpD1+eI
        ayau4+DPal6xqS6ILbt8ceJrpJvetlcTgJQEI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B0F54192A6;
        Mon, 13 Jan 2020 17:33:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 20E65192A4;
        Mon, 13 Jan 2020 17:33:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Bowersox <kevin.m.bowersox@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re* Potential Issue with ls-tree documentation
References: <18b8b8fd-ee38-e1bf-8fae-b719b7b78a75@gmail.com>
Date:   Mon, 13 Jan 2020 14:33:27 -0800
In-Reply-To: <18b8b8fd-ee38-e1bf-8fae-b719b7b78a75@gmail.com> (Kevin
        Bowersox's message of "Sat, 11 Jan 2020 04:46:33 -0500")
Message-ID: <xmqqk15vj8aw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B8A97430-3654-11EA-B237-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Bowersox <kevin.m.bowersox@gmail.com> writes:

> Within the ls-tree documentation for Git found here:
> https://git-scm.com/docs/git-ls-tree
> <https://git-scm.com/docs/git-ls-tree>
>
> It mentions the following:
>
> the behaviour is slightly different from that of "/bin/ls" in that the
> <path>=C2=A0denotes just a list of patterns to match, e.g. so specifyin=
g
> directory name (without |-r|) will behave differently, and order of
> the arguments does not matter.

The above description is solely focused on the pathspec part of the
argument list and the text needs to clarify that.  In other words,
the above paragraph only wants to say:

    Among the paths in the given tree-ish, a subset of paths are
    chosen to be shown by using pathspec, and the way these pathspec
    arguments are used is different from how "/bin/ls" uses its
    arguments.

The "order of the arguments" part is better read as if there is
the word "pathspec" before "arguments" for clarity.  As the synopsis
makes it clear, <tree-ish> must come before the pathspec, so the
order of that part would not be flexible, obviously.

Thanks.

Perhaps something like this?

-- >8 --
Subject: ls-tree doc: clarify and modernize pathspec description

We have been updating our docs to consistently say <pathspec> when
an argument is one and not a path; "ls-tree" takes a tree-ish and
optionally pathspec, so use the correct term.

It is correct that the order of pathspec arguments do not make a
difference in the output unlike the order of path arguments given to
"/bin/ls", but the existing documentation can be misread to allow
having even the <tree-ish> argument at a random place on the command
line, which obviously was not what the original authors intended to
say.  Clarify it.

Noticed-by: Kevin Bowersox <kevin.m.bowersox@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-ls-tree.txt | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.tx=
t
index a7515714da..aa368a8d14 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -11,19 +11,20 @@ SYNOPSIS
 [verse]
 'git ls-tree' [-d] [-r] [-t] [-l] [-z]
 	    [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev=
[=3D<n>]]
-	    <tree-ish> [<path>...]
+	    <tree-ish> [<pathspec>...]
=20
 DESCRIPTION
 -----------
 Lists the contents of a given tree object, like what "/bin/ls -a" does
 in the current working directory.  Note that:
=20
- - the behaviour is slightly different from that of "/bin/ls" in that th=
e
-   '<path>' denotes just a list of patterns to match, e.g. so specifying
-   directory name (without `-r`) will behave differently, and order of t=
he
+ - The way <pathspec> is used is slightly different from how "/bin/ls" u=
ses
+   its paths arguments, in that '<pathspec>' denotes just a list of
+   patterns to match, e.g. so specifying directory name (without
+   `-r`) will behave differently, and the order of the pathspec
    arguments does not matter.
=20
- - the behaviour is similar to that of "/bin/ls" in that the '<path>' is
+ - the behaviour is similar to that of "/bin/ls" in that the '<pathspec>=
' is=09
    taken as relative to the current working directory.  E.g. when you ar=
e
    in a directory 'sub' that has a directory 'dir', you can run 'git
    ls-tree -r HEAD dir' to list the contents of the tree (that is
@@ -73,10 +74,8 @@ OPTIONS
 	Do not limit the listing to the current working directory.
 	Implies --full-name.
=20
-[<path>...]::
-	When paths are given, show them (note that this isn't really raw
-	pathnames, but rather a list of patterns to match).  Otherwise
-	implicitly uses the root level of the tree as the sole path argument.
+[<pathspec>...]::
+	When pathspec is given, only show paths that match the pattern.
=20
=20
 Output Format


