Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C53C433C1
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 00:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFB1B61A1E
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 00:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhCZAmT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 20:42:19 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53566 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhCZAlu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 20:41:50 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0CD84110524;
        Thu, 25 Mar 2021 20:41:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=u9wObKUs1ujs
        2d2EjBH9xRXvzEo=; b=HbuDPyk/ksKuN6wKvdsoXoj+pdhrnUFkLQCM26ntF+GS
        Yogt6orxHdpIGwQ3Ew76PkS6VycjoYXkCaj3bL9gYvfZWcnH+HQ5OpXHTyV8Hxf0
        X8RXeYo8qo4tAxO/VM4cGOUUlCLFmtBSTAD6X300M6uS1kSayM1qvrjWKrku0hc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=fZVLJS
        8LBHlpGmb6I5Dq5dpI186EfHXfAOQMV+vqi4d88mkEJJiRgy34d0rt8moVDOUJXF
        tG9kH7gM1PmB+qwO4pY1lLte8P8wL1HFIr8yFTRrrd2/VlVulIJ1uZ5vy8sa2q24
        oNwWfsvYoqf5L9/GePPFl/566jNTwt9skl2Qo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 04E71110523;
        Thu, 25 Mar 2021 20:41:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 44FDB110522;
        Thu, 25 Mar 2021 20:41:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?utf-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr0=?= =?utf-8?B?z4TOv8+C?= 
        <stdedos+git@gmail.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 1/1] pathspec: warn for a no-glob entry that contains
 `**`
References: <xmqqft1iquka.fsf@gitster.g>
        <20210325233648.31162-2-stdedos+git@gmail.com>
Date:   Thu, 25 Mar 2021 17:41:45 -0700
In-Reply-To: <20210325233648.31162-2-stdedos+git@gmail.com>
 (=?utf-8?B?Is6jz4TOsc+Nz4HOv8+CCc6dz4TOrc69z4TOv8+CIidz?= message of "Fri,
 26 Mar 2021 01:36:49 +0200")
Message-ID: <xmqq35wiu4om.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0BA2C89C-8DCC-11EB-BC53-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82 =CE=9D=CF=84=CE=AD=CE=BD=CF=84=
=CE=BF=CF=82"  <stdedos@gmail.com> writes:

> From: Stavros Ntentos <133706+stdedos@users.noreply.github.com>
>
> If a pathspec given that contains `**`, chances are that someone is
> naively expecting that it will do what the manual has told him
> (i.e. that `**` will match 0-or-more directories).

OK. this is a well written introduction of the problem being solved.

But chances are that the user may have meant to give double-asterisk
just out of habit, very well knowing that it would not be an error
to give ** when a single * suffices.

Which leads us to suspect that it is a bad change to make this a
warning that unconditionally fires and cannot squelch.  It may be
better to implement it as an advice, where the user who knowingly
uses that construct can say "yes, I know what I am doing" and
squelch it.

> However, without an explicit `:(glob)` magic, that will fall out the sk=
y:
> the two `**` will merge into one star, which surrounded by slashes, wil=
l
> match any directory name.

I am not sure everything after the "the sky:" you wrote is what you
meant to write.  Without being marked with a "glob" magic, a
wildcard character in a pattern matches even a slash, so these two

	git ls-files 'Documentation**v2.txt'
	git ls-files 'Documentation*v2.txt'

give the identical result and there is nothing about "surrounded by
slashes" involved in it.

So, perhaps taking the first two paragraphs together and rewriting:

	When '/**/' appears in the pathspec, the user may be
	expecting that it would be matched using the "wildmatch"
	semantics, matching 0 or more directories.  But that is
	not what happens without ":(glob)" magic.

or did you want to warn about "foo**bar" as if it were "foo/**/bar"?

The output from these commands:

	git ls-files ':(glob)Documentation/**/*stash.txt'
	git ls-files ':(glob)Documentation***stash.txt'
	git ls-files ':(glob)Documentation**stash.txt'

seems to tell me that the "zero-or-more directories" magic happens
only when /**/ form is used, not when two asterisks are placed next
to each other in a random context.

> These changes attempt to bring awareness to this issue.

In any case, after presenting what problem we are trying to address,
we present our approach / solution in a form as if we are giving
orders to the codebase to "become like so".

	Teach the pathspec parser to emit an advice message when a
	substring "/**/" appears in a pathspec element that does not
	have a ":(glob)" magic.  Make sure we don't disturb users
	who use ":(literal)" magic with such a substring, as it is
	clear they want to find these strings literally.

perhaps.

> Signed-off-by: Stavros Ntentos <133706+stdedos@users.noreply.github.com=
>
> ---
>  pathspec.c                 | 13 +++++++++++++
>  pathspec.h                 |  1 +
>  t/t6130-pathspec-noglob.sh | 13 +++++++++++++
>  3 files changed, 27 insertions(+)
>
> diff --git a/pathspec.c b/pathspec.c
> index 7a229d8d22..d5b9c0d792 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -1,3 +1,4 @@
> +#include <string.h>

Never include any header file before including <git-compat-util.h>.
Including <git-compat-util.h> indirectly by including <cache.h> or
<builtin.h> counts as including it as the first thing.

As all necessary standard system headers are supposed to be given by
including <git-compat-util.h>, if you needed to explicitly include
the above, that may mean <git-compat-util.h>, which should cause the
header that lists necessary function, is not working properly on
your platform and needs to be adjusted. Are you on a minority
platform we haven't adjusted the header inclusion order for, and
what function are you trying to use that does not work without
adding this extra #include here?  We already use strstr() in many
places, so that is not the function we are missing system includes
for.

Or perhaps this is a remnant of what you added while you were
experimenting, without realizing that "#include <cache.h>" that is
already there already gives you anything you need.  If that is the
case, iow, if the code works without the extra include, please
remove that line.

> @@ -588,6 +589,8 @@ void parse_pathspec(struct pathspec *pathspec,
> =20
>  		init_pathspec_item(item + i, flags, prefix, prefixlen, entry);
> =20
> +		check_missing_glob(entry, item[i].magic);
> +

We have only one caller of the helper (i.e. this one) and nowhere
else, and the helper is small enough ...

> @@ -739,3 +742,13 @@ int match_pathspec_attrs(const struct index_state =
*istate,
> =20
>  	return 1;
>  }
> +
> +void check_missing_glob(const char *pathspec_entry, int flags) {
> +	if (flags & (PATHSPEC_GLOB | PATHSPEC_LITERAL)) {
> +		return;
> +	}
> +
> +	if (strstr(pathspec_entry, "**")) {
> +		warning(_("Pathspec provided contains `**`, but no :(glob) magic.\nI=
t will not match 0 or more directories!"));
> +	}
> +}

... hence, there is no reason why this helper should exist, let
alone be a public function.  Also, there is no reason to split the
conditional into two.  Just "it is OK if we have GLOB or LITERAL,
otherwise see if there is /**/" is sufficient.

It would be more sensible to just add the check to parse_pathspec()
directly.

Also, our warning messages do not begin with an uppercase.

See attached patch for all of the above, but it is for illustration
purposes only; not even compile tested.  I am not illustrating how
to turn this into an advice message that the user can squelch with
the illustration patch.

> diff --git a/t/t6130-pathspec-noglob.sh b/t/t6130-pathspec-noglob.sh
> index ba7902c9cd..af6cd16f76 100755
> --- a/t/t6130-pathspec-noglob.sh
> +++ b/t/t6130-pathspec-noglob.sh
> @@ -157,4 +157,17 @@ test_expect_success '**/ does not work with :(lite=
ral) and --glob-pathspecs' '
>  	test_must_be_empty actual
>  '
> =20

> +cat > expected <<"EOF"
> +warning: Pathspec provided contains `**`, but no :(glob) magic.
> +EOF

Please don't imitate ancient tests.  These days, all preparations
for individual tests, including the expected outcome, are to be done
inside the test itself.  Study nearby tests in the same script for
better examples.

> +test_expect_success '** without :(glob) warns of lacking glob magic' '
> +	test_might_fail git stash -- "**/bar" 2>warns &&
> +	grep -Ff expected warns

Same comment.  Nearby examples all set up expeced output and never
uses "grep" to see if the expectation is satisfied.  Imitate them.

> +'
> +
> +test_expect_success '** with :(literal) does not warn of lacking glob =
magic' '
> +	test_might_fail git stash -- ":(literal)**/bar" 2>warns &&
> +	! grep -Ff expected warns

Ditto.

Thanks.


 pathspec.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git i/pathspec.c w/pathspec.c
index 18b3be362a..5b0eed5a65 100644
--- i/pathspec.c
+++ w/pathspec.c
@@ -598,6 +598,10 @@ void parse_pathspec(struct pathspec *pathspec,
 			die(_("pathspec '%s' is beyond a symbolic link"), entry);
 		}
=20
+		if (!(item[i].magic & (PATHSPEC_GLOB | PATHSPEC_LITERAL)) &&
+		    strstr(entry, "**"))
+			warning(_("** in '%s'without :(glob) magic:"), entry);
+
 		if (item[i].nowildcard_len < item[i].len)
 			pathspec->has_wildcard =3D 1;
 		pathspec->magic |=3D item[i].magic;
