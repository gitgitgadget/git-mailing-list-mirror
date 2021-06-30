Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87584C11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 20:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 625FF6145A
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 20:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbhF3Uqg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 16:46:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52976 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhF3Uqg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 16:46:36 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C6999CBECA;
        Wed, 30 Jun 2021 16:44:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Xa18OSnPztzR
        X8Zd/t7oA9SJqyK/i2I98A+Hp9w81U4=; b=ZTr74DNMrqhKAEbDG90mqK8EaOjf
        y+P9JBuF2WoKpEr46mZ2KsHEg13MaQ+7AuZlUYr0TRZ3qQ9ITMbx+yoIqNICBDZz
        gX+4IX0ETEdQ72Cd/9f4Adq+VRXu7tKfZ0qMW4MUiQAM2pods879pTSfXtas68AB
        MeIaZpeqAyAO4pk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BC7F7CBEC9;
        Wed, 30 Jun 2021 16:44:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2B73FCBEC8;
        Wed, 30 Jun 2021 16:44:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 1/2] t6400: preserve git ls-files exit status code
References: <20210615172038.28917-1-congdanhqx@gmail.com>
        <cover.1624974969.git.congdanhqx@gmail.com>
        <49104273b8b801fc61811347120c5f4c42a3700b.1624974969.git.congdanhqx@gmail.com>
        <CAPig+cSKOzebGRyoytUGORhq56P0rijYrKO6uu7q7fWnzwiQkw@mail.gmail.com>
        <xmqqk0mcuw0e.fsf@gitster.g>
        <CAPig+cRu9Sh7gKi37Hj9nj+A0zZvmrrJgaVZepsD0Y-618tmvw@mail.gmail.com>
        <xmqqa6n8uipn.fsf@gitster.g> <YNxPEb4V3SIqGRl9@danh.dev>
Date:   Wed, 30 Jun 2021 13:44:04 -0700
In-Reply-To: <YNxPEb4V3SIqGRl9@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcuG6p24g?=
 =?utf-8?B?Q8O0bmc=?= Danh"'s message of
        "Wed, 30 Jun 2021 18:01:37 +0700")
Message-ID: <xmqqzgv7t757.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E8D67232-D9E3-11EB-9CC2-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

>> Could be, except that I recall we saw extra noises like --out/--err
>> that weren't used and contaminating the current working directory,
>> which are gone from the latest iteration.
>
> Yes, in v{1,2}, there's the extra noises of --out and --err,
> but it's gone in v3.
>
> I guess you're thinking about the contamination of $PWD iff it's not
> a git worktree. That could be simplified by BUG-ging if $PWD is not
> a git worktree.

No.  I am not thinking about that.  I do not think it is a big loss
if the helper cannot be used in non-repository.

> Maybe, you're thinking about the extra noises to handle the failure run
> of command under check? That could be dropped, too.

No.  I am not thinking about that, either.

> Would you mind looking at v3 1/4 again to see what is your opinion
> there? I don't mind re-roll a same or simplified version of v3,
> with s/test_line_count_cmd/test_output_wc_l/ if you see fit.

Let's not go back that far.  This is taken from v4 (t/t6400) ...

	local ops val &&
	if test "$#" -le 2
	then
		BUG "Expect 2 or more arguments"
	fi &&
	ops=3D"$1" &&
	val=3D"$2" &&
	shift 2 &&
	mkdir -p .git/trash &&
	"$@" >.git/trash/output &&
	test_line_count "$ops" "$val" .git/trash/output

... except that it runs '"$@"' instead of 'git ls-files "$@"', so
that we could try running things other than ls-files, and that would
be mostly good enough.  We may want to be prepared for a caller who
wants to use the helper from within a subdirectory by not hardcoding
".git/trash", though.  Something along the lines of ...

	local ops val &&
+	local trashdir=3D$(git rev-parse --git-dir)/trash &&
	if test ...
	...
-	mkdir -p .git/trash &&
-	"$@" >".git/trash/output" &&
-	test_line_count "$ops" "$val" .git/trash/output
+	mkdir -p "$trashdir" &&
+	"$@" >"$trashdir/output" &&
+	test_line_count "$ops" "$val" "$trashdir/output"
