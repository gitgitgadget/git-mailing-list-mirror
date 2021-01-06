Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269FFC433E6
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 22:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E004B23132
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 22:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbhAFWWr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 17:22:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60878 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbhAFWWr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 17:22:47 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A21EA2E79;
        Wed,  6 Jan 2021 17:22:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qDbFMl55AM15
        DnhV6vaa+sEiRYU=; b=pklPk2TPky0gaCG/Jfl0fnOS2pKj5G95S6/uLCs2zvFP
        hwiDbQI7HcRYGR0ZW9PP6UChatfHHp8uE/Rl6U1LadFAP8W7JIUY4FjYAMcPkcHF
        7fpE3O9ZX6wP067oVaz95G2Jj5X6Ue/4RnqiL+JHdEK3nf/g0VRl/Kh4iQ48jaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Azick0
        ztEnqan5YD4FJ9jr+D88LGcHgQ1erZ5bKNDqAhsWYj+YrJ/iUlo8yDQCD1tZuVqO
        zfHA4u3tKOQyc65yB53GmRq+xoRwGqgdnhylB8KeeQ6Ad6AYKfwDHHIxlxfYWpuo
        E9FODAS4Wy0IbJMvlUDPaJGj/LfBTzUN7gGjc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D722A2E78;
        Wed,  6 Jan 2021 17:22:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 42F0CA2E77;
        Wed,  6 Jan 2021 17:22:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>
Subject: Re: [PATCH v6 23/23] mktag: add a --[no-]strict option
References: <xmqq4kjuygw7.fsf@gitster.c.googlers.com>
        <20210106114727.8405-1-avarab@gmail.com>
Date:   Wed, 06 Jan 2021 14:21:59 -0800
In-Reply-To: <20210106114727.8405-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 6 Jan 2021 12:47:27 +0100")
Message-ID: <xmqqmtxlpuyg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9860B768-506D-11EB-A256-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Now that mktag has been migrated to use the fsck machinery to check
> its input, it makes sense to teach it to run in the equivalent of "git
> fsck"'s default mode.
>
> For cases where mktag is used to (re)create a tag object using data
> from an existing and malformed tag object, the validation may
> optionally have to be loosened. Teach the command to take the
> "--[no-]strict" option to do so.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>
> On Wed, Jan 06 2021, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>>> Now that mktag has been migrated to use the fsck machinery to check
>>> its input, it makes sense to teach it to run in the equivalent of "gi=
t
>>> fsck"'s default mode, instead of hardcoding "git fsck --strict". Let'=
s
>>> do that and support the "--no-strict" option.
>>>
>>> Since this is a new option we don't need to cater to parse-option.c's
>>> default of automatically supporting --strict. So let's use
>>> PARSE_OPT_NONEG, using a new trivial helper macro.
>>
>> I do not understand the last paragraph.
>
> I forgot to update the commit message when changing this from
> v4->v5. Here's a v6 of just this patch (to save on list traffic) with
> an updated commit message. Thanks!

Okay.  I actually was expecting to hear the reason why the approach
taken in v4 to use PARSE_OPT_NONEG is a good one, but I take the
change of approach in v5 as the sign that you now agree with me that
a plain vanilla bool that happens to default to true is easier to
manage.

Will replace.  Thanks.

>
>  Documentation/git-mktag.txt |  8 ++++++++
>  builtin/mktag.c             |  9 +++++++++
>  t/t3800-mktag.sh            | 33 +++++++++++++++++++++++----------
>  3 files changed, 40 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
> index 79813ff8df0..17a2603a600 100644
> --- a/Documentation/git-mktag.txt
> +++ b/Documentation/git-mktag.txt
> @@ -11,6 +11,14 @@ SYNOPSIS
>  [verse]
>  'git mktag'
> =20
> +OPTIONS
> +-------
> +
> +--strict::
> +	By default mktag turns on the equivalent of
> +	linkgit:git-fsck[1] `--strict` mode. Use `--no-strict` to
> +	disable it.
> +
>  DESCRIPTION
>  -----------
> =20
> diff --git a/builtin/mktag.c b/builtin/mktag.c
> index 9b04b61c2bb..41a399a69e4 100644
> --- a/builtin/mktag.c
> +++ b/builtin/mktag.c
> @@ -10,6 +10,7 @@ static char const * const builtin_mktag_usage[] =3D {
>  	N_("git mktag"),
>  	NULL
>  };
> +static int option_strict =3D 1;
> =20
>  static struct fsck_options fsck_options =3D FSCK_OPTIONS_STRICT;
> =20
> @@ -25,6 +26,12 @@ static int mktag_fsck_error_func(struct fsck_options=
 *o,
>  {
>  	switch (msg_type) {
>  	case FSCK_WARN:
> +		if (!option_strict) {
> +			fprintf_ln(stderr, _("warning: tag input does not pass fsck: %s"), =
message);
> +			return 0;
> +
> +		}
> +		/* fallthrough */
>  	case FSCK_ERROR:
>  		/*
>  		 * We treat both warnings and errors as errors, things
> @@ -67,6 +74,8 @@ static int verify_object_in_tag(struct object_id *tag=
ged_oid, int *tagged_type)
>  int cmd_mktag(int argc, const char **argv, const char *prefix)
>  {
>  	static struct option builtin_mktag_options[] =3D {
> +		OPT_BOOL(0, "strict", &option_strict,
> +			 N_("enable more strict checking")),
>  		OPT_END(),
>  	};
>  	struct strbuf buf =3D STRBUF_INIT;
> diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
> index 0ddd0f01cc7..4d76ccbbc19 100755
> --- a/t/t3800-mktag.sh
> +++ b/t/t3800-mktag.sh
> @@ -12,12 +12,17 @@ test_description=3D'git mktag: tag object verify te=
st'
>  # given in the expect.pat file.
> =20
>  check_verify_failure () {
> -	expect=3D"$2"
> -	test_expect_success "$1" '
> +	test_expect_success "$1" "
>  		test_must_fail env GIT_TEST_GETTEXT_POISON=3Dfalse \
>  			git mktag <tag.sig 2>message &&
> -		grep "$expect" message
> -	'
> +		grep '$2' message &&
> +		if test '$3' !=3D '--no-strict'
> +		then
> +			test_must_fail env GIT_TEST_GETTEXT_POISON=3Dfalse \
> +				git mktag --no-strict <tag.sig 2>message.no-strict &&
> +			grep '$2' message.no-strict
> +		fi
> +	"
>  }
> =20
>  test_expect_mktag_success() {
> @@ -65,7 +70,7 @@ too short for a tag
>  EOF
> =20
>  check_verify_failure 'Tag object length check' \
> -	'^error:.* missingObject:'
> +	'^error:.* missingObject:' 'strict'
> =20
>  ############################################################
>  #  2. object line label check
> @@ -240,7 +245,7 @@ tagger . <> 0 +0000
>  EOF
> =20
>  check_verify_failure 'verify tag-name check' \
> -	'^error:.* badTagName:'
> +	'^error:.* badTagName:' '--no-strict'
> =20
>  ############################################################
>  # 11. tagger line label check #1
> @@ -254,7 +259,7 @@ This is filler
>  EOF
> =20
>  check_verify_failure '"tagger" line label check #1' \
> -	'^error:.* missingTaggerEntry:'
> +	'^error:.* missingTaggerEntry:' '--no-strict'
> =20
>  ############################################################
>  # 12. tagger line label check #2
> @@ -269,7 +274,7 @@ This is filler
>  EOF
> =20
>  check_verify_failure '"tagger" line label check #2' \
> -	'^error:.* missingTaggerEntry:'
> +	'^error:.* missingTaggerEntry:' '--no-strict'
> =20
>  ############################################################
>  # 13. allow missing tag author name like fsck
> @@ -298,7 +303,7 @@ tagger T A Gger <
>  EOF
> =20
>  check_verify_failure 'disallow malformed tagger' \
> -	'^error:.* badEmail:'
> +	'^error:.* badEmail:' '--no-strict'
> =20
>  ############################################################
>  # 15. allow empty tag email
> @@ -422,13 +427,21 @@ this line should not be here
>  EOF
> =20
>  check_verify_failure 'detect invalid header entry' \
> -	'^error:.* extraHeaderEntry:'
> +	'^error:.* extraHeaderEntry:' '--no-strict'
> =20
>  test_expect_success 'invalid header entry config & fsck' '
>  	test_must_fail git mktag <tag.sig &&
> +	git mktag --no-strict <tag.sig &&
> +
>  	test_must_fail git -c fsck.extraHeaderEntry=3Derror mktag <tag.sig &&
> +	test_must_fail git -c fsck.extraHeaderEntry=3Derror mktag --no-strict=
 <tag.sig &&
> +
>  	test_must_fail git -c fsck.extraHeaderEntry=3Dwarn mktag <tag.sig &&
> +	git -c fsck.extraHeaderEntry=3Dwarn mktag --no-strict <tag.sig &&
> +
>  	git -c fsck.extraHeaderEntry=3Dignore mktag <tag.sig &&
> +	git -c fsck.extraHeaderEntry=3Dignore mktag --no-strict <tag.sig &&
> +
>  	git fsck &&
>  	env GIT_TEST_GETTEXT_POISON=3Dfalse \
>  		git -c fsck.extraHeaderEntry=3Dwarn fsck 2>err &&
