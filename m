Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF31C433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 07:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E32D2611ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 07:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbhEQHrX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 03:47:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50834 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbhEQHrW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 03:47:22 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F1B52B9E85;
        Mon, 17 May 2021 03:46:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=1Vu/vkS+brbs/RKprIgQ/aVCI33FJW/UHUMAn3WT1kc=; b=gJl1
        VhWji7Qi5nbC3mqrSVv7PIDFsVfDhWgLTvkUlBpntYksqOO9g7sJljzgEDx7hBXo
        SL77i2uXBWrMozx8MQh2XXuoWRHsyK/Z61FqDVbhrC1qlKnAFDVL8f8F1BhZUuvU
        v/NWVaEtHfj3iXjUkAXSi2YjYlXbcQn1l5T2ZKw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E4B0CB9E84;
        Mon, 17 May 2021 03:46:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A917AB9E83;
        Mon, 17 May 2021 03:46:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>
Subject: Re* [PATCH] doc: glossary: add entry for revision range
References: <20210516203736.1098072-1-felipe.contreras@gmail.com>
Date:   Mon, 17 May 2021 16:46:02 +0900
Message-ID: <xmqqbl993irp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE5207EE-B6E3-11EB-9EC4-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Revision ranges are one of the most pervasive concepts in Git. It belongs
> in the glossary.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/glossary-content.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index 67c7a50b96..31151277ba 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -554,6 +554,10 @@ The most notable example is `HEAD`.
>  [[def_revision]]revision::
>  	Synonym for <<def_commit,commit>> (the noun).
>  
> +[[def_revision_range]]revision range::
> +        A syntax to specify a list of commits, usually indicating the starting
> +        and ending points. For example: `master..@`.

As there is no need to spell out HEAD, `master..` would be a better
example.  Especially since most people are downstream consumers, I'd
suggest using `origin..` or `@{u}..` here.  Either is in line with
the spirit of the example in the patch that asks "what did I do on
my own on this branch since I forked?".  Incidentally, it also
avoids fruitless arguments about what the name of the primary
integration branch ought to be.

Also "see the 'Specifying Ranges' and 'Revision Range Summary'
sections of linkgit:gitrevisions[7] for details" would be a helpful
addition to readers.  Since there are examples there, we may even be
able to drop "For example..." from here and have just refer the
readers to these sections.

By the way, this reminds of me one thing that seems to occasionally
confuse new people.  Most Git commands take a single range, even
though you can give multiple bottoms and tops.  This is because a
revision range is *not* just a random "list" of commits, but a single
connected set of commits, and to new people, the distinction between
them seems to be a bit unclear.

We may want to clarify with something like the following.

 Documentation/revisions.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git c/Documentation/revisions.txt w/Documentation/revisions.txt
index d9169c062e..2b7d8e3745 100644
--- c/Documentation/revisions.txt
+++ w/Documentation/revisions.txt
@@ -260,6 +260,9 @@ any of the given commits.
 A commit's reachable set is the commit itself and the commits in
 its ancestry chain.
 
+There are several notations to specify a set of connected commits
+(called a "revision range"), illustrated below.
+
 
 Commit Exclusions
 ~~~~~~~~~~~~~~~~~
@@ -294,6 +297,20 @@ is a shorthand for 'HEAD..origin' and asks "What did the origin do since
 I forked from them?"  Note that '..' would mean 'HEAD..HEAD' which is an
 empty range that is both reachable and unreachable from HEAD.
 
+Commands that are specifically designed to take two distinct ranges
+(e.g. "git range-diff R1 R2" to compare two ranges) do exist, but
+they are exceptions.  Unless otherwise noted, all "git" commands
+that operate on set of commits work on a single revision range.  In
+other words, giving two dotted ranges next to each other, e.g.
+
+    $ git log 'r1..r2' 'r3..r4'
+
+does *not* specify two revision ranges for most commands.  Instead
+it will name a single connected set of commits, i.e. those that are
+reachable from either r2 or r4 but are reachable from neither r1 or
+r3.
+
+
 Other <rev>{caret} Parent Shorthand Notations
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Three other shorthands exist, particularly useful for merge commits,
