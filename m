Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24C0C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 13:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77517603E7
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 13:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236683AbhH3NdD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 09:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhH3NdD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 09:33:03 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFFDC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 06:32:09 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a14so7869550uao.0
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 06:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wiYJs0/aKt7c+V4GnTe+ZmXxxYqFXzzKEwVD9HCxg1U=;
        b=VnQSVPAO09I06fdeX/a6jZTq9N5ANbxrTCC++W8qupDzkdlQFs/HPv15dknMS4kHmn
         D0dWDOMVM24utKQpbDhtvnBsKxz4b5/QOl2KOJkmBk111R67wct02x0J7Vet2NB/SlEe
         dHk6WiL+8/v5mr4sZF0OHmqnfQGW2yfsZzctGSi1P2F1wkw+l5EDi6TFoafdsqDqvKhb
         +CgaAMabQjtKO2kijmPImYihUqz9I5hE6hhF+5YU/rT6tQlfUgE2yf4WDu79fkLBC0xR
         nI5YPoNOEtKjX+Veeq/QlepziBdAFdpDY8p0NSp/bvaD5X/Xk2k18aeUBypaKm0mPylN
         1goA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wiYJs0/aKt7c+V4GnTe+ZmXxxYqFXzzKEwVD9HCxg1U=;
        b=UA4mcjINX+wVfTj2M9Gba0b4QfY6jzpzwETDsKUvo+F20mjLG2G66H55FAyNYAXPjs
         BEOwDjY5ezCSezB/r0TNnFia/jPrFPFM66f0zv5krEDU0uevQfxhTM0pZVNVlxZ+3nxf
         wKRY+Nyd3v8lGmk19xGYVUi3ewAq7vRnDw0q/WNtN3joEvANlRIeYuOYdqKqLoz4xD/C
         BwuWO5ZVZRI0mnRGBU20Wqoyfrw5TaBuIlonN6kaSXEEtGftaqpx45XOYVZnEu/oBxJo
         cxiM22c2DHwbKgnYLaP2AltxYG9sURSRGXnWOqSAfIQgRGyDmnYFMXDu7YS25eUNEqL7
         lTTA==
X-Gm-Message-State: AOAM533F5YH495dn0hjdDuRO+X4rW8h0geEO8bBIbzkfAqQRfCRrAdu4
        0H8pXiJ+vTjf2cfNhVqqywNA8PBBRT9W1VNJ6LMI3w==
X-Google-Smtp-Source: ABdhPJxCTdsqazKTqTx/t7nLSjZ5y16sepaO6Qk5JfSLzUhigOWe2X3cJEm3Kb0eO8b52ernHpImkPKv2ppntsvqRnM=
X-Received: by 2002:ab0:330a:: with SMTP id r10mr8921748uao.47.1630330327414;
 Mon, 30 Aug 2021 06:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
 <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com> <3d57f7c443082fd2a7f01aee003a9cd3ca2dd910.1629207607.git.gitgitgadget@gmail.com>
 <871r6kh3m8.fsf@evledraar.gmail.com>
In-Reply-To: <871r6kh3m8.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 30 Aug 2021 15:31:55 +0200
Message-ID: <CAFQ2z_OTdXSvPcjPRi8fx6F_yjwiL3vRpPtnEOTyaeBxMB2wHQ@mail.gmail.com>
Subject: Re: [PATCH v3 20/25] refs: RFC: Reftable support for git-core
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 23, 2021 at 12:12 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Elsewhere in this series we use the ARRAY_SIZE() macro from
> git-compat-util.h, can't we also use REALLOC_ARRAY() from the same
> header here?

Done.

> > [...]
> > +     if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
> > +             /* XXX - skip writing records that were not changed. */
> > +             err =3D reftable_addition_commit(add);
> > +     } else {
> > +             /* XXX - print something */
> > +     }
>
> Aren't these comments covered by some of the failing tests under
> GIT_TEST_REFTABLE=3Dtrue? I.e. what I mentioned
> https://lore.kernel.org/git/877dgch4rn.fsf@evledraar.gmail.com/

The XXX comments are directed at reviewers. I don't know if these
places relate to test failures.

> > [...]
> > +     if (err < 0) {
> > +             errno =3D reftable_error_to_errno(err);
> > +             err =3D -1;
> > +             goto done;
> > +     }
>
> In your proposed fixup for the merger of our topics in
> https://lore.kernel.org/git/pull.1054.v3.git.git.1629207607.gitgitgadget@=
gmail.com/
> you have the call to reftable_error_to_errno() here deleted, so isn't
> this also redundant at this point (and then the
> reftable_error_to_errno() function can be deleted), or is this errno
> setting still needed with some of my changes?

No; it's purely informational, but the errno codes aren't a good
match, so OK to drop as well.

> Can't later tests just use "main" instead of primary with a
> GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain, then we can drop this
> "git_init" wrapper?

Done.

> > +initialize ()  {
> > +     rm -rf .git &&
>
> Should instead set up a test_when_finished "rm -rf .git" ?

No. The test framework sets up a scratch repo, but the scratch repo
doesn't use reftable, so it interferes with the tests.

> > +     (GIT_TEST_REFTABLE=3D1; export GIT_TEST_REFTABLE; git_init) &&
>
> This export before calling git_init can surely go away if git_init goes,
> but alo why export beforehand here, but in later tests in this file we
> just do a plain:
>
>     (GIT_TEST_REFTABLE=3D1 git_init) &&

Done.

> > +     mv .git/hooks .git/hooks-disabled
>
> Is this "mv" cargo-culted from what test_create_repo() used to do before
> my-f0d4d398e28 (test-lib: split up and deprecate test_create_repo(),
> 2021-05-10)? In any case templated hooks are disabled by default (named
> *.sample), so I don't think this is needed.

Done.

> > +     echo hoi >> file.t &&
>
> Nit: >>file.t, not ">> file.t".

Dnoe.

> > +     git show-ref | sed s/before/after/g > expected &&
>
> Don't have "git" on the LHS of a pipe, it'll hide a segfault. Should use
> a temporary file. Also "s/ > />/g" like above (and in some places below,
> will stop noting it...).

Done.

> > +test_expect_success 'SHA256 support, env' '
> > +     rm -rf .git &&
> > +     GIT_DEFAULT_HASH=3Dsha256 && export GIT_DEFAULT_HASH &&
> > +     (GIT_TEST_REFTABLE=3D1 git_init) &&
> > +     mv .git/hooks .git/hooks-disabled &&
>
> Comments about this .git/hooks-disabled not being needed aside, this
> seems to be duplicating the initialize() function. I.e. should we not
> skip the "rm -rf" and "mv" here, and just set GIT_DEFAULT_HASH=3Dsha256
> and call initialize?
>
> (Better yet, if we get rid of that "git init" wrapper as I noted above,
> this can just be an argument to "git init", no?

Done.

>
> > [...]
> > +     rm -rf .git &&
> > +     (GIT_TEST_REFTABLE=3D1 git_init --object-format=3Dsha256) &&
> > +     mv .git/hooks .git/hooks-disabled &&
>
> ditto.

done.

> > +     ! git update-ref -d refs/tags/file $INVALID_SHA1 &&
>
> Always "test_must_fail git", not "! git".

done.

>
> > [...]
> > +test_expect_success 'clone calls transaction_initial_commit' '
> > +     test_commit message1 file1 &&
> > +     git clone . cloned &&
> > +     (test  -f cloned/file1 || echo "Fixme.")
>
> So this test really tests nothing much, and we should skip the "Fixme"
> here and have this be test_expect_failure() or something instead?
>
> > [...]
> > +     git show-ref | cut -f2 -d" " >actual &&
>
> Git on LHS of a pipe again.
>
> > +# This matches show-ref's output
> > +print_ref() {
> > +     echo "$(git rev-parse "$1") $1"
> > +}
> > +
> > +test_expect_success 'peeled tags are stored' '
> > +     initialize &&
> > +     test_commit file &&
> > +     git tag -m "annotated tag" test_tag HEAD &&
> > +     {
> > +             print_ref "refs/heads/primary" &&
> > +             print_ref "refs/tags/file" &&
> > +             print_ref "refs/tags/test_tag" &&
> > +             print_ref "refs/tags/test_tag^{}"
> > +     } >expect &&
>
> Maybe I'm missing something, but wouldn't this print_ref() helper be
> better as a "git for-each-ref --format" of some sort?
>
> > [...]
> > +. "$TEST_DIRECTORY"/lib-httpd.sh
> > +start_httpd
> > +
> > +REPO=3D"$HTTPD_DOCUMENT_ROOT_PATH/repo"
>
> Let's split these httpd-needing tests into another test file, see
> https://lore.kernel.org/git/87bl753i2p.fsf@evledraar.gmail.com/ for why.

done.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
