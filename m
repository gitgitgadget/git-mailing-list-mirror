Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 890B42089A
	for <e@80x24.org>; Tue, 25 Jul 2017 18:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750898AbdGYSlo (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 14:41:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50369 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750781AbdGYSln (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 14:41:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 827707195A;
        Tue, 25 Jul 2017 14:41:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=44B2pdQBHkhu
        qX88bsQ5/MfWBzU=; b=Mi3y1JCgeRLPCpD/mm4KVwsJRxuZ7fBTAoLrqHMZtkIf
        a7dtKy6XitUOJADupMF40mrAVT2Q7bKhJ17q9SLPxjt7DcyYCPkCa1WgePk0AEfG
        oagp/I43k0oNAUTpt1WuYoXVTlBR5Wl14c3sANCKK4MRGHqQT3ZWT2WwBtPwfBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=I5N0el
        XyZyE2qo7VXR2WPCn8D2ITGOz9Uu+ET8oqPYU88csQPTCXxyKMmcTqpqevoUC4NN
        7z5hJ+VhEG7HOFjv6LA59rceKF6YhhhQVyVguE3q5fJZ/IqUqT674x4Y66odCchZ
        MvSBzZyVEA5TuFIu7WwpyT8YY7iC6QP8OwwwY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A36971959;
        Tue, 25 Jul 2017 14:41:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D187771958;
        Tue, 25 Jul 2017 14:41:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C5=81ukasz?= Gryglicki <lukaszgryglicki@o2.pl>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3] merge: add a --signoff flag.
References: <0102015d0c41db74-34ff8613-05e2-44bb-a05b-2624108c36c8-000000@eu-west-1.amazonses.com>
        <0102015d0cf235f7-9be8e1fc-a926-4e6f-8180-c131da1c4161-000000@eu-west-1.amazonses.com>
Date:   Tue, 25 Jul 2017 11:41:33 -0700
In-Reply-To: <0102015d0cf235f7-9be8e1fc-a926-4e6f-8180-c131da1c4161-000000@eu-west-1.amazonses.com>
        (=?utf-8?Q?=22=C5=81ukasz?= Gryglicki"'s message of "Tue, 4 Jul 2017
 09:33:06 +0000")
Message-ID: <xmqqeft4bbqa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E2815C04-7168-11E7-88FF-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C5=81ukasz Gryglicki <lukaszgryglicki@o2.pl> writes:

> Some projects require every commit to be signed off.
> Our workflow is to create feature branches and require every commit to
> be signed off. When feature is finally approved we need to merge it int=
o
> master. Merge itself is usually trivial and is done by
> `git merge origin/master`.
>
> Unfortunatelly `merge` command have no --signoff
> flag, so we need to either add signoff line manually or use
> `git commit --amend -s` after the merge.

Who are "we" in the above?  Certainly not the Git development
project who stands behind the log message.  I also find the first
paragraph overly verbose. =20

Perhaps something like this instead?

    Some projects require every commit, even merges, to be signed
    off [*1*].  Because "git merge" does not have a "--signoff"
    option like "git commit" does, the user needs to add one
    manually when the command presents an editor to describe the
    merge, or later use "git commit --amend --signoff".

    Help developers of these projects by teaching "--signoff" option
    to "git merge".

    *1* https://public-inbox.org/git/CAHv71zK5SqbwrBFX=3Da8-DY9H3KT4FEyMg=
v__p2gZzNr0WUAPUw@mail.gmail.com/T/#u

    Requested-by: Dan Kohn <dan@linuxfoundation.org>
    Signed-off-by: =C5=81ukasz Gryglicki <lukaszgryglicki@o2.pl>

Notice that I updated your s-o-b line in the above illustration
because we prefer to see the same name as patch author (which is
usually taken from your e-mail From: header) there.

> +--signoff::
> +	Add Signed-off-by line by the committer at the end of the commit
> +	log message.  The meaning of a signoff depends on the project,
> +	but it typically certifies that committer has
> +	the rights to submit this work under the same license and
> +	agrees to a Developer Certificate of Origin
> +	(see http://developercertificate.org/ for more information).

This is taken verbatim from Documentation/git-commit.txt and "this
work" in that context is entirely sensible, but it is not quite
clear what it means in the context of "git merge".

> diff --git a/builtin/merge.c b/builtin/merge.c
> index 900bafdb45d0b..78c36e9bf353b 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -70,6 +70,7 @@ static int continue_current_merge;
>  static int allow_unrelated_histories;
>  static int show_progress =3D -1;
>  static int default_to_upstream =3D 1;
> +static int signoff;
>  static const char *sign_commit;
> =20
>  static struct strategy all_strategy[] =3D {
> @@ -233,6 +234,7 @@ static struct option builtin_merge_options[] =3D {
>  	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
>  	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
>  	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored=
 files (default)")),
> +	OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
>  	OPT_END()
>  };
> =20
> @@ -763,6 +765,8 @@ static void prepare_to_commit(struct commit_list *r=
emoteheads)
>  	strbuf_addch(&msg, '\n');
>  	if (0 < option_edit)
>  		strbuf_commented_addf(&msg, _(merge_editor_comment), comment_line_ch=
ar);
> +	if (signoff)
> +		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
>  	write_file_buf(git_path_merge_msg(), msg.buf, msg.len);
>  	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commi=
t-msg",
>  			    git_path_merge_msg(), "merge", NULL))

The invocation of the editor comes after this post-context, and the
new code seems to sit at the right place.  Good.

> diff --git a/t/t7614-merge-signoff.sh b/t/t7614-merge-signoff.sh
> new file mode 100755
> index 0000000000000..c1b8446f491dc
> --- /dev/null
> +++ b/t/t7614-merge-signoff.sh
> @@ -0,0 +1,69 @@
> +#!/bin/sh
> +
> +test_description=3D'git merge --signoff
> +
> +This test runs git merge --signoff and makes sure that it works.
> +'
> +
> +. ./test-lib.sh
> +
> +# Setup test files
> +test_setup() {

Style: "test_setup () {" but see below.

> +	# Expected commit message after merge --signoff
> +	cat >expected-signed <<EOF &&
> +Merge branch 'master' into other-branch
> +
> +Signed-off-by: $(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/")
> +EOF

Indenting the here-text with "<<-EOF" makes it easier to read, e.g.

	cat >expected-signed <<-EOF &&
	Merge branch 'master' into other-branch

	Signed-off-by: $(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/")
	EOF

Likewise for the other one.

> +...
> +}

I do not see much point in making this a shell function.  I'd just
do all of the above in the first "test_expect_success 'setup'"
thing, if I were doing this patch.

> +
> +# Setup repository, files & feature branch
> +# This step must be run if You want to test 2,3 or 4
> +# Order of 2,3,4 is not important, but 1 must be run before
> +# For example `-r 1,4` or `-r 1,4,2 -v` etc
> +# But not `-r 2` or `-r 4,3,2,1`

That is pretty much the standard practice to require 'setup' to
always run; no need to waste 5 lines to document it.

> +test_expect_success 'setup' '
> +	test_setup
> +'
> +
> +# Test with --signoff flag

That can already be seen on the test title below.  Remove it?

> +test_expect_success 'git merge --signoff adds a sign-off line' '
> +...
> +test_expect_success 'git merge does not add a sign-off line' '
> +...
> +test_expect_success 'git merge --no-signoff flag cancels --signoff fla=
g' '
> +...
> +'

They all look sensible thing to check.  We would also need to make
sure that the end user sees the S-o-b: prepopulated when the editor
is spawned, I would think, perhaps like (completely untested)

	write_script save-editor <<-\EOF &&
	cp "$1" "$1".saved
	EOF
	GIT_EDITOR=3D./save-editor git merge --signoff --no-signoff ... &&
 	... check the contents of the MERGE_MSG.saved file to=20
	... ensure string Signed-off-by: appears (or does not
	... appear) here, e.g.
	test_i18ngrep ! "^Signed-off-by: " .git/MERGE_MSG.saved

Thanks.
