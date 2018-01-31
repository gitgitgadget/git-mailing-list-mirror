Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CB601F404
	for <e@80x24.org>; Wed, 31 Jan 2018 23:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756001AbeAaXSa (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 18:18:30 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37966 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753434AbeAaXS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 18:18:29 -0500
Received: by mail-wr0-f196.google.com with SMTP id t94so5340206wrc.5
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 15:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=c1N1aSWum/pv3tE/LCw3ngeXlj+EdHU/3D4u0Go37Sg=;
        b=QnAAeGySkzGkdKQ1awHmJNlzpQ+8mi8HNH3esErQv3qlbnMFhxaBUMNkCQR7D/XPTD
         8b4SUgikGHZwItddQHw6nzVymiUYwVnrBCZ2CQzMmx8hT99xI3DG8T2DaMh3erQr13fI
         yo58UPx+0qoUjj5Z0Oi+iNH4LQLNgzAwrw3jZwjBSZarD3Dv6EqN0KYchsr69KnbBN5V
         VXYQjuUP9UzlXvaJAozsJg9INSdOYS+UtbVRtIKRocfIN48yEEOg+l4jKWkh5cTaFawY
         qTQ4zvnYZDY+MVZw4ddn/HAfd+4OiXF5/uJnjZ2+kc8CEd6H+kHTkPk/eEAgQC1dUFeb
         hyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=c1N1aSWum/pv3tE/LCw3ngeXlj+EdHU/3D4u0Go37Sg=;
        b=VpDndS567C+Sz6B8aXPIKnRkXMY++RRQ1HvQEYIMaLDJvqrhZVy6KMVA6V3DzjJ3Ro
         hXZNmtmz6WtdqahM93nT9tR7GdNGobY6C0ck8NMvb+Yy9k4YBEaQqah3lC9vNBh7YcAB
         Dl+Rb1AJ5hWduzTQLq+e4/066IbwWwz9PLUzydV+Ui+uoUtcoHzhVydj7TdOUsU9aMM5
         m0Ocub0EjZcZz0zg8tkSijaXE1qLtHHN8jiGQMfY8zflPrjpTe90e6hgFycocXlP4wXC
         eV28ez+HkqJf3U3jLyDPP9cCL+Lr97ASphDzS6ZGG+XdhnSQ6BsYdFgLHZINS9K+tCze
         8UxA==
X-Gm-Message-State: AKwxytd8uwVf+J5grn9vtkqrqlj5ODzsk7OiDDLMDBM+8rQZhrRXKHu+
        AcqxtHlpHH+fHT5vZgg9S00=
X-Google-Smtp-Source: AH8x2247Sz0IxziQ9fhrVmR+bT5oMHg88CVOvL884uLGlv9bSD0rEyZVUbaPS4azKUWhrFI3ESn2mA==
X-Received: by 10.223.158.5 with SMTP id u5mr28468883wre.197.1517440707543;
        Wed, 31 Jan 2018 15:18:27 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y19sm6407914wrd.93.2018.01.31.15.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Jan 2018 15:18:26 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>, tim@tim-landscheidt.de
Subject: Re: [PATCH v2 3/3] rebase: introduce and use pseudo-ref ORIG_COMMIT
References: <20180126095520.919-1-pclouds@gmail.com>
        <20180131093051.15525-1-pclouds@gmail.com>
        <20180131093051.15525-5-pclouds@gmail.com>
Date:   Wed, 31 Jan 2018 15:18:26 -0800
In-Reply-To: <20180131093051.15525-5-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 31 Jan 2018 16:30:51 +0700")
Message-ID: <xmqqlggdr519.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> The new command `git rebase --show-current-patch` is useful for seeing
> the commit related to the current rebase state. Some however may find
> the "git show" command behind it too limiting. You may want to
> increase context lines, do a diff that ignores whitespaces...
>
> For these advanced use cases, the user can execute any command they
> want with the new pseudo ref ORIG_COMMIT.
>
> This also helps show where the stopped commit is from, which is hard
> to see from the previous patch which implements --show-current-patch.
>
> Helped-by: Tim Landscheidt <tim@tim-landscheidt.de>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---

Hmph, how is this new file conceptually different from existing ones
like CHERRY_PICK_HEAD?  

>  Documentation/git-rebase.txt           | 3 ++-
>  builtin/am.c                           | 4 ++++
>  contrib/completion/git-completion.bash | 2 +-
>  git-rebase--interactive.sh             | 5 ++++-
>  git-rebase--merge.sh                   | 4 +++-
>  git-rebase.sh                          | 1 +
>  sequencer.c                            | 3 +++
>  t/t3400-rebase.sh                      | 3 ++-
>  t/t3404-rebase-interactive.sh          | 5 ++++-
>  9 files changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 7ef9577472..6da9296bf8 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -252,7 +252,8 @@ leave out at most one of A and B, in which case it defaults to HEAD.
>  
>  --show-current-patch::
>  	Show the current patch in an interactive rebase or when rebase
> -	is stopped because of conflicts.
> +	is stopped because of conflicts. This is the equivalent of
> +	`git show ORIG_COMMIT`.
>  
>  -m::
>  --merge::
> diff --git a/builtin/am.c b/builtin/am.c
> index caec50cba9..bf9b356340 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1011,6 +1011,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
>  
>  	if (mkdir(state->dir, 0777) < 0 && errno != EEXIST)
>  		die_errno(_("failed to create directory '%s'"), state->dir);
> +	delete_ref(NULL, "ORIG_COMMIT", NULL, REF_NO_DEREF);
>  
>  	if (split_mail(state, patch_format, paths, keep_cr) < 0) {
>  		am_destroy(state);
> @@ -1110,6 +1111,7 @@ static void am_next(struct am_state *state)
>  
>  	oidclr(&state->orig_commit);
>  	unlink(am_path(state, "original-commit"));
> +	delete_ref(NULL, "ORIG_COMMIT", NULL, REF_NO_DEREF);
>  
>  	if (!get_oid("HEAD", &head))
>  		write_state_text(state, "abort-safety", oid_to_hex(&head));
> @@ -1441,6 +1443,8 @@ static int parse_mail_rebase(struct am_state *state, const char *mail)
>  
>  	oidcpy(&state->orig_commit, &commit_oid);
>  	write_state_text(state, "original-commit", oid_to_hex(&commit_oid));
> +	update_ref("am", "ORIG_COMMIT", &commit_oid,
> +		   NULL, 0, UPDATE_REFS_DIE_ON_ERR);
>  
>  	return 0;
>  }
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 2bd30d68cf..deea688e0e 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -439,7 +439,7 @@ __git_refs ()
>  			track=""
>  			;;
>  		*)
> -			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD; do
> +			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD ORIG_COMMIT; do
>  				case "$i" in
>  				$match*)
>  					if [ -e "$dir/$i" ]; then
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 0c0f8abbf9..ef72bd5871 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -199,12 +199,14 @@ make_patch () {
>  
>  die_with_patch () {
>  	echo "$1" > "$state_dir"/stopped-sha
> +	git update-ref ORIG_COMMIT "$1"
>  	make_patch "$1"
>  	die "$2"
>  }
>  
>  exit_with_patch () {
>  	echo "$1" > "$state_dir"/stopped-sha
> +	git update-ref ORIG_COMMIT "$1"
>  	make_patch $1
>  	git rev-parse --verify HEAD > "$amend"
>  	gpg_sign_opt_quoted=${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")}
> @@ -841,7 +843,7 @@ To continue rebase after editing, run:
>  	exit
>  	;;
>  show-current-patch)
> -	exec git show "$(cat "$state_dir/stopped-sha")" --
> +	exec git show ORIG_COMMIT --
>  	;;
>  esac
>  
> @@ -858,6 +860,7 @@ fi
>  
>  orig_head=$(git rev-parse --verify HEAD) || die "$(gettext "No HEAD?")"
>  mkdir -p "$state_dir" || die "$(eval_gettext "Could not create temporary \$state_dir")"
> +rm -f "$(git rev-parse --git-path ORIG_COMMIT)"
>  
>  : > "$state_dir"/interactive || die "$(gettext "Could not mark as interactive")"
>  write_basic_state
> diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
> index 0a96dfae37..70966c32c3 100644
> --- a/git-rebase--merge.sh
> +++ b/git-rebase--merge.sh
> @@ -57,6 +57,7 @@ call_merge () {
>  	echo "$msgnum" >"$state_dir/msgnum"
>  	cmt="$(cat "$state_dir/cmt.$msgnum")"
>  	echo "$cmt" > "$state_dir/current"
> +	git update-ref ORIG_COMMIT "$cmt"
>  	hd=$(git rev-parse --verify HEAD)
>  	cmt_name=$(git symbolic-ref HEAD 2> /dev/null || echo HEAD)
>  	eval GITHEAD_$cmt='"${cmt_name##refs/heads/}~$(($end - $msgnum))"'
> @@ -138,13 +139,14 @@ skip)
>  	return
>  	;;
>  show-current-patch)
> -	exec git show "$(cat "$state_dir/current")" --
> +	exec git show ORIG_COMMIT --
>  	;;
>  esac
>  
>  mkdir -p "$state_dir"
>  echo "$onto_name" > "$state_dir/onto_name"
>  write_basic_state
> +rm -f "$(git rev-parse --git-path ORIG_COMMIT)"
>  
>  msgnum=0
>  for cmt in $(git rev-list --reverse --no-merges "$revisions")
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 41c915d18c..1db4301b90 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -182,6 +182,7 @@ You can run "git stash pop" or "git stash drop" at any time.
>  }
>  
>  finish_rebase () {
> +	rm -f "$(git rev-parse --git-path ORIG_COMMIT)"
>  	apply_autostash &&
>  	{ git gc --auto || true; } &&
>  	rm -rf "$state_dir"
> diff --git a/sequencer.c b/sequencer.c
> index 4d3f60594c..fe907a0701 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1792,6 +1792,8 @@ static int make_patch(struct commit *commit, struct replay_opts *opts)
>  	p = short_commit_name(commit);
>  	if (write_message(p, strlen(p), rebase_path_stopped_sha(), 1) < 0)
>  		return -1;
> +	update_ref("rebase", "ORIG_COMMIT", &commit->object.oid,
> +		   NULL, 0, UPDATE_REFS_DIE_ON_ERR);
>  
>  	strbuf_addf(&buf, "%s/patch", get_dir(opts));
>  	memset(&log_tree_opt, 0, sizeof(log_tree_opt));
> @@ -2043,6 +2045,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>  			unlink(rebase_path_author_script());
>  			unlink(rebase_path_stopped_sha());
>  			unlink(rebase_path_amend());
> +			delete_ref(NULL, "ORIG_COMMIT", NULL, REF_NO_DEREF);
>  		}
>  		if (item->command <= TODO_SQUASH) {
>  			if (is_rebase_i(opts))
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 09943d6a9b..2be4abcb7b 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -306,7 +306,8 @@ test_expect_success 'rebase--merge.sh and --show-current-patch' '
>  		test_must_fail git rebase --merge --onto init HEAD^ &&
>  		git rebase --show-current-patch >actual.patch &&
>  		GIT_TRACE=1 git rebase --show-current-patch >/dev/null 2>stderr &&
> -		grep "show.*$(git rev-parse two)" stderr
> +		grep "show.*ORIG_COMMIT" stderr &&
> +		test "$(git rev-parse ORIG_COMMIT)" = "$(git rev-parse two)"
>  	)
>  '
>  
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 3af6f149a9..c0fe0193bb 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -227,7 +227,10 @@ test_expect_success 'stop on conflicting pick' '
>  
>  test_expect_success 'show conflicted patch' '
>  	GIT_TRACE=1 git rebase --show-current-patch >/dev/null 2>stderr &&
> -	grep "show.*$(cat "$state_dir/stopped-sha")" stderr
> +	grep "show.*ORIG_COMMIT" stderr &&
> +	# the original stopped-sha1 is abbreviated
> +	stopped_sha1="$(git rev-parse $(cat ".git/rebase-merge/stopped-sha"))" &&
> +	test "$(git rev-parse ORIG_COMMIT)" = "$stopped_sha1"
>  '
>  
>  test_expect_success 'abort' '
