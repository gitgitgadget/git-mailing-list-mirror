Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C9BC433DB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 21:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B943665253
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 21:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhCHVwA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 16:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbhCHVvy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 16:51:54 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837FAC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 13:51:54 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id v192so5065489oia.5
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 13:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E0JOmkwaPSBTqVGR6hL5plxvbCWCAaqrafzy9/fc3dw=;
        b=nbvTBo5YkrOYj0tIL/EmQp/Mf0GBs8JLFz1uJectSoEovCH4OlTpTko3WfADWkwQTC
         g5h/47W8vAON41EgM/mMG9SOycMu7Bc58NRQlMLzF4FgcotnLpDRFHoDBrtlaMRI5yl5
         RKK/4O1h7Z+LHgn51f4D3uAjxQ1ALI6A80P+IHI5e04UPaPVKhISpAr6+Z3v3sx+s85q
         +Z5Bizly2moS9vlJXNXhXGSqM/k75xzO24l5YkhqaOesBOhNpYZMlS5IbHrztALZLTw0
         KMWCSIUAXusNrTBae9SHcAPT8iGWg0eypOWneHpVbegA6rxuOvVe5WtVmUxgwLJogDNE
         +lhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E0JOmkwaPSBTqVGR6hL5plxvbCWCAaqrafzy9/fc3dw=;
        b=p39kQothVx8L5x33Zv1WJ42H5G80XZroV2GZhvWmStK9DHOlrCdunWMoizNOWJ/SIi
         M8QMNJXQNbqmTaXxwISr8VQoEqC2ImiTf/PBomjEjaH/Kejra/Zp9GAwvgJ44PSpusCd
         1dJwziur8gpSCPa6VZ2MNjxQNjEJ0a/fprIjevpLDQ2XDMGPJIE8d0b4rOnpX1SPnVBL
         ZTBZSZ+x9tAorpYdo5Fq7BnMR4y+MsogCa7kq1Xqrvh+reErcH6XQmT0v0Z7yXzQ6jP9
         tTm3T5Em0koPbI1UfEANNpOAYc5cjlS8weEIc6WD+dcSRy60cnaFrn8r3h+sba6XMm+w
         E5kg==
X-Gm-Message-State: AOAM530UWmhU2DikQdGoiQCaTSmYtFSmjjZI3ju8Ejc59njlMJ55DPL5
        3TOARDCZM5ZqmjvVoB2e3GzpxHdIvyaOocLfLBE=
X-Google-Smtp-Source: ABdhPJwFKN6UFIF4QtbuTou67uaJgRBfcuS80sB6QCj9HevKM5lxKHy51y9YQI6i7bOsNMUGsqOe2qiuXpvRu5FMKQg=
X-Received: by 2002:a05:6808:a8a:: with SMTP id q10mr665582oij.167.1615240313776;
 Mon, 08 Mar 2021 13:51:53 -0800 (PST)
MIME-Version: 1.0
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
 <d8c6eb39aa7c39263b7f0333ec92a3cc65c367ec.1614905738.git.gitgitgadget@gmail.com>
 <87v9a1iycx.fsf@evledraar.gmail.com>
In-Reply-To: <87v9a1iycx.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 8 Mar 2021 13:51:42 -0800
Message-ID: <CABPp-BFr5_EurX2D1Yo7UAJNnLLFauqE5FFfULjGjtzzG9UJZQ@mail.gmail.com>
Subject: Re: [PATCH 10/11] merge-ort: write $GIT_DIR/AUTO_MERGE whenever we
 hit a conflict
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 8, 2021 at 5:11 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Fri, Mar 05 2021, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > There are a variety of questions users might ask while resolving
> > conflicts:
> >   * What changes have been made since the previous (first) parent?
> >   * What changes are staged?
> >   * What is still unstaged? (or what is still conflicted?)
> >   * What changes did I make to resolve conflicts so far?
> > The first three of these have simple answers:
> >   * git diff HEAD
> >   * git diff --cached
> >   * git diff
> > There was no way to answer the final question previously.  Adding one
> > is trivial in merge-ort, since it works by creating a tree representing
> > what should be written to the working copy complete with conflict
> > markers.  Simply write that tree to .git/AUTO_MERGE, allowing users to
> > answer the fourth question with
> >   * git diff AUTO_MERGE
> >
> > I avoided using a name like "MERGE_AUTO", because that would be
> > merge-specific (much like MERGE_HEAD, REBASE_HEAD, REVERT_HEAD,
> > CHERRY_PICK_HEAD) and I wanted a name that didn't change depending on
> > which type of operation the merge was part of.
>
> That's a really cool feature. I'm starting to like this "ort" thing :)
>
> (After knowing almost nothing about it until a few days ago...)
>
> > Ensure that paths which clean out other temporary operation-specific
> > files (e.g. CHERRY_PICK_HEAD, MERGE_MSG, rebase-merge/ state directory)
> > also clean out this AUTO_MERGE file.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  branch.c         |  1 +
> >  builtin/rebase.c |  1 +
> >  merge-ort.c      | 10 ++++++++++
> >  path.c           |  1 +
> >  path.h           |  2 ++
> >  sequencer.c      |  5 +++++
> >  6 files changed, 20 insertions(+)
> >
> > diff --git a/branch.c b/branch.c
> > index 9c9dae1eae32..b71a2de29dbe 100644
> > --- a/branch.c
> > +++ b/branch.c
> > @@ -344,6 +344,7 @@ void remove_merge_branch_state(struct repository *r=
)
> >       unlink(git_path_merge_rr(r));
> >       unlink(git_path_merge_msg(r));
> >       unlink(git_path_merge_mode(r));
> > +     unlink(git_path_auto_merge(r));
> >       save_autostash(git_path_merge_autostash(r));
> >  }
> >
> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index de400f9a1973..7d9afe118fd4 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -739,6 +739,7 @@ static int finish_rebase(struct rebase_options *opt=
s)
> >       int ret =3D 0;
> >
> >       delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
> > +     unlink(git_path_auto_merge(the_repository));
> >       apply_autostash(state_dir_path("autostash", opts));
> >       close_object_store(the_repository->objects);
> >       /*
> > diff --git a/merge-ort.c b/merge-ort.c
> > index 37b69cbe0f9a..cf927cd160e1 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -3362,6 +3362,9 @@ void merge_switch_to_result(struct merge_options =
*opt,
> >  {
> >       assert(opt->priv =3D=3D NULL);
> >       if (result->clean >=3D 0 && update_worktree_and_index) {
> > +             const char *filename;
> > +             FILE *fp;
> > +
> >               trace2_region_enter("merge", "checkout", opt->repo);
> >               if (checkout(opt, head, result->tree)) {
> >                       /* failure to function */
> > @@ -3380,6 +3383,13 @@ void merge_switch_to_result(struct merge_options=
 *opt,
> >               }
> >               opt->priv =3D NULL;
> >               trace2_region_leave("merge", "record_conflicted", opt->re=
po);
> > +
> > +             trace2_region_enter("merge", "write_auto_merge", opt->rep=
o);
> > +             filename =3D git_path_auto_merge(opt->repo);
> > +             fp =3D xfopen(filename, "w");
> > +             fprintf(fp, "%s\n", oid_to_hex(&result->tree->object.oid)=
);
> > +             fclose(fp);
> > +             trace2_region_leave("merge", "write_auto_merge", opt->rep=
o);
>
> This isn't a new problem since you're just folling an existing pattern,
> but here you (rightly) do xopen()< and the:n

Looks like your comment got garbled/truncated.  Do you remember the
rest of what you were going to say here?

> >       }
> >
> >       if (display_update_msgs) {
> > diff --git a/path.c b/path.c
> > index 7b385e5eb282..9e883eb52446 100644
> > --- a/path.c
> > +++ b/path.c
> > @@ -1534,5 +1534,6 @@ REPO_GIT_PATH_FUNC(merge_rr, "MERGE_RR")
> >  REPO_GIT_PATH_FUNC(merge_mode, "MERGE_MODE")
> >  REPO_GIT_PATH_FUNC(merge_head, "MERGE_HEAD")
> >  REPO_GIT_PATH_FUNC(merge_autostash, "MERGE_AUTOSTASH")
> > +REPO_GIT_PATH_FUNC(auto_merge, "AUTO_MERGE")
> >  REPO_GIT_PATH_FUNC(fetch_head, "FETCH_HEAD")
> >  REPO_GIT_PATH_FUNC(shallow, "shallow")
> > diff --git a/path.h b/path.h
> > index e7e77da6aaa5..251c78d98000 100644
> > --- a/path.h
> > +++ b/path.h
> > @@ -176,6 +176,7 @@ struct path_cache {
> >       const char *merge_mode;
> >       const char *merge_head;
> >       const char *merge_autostash;
> > +     const char *auto_merge;
> >       const char *fetch_head;
> >       const char *shallow;
> >  };
> > @@ -191,6 +192,7 @@ const char *git_path_merge_rr(struct repository *r)=
;
> >  const char *git_path_merge_mode(struct repository *r);
> >  const char *git_path_merge_head(struct repository *r);
> >  const char *git_path_merge_autostash(struct repository *r);
> > +const char *git_path_auto_merge(struct repository *r);
> >  const char *git_path_fetch_head(struct repository *r);
> >  const char *git_path_shallow(struct repository *r);
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index d2332d3e1787..472cdd8c620d 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -2096,6 +2096,7 @@ static int do_pick_commit(struct repository *r,
> >               refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_H=
EAD",
> >                               NULL, 0);
> >               unlink(git_path_merge_msg(r));
> > +             unlink(git_path_auto_merge(r));
>
> Shouldn't this & the rest ideally be at least unlink_or_warn()?

Perhaps, but I think that should be a follow-on series or
#leftoverbits.  I'm having enough trouble getting reviews (I think I'm
burning Stolee out after the last half year) without making my series
longer for tangential cleanups.  :-)

I'm starting to worry that despite having all the remaining patches
ready (and most have been ready for months), that we won't be able to
get merge-ort done before git-2.32 -- the -rc0 for it is now just
under three months away.

> >               fprintf(stderr,
> >                       _("dropping %s %s -- patch contents already upstr=
eam\n"),
> >                       oid_to_hex(&commit->object.oid), msg.subject);
> > @@ -2451,6 +2452,8 @@ void sequencer_post_commit_cleanup(struct reposit=
ory *r, int verbose)
> >               need_cleanup =3D 1;
> >       }
> >
> > +     unlink(git_path_auto_merge(r));
> > +
> >       if (!need_cleanup)
> >               return;
> >
> > @@ -4111,6 +4114,7 @@ static int pick_commits(struct repository *r,
> >                       unlink(rebase_path_stopped_sha());
> >                       unlink(rebase_path_amend());
> >                       unlink(git_path_merge_head(r));
> > +                     unlink(git_path_auto_merge(r));
> >                       delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DERE=
F);
> >
> >                       if (item->command =3D=3D TODO_BREAK) {
> > @@ -4505,6 +4509,7 @@ static int commit_staged_changes(struct repositor=
y *r,
> >               return error(_("could not commit staged changes."));
> >       unlink(rebase_path_amend());
> >       unlink(git_path_merge_head(r));
> > +     unlink(git_path_auto_merge(r));
> >       if (final_fixup) {
> >               unlink(rebase_path_fixup_msg());
> >               unlink(rebase_path_squash_msg());
