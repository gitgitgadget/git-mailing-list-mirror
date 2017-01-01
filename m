Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB9AB1FCA5
	for <e@80x24.org>; Sun,  1 Jan 2017 14:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932115AbdAAOXr (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jan 2017 09:23:47 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36722 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932066AbdAAOXp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2017 09:23:45 -0500
Received: by mail-qk0-f176.google.com with SMTP id n21so328241587qka.3
        for <git@vger.kernel.org>; Sun, 01 Jan 2017 06:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gdUP/dfaYuetxlIgWW2JZ9ZuHsO6YbsKdYl/rOBXZBs=;
        b=Yt0KAw80s3BUkzPeaP2i9MrXSziLby0o3lZkjPXCNtVcyOACjgervo+2Mqy+WojyrG
         o8cTZ71zg/5v615t8BpZTt73v0Zn+w2KmiKeJWNeDmZ9gzGcXssy37RpwPDGNgb2j5FI
         irH+DodHMnC1yu1sK3WLO3TeQIo+uX21IXo4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gdUP/dfaYuetxlIgWW2JZ9ZuHsO6YbsKdYl/rOBXZBs=;
        b=k8pdB8///B/cZtvI6P71OXS1K5QkZk4VB+KW7QYVG+wFrVINDJfrfal0bMUFyjK4sM
         6OhFNMl7iqrfZxB2gpm+yu+m1+Z/Iv9hzLJgWgTZ3MDvD23fJLPda+w3OCfKo/1VhKny
         QdK3VCYjHx1zcegfj42JojzRLAU+f5Otp3yAYV/FtoRsiWNJSKllXRPRyLLeTW2joLdA
         USNV7DEXDi6PG11vOyT4Nx4lbRzBu0C2Ynp18WSxt2YJc51FBKDSDdQTz2aWZ1iVLNwM
         7y7VlVt4WsEID546JIP20vd7X1XqxYFDzY0uO1fUQIQgRWYxN76DhfZV8RgoplLUOIaG
         fpdw==
X-Gm-Message-State: AIkVDXJaNv31fky6XvA5sOaLG8aau3Md9+84qyUSBHolso+P9HWMNBG8Ymr2PokopOZgqi0UeGLURm284Fodog==
X-Received: by 10.55.112.65 with SMTP id l62mr60835326qkc.76.1483280624379;
 Sun, 01 Jan 2017 06:23:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.47.111 with HTTP; Sun, 1 Jan 2017 06:23:43 -0800 (PST)
In-Reply-To: <20161231114412.23439-1-pranit.bauva@gmail.com>
References: <20161231114412.23439-1-pranit.bauva@gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Sun, 1 Jan 2017 14:23:43 +0000
Message-ID: <CAE5ih7-7e+ZLUbE7iquWV2=qP4ofzAHUC2ZPg3b-ivSpCo4eRw@mail.gmail.com>
Subject: Re: [PATCH] don't use test_must_fail with grep
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     Git Users <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31 December 2016 at 11:44, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> test_must_fail should only be used for testing git commands. To test the
> failure of other commands use `!`.
>
> Reported-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
>  t/t3510-cherry-pick-sequence.sh  |  6 +++---
>  t/t5504-fetch-receive-strict.sh  |  2 +-
>  t/t5516-fetch-push.sh            |  2 +-
>  t/t5601-clone.sh                 |  2 +-
>  t/t6030-bisect-porcelain.sh      |  2 +-
>  t/t7610-mergetool.sh             |  2 +-
>  t/t9001-send-email.sh            |  2 +-
>  t/t9117-git-svn-init-clone.sh    | 12 ++++++------
>  t/t9813-git-p4-preserve-users.sh |  8 ++++----
>  t/t9814-git-p4-rename.sh         |  6 +++---
>  10 files changed, 22 insertions(+), 22 deletions(-)
>
> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
> index 372307c21..0acf4b146 100755
> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -385,7 +385,7 @@ test_expect_success '--continue respects opts' '
>         git cat-file commit HEAD~1 >picked_msg &&
>         git cat-file commit HEAD~2 >unrelatedpick_msg &&
>         git cat-file commit HEAD~3 >initial_msg &&
> -       test_must_fail grep "cherry picked from" initial_msg &&
> +       ! grep "cherry picked from" initial_msg &&
>         grep "cherry picked from" unrelatedpick_msg &&
>         grep "cherry picked from" picked_msg &&
>         grep "cherry picked from" anotherpick_msg
> @@ -426,9 +426,9 @@ test_expect_failure '--signoff is automatically propagated to resolved conflict'
>         git cat-file commit HEAD~1 >picked_msg &&
>         git cat-file commit HEAD~2 >unrelatedpick_msg &&
>         git cat-file commit HEAD~3 >initial_msg &&
> -       test_must_fail grep "Signed-off-by:" initial_msg &&
> +       ! grep "Signed-off-by:" initial_msg &&
>         grep "Signed-off-by:" unrelatedpick_msg &&
> -       test_must_fail grep "Signed-off-by:" picked_msg &&
> +       ! grep "Signed-off-by:" picked_msg &&
>         grep "Signed-off-by:" anotherpick_msg
>  '
>
> diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
> index 9b19cff72..49d3621a9 100755
> --- a/t/t5504-fetch-receive-strict.sh
> +++ b/t/t5504-fetch-receive-strict.sh
> @@ -152,7 +152,7 @@ test_expect_success 'push with receive.fsck.missingEmail=warn' '
>         git --git-dir=dst/.git config --add \
>                 receive.fsck.badDate warn &&
>         git push --porcelain dst bogus >act 2>&1 &&
> -       test_must_fail grep "missingEmail" act
> +       ! grep "missingEmail" act
>  '
>
>  test_expect_success \
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 26b2cafc4..0fc5a7c59 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1004,7 +1004,7 @@ test_expect_success 'push --porcelain' '
>  test_expect_success 'push --porcelain bad url' '
>         mk_empty testrepo &&
>         test_must_fail git push >.git/bar --porcelain asdfasdfasd refs/heads/master:refs/remotes/origin/master &&
> -       test_must_fail grep -q Done .git/bar
> +       ! grep -q Done .git/bar
>  '
>
>  test_expect_success 'push --porcelain rejected' '
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index a43339420..4241ea5b3 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -151,7 +151,7 @@ test_expect_success 'clone --mirror does not repeat tags' '
>         git clone --mirror src mirror2 &&
>         (cd mirror2 &&
>          git show-ref 2> clone.err > clone.out) &&
> -       test_must_fail grep Duplicate mirror2/clone.err &&
> +       ! grep Duplicate mirror2/clone.err &&
>         grep some-tag mirror2/clone.out
>
>  '
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index 5e5370feb..8c2c6eaef 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -407,7 +407,7 @@ test_expect_success 'good merge base when good and bad are siblings' '
>         test_i18ngrep "merge base must be tested" my_bisect_log.txt &&
>         grep $HASH4 my_bisect_log.txt &&
>         git bisect good > my_bisect_log.txt &&
> -       test_must_fail grep "merge base must be tested" my_bisect_log.txt &&
> +       ! grep "merge base must be tested" my_bisect_log.txt &&
>         grep $HASH6 my_bisect_log.txt &&
>         git bisect reset
>  '
> diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
> index 63d36fb28..0fe7e58cf 100755
> --- a/t/t7610-mergetool.sh
> +++ b/t/t7610-mergetool.sh
> @@ -602,7 +602,7 @@ test_expect_success MKTEMP 'temporary filenames are used with mergetool.writeToT
>         test_config mergetool.myecho.trustExitCode true &&
>         test_must_fail git merge master &&
>         git mergetool --no-prompt --tool myecho -- both >actual &&
> -       test_must_fail grep ^\./both_LOCAL_ actual >/dev/null &&
> +       ! grep ^\./both_LOCAL_ actual >/dev/null &&
>         grep /both_LOCAL_ actual >/dev/null &&
>         git reset --hard master >/dev/null 2>&1
>  '
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 3dc4a3454..0f398dd16 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -50,7 +50,7 @@ test_no_confirm () {
>                 --smtp-server="$(pwd)/fake.sendmail" \
>                 $@ \
>                 $patches >stdout &&
> -               test_must_fail grep "Send this email" stdout &&
> +               ! grep "Send this email" stdout &&
>                 >no_confirm_okay
>  }
>
> diff --git a/t/t9117-git-svn-init-clone.sh b/t/t9117-git-svn-init-clone.sh
> index 69a675052..044f65e91 100755
> --- a/t/t9117-git-svn-init-clone.sh
> +++ b/t/t9117-git-svn-init-clone.sh
> @@ -55,7 +55,7 @@ test_expect_success 'clone to target directory with --stdlayout' '
>  test_expect_success 'init without -s/-T/-b/-t does not warn' '
>         test ! -d trunk &&
>         git svn init "$svnrepo"/project/trunk trunk 2>warning &&
> -       test_must_fail grep -q prefix warning &&
> +       ! grep -q prefix warning &&
>         rm -rf trunk &&
>         rm -f warning
>         '
> @@ -63,7 +63,7 @@ test_expect_success 'init without -s/-T/-b/-t does not warn' '
>  test_expect_success 'clone without -s/-T/-b/-t does not warn' '
>         test ! -d trunk &&
>         git svn clone "$svnrepo"/project/trunk 2>warning &&
> -       test_must_fail grep -q prefix warning &&
> +       ! grep -q prefix warning &&
>         rm -rf trunk &&
>         rm -f warning
>         '
> @@ -86,7 +86,7 @@ EOF
>  test_expect_success 'init with -s/-T/-b/-t assumes --prefix=origin/' '
>         test ! -d project &&
>         git svn init -s "$svnrepo"/project project 2>warning &&
> -       test_must_fail grep -q prefix warning &&
> +       ! grep -q prefix warning &&
>         test_svn_configured_prefix "origin/" &&
>         rm -rf project &&
>         rm -f warning
> @@ -95,7 +95,7 @@ test_expect_success 'init with -s/-T/-b/-t assumes --prefix=origin/' '
>  test_expect_success 'clone with -s/-T/-b/-t assumes --prefix=origin/' '
>         test ! -d project &&
>         git svn clone -s "$svnrepo"/project 2>warning &&
> -       test_must_fail grep -q prefix warning &&
> +       ! grep -q prefix warning &&
>         test_svn_configured_prefix "origin/" &&
>         rm -rf project &&
>         rm -f warning
> @@ -104,7 +104,7 @@ test_expect_success 'clone with -s/-T/-b/-t assumes --prefix=origin/' '
>  test_expect_success 'init with -s/-T/-b/-t and --prefix "" still works' '
>         test ! -d project &&
>         git svn init -s "$svnrepo"/project project --prefix "" 2>warning &&
> -       test_must_fail grep -q prefix warning &&
> +       ! grep -q prefix warning &&
>         test_svn_configured_prefix "" &&
>         rm -rf project &&
>         rm -f warning
> @@ -113,7 +113,7 @@ test_expect_success 'init with -s/-T/-b/-t and --prefix "" still works' '
>  test_expect_success 'clone with -s/-T/-b/-t and --prefix "" still works' '
>         test ! -d project &&
>         git svn clone -s "$svnrepo"/project --prefix "" 2>warning &&
> -       test_must_fail grep -q prefix warning &&
> +       ! grep -q prefix warning &&
>         test_svn_configured_prefix "" &&
>         rm -rf project &&
>         rm -f warning
> diff --git a/t/t9813-git-p4-preserve-users.sh b/t/t9813-git-p4-preserve-users.sh
> index 0fe231280..2384535a7 100755
> --- a/t/t9813-git-p4-preserve-users.sh
> +++ b/t/t9813-git-p4-preserve-users.sh
> @@ -126,13 +126,13 @@ test_expect_success 'not preserving user with mixed authorship' '
>                 grep "git author charlie@example.com does not match" &&
>
>                 make_change_by_user usernamefile3 alice alice@example.com &&
> -               git p4 commit |\
> -               test_must_fail grep "git author.*does not match" &&
> +               ! git p4 commit |\
> +               grep "git author.*does not match" &&

Would it be clearer to use this?

    git p4 commit |\
    grep -q -v "git author.*does not match" &&

With your original change, I think that if "git p4 commit" fails, then
that expression will be treated as a pass. What we want is for "git p4
commit" to pass, but the string to be missing.

(I would have used "--invert-match" rather than "-v", but it seems
that's not supported on Solaris).

Luke
