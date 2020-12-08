Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46321C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 23:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEF4523A22
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 23:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731572AbgLHX0j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 18:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730364AbgLHX0i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 18:26:38 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A627C0613CF
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 15:25:58 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id cm17so15434edb.4
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 15:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3jnxtF+N5RpAhYd1KXwVtSCAvE2GcFmnVjvQVnIwvFY=;
        b=QG0c3GEp24qchSsexuLWZ8Sa72avSS7Dc/j/1cKtMm0DUmlNCFQveRLz8hEMGZJT9k
         asruOnxMYZCf/kU5izvfp0nv8Uo89k4pQgSz+P7/fnPaT7hXBNYcg7FpZMmSpvmHc5lF
         QUsznxhNfzHioRCN60VPHikQJo9OKaU8DZuKDFQmue88JIEcjImNeADz0EsUdt3dr49X
         ev/c5Mc78ZSAnPy3aFVhgNR76vdWa1rajQry2VlawkY+t9QJhe9nXgKu0O2e5DRb6f96
         E4vSaENgkcGO6Gdh9VT6/i/A2pKW0O7ALtkPGwL7r7zdg5jvvvYUWgCisDfzA5vWC+aC
         j6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3jnxtF+N5RpAhYd1KXwVtSCAvE2GcFmnVjvQVnIwvFY=;
        b=hUDcKAm5LVmHzoO/nYANR88ybKC+CwWAMjBHlJLYY3Rj7QVe0G9PEK1eaJwe9aUx6H
         tKalJbXzwRKCYcDJnuMa6fLts8tR/OU07w1COmOxRkHNCWtifvG7pIZq9q953tn2jlBg
         yflFq1mIR/4GLDSjicKOlK/Qwf9JMb91/YSxc/WBts09dIhBt294zQffSwJeJqQ/rtUm
         nmF86MkZPfy3xpB6E89YnYaxsDmyiVfwMV86m9tCrSIf7qiub3dtcghkfHHZPF3EzIFx
         ydxM2k9b+n0nnhCfJGh1pRQL+r6EaqCGmVV7IIZdDcM/Yvh5VWnZEX8ew61w41NK+e1/
         mpnw==
X-Gm-Message-State: AOAM532MwEDNxOLj3C6vfOVXMcdmaaqTKzSEoB2UhU0Alyg5G9aC3fJ4
        JrV2mcpQwzzFsXUR0uT6iPsPJqrWgYGOECx26BWYaIRLOn8PPQ==
X-Google-Smtp-Source: ABdhPJwZP3RjIPC2fFzlFLpCVY1sx+q5YDbfUAuMM8OCKj8n1jQ7FVUAU6GexP+BDg+5zLgb9hn249j3snz3uPOhJgc=
X-Received: by 2002:a05:6402:687:: with SMTP id f7mr291623edy.314.1607469957308;
 Tue, 08 Dec 2020 15:25:57 -0800 (PST)
MIME-Version: 1.0
References: <d52db91d-af6d-c93c-2c4a-e2460905623d@nokia.com> <1607442126-34705-1-git-send-email-peter.kaestle@nokia.com>
In-Reply-To: <1607442126-34705-1-git-send-email-peter.kaestle@nokia.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Date:   Tue, 8 Dec 2020 18:25:44 -0500
Message-ID: <CADtb9DwwfAG69YmM0+0FC6qkO361-95Uy8dNZ8jXnrVcxHSrMQ@mail.gmail.com>
Subject: Re: [PATCH v3] submodules: fix of regression on fetching of non-init subsub-repo
To:     Peter Kaestle <peter.kaestle@nokia.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.us>,
        Ralf Thielow <ralf.thielow@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peter,

Le mar. 8 d=C3=A9c. 2020, =C3=A0 10 h 43, Peter Kaestle
<peter.kaestle@nokia.com> a =C3=A9crit :
>
>  -- 8< --
>
> Furthermore a regression test case is added, which tests for recursive
> fetches on a superproject with uninitialized sub repositories.  This
> issue was leading to an infinite loop when doing a revert of a62387b.

I think this paragraph could be removed as it's saying the same thing as
the one below.

>
> The first attempt to fix this regression, in 1b7ac4e6d4 (submodules:
> fix of regression on fetching of non-init subsub-repo, 2020-11-12), by
> simply reverting a62387b, resulted in an infinite loop of submodule
> fetches in the simpler case of a recursive fetch of a superproject with
> uninitialized submodules, and so this commit was reverted in 7091499bc0
> (Revert "submodules: fix of regression on fetching of non-init
> subsub-repo", 2020-12-02).
> To prevent future breakages, also add a regression test for this
> scenario.
>
> Signed-off-by: Peter Kaestle <peter.kaestle@nokia.com>
> CC: Junio C Hamano <gitster@pobox.com>
> CC: Philippe Blain <levraiphilippeblain@gmail.com>
> CC: Ralf Thielow <ralf.thielow@gmail.com>
> CC: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  submodule.c                 |   7 ++-
>  t/t5526-fetch-submodules.sh | 124 ++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 130 insertions(+), 1 deletion(-)
>
> diff --git a/submodule.c b/submodule.c
> index b3bb59f..b561445 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1477,6 +1477,7 @@ static int get_next_submodule(struct child_process =
*cp,
>                         strbuf_release(&submodule_prefix);
>                         return 1;
>                 } else {
> +                       struct strbuf empty_submodule_path =3D STRBUF_INI=
T;
>
>                         fetch_task_release(task);
>                         free(task);
> @@ -1485,13 +1486,17 @@ static int get_next_submodule(struct child_proces=
s *cp,
>                          * An empty directory is normal,
>                          * the submodule is not initialized
>                          */
> +                       strbuf_addf(&empty_submodule_path, "%s/%s/",
> +                                                       spf->r->worktree,
> +                                                       ce->name);
>                         if (S_ISGITLINK(ce->ce_mode) &&
> -                           !is_empty_dir(ce->name)) {
> +                           !is_empty_dir(empty_submodule_path.buf)) {
>                                 spf->result =3D 1;
>                                 strbuf_addf(err,
>                                             _("Could not access submodule=
 '%s'\n"),
>                                             ce->name);
>                         }
> +                       strbuf_release(&empty_submodule_path);
>                 }
>         }
>
> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index dd8e423..495348a 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -719,4 +719,128 @@ test_expect_success 'fetch new submodule commit int=
ermittently referenced by sup
>         )
>  '
>
> +add_commit_push () {
> +       dir=3D"$1" &&
> +       msg=3D"$2" &&
> +       shift 2 &&
> +       git -C "$dir" add "$@" &&
> +       git -C "$dir" commit -a -m "$msg" &&
> +       git -C "$dir" push
> +}
> +
> +compare_refs_in_dir () {
> +       fail=3D &&
> +       if test "x$1" =3D 'x!'
> +       then
> +               fail=3D'!' &&
> +               shift
> +       fi &&
> +       git -C "$1" rev-parse --verify "$2" >expect &&
> +       git -C "$3" rev-parse --verify "$4" >actual &&
> +       eval $fail test_cmp expect actual
> +}
> +
> +
> +test_expect_success 'setup nested submodule fetch test' '
> +       # does not depend on any previous test setups
> +
> +       for repo in outer middle inner
> +       do
> +               git init --bare $repo &&
> +               git clone $repo ${repo}_content &&
> +               echo "$repo" >"${repo}_content/file" &&
> +               add_commit_push ${repo}_content "initial" file ||
> +               return 1
> +       done &&
> +
> +       git clone outer A &&
> +       git -C A submodule add "$pwd/middle" &&
> +       git -C A/middle/ submodule add "$pwd/inner" &&
> +       add_commit_push A/middle/ "adding inner sub" .gitmodules inner &&
> +       add_commit_push A/ "adding middle sub" .gitmodules middle &&
> +
> +       git clone outer B &&
> +       git -C B/ submodule update --init middle &&
> +
> +       compare_refs_in_dir A HEAD B HEAD &&
> +       compare_refs_in_dir A/middle HEAD B/middle HEAD &&
> +       test_path_is_file B/file &&
> +       test_path_is_file B/middle/file &&
> +       test_path_is_missing B/middle/inner/file &&
> +
> +       echo "change on inner repo of A" >"A/middle/inner/file" &&
> +       add_commit_push A/middle/inner "change on inner" file &&
> +       add_commit_push A/middle "change on inner" inner &&
> +       add_commit_push A "change on inner" middle
> +'
> +
> +test_expect_success 'fetching a superproject containing an uninitialized=
 sub/sub project' '
> +       # depends on previous test for setup
> +
> +       git -C B/ fetch &&
> +       compare_refs_in_dir A origin/HEAD B origin/HEAD
> +'
> +
> +fetch_with_recusion_abort () {

s/recusion/recursion/

> +       # In a regression the following git call will run into infinite r=
ecursion.
> +       # To handle that, we connect the sed command to the git call by a=
 pipe
> +       # so that sed can kill the infinite recusion when detected.

s/recusion/recursion/

> +       # The recursion creates git output like:
> +       # Fetching submodule sub
> +       # Fetching submodule sub/sub              <-- [1]
> +       # Fetching submodule sub/sub/sub
> +       # ...
> +       # [1] sed will stop reading and cause git to eventually stop and =
die
> +
> +       git -C "$1" fetch --recurse-submodules 2>&1 |
> +               sed "/Fetching submodule $2[^$]/q" >out &&
> +       ! grep "Fetching submodule $2[^$]" out
> +}
> +
> +test_expect_success 'setup recursive fetch with uninit submodule' '
> +       # does not depend on any previous test setups
> +
> +       # setup a remote superproject to make git fetch work with an unin=
it submodule
> +       git init --bare super_bare &&
> +       git clone super_bare super &&
> +       git init sub &&
> +
> +       >sub/file &&
> +       git -C sub add file &&
> +       git -C sub commit -m "add file" &&
> +       git -C sub rev-parse HEAD >expect &&
> +
> +       # adding submodule without cloning
> +       echo "[submodule \"sub\"]" >super/.gitmodules &&
> +       echo "path =3D sub" >>super/.gitmodules &&
> +       echo "url =3D ../sub" >>super/.gitmodules &&
> +       git -C super update-index --add --cacheinfo 160000 $(cat expect) =
sub &&
> +       mkdir super/sub &&
> +
> +       git -C super submodule status >out &&
> +       sed -e "s/^-//" -e "s/ sub.*$//" out >actual &&
> +       test_cmp expect actual
> +'

I think this is overly complicated, what I was hinting at was adding
the submodule
in the superproject before cloning it, so something along these lines:

test_create_repo super &&
test_commit -C super initial &&
test_create_repo sub &&
test_commit -C sub initial &&
git -C sub rev-parse HEAD >expect &&

git -C super submodule add ../sub &&
git -C super commit -m "add sub" &&

git clone super superclone &&
git -C superclone submodule status >out &&
sed -e "s/^-//" -e "s/ sub.*$//" out >actual &&
test_cmp expect actual

And then running the two tests below in "superclone".


> +
> +test_expect_success 'recursive fetch with uninit submodule' '
> +       # depends on previous test for setup
> +
> +       fetch_with_recusion_abort super sub &&

s/recusion/recursion/

> +       git -C super submodule status >out &&
> +       sed -e "s/^-//" -e "s/ sub$//" out >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'recursive fetch after deinit a submodule' '
> +       # depends on previous test for setup
> +
> +       git -C super submodule update --init sub &&
> +       git -C super submodule deinit -f sub &&
> +
> +       fetch_with_recusion_abort super sub &&

s/recusion/recursion/

> +       git -C super submodule status >out &&
> +       sed -e "s/^-//" -e "s/ sub$//" out >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.6.2
>

Philippe.
