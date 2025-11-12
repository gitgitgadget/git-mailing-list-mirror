Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BBF32C92A
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963098; cv=none; b=Ud/6iE1lr7YvNhnIjkVQ2bTLsOqjIeq+SZmnvZ7cGfYFSV+fPV+c6Xiv6QWNpz5i8fJxjAOP2U3+8jpf09R05XhdS/pCQZZySK4Zq6BOl7pucBP9GdhCVeOdXd7CiHhDB7P2FXJJayw6Ll+JjGr+9Yn1VG632r2cUsg7xdBcZvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963098; c=relaxed/simple;
	bh=eGypm90PKXdAR6uY0dpuYqw7SIriuhIvgiHtLKYUFEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2YVusoSQdYW5P+7zv2QfRCyzVlaHATQ9qXBz2NhHC3FXzDZdn4wSmjgzG64hNDOJpQQWvjCRVdnkz9nDdEIQMIky4P1toQxtGTz9ACQpqGUYmMxcEqIQ1MuyP2/Wn53wKKhV+6RjtjPv8zoR4iQvlHntbjrvqJgyHubauczh6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObhNM09Q; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObhNM09Q"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so1365615a12.3
        for <git@vger.kernel.org>; Wed, 12 Nov 2025 07:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762963094; x=1763567894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moBCQY+tP3fceSaMa2SH4iCIqbSgmS1ldia8keYNmzU=;
        b=ObhNM09QQKWS+iMJ5X02yAuTjjWHcDhYznMX5wqD1G6Jg8vNNrFcmWt6ehh4vg96gc
         EL3oIrkoyBeONbI5BT5HBORxhFls70c942Ni+Aa2f0kd7ISpPzePMhXCK8qekueYOWEs
         bHz2RpiYEjsL1MCSLgbY0f02vPixqIQ9erJxpAep88unj4MIhgqMhtB81EpMtNrQrZ9P
         aMHdCWzL6z1VBcq6C+TUA3TQl5LCuZrerSAdsoA7kT49QHwMOMPQxI0HHYN8EvWQNF1f
         Dq15yXP0UqevTIAt7J7yfkSEvctESBfOFIq65xVZjnCbBNijaTq0vDWwjYq9nRLRNeZL
         N14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762963094; x=1763567894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=moBCQY+tP3fceSaMa2SH4iCIqbSgmS1ldia8keYNmzU=;
        b=t8YzdMXjLYPufQyP8awulu9WoKRQ4nL+Vx8camSwtBW/XU69srR7ALmXa8r0xG66L2
         NfY6WSZP1CNZnQwwo+PY9MNnwAK3kwJpEvs0pssclH4M3g6qwVVyljQAMIXb84t54eUv
         CvqFGf91Jf2k11h1cHRO15UVaIj4cozTl13yA350cWxBhamK6Ye26nG/+/C+tCTvEY1Q
         QODp0FZ9pr5ct87gawSDyvFuyX81sD1LnFhg1E92T0ILsMRxJZgVY8ZceVw3X6Yg8A5i
         Bvc9JnTuafgRoIbFk7QT5ZB3crgVWEc4vGqcrRYEAHgjOu/fAiGwqeFsGveZZ5yrhnd3
         +iKA==
X-Forwarded-Encrypted: i=1; AJvYcCVP+WHoZvQbemyYWfMsvj8kURytUwJmVuD8dqFfdHxB98zCyxRfYW03EqYDg8z+pePpSTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEWoF+2AQgvH2U+C9PV0eoHgDV/aDi6NSmevsb7gujQa/+Yon0
	WstI5xCk/jCoTQvm3u+4+2YQEc6ri4qcuzdGON+oDJEcFMawmdsDOBNAc6mg+BvdkjHyHdIU1Bj
	HRsOdu7E3kPUOaFQKhBhstVaPkuZbgvkqLB3Y+G8+eWWn
X-Gm-Gg: ASbGncuFdDCuP0nckjpb7iAxZGw6LZ0fPHEZnqmRtcxXoV+llMHH+PXneh6gShj8D2f
	3c8QLspbwEz6TuIiJCY1d6xf/OONjzu7jOc/1oUTpb/pbnS/J75U/W/PWnobZi1mn9luostGpCV
	89cTqJ1r/i1weHKE34F0OuZSIuwvtT2y2loG4SCCcuFgZnxQbjAnJvIJxTsRZ95+JMn4qeY2yYw
	EATBb1wKvjHSEkWT3fy5EJ1m9v8fJoI0vnmOycMKXkC6aOB1VM8cZbZraAHBz6f12ja4+qhVLi0
	DKpH5g0xJ6QL
X-Google-Smtp-Source: AGHT+IG3RXejuCOb34TABH+eK69xLeR9HcPHk6Ge9V6C4wf1btLHE4WTnqvw960+ILnEw73NXNzEkPX792XUoQXiCBI=
X-Received: by 2002:a05:6402:3507:b0:641:61bc:560 with SMTP id
 4fb4d7f45d1cf-6431a57e1f4mr2843981a12.36.1762963093936; Wed, 12 Nov 2025
 07:58:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
 <6be20c41-15a0-4732-bd12-4927a59a9f59@gmail.com> <CAOLTT8TPrNTCjHwJfdeei+t8+7AxGC-dvbq-4oHJ=qNn_c+-jQ@mail.gmail.com>
 <7d99f00c-3602-4b28-8efd-4780cad41ca8@gmail.com>
In-Reply-To: <7d99f00c-3602-4b28-8efd-4780cad41ca8@gmail.com>
From: ZheNing Hu <adlternative@gmail.com>
Date: Wed, 12 Nov 2025 23:58:02 +0800
X-Gm-Features: AWmQ_bnOUs3ul1EFXnKY7gxt3SDsv6s6obTAFCQxiJc6SlYoerxRqpYWj55WRxk
Message-ID: <CAOLTT8TLEsSAcfUomoActrUSzje5mQNE7EweXh8WtY3sOfzfkg@mail.gmail.com>
Subject: Re: [PATCH] commit: add --committer option
To: phillip.wood@dunelm.org.uk
Cc: ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Phillip Wood <phillip.wood123@gmail.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=881=
1=E6=97=A5=E5=91=A8=E4=BA=8C 22:38=E5=86=99=E9=81=93=EF=BC=9A
>
> On 11/11/2025 13:01, ZheNing Hu wrote:
> > Phillip Wood <phillip.wood123@gmail.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=
=8811=E6=97=A5=E5=91=A8=E4=BA=8C 00:50=E5=86=99=E9=81=93=EF=BC=9A
> >> On 09/11/2025 10:22, ZheNing Hu via GitGitGadget wrote:
> >>> From: ZheNing Hu <adlternative@gmail.com>
> >>>
> >>>
> >>>       This patch introduces the --committer option to git-commit, pro=
viding:
> >>>
> >>>        1. Consistency with the existing --author option
> >>>        2. A more convenient alternative to environment variables
> >>>        3. Better support for automated workflows and scripts
> >>>        4. Improved user experience when managing multiple identities
> >>
> >> What's the use case for the same person committing under different
> >> identities? We already have a config mechanism to set different
> >> identities for different repositories but I'm struggling to see why
> >> someone would want to create commits under multiple identities in a
> >> single repository. For scripts it easy enough to set the relevant
> >> environment variables if a tool wants to create commits under its own
> >> identity.
> >>
> >
> > I frequently need to distinguish between different user.name and user.e=
mail
> > configurations on our company's internal GitHub.
> >
> > The current problems are:
> >
> > When I misconfigure (which happens occasionally), git commit --author o=
nly fixes
> > the author part, I still need to additionally set GIT_COMMITTER_NAME an=
d
> > GIT_COMMITTER_EMAIL environment variables to fix the committer informat=
ion
> > These environment variables are painful to use, requiring manual setup
> > every time
>
> I'm afraid I don't quite follow. If you are amending existing commits to
> fix them up after you have corrected your configuration then they will
> have the correct committer automatically when you run "git commit
> --amend --author=3D..." to correct the author. If you are committing
> before you have realized that user.{name,email} are misconfigured then I
> don't see how "--committer" helps because you have not yet realized
> anything is wrong.
>

You're right that after realizing the misconfiguration and correcting the
repository's user.name and user.email, running `git commit --amend` will
 fix the committer information, but the author remains unchanged. Users
then need an additional `git commit --amend --author=3D...` to fix the auth=
or,
which does work but requires an extra step.

I see your point that this becomes more cumbersome when dealing with
multiple commits. In such cases, users currently need to use something like=
:

```
GIT_AUTHOR_NAME=3D"..." GIT_AUTHOR_EMAIL=3D"..." \
GIT_COMMITTER_NAME=3D"..." GIT_COMMITTER_EMAIL=3D"..." \
git rebase -f <target>
```

This is indeed tedious and error-prone, especially when you want
to quickly fix and push commits to the platform.

`git commit --amend --author --committer` or a new `git rebase
--author --committer`
would provide a more user-friendly workflow for correcting identity
information after misconfiguration, eliminating the need to manually
set multiple
environment variables or run multiple commands.

> Thanks
>
> Phillip
>

Thanks

ZheNing Hu

> > If a --committer option could be provided to align with --author, users=
 wouldn't
> > need to remember and use these additional environment variables.
> > This would greatly simplify the workflow and reduce cognitive overhead.
> >
> >
> >> Thanks
> >>
> >> Phillip
> >>
> >>>       The implementation follows the same pattern as the --author opt=
ion,
> >>>       accepting the format "Name " and properly validating the input.
> >>>
> >>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-199=
7%2Fadlternative%2Fzh%2Fimplement-committer-option-v1
> >>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1997/a=
dlternative/zh/implement-committer-option-v1
> >>> Pull-Request: https://github.com/gitgitgadget/git/pull/1997
> >>>
> >>>    Documentation/git-commit.adoc |  9 +++-
> >>>    builtin/commit.c              | 58 ++++++++++++++++++++++++-
> >>>    t/t7509-commit-authorship.sh  | 80 +++++++++++++++++++++++++++++++=
++++
> >>>    3 files changed, 144 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/Documentation/git-commit.adoc b/Documentation/git-commit=
.adoc
> >>> index 54c207ad45..a015c8328e 100644
> >>> --- a/Documentation/git-commit.adoc
> >>> +++ b/Documentation/git-commit.adoc
> >>> @@ -12,7 +12,7 @@ git commit [-a | --interactive | --patch] [-s] [-v]=
 [-u[<mode>]] [--amend]
> >>>           [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amen=
d|reword):]<commit>]
> >>>           [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
> >>>           [--allow-empty-message] [--no-verify] [-e] [--author=3D<aut=
hor>]
> >>> -        [--date=3D<date>] [--cleanup=3D<mode>] [--[no-]status]
> >>> +        [--date=3D<date>] [--committer=3D<committer>] [--cleanup=3D<=
mode>] [--[no-]status]
> >>>           [-i | -o] [--pathspec-from-file=3D<file> [--pathspec-file-n=
ul]]
> >>>           [(--trailer <token>[(=3D|:)<value>])...] [-S[<keyid>]]
> >>>           [--] [<pathspec>...]
> >>> @@ -181,6 +181,13 @@ See linkgit:git-rebase[1] for details.
> >>>    `--date=3D<date>`::
> >>>        Override the author date used in the commit.
> >>>
> >>> +`--committer=3D<committer>`::
> >>> +     Override the committer for the commit. Specify an explicit comm=
itter using the
> >>> +     standard `A U Thor <committer@example.com>` format. Otherwise _=
<committer>_
> >>> +     is assumed to be a pattern and is used to search for an existin=
g
> >>> +     commit by that author (i.e. `git rev-list --all -i --author=3D<=
committer>`);
> >>> +     the commit author is then copied from the first such commit fou=
nd.
> >>> +
> >>>    `-m <msg>`::
> >>>    `--message=3D<msg>`::
> >>>        Use _<msg>_ as the commit message.
> >>> diff --git a/builtin/commit.c b/builtin/commit.c
> >>> index 0243f17d53..88e77cbaab 100644
> >>> --- a/builtin/commit.c
> >>> +++ b/builtin/commit.c
> >>> @@ -49,7 +49,7 @@ static const char * const builtin_commit_usage[] =
=3D {
> >>>           "           [--dry-run] [(-c | -C | --squash) <commit> | --=
fixup [(amend|reword):]<commit>]\n"
> >>>           "           [-F <file> | -m <msg>] [--reset-author] [--allo=
w-empty]\n"
> >>>           "           [--allow-empty-message] [--no-verify] [-e] [--a=
uthor=3D<author>]\n"
> >>> -        "           [--date=3D<date>] [--cleanup=3D<mode>] [--[no-]s=
tatus]\n"
> >>> +        "           [--date=3D<date>] [--committer=3D<committer>] [-=
-cleanup=3D<mode>] [--[no-]status]\n"
> >>>           "           [-i | -o] [--pathspec-from-file=3D<file> [--pat=
hspec-file-nul]]\n"
> >>>           "           [(--trailer <token>[(=3D|:)<value>])...] [-S[<k=
eyid>]]\n"
> >>>           "           [--] [<pathspec>...]"),
> >>> @@ -112,6 +112,7 @@ static enum {
> >>>    } commit_style;
> >>>
> >>>    static const char *force_author;
> >>> +static const char *force_committer;
> >>>    static char *logfile;
> >>>    static char *template_file;
> >>>    /*
> >>> @@ -690,6 +691,48 @@ static void determine_author_info(struct strbuf =
*author_ident)
> >>>        free(date);
> >>>    }
> >>>
> >>> +static void determine_committer_info(struct strbuf *committer_ident)
> >>> +{
> >>> +     char *name, *email, *date;
> >>> +     struct ident_split committer;
> >>> +
> >>> +     name =3D xstrdup_or_null(getenv("GIT_COMMITTER_NAME"));
> >>> +     email =3D xstrdup_or_null(getenv("GIT_COMMITTER_EMAIL"));
> >>> +     date =3D xstrdup_or_null(getenv("GIT_COMMITTER_DATE"));
> >>> +
> >>> +     if (force_committer) {
> >>> +             struct ident_split ident;
> >>> +
> >>> +             if (split_ident_line(&ident, force_committer, strlen(fo=
rce_committer)) < 0)
> >>> +                     die(_("malformed --committer parameter"));
> >>> +             set_ident_var(&name, xmemdupz(ident.name_begin, ident.n=
ame_end - ident.name_begin));
> >>> +             set_ident_var(&email, xmemdupz(ident.mail_begin, ident.=
mail_end - ident.mail_begin));
> >>> +
> >>> +             if (ident.date_begin) {
> >>> +                     struct strbuf date_buf =3D STRBUF_INIT;
> >>> +                     strbuf_addch(&date_buf, '@');
> >>> +                     strbuf_add(&date_buf, ident.date_begin, ident.d=
ate_end - ident.date_begin);
> >>> +                     strbuf_addch(&date_buf, ' ');
> >>> +                     strbuf_add(&date_buf, ident.tz_begin, ident.tz_=
end - ident.tz_begin);
> >>> +                     set_ident_var(&date, strbuf_detach(&date_buf, N=
ULL));
> >>> +             }
> >>> +     }
> >>> +
> >>> +     if (force_date) {
> >>> +             struct strbuf date_buf =3D STRBUF_INIT;
> >>> +             if (parse_force_date(force_date, &date_buf))
> >>> +                     die(_("invalid date format: %s"), force_date);
> >>> +             set_ident_var(&date, strbuf_detach(&date_buf, NULL));
> >>> +     }
> >>> +
> >>> +     strbuf_addstr(committer_ident, fmt_ident(name, email, WANT_COMM=
ITTER_IDENT, date,
> >>> +                             IDENT_STRICT));
> >>> +     assert_split_ident(&committer, committer_ident);
> >>> +     free(name);
> >>> +     free(email);
> >>> +     free(date);
> >>> +}
> >>> +
> >>>    static int author_date_is_interesting(void)
> >>>    {
> >>>        return author_message || force_date;
> >>> @@ -1321,6 +1364,9 @@ static int parse_and_validate_options(int argc,=
 const char *argv[],
> >>>        if (force_author && renew_authorship)
> >>>                die(_("options '%s' and '%s' cannot be used together")=
, "--reset-author", "--author");
> >>>
> >>> +     if (force_committer && !strchr(force_committer, '>'))
> >>> +             force_committer =3D find_author_by_nickname(force_commi=
tter);
> >>> +
> >>>        if (logfile || have_option_m || use_message)
> >>>                use_editor =3D 0;
> >>>
> >>> @@ -1709,6 +1755,7 @@ int cmd_commit(int argc,
> >>>                OPT_FILENAME('F', "file", &logfile, N_("read message f=
rom file")),
> >>>                OPT_STRING(0, "author", &force_author, N_("author"), N=
_("override author for commit")),
> >>>                OPT_STRING(0, "date", &force_date, N_("date"), N_("ove=
rride date for commit")),
> >>> +             OPT_STRING(0, "committer", &force_committer, N_("commit=
ter"), N_("override committer for commit")),
> >>>                OPT_CALLBACK('m', "message", &message, N_("message"), =
N_("commit message"), opt_parse_m),
> >>>                OPT_STRING('c', "reedit-message", &edit_message, N_("c=
ommit"), N_("reuse and edit message from specified commit")),
> >>>                OPT_STRING('C', "reuse-message", &use_message, N_("com=
mit"), N_("reuse message from specified commit")),
> >>> @@ -1785,6 +1832,7 @@ int cmd_commit(int argc,
> >>>
> >>>        struct strbuf sb =3D STRBUF_INIT;
> >>>        struct strbuf author_ident =3D STRBUF_INIT;
> >>> +     struct strbuf committer_ident =3D STRBUF_INIT;
> >>>        const char *index_file, *reflog_msg;
> >>>        struct object_id oid;
> >>>        struct commit_list *parents =3D NULL;
> >>> @@ -1930,8 +1978,13 @@ int cmd_commit(int argc,
> >>>                append_merge_tag_headers(parents, &tail);
> >>>        }
> >>>
> >>> +     if (force_committer) {
> >>> +             determine_committer_info(&committer_ident);
> >>> +     }
> >>> +
> >>>        if (commit_tree_extended(sb.buf, sb.len, &the_repository->inde=
x->cache_tree->oid,
> >>> -                              parents, &oid, author_ident.buf, NULL,
> >>> +                              parents, &oid, author_ident.buf,
> >>> +                              force_committer ? committer_ident.buf =
: NULL,
> >>>                                 sign_commit, extra)) {
> >>>                rollback_index_files();
> >>>                die(_("failed to write commit object"));
> >>> @@ -1980,6 +2033,7 @@ cleanup:
> >>>        free_commit_extra_headers(extra);
> >>>        free_commit_list(parents);
> >>>        strbuf_release(&author_ident);
> >>> +     strbuf_release(&committer_ident);
> >>>        strbuf_release(&err);
> >>>        strbuf_release(&sb);
> >>>        free(logfile);
> >>> diff --git a/t/t7509-commit-authorship.sh b/t/t7509-commit-authorship=
.sh
> >>> index 8e373b566b..45527f6a70 100755
> >>> --- a/t/t7509-commit-authorship.sh
> >>> +++ b/t/t7509-commit-authorship.sh
> >>> @@ -12,6 +12,11 @@ author_header () {
> >>>        sed -n -e '/^$/q' -e '/^author /p'
> >>>    }
> >>>
> >>> +committer_header () {
> >>> +     git cat-file commit "$1" |
> >>> +     sed -n -e '/^$/q' -e '/^committer /p'
> >>> +}
> >>> +
> >>>    message_body () {
> >>>        git cat-file commit "$1" |
> >>>        sed -e '1,/^$/d'
> >>> @@ -171,4 +176,79 @@ test_expect_success '--reset-author with CHERRY_=
PICK_HEAD' '
> >>>        test_cmp expect actual
> >>>    '
> >>>
> >>> +test_expect_success '--committer option overrides committer' '
> >>> +     git checkout Initial &&
> >>> +     echo "Test --committer" >>foo &&
> >>> +     test_tick &&
> >>> +     git commit -a -m "test committer" --committer=3D"Custom Committ=
er <custom@committer.example>" &&
> >>> +     committer_header HEAD >actual &&
> >>> +     grep "Custom Committer <custom@committer.example>" actual
> >>> +'
> >>> +
> >>> +test_expect_success '--committer with pattern search' '
> >>> +     echo "Test committer pattern" >>foo &&
> >>> +     test_tick &&
> >>> +     git commit -a -m "test committer pattern" --committer=3D"Frigat=
e" &&
> >>> +     committer_header HEAD >actual &&
> >>> +     grep "Frigate <flying@over.world>" actual
> >>> +'
> >>> +
> >>> +test_expect_success '--committer malformed parameter' '
> >>> +     echo "Test malformed" >>foo &&
> >>> +     test_tick &&
> >>> +     test_must_fail git commit -a -m "test malformed" --committer=3D=
"malformed committer"
> >>> +'
> >>> +
> >>> +test_expect_success '--committer with --amend option' '
> >>> +     git checkout -f Initial &&
> >>> +     echo "Test committer with amend" >>foo &&
> >>> +     test_tick &&
> >>> +     git commit -a -m "initial commit for amend test" &&
> >>> +     echo "Modified for amend" >>foo &&
> >>> +     test_tick &&
> >>> +     git commit -a --amend --no-edit \
> >>> +             --author=3D"Test Author <test@author.example>" \
> >>> +             --committer=3D"Test Committer <test@committer.example>"=
 &&
> >>> +     author_header HEAD >actual_author &&
> >>> +     grep "Test Author <test@author.example>" actual_author &&
> >>> +     committer_header HEAD >actual_committer &&
> >>> +     grep "Test Committer <test@committer.example>" actual_committer
> >>> +'
> >>> +
> >>> +test_expect_success 'GIT_COMMITTER_* environment variables' '
> >>> +     git checkout -f Initial &&
> >>> +     echo "Test env vars" >>foo &&
> >>> +     test_tick &&
> >>> +     GIT_COMMITTER_NAME=3D"Env Committer" \
> >>> +     GIT_COMMITTER_EMAIL=3D"env@test.example" \
> >>> +     git commit -a -m "test committer env vars" &&
> >>> +     committer_header HEAD >actual &&
> >>> +     grep "Env Committer <env@test.example>" actual
> >>> +'
> >>> +
> >>> +test_expect_success '--committer overrides GIT_COMMITTER_* environme=
nt variables' '
> >>> +     echo "Test override" >>foo &&
> >>> +     test_tick &&
> >>> +     GIT_COMMITTER_NAME=3D"Env Committer" \
> >>> +     GIT_COMMITTER_EMAIL=3D"env@test.example" \
> >>> +     git commit -a -m "test override" \
> >>> +             --committer=3D"Override Committer <override@test.exampl=
e>" &&
> >>> +     committer_header HEAD >actual &&
> >>> +     grep "Override Committer <override@test.example>" actual
> >>> +'
> >>> +
> >>> +test_expect_success '--date with --committer changes both author and=
 committer dates' '
> >>> +     git checkout -f Initial &&
> >>> +     echo "Test date override" >>foo &&
> >>> +     test_tick &&
> >>> +     git commit -a -m "test date" \
> >>> +             --author=3D"Date Author <date@author.example>" \
> >>> +             --committer=3D"Date Committer <date@committer.example>"=
 \
> >>> +             --date=3D"2024-06-15 10:30:00 +0800" &&
> >>> +     git log -1 --format=3D"%ai" >author_date &&
> >>> +     git log -1 --format=3D"%ci" >committer_date &&
> >>> +     grep "2024-06-15 10:30:00 +0800" author_date &&
> >>> +     grep "2024-06-15 10:30:00 +0800" committer_date
> >>> +'
> >>> +
> >>>    test_done
> >>>
> >>> base-commit: 4badef0c3503dc29059d678abba7fac0f042bc84
> >>
> >
>
