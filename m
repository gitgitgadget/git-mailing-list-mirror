Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66592C2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 20:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252BC2073A
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 20:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZBVAvWN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbgAUUHe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 15:07:34 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35055 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgAUUHe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 15:07:34 -0500
Received: by mail-ot1-f67.google.com with SMTP id i15so4164670oto.2
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 12:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0njAnNw2saITtkJ02uCNp675VMngnT5QANgfDJVAkEM=;
        b=KZBVAvWNcO/l6d4EjPVNwt3/+WIsQIEwDyQCcX2u2zPpEflEa6rXZgABDSeCaPIStn
         ufmqV+F1c69n+JVNXi+S3xaDKjLVkIAuaMRef7wjY/2mSZo2a8uCy/Q5WRN54p6CbxcE
         IDoRhhCoMxFIMjiZKqUVZMlFlmK4Nr+7HoghqDUPm6h4CBHXOyJ4FSu2+GLuqsd3TVQP
         o2Zw0oBM/VurI4iVrI6Nus6jK2xFuvrauBfcA0y+29dA98kAkDTcWr5HmLSfWAOdfOtl
         lQp2u6nuaZyB42SZi8NMgeLjt8VTSWuw1lwIG7kJbP/CqL8E4vQ4oYGTsiRUo0JXl00u
         c97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0njAnNw2saITtkJ02uCNp675VMngnT5QANgfDJVAkEM=;
        b=j59ainwW522TbhMamnU4YjOMdSNpFYP5iQ8uk5tiisbuLhBc6it+yErEgXFig9KNlC
         SFAdfQFUyA+8zRSS02G3d1qdTZgxdBCXQub5TYRO6VDw9EmZL7WebaW9cxZprAy4eDng
         hP3iLxY8Ulz+zcnDgPc6KICtvCDdrNVzt23q8OuC5x1Gt6pXuJ8RFNf/V2tr3ntl4UMA
         x5FZ3RZWh6xrowHIfhwjCEl39F25GvnpCXFFvQVPMIEK0yqbGncGIhVNgjnDTHp64RsO
         Qw+8hv5zqTPsM8PO/QSUg9zl2qYcKgnlhoXzIJSFhK5TVVPmFago4Hk7vd3e/0GgWDdb
         vgxQ==
X-Gm-Message-State: APjAAAV93hrWbcvhjpglrfPaRPuWcNyf72/xG12UqehUr20QINMyqXxs
        ozYSRGpmysSVuk1TZHCDJJkoxfT9XjrHuL0MPkGzI30a
X-Google-Smtp-Source: APXvYqxPoikAOGndeudq6t/pxjRL7I74ragFQL5W+79Z+hG9og6PVDyYCcGwGPIW6NBoRLBq8tBG+WYIC1UUqAaix8c=
X-Received: by 2002:a9d:24ea:: with SMTP id z97mr4907557ota.345.1579637252547;
 Tue, 21 Jan 2020 12:07:32 -0800 (PST)
MIME-Version: 1.0
References: <20200109150332.GF32750@szeder.dev> <20200121191857.23047-1-alban.gruin@gmail.com>
In-Reply-To: <20200121191857.23047-1-alban.gruin@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 21 Jan 2020 12:07:20 -0800
Message-ID: <CABPp-BEMZS4b_iYqP8nw0Oegfdx4DQadSwp00mXKPiaV58Pbpw@mail.gmail.com>
Subject: Re: [PATCH v1] rebase -i: stop checking out the tip of the branch to rebase
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

// Adding Phillip and Johannes since they know the sequencer internals
very well.

On Tue, Jan 21, 2020 at 11:21 AM Alban Gruin <alban.gruin@gmail.com> wrote:
>
> One of the first things done by the interactive rebase is to make a todo
> list.  This requires knowledge of the commit range to rebase.  To get
> the oid of the last commit of the range, the tip of the branch to rebase
> is checked out with prepare_branch_to_be_rebased(), then the oid of the
> HEAD is read.  On big repositories, it's a performance penalty: the user
> may have to wait before editing the todo list while git is extracting the
> branch silently (because git-checkout is silenced here).  After this,
> the head of the branch is not even modified.
>
> Since we already have the oid of the tip of the branch in
> `opts->orig_head', it's useless to switch to this commit.
>
> This removes the call to prepare_branch_to_be_rebased() in
> do_interactive_rebase(), and adds a `orig_head' parameter to
> get_revision_ranges().  prepare_branch_to_be_rebased() is removed as it
> is no longer used.
>
> This introduces a visible change: as we do not switch on the tip of the
> branch to rebase, no reflog entry is created at the beginning of the
> rebase for it.

Oh, sweet, thanks for digging in.  I had also dug in just after the
report, but not quite far enough as I still had failing tests and I
was feeling a bit stretched thin on other projects so I punted hoping
that SZEDER would post something.  Looks like the orig_head thing was
probably what I was missing.

I was a little surprised that there wasn't any regression test that
needed to be modified, as it reminded me of a previous conversation
about excessive work in the interactive backend[1], but after looking
it up that was apparently about too many calls to commit rather than
too many calls to checkout.

[1] https://lore.kernel.org/git/nycvar.QRO.7.76.6.1811121614190.39@tvgsbejv=
aqbjf.bet/

> Reported-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>
> Notes:
>     Improvements brought by this patch:
>
>     Before:
>
>     $ time git rebase -m --onto v4.18 463fa44eec2fef50~ 463fa44eec2fef50
>
>     real    0m8,940s
>     user    0m6,830s
>     sys     0m2,121s
>
>     After:
>
>     $ time git rebase -m --onto v4.18 463fa44eec2fef50~ 463fa44eec2fef50
>
>     real    0m1,834s
>     user    0m0,916s
>     sys     0m0,206s

Nice...do we want to mention this in the commit message proper too?

>
>     Both tests have been performed on a 5400 RPM SATA III hard drive.
>
>  builtin/rebase.c | 18 +++++-------------
>  sequencer.c      | 14 --------------
>  sequencer.h      |  3 ---
>  3 files changed, 5 insertions(+), 30 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 8081741f8a..6154ad8fa5 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -246,21 +246,17 @@ static int edit_todo_file(unsigned flags)
>  }
>
>  static int get_revision_ranges(struct commit *upstream, struct commit *o=
nto,
> -                              const char **head_hash,
> +                              struct object_id *orig_head, const char **=
head_hash,
>                                char **revisions, char **shortrevisions)
>  {
>         struct commit *base_rev =3D upstream ? upstream : onto;
>         const char *shorthead;
> -       struct object_id orig_head;
> -
> -       if (get_oid("HEAD", &orig_head))
> -               return error(_("no HEAD?"));
>
> -       *head_hash =3D find_unique_abbrev(&orig_head, GIT_MAX_HEXSZ);
> +       *head_hash =3D find_unique_abbrev(orig_head, GIT_MAX_HEXSZ);
>         *revisions =3D xstrfmt("%s...%s", oid_to_hex(&base_rev->object.oi=
d),
>                                                    *head_hash);
>
> -       shorthead =3D find_unique_abbrev(&orig_head, DEFAULT_ABBREV);
> +       shorthead =3D find_unique_abbrev(orig_head, DEFAULT_ABBREV);
>
>         if (upstream) {
>                 const char *shortrev;
> @@ -314,12 +310,8 @@ static int do_interactive_rebase(struct rebase_optio=
ns *opts, unsigned flags)
>         struct replay_opts replay =3D get_replay_opts(opts);
>         struct string_list commands =3D STRING_LIST_INIT_DUP;
>
> -       if (prepare_branch_to_be_rebased(the_repository, &replay,
> -                                        opts->switch_to))
> -               return -1;
> -
> -       if (get_revision_ranges(opts->upstream, opts->onto, &head_hash,
> -                               &revisions, &shortrevisions))
> +       if (get_revision_ranges(opts->upstream, opts->onto, &opts->orig_h=
ead,
> +                               &head_hash, &revisions, &shortrevisions))
>                 return -1;
>
>         if (init_basic_state(&replay,
> diff --git a/sequencer.c b/sequencer.c
> index b9dbf1adb0..4dc245d7ec 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3715,20 +3715,6 @@ static int run_git_checkout(struct repository *r, =
struct replay_opts *opts,
>         return ret;
>  }
>
> -int prepare_branch_to_be_rebased(struct repository *r, struct replay_opt=
s *opts,
> -                                const char *commit)
> -{
> -       const char *action;
> -
> -       if (commit && *commit) {
> -               action =3D reflog_message(opts, "start", "checkout %s", c=
ommit);
> -               if (run_git_checkout(r, opts, commit, action))
> -                       return error(_("could not checkout %s"), commit);
> -       }
> -
> -       return 0;
> -}
> -
>  static int checkout_onto(struct repository *r, struct replay_opts *opts,
>                          const char *onto_name, const struct object_id *o=
nto,
>                          const char *orig_head)
> diff --git a/sequencer.h b/sequencer.h
> index 9f9ae291e3..74f1e2673e 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -190,9 +190,6 @@ void commit_post_rewrite(struct repository *r,
>                          const struct commit *current_head,
>                          const struct object_id *new_head);
>
> -int prepare_branch_to_be_rebased(struct repository *r, struct replay_opt=
s *opts,
> -                                const char *commit);
> -
>  #define SUMMARY_INITIAL_COMMIT   (1 << 0)
>  #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
>  void print_commit_summary(struct repository *repo,
> --
> 2.24.1

The code looks reasonable to me, but I'm still not completely familiar
with all the rebase and sequencer code so I'm hoping Phillip or
Johannes can give a thumbs up.

Thanks for digging into this and figuring out the bits that I missed
when I tried.


Elijah
