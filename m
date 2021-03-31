Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E7FC433ED
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 22:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB07C60FF2
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 22:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbhCaWdl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 18:33:41 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57982 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbhCaWd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 18:33:28 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 837371249F0;
        Wed, 31 Mar 2021 18:33:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ze5ZGbu/5uaN
        5O7Ey5qb7yJCXHw=; b=GPVuwvOHn93aGQdzfPfNHuDB+JjfL3sT0eIa6Ah+7yTT
        WTNVrsYYMDj63mAH8B4CLgaAiGt4WswZ8wi2lSJWzKq1HiOFIQqnhfQOrmuLdPXm
        3nT8km/U1R6t3cdcqz6MNTzd5VHc0E7z9tFQaJN9OR4haEU3vyfOgHrnDYUozCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=peDdAr
        fpLIoe3nw/KkC0bexNC9y7S9pgfXhqeCk1iDDaXj4eOeZ7jSOIucaz0ybaW2KsPw
        KDf2HD3pZxvT7zXUvYx4U+7wlCIJJitorq6YczMVJ82pgPPqJfZY55o63k8Jlkt2
        274z++OuS33+1wBYc8RwO/EA5yIgxmxJI4gQ8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6A7911249EF;
        Wed, 31 Mar 2021 18:33:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 92B5B1249E5;
        Wed, 31 Mar 2021 18:33:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v5 01/18] cache.h: add a comment to object_type()
In-Reply-To: <patch-01.19-a74e02ff0ba-20210331T190531Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 31 Mar
 2021 21:09:29
        +0200")
References: <87o8fcqrg8.fsf@evledraar.gmail.com>
        <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
        <patch-01.19-a74e02ff0ba-20210331T190531Z-avarab@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
Date:   Wed, 31 Mar 2021 15:33:23 -0700
Message-ID: <xmqqpmzf54y4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1B8DA8F4-9271-11EB-9EAC-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add a comment to the object_type() function to explain what it
> returns, and what the "mode" is in the "else" case.
>
> The object_type() function dates back to 4d1012c3709 (Fix rev-list
> when showing objects involving submodules, 2007-11-11). It's not
> immediately obvious to someone looking at its history and how it's
> come to be used.
>
> Despite what Linus noted in 4d1012c3709 (Fix rev-list when showing
> objects involving submodules, 2007-11-11) about wanting to move away
> from users of object_type() relying on S_ISLNK(mode) being true here
> we do currently rely on that.

You are misreading Linus's comment here.

The comment is not about "S_ISLNK()" specifically.  It is about
assuming that any "S_ISx()" macros that are designed to work on
stat.st_mode would work the same way for our "mode bits in tree"
(i.e. 'internal git state' in the commit message refers to this
fact).  Platforms do not have to have 100xxx to be regular files,
but we did rely on that bit assignment.

And then we invented S_ISGITLINK() that exists on nobody's
stat.st_mode and have been assuming that would not collide
with any real S_IFMT bit assignment.

All of that has been patched with NEEDS_MODE_TRANSLATION band-aid
quite some time ago, though, with d543d9c0 (compat: convert modes to
use portable file type values, 2014-12-03).

So, no, we do not quite rely on that anymore.

> If this is changed to a condition to
> only return OBJ_BLOB on S_ISREG(mode) then t4008, t4023 and t7415 will
> have failing tests.

Specifically, the comment is not about symbolic links, and nobody
who reads the comment correctly would imagine that limiting BLOB
to S_ISREG.  The comment merely was lamenting that

	"If ISDIR, then tree and otherwise blob" does not hold
	anymore since we added submodules; "If ISDIR, then tree, and
	if ISGITLINK, then commit and otherwise blob" would fix it,
	but relying on ISDIR, ISGITLINK, etc. was a mistake that we
	continue to rely on even with this fix.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---

Which means that a lot of the stuff in the proposed log message is
false.  I do however think that ...

>  cache.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/cache.h b/cache.h
> index 57f2285bba9..41e99bd9c63 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -451,11 +451,16 @@ enum object_type {
>  	OBJ_MAX
>  };


> +/*
> + * object_type() returns an object of a type that'll appear in a tree,
> + * so no OBJ_TAG is possible. This is mostly (and dates back to)
> + * consumers of the tree-walk.h API's "mode" field.
> + */

... this comment is correct and it is a good change to clarify what
'mode' we are talking about here.

>  static inline enum object_type object_type(unsigned int mode)
>  {
>  	return S_ISDIR(mode) ? OBJ_TREE :
>  		S_ISGITLINK(mode) ? OBJ_COMMIT :
> -		OBJ_BLOB;
> +		OBJ_BLOB; /* S_ISREG(mode) || S_ISLNK(mode) */

For futureproofing, it might not be a bad idea to do this:

	S_ISDIR(mode) ? OBJ_TREE :
	S_ISGITLINK(mode) ? OBJ_COMMIT :
	(S_ISREG(mode) || S_ISLNK(mode)) ? OBJ_BLOB :
	OBJ_ERROR;

to anticipate new tree mode bits so that the need for a fix similar
to 4d1012c3 (Fix rev-list when showing objects involving submodules,
2007-11-11) is immediately noticed, but for now, code and comment
clarification would be sufficient.

The proposed log message needs rewriting, though.

Thanks.


