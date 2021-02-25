Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F48C433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 03:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49D2E64E90
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 03:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236948AbhBYDDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 22:03:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63711 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236900AbhBYDDE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 22:03:04 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D37C398FCF;
        Wed, 24 Feb 2021 22:02:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SpKBj4Hr4p4w
        /bMCrhLWwZXRW10=; b=DkGwyKt521PEKyjoGCdKSXztj9SapBOGzusf2wV+VryV
        530nLHp6zGJlC9qUK6wyoBej7Pi+sfBiz9LEQFTDTGDVtvrXbZtZ2Mx3wSFdtxm0
        W72Vuju1/Nh5nKPObLRzEYsRDqQVYtq2IzFBcHh2wRoL+nkt9sEUZ0QP/OAxv2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=L+FMbd
        YDjTfdF3OebXx+Qm26hfKuKYtA4MEf8SvffzAZtDiDUVKC4Wta5/Td7zGV/Bq2g3
        J2yCxFNIA2w6XQHKwzs1kB8I+q0Ow3G7x7+9OGVutSfWY9pPlUn9QxioRVxlUqgf
        2j36pJmmgpdrETuKJbSltI9+KvMNpBiLhAFKM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CA9CD98FCE;
        Wed, 24 Feb 2021 22:02:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 581F998FCB;
        Wed, 24 Feb 2021 22:02:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 1/2] remote: add camel-cased *.tagOpt key, like clone
References: <20210225012117.17331-1-avarab@gmail.com>
Date:   Wed, 24 Feb 2021 19:02:19 -0800
In-Reply-To: <20210225012117.17331-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 25 Feb 2021 02:21:16 +0100")
Message-ID: <xmqq1rd4yhms.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E029809C-7715-11EB-B5CF-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change "git remote add" so that it adds a *.tagOpt key, and not the
> lower-cased *.tagopt on "git remote add --no-tags", just as "git clone
> --no-tags" would do.
>
> This doesn't matter for anything that reads the config. It's just
> prettier if we write config keys in their documented camelCase form to
> user-readable config files.
>
> When I added support for "clone -no-tags" in 0dab2468ee5 (clone: add a
> --no-tags option to clone without tags, 2017-04-26) I made it use
> the *.tagOpt form, but the older "git remote add" added in
> 111fb858654 (remote add: add a --[no-]tags option, 2010-04-20) has
> been using *.tagopt all this time.
>
> It's easy enough to add a test for this, so let's do that. We can't
> use "git config -l" there, because it'll normalize the keys to their
> lower-cased form. Let's add the test for "git clone" too for good
> measure, not just to the "git remote" codepath we're fixing.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>
> I also noticed that we write e.g. init.objectformat instead of
> init.objectFormat, and core.logallrefupdates etc. If anyone's got an
> even even worse case of OCD there's an interesting #leftoverbits
> project there of scouring the code for more cases of this sort of
> thing...
>
>  builtin/remote.c         | 2 +-
>  t/t5505-remote.sh        | 1 +
>  t/t5612-clone-refspec.sh | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index d11a5589e49..f286ae97538 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -221,7 +221,7 @@ static int add(int argc, const char **argv)
> =20
>  	if (fetch_tags !=3D TAGS_DEFAULT) {
>  		strbuf_reset(&buf);
> -		strbuf_addf(&buf, "remote.%s.tagopt", name);
> +		strbuf_addf(&buf, "remote.%s.tagOpt", name);

Good find.

A general rule for a name used to refer to a configuration variable
the C code ought to be

 - if it is used to match what the system gave us, make sure we use
   all lowercase for the first and the last component and match with
   strcmp(), not with strcasecmp().

 - if it is used to update, make sure we use the canonical spelling,
   if only for the documentation value.

> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 045398b94e6..2a7b5cd00a0 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -594,6 +594,7 @@ test_expect_success 'add --no-tags' '
>  		cd add-no-tags &&
>  		git init &&
>  		git remote add -f --no-tags origin ../one &&
> +		grep tagOpt .git/config &&
>  		git tag -l some-tag >../test/output &&
>  		git tag -l foobar-tag >../test/output &&
>  		git config remote.origin.tagopt >>../test/output
> diff --git a/t/t5612-clone-refspec.sh b/t/t5612-clone-refspec.sh
> index 6a6af7449ca..3126cfd7e9d 100755
> --- a/t/t5612-clone-refspec.sh
> +++ b/t/t5612-clone-refspec.sh
> @@ -97,6 +97,7 @@ test_expect_success 'by default no tags will be kept =
updated' '
>  test_expect_success 'clone with --no-tags' '
>  	(
>  		cd dir_all_no_tags &&
> +		grep tagOpt .git/config &&
>  		git fetch &&
>  		git for-each-ref refs/tags >../actual
>  	) &&
