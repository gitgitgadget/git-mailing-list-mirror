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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD7DC433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 11:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BCC764FD0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 11:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhCLLl2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 06:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbhCLLl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 06:41:26 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C47C061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 03:41:26 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id x28so3371475otr.6
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 03:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VwW1Lavcb7t5PuhKmouNzrf/1lKgSRWF7GtxgiWzPaM=;
        b=q7u7oZGLa/UNAf+CvWywiGd4mFoyIlFiBmfn8jgIv32hHa5mGgrx8EBLmVoDeA+uYq
         6SmS76r4hUdd7ZPQCb58ywtk0bVQWzhwFSK+/JixTuBeJrJnUx3kwHjI4JV4XNHczxpa
         lvVQPuJn/pCGiKLJNL5NTId8afUErqdoOsWr6qsCfLsQC5XrSjjb7Rgbq81l0VL4ZX91
         iK9/wois9OqfKD1Og1ldfhx/KIwOAcWUPoHvVVqs+WsjHf8RbJXuaacHmxpED8IdqIgP
         /iE0cBNobW9zhnSYEyU3em1LDdlie+V6GU7z3JqEajKhoguTfXvpSqcxpBjM9P3r1Mo8
         FyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VwW1Lavcb7t5PuhKmouNzrf/1lKgSRWF7GtxgiWzPaM=;
        b=YTkAqS0igx+7osJCwOdw49qn1ur+1RXW3dR6+hQd/R8WohZigSzheE68fHQEv9MUSK
         DFORC+jmQMzJ2qO1LQVGkDrTKwVCflZ1Rmf7yeChwl4bQowHOgL8mqMSucI5b/vCQKhO
         9pgA2EcON2JzlEPYLPLN/jnV9FJ5uLBoaslImeCE4LXsCBaamt2RskXo18uMhwgNaErQ
         8zWOwZ3yXVWzFAfkDwyqmBTm4qTpegQ0xG6FBePgfgnGeZMM2xBYT2wJKzVnJp5aS2Cj
         MNC4omPiTQJPEVRjomYLiZag++2+MtuXuCq4gNTF1FGxUUN2AKhINO8WsMHZ2g1MMvbv
         KcRw==
X-Gm-Message-State: AOAM532pyytf55ThrY6KRpz4zUd1KiARcuwZRDl/gl7jKrxegtW8q3vy
        Ah43qqqr23jLpLUrrYkR4w2J3LWUAzK5DiG0BKY=
X-Google-Smtp-Source: ABdhPJxNooXpRPK63aMug+cph5D5Oc/ri4gocCPfVqgMB/vL6/I0N1/B6rM9JE8sb/sbsIuCkTUp55SaSsfk5SanN4M=
X-Received: by 2002:a9d:6308:: with SMTP id q8mr2956834otk.160.1615549285432;
 Fri, 12 Mar 2021 03:41:25 -0800 (PST)
MIME-Version: 1.0
References: <pull.901.git.1615446968597.gitgitgadget@gmail.com> <20210311150304.GA8169@konoha>
In-Reply-To: <20210311150304.GA8169@konoha>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 12 Mar 2021 19:41:13 +0800
Message-ID: <CAOLTT8SpAOj51jqYUYqYwXaVKSn1fANvetauaG0z4etiBMzVEw@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] commit: provides multiple common signatures
To:     Shourya Shukla <periperidip@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <periperidip@gmail.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8811=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8811:05=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Hey!
>

Hi!

> The idea seems very useful to me though I am not sure what others feel
> about this and whether Git is ready for such a thing or not. Keeping
> this concern aside, I will still review the patch due to my own interest
> in it as well.
>

haha, thank you! I'm glad that my whims can be recognized by you and help
git itself.

> On 11/03 07:16, ZheNing Hu via GitGitGadget wrote:
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Similar to "Helped-by", "Reported-by", "Reviewed-by", "Mentored-by"
> > these signatures are often seen in git commit messages. After
>
> I think it will be better to rephrase the line so that it is easier to
> understand. It took me a couple of reads to figure out what you meant.
>
> Something like:
>
> Similar to "Signed-off-by", trailers such as "Reported-by", "Helped-by"
> and "Mentored-by" are also seen in Git commits.
>

It's exactly what you said.
My lack of English sometimes limits my expression.

> > referring to the simple implementation of `commit --signoff`
> > and `send-email -cc=3D" commiter <email>"`, I am considering
> > whether to provide multiple signature parameters from the
> > command line. I think this might help maintainers and
> > developers directly uses the shell to provide these signatures
> > instead of multiple times repetitive writing those trailers
> > each time.
>
> The above para is more appropriate for a cover letter than a commit
> message. Your thought process for the patch you sent is equally valuable
> but this does not belong in the commit message. Commit messages are more
> about what you did and any nuances that follow. You get me?
>
> Use 'git format-patch --cover-letter <...>' to create a cover letter for
> your patch.
>

I understand it now, because I use GGG, I will put this content into the
GGG conversation.

> > To achieve this goal, i refactored the `append_signoff` design and
> > provided `append_message` and `append_message_string_list` interfaces,
> > providing new ways to generate those various signatures.
>
> s/i/I
>
> Also, commit messages are generally written in the imperative tense when
> desciribing what you have done in the commit.
>

You're right.

> > Users now can use `commit -H "helper <eamil>"` to generate "Helped-by" =
trailer,
> > `commit -R "reviewer <eamil>"` to generate "Reviewed-by" trailer,
> > `commit -r "reporter <eamil> "`to generate "Reported-by" trailer,
> > `commit -M "mentor <eamil>"` to generate "Mentored-by" trailer.
>
> Multiple typos.
>
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
>
> So, an improved commit message could be:
>
> -----8<-----
> commit: support multiple trailers from the command line
>
> Historically, Git has supported the 'Signed-off-by' commit trailer
> using the '--signoff' and the '-s' option from the command line. Extend
> this list to include other commonly used trailers viz., "Helped-by",
> "Reviewed-by", "Reported-by" and "Mentored-by". Introduce options '-H',
> '-R', '-r' and '-M' corresponding to the aforementioned trailers.
>
> While at it, add tests in the script 't7502-commit-porcelain.sh' and add
> information regarding these options in the Documentation of 'git
> commit'.

I think this paragraph may not be needed. Junio said in reply to one
of my previous patches that we may not need to add instructions about test
files and documents, because `git log -p --stat` can clearly see that what =
we
have done in testing and documentation.

> ----->8-----
>
> >     [GSOC] commit: provides multiple signatures from command line
> >
> >     I don=E2=80=99t know if my idea will satisfy everyone, I'm also thi=
nking about
> >     whether we can provide a more generalized version (I think this ide=
a can
> >     be extended: because users and developers have other signature meth=
ods
> >     that they want, such as "Based-on-patch-by") I hope someone can giv=
e me
> >     pointers (on the correctness of ideas or codes)
>
> It will be great if we let the user add customised options for the
> respective trailers but I think that trying to cater to such a large
> audience will only complicate the whole process and decrease the support
> avialable for the options/command. Apart from this, I think that the
> trailer "Reviewed-by" may not be that widely used and it would be better
> if we remove it from this patch.

Okay, I will delete it.

>
> >  Documentation/git-commit.txt |  24 +++++++-
> >  builtin/commit.c             |  63 +++++++++++++++++++++
> >  sequencer.c                  |  40 +++++++++----
> >  sequencer.h                  |   4 ++
> >  t/t7502-commit-porcelain.sh  | 106 +++++++++++++++++++++++++++++++++++
> >  5 files changed, 226 insertions(+), 11 deletions(-)
> >
> > diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.tx=
t
> > index 17150fa7eabe..e1b528d70c1a 100644
> > --- a/Documentation/git-commit.txt
> > +++ b/Documentation/git-commit.txt
> > @@ -14,7 +14,9 @@ SYNOPSIS
> >          [--allow-empty-message] [--no-verify] [-e] [--author=3D<author=
>]
> >          [--date=3D<date>] [--cleanup=3D<mode>] [--[no-]status]
> >          [-i | -o] [--pathspec-from-file=3D<file> [--pathspec-file-nul]=
]
> > -        [-S[<keyid>]] [--] [<pathspec>...]
> > +        [-S[<keyid>]] [--] [<pathspec>...] [(-H|--helped-by)=3D<addres=
s>...]
> > +        [(-R|--reviewed-by)=3D<address>...] [(-r|--reported-by)=3D<add=
ress>...]
> > +        [(-M|--mentored)=3D<address>...]
> >
> >  DESCRIPTION
> >  -----------
> > @@ -166,6 +168,26 @@ The `-m` option is mutually exclusive with `-c`, `=
-C`, and `-F`.
> >
> >  include::signoff-option.txt[]
> >
> > +-H=3D<address>...::
> > +--helped-by=3D<address>...::
> > +     Add one or more `Helped-by` trailer by the committer at the end o=
f the commit
> > +     log message.
> > +
> > +-R=3D<address>...::
> > +--reviewed-by=3D<address>...::
> > +     Add one or more `Reviewed-by` trailer by the committer at the end=
 of the commit
> > +     log message.
> > +
> > +-r=3D<address>...::
> > +--reported-by=3D<address>...::
> > +     Add one or more `Reported-by` trailer by the committer at the end=
 of the commit
> > +     log message.
> > +
> > +-M=3D<address>...::
> > +--mentored-by=3D<address>...::
> > +     Add one or more `Mentored-by` trailer by the committer at the end=
 of the commit
> > +     log message.
>
> Oh! I did not think you had added long forms of these options and was
> about to comment on that. Good that you added. Do talk about them as
> well in the commit message.
>

Yes, I forgot to mention these long formats in the commit message.

> >  -n::
> >  --no-verify::
> >       This option bypasses the pre-commit and commit-msg hooks.
> > diff --git a/builtin/commit.c b/builtin/commit.c
> > index 739110c5a7f6..4b312af03181 100644
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -113,6 +113,10 @@ static int config_commit_verbose =3D -1; /* unspec=
ified */
> >  static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
> >  static char *untracked_files_arg, *force_date, *ignore_submodule_arg, =
*ignored_arg;
> >  static char *sign_commit, *pathspec_from_file;
> > +static struct string_list helped_by =3D STRING_LIST_INIT_NODUP;
> > +static struct string_list mentored_by =3D STRING_LIST_INIT_NODUP;
> > +static struct string_list reviewed_by =3D STRING_LIST_INIT_NODUP;
> > +static struct string_list reported_by =3D STRING_LIST_INIT_NODUP;
>
> Good that you kept the variables as 'string_list's instead of a usual
> 'char*'.
>
> >  /*
> >   * The default commit message cleanup mode will remove the lines
> > @@ -829,6 +833,20 @@ static int prepare_to_commit(const char *index_fil=
e, const char *prefix,
> >       if (signoff)
> >               append_signoff(&sb, ignore_non_trailer(sb.buf, sb.len), 0=
);
> >
> > +     if(helped_by.items)
> > +             append_message_string_list(&sb, "Helped-by: ", &helped_by=
, ignore_non_trailer(sb.buf, sb.len), 0);
> > +     if(reviewed_by.items)
> > +             append_message_string_list(&sb, "Reviewed-by: ", &reviewe=
d_by, ignore_non_trailer(sb.buf, sb.len), 0);
> > +     if(reported_by.items)
> > +             append_message_string_list(&sb, "Reported-by: ", &reporte=
d_by, ignore_non_trailer(sb.buf, sb.len), 0);
> > +     if(mentored_by.items)
> > +             append_message_string_list(&sb, "Mentored-by: ", &mentore=
d_by, ignore_non_trailer(sb.buf, sb.len), 0);
>
> I think this part will look prettier if you wrap around the text. For
> code segments, the wrap around limit is 80 chars. For commit messages
> its 72 chars. Wrap around means that as soon as you hit N number of
> characters, you proceed to the next(new) line.
>

Fine.

> > +     string_list_clear(&helped_by, 0);
> > +     string_list_clear(&reviewed_by, 0);
> > +     string_list_clear(&reported_by, 0);
> > +     string_list_clear(&mentored_by, 0);
> > +
> >       if (fwrite(sb.buf, 1, sb.len, s->fp) < sb.len)
> >               die_errno(_("could not write commit template"));
> >
> > @@ -1490,6 +1508,42 @@ static int git_commit_config(const char *k, cons=
t char *v, void *cb)
> >       return git_status_config(k, v, s);
> >  }
> >
> > +static int help_callback(const struct option *opt, const char *arg, in=
t unset)
> > +{
> > +     if (unset)
> > +             string_list_clear(&helped_by, 0);
> > +     else
> > +             string_list_append(&helped_by, arg);
> > +     return 0;
> > +}
> > +
> > +static int review_callback(const struct option *opt, const char *arg, =
int unset)
> > +{
> > +     if (unset)
> > +             string_list_clear(&reviewed_by, 0);
> > +     else
> > +             string_list_append(&reviewed_by, arg);
> > +     return 0;
> > +}
> > +
> > +static int report_callback(const struct option *opt, const char *arg, =
int unset)
> > +{
> > +     if (unset)
> > +             string_list_clear(&reported_by, 0);
> > +     else
> > +             string_list_append(&reported_by, arg);
> > +     return 0;
> > +}
> > +
> > +static int mentor_callback(const struct option *opt, const char *arg, =
int unset)
> > +{
> > +     if (unset)
> > +             string_list_clear(&mentored_by, 0);
> > +     else
> > +             string_list_append(&mentored_by, arg);
> > +     return 0;
> > +}
> >  int cmd_commit(int argc, const char **argv, const char *prefix)
> >  {
> >       static struct wt_status s;
> > @@ -1507,6 +1561,10 @@ int cmd_commit(int argc, const char **argv, cons=
t char *prefix)
> >               OPT_STRING(0, "fixup", &fixup_message, N_("commit"), N_("=
use autosquash formatted message to fixup specified commit")),
> >               OPT_STRING(0, "squash", &squash_message, N_("commit"), N_=
("use autosquash formatted message to squash specified commit")),
> >               OPT_BOOL(0, "reset-author", &renew_authorship, N_("the co=
mmit is authored by me now (used with -C/-c/--amend)")),
> > +             OPT_CALLBACK('H', "helped-by", NULL, N_("email"), N_("add=
 a Helped-by trailer"), help_callback),
> > +             OPT_CALLBACK('r', "reported-by", NULL, N_("email"), N_("a=
dd a Reported-by trailer"), report_callback),
> > +             OPT_CALLBACK('R', "reviewed-by", NULL, N_("email"), N_("a=
dd a Reviewed-by trailer"), review_callback),
> > +             OPT_CALLBACK('M', "mentored-by", NULL, N_("email"), N_("a=
dd a Mentored-by trailer"), mentor_callback),
>
> It would be lovely if you could line wrap these above additions too!
>
> >               OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-b=
y trailer")),
> >               OPT_FILENAME('t', "template", &template_file, N_("use spe=
cified template file")),
> >               OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commi=
t")),
> > @@ -1561,6 +1619,11 @@ int cmd_commit(int argc, const char **argv, cons=
t char *prefix)
> >       struct commit_extra_header *extra =3D NULL;
> >       struct strbuf err =3D STRBUF_INIT;
> >
> > +     helped_by.strdup_strings =3D 1;
> > +     reviewed_by.strdup_strings =3D 1;
> > +     reported_by.strdup_strings =3D 1;
> > +     mentored_by.strdup_strings =3D 1;
> > +
> >       if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
> >               usage_with_options(builtin_commit_usage, builtin_commit_o=
ptions);
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index d2332d3e1787..528daf9df252 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -4668,16 +4668,12 @@ int sequencer_pick_revisions(struct repository =
*r,
> >       return res;
> >  }
> >
> > -void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsig=
ned flag)
> > +void append_message(struct strbuf *msgbuf, struct strbuf *sob,
> > +                     size_t ignore_footer, unsigned flag)
>
> Its nice to see that you generalised the pre-exisiting function instead
> of creating a new one(s) for the new trailers. Good.
>
> It will be better to name 'struct strbuf *sob' to something more
> generic, maybe 'struct strbuf *trailer' since 'sob' stands for
> 'Signed-off-by' and since the function is becoming more generic, its
> contents should too.
>
When I wrote it, I didn=E2=80=99t realize that sob refers to the abbreviati=
on of
'Signed-off-by', I will change it.
> >  {
> >       unsigned no_dup_sob =3D flag & APPEND_SIGNOFF_DEDUP;
> > -     struct strbuf sob =3D STRBUF_INIT;
> >       int has_footer;
> >
> > -     strbuf_addstr(&sob, sign_off_header);
> > -     strbuf_addstr(&sob, fmt_name(WANT_COMMITTER_IDENT));
> > -     strbuf_addch(&sob, '\n');
> > -
> >       if (!ignore_footer)
> >               strbuf_complete_line(msgbuf);
> >
> > @@ -4685,11 +4681,11 @@ void append_signoff(struct strbuf *msgbuf, size=
_t ignore_footer, unsigned flag)
> >        * If the whole message buffer is equal to the sob, pretend that =
we
> >        * found a conforming footer with a matching sob
> >        */
> > -     if (msgbuf->len - ignore_footer =3D=3D sob.len &&
> > -         !strncmp(msgbuf->buf, sob.buf, sob.len))
> > +     if (msgbuf->len - ignore_footer =3D=3D sob->len &&
> > +         !strncmp(msgbuf->buf, sob->buf, sob->len))
> >               has_footer =3D 3;
> >       else
> > -             has_footer =3D has_conforming_footer(msgbuf, &sob, ignore=
_footer);
> > +             has_footer =3D has_conforming_footer(msgbuf, sob, ignore_=
footer);
>
> Again, rename the variables.
>
> >       if (!has_footer) {
> >               const char *append_newlines =3D NULL;
> > @@ -4723,8 +4719,32 @@ void append_signoff(struct strbuf *msgbuf, size_=
t ignore_footer, unsigned flag)
> >
> >       if (has_footer !=3D 3 && (!no_dup_sob || has_footer !=3D 2))
> >               strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
> > -                             sob.buf, sob.len);
> > +                             sob->buf, sob->len);
> > +}
> > +void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsig=
ned flag)
> > +{
> > +     struct strbuf sob =3D STRBUF_INIT;
> > +     strbuf_addstr(&sob, sign_off_header);
> > +     strbuf_addstr(&sob, fmt_name(WANT_COMMITTER_IDENT));
> > +     strbuf_addch(&sob, '\n');
> > +     append_message(msgbuf, &sob, ignore_footer, flag);
> > +     strbuf_release(&sob);
> > +}
>
> I think it will be nice if you could use a flag to denote whether the
> entity to be appended is a 'sign-off' or not. This way when say the
> variable 'int signoff' is 1, then use the above part in the
> 'append_message()' function otherwise go with the flow that exists.
>
> > +void append_message_string_list(struct strbuf *msgbuf, const char *hea=
der,
> > +             struct string_list *sobs, size_t ignore_footer, unsigned =
flag) {
> > +     int i;
> > +     struct strbuf sob =3D STRBUF_INIT;
> > +
> > +     for ( i =3D 0; i < sobs->nr; i++)
> > +     {
> > +             strbuf_addstr(&sob, header);
> > +             strbuf_addstr(&sob, sobs->items[i].string);
> > +             strbuf_addch(&sob, '\n');
> > +             append_message(msgbuf, &sob, ignore_footer, flag);
> > +             strbuf_reset(&sob);
> > +     }
> >       strbuf_release(&sob);
> >  }
>
> Similarly, here, if 'signoff =3D 0' then the above part goes on. Or
> another alternative can be to create a 'append_message_helper()' and
> shift the current contents of 'append_message()' into that and use the
> above function to work as per the value of signoff.
>
> So a possible flow can be:
>
> void append_message_string_list(...params...) {
>
>         if (signoff) {
>                 ..excecute the necessary segments and call the
>                 'append_message_helper()' function...
>         } else {
>                 ..similarly here..
>         }
> }
>
> This way we save ourselves some extra functions.

May some thing like this:

if (signoff)
        append_message_string_list(&sb, "Signed-off-by: ", NULL,
                   ignore_non_trailer(sb.buf, sb.len), 0);

And then we could judge in `append_message_string_list`
if the arguement `string_list *trailers` set to NULL. If so,
we do something similar to `append_signoff`, otherwise,
we carry out other situations.

So that we can delete the `append_signoff` and user can only
need to call  `append_message_string_list` in any where, I don't
 know if it is better.

>
> > diff --git a/sequencer.h b/sequencer.h
> > index f8b2e4ab8527..b24e274f4c62 100644
> > --- a/sequencer.h
> > +++ b/sequencer.h
> > @@ -174,6 +174,10 @@ int todo_list_rearrange_squash(struct todo_list *t=
odo_list);
> >   * and the new signoff will be spliced into the buffer before those by=
tes.
> >   */
> >  void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsig=
ned flag);
> > +void append_message(struct strbuf *msgbuf, struct strbuf *sob,
> > +             size_t ignore_footer, unsigned flag);
> > +void append_message_string_list(struct strbuf *msgbuf, const char*head=
er,
> > +             struct string_list *sobs, size_t ignore_footer, unsigned =
flag);
> >
> >  void append_conflicts_hint(struct index_state *istate,
> >               struct strbuf *msgbuf, enum commit_msg_cleanup_mode clean=
up_mode);
>
> Then, these would have to be corrected too.
>
> > diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
> > index 6396897cc818..40823152a51c 100755
> > --- a/t/t7502-commit-porcelain.sh
> > +++ b/t/t7502-commit-porcelain.sh
> > @@ -154,6 +154,112 @@ test_expect_success 'sign off' '
> >
> >  '
>
> I feel that the tests deserve a commit of their own. A follow-up commit
> in this patch.
>
> > +test_expect_success 'helped-by' '
> > +
> > +     >file1 &&
> > +     git add file1 &&
> > +     git commit --helped-by=3D"foo <bar@frotz>" \
> > +     --helped-by=3D"foo2 <bar2@frotz>" -m "thank you" &&
> > +     git cat-file commit HEAD >commit.msg &&
> > +     sed -ne "s/Helped-by: //p" commit.msg >actual &&
> > +     cat >expected <<-\EOF &&
> > +     foo <bar@frotz>
> > +     foo2 <bar2@frotz>
> > +     EOF
> > +     test_cmp expected actual
> > +
>
> Was this extra line feed intentional? It looks odd here and other test
> (scripts) don't have this. Though, this test script seems to have many
> tests which have an extra line feed. My suggestion would be to eliminate
> it. Maybe this script is old and hasn't been reviewed for a cleanup in
> a long time.
>

I might want to keep the same format with the last "sign off" test. Now it
seems that this is not necessary.

> > +'
> > +
> > +test_expect_success 'reported-by' '
> > +
> > +     >file2 &&
> > +     git add file2 &&
> > +     git commit --reported-by=3D"foo <bar@frotz>" \
> > +     --reported-by=3D"foo2 <bar2@frotz>" -m "thank you" &&
> > +     git cat-file commit HEAD >commit.msg &&
> > +     sed -ne "s/Reported-by: //p" commit.msg >actual &&
> > +     cat >expected <<-\EOF &&
> > +     foo <bar@frotz>
> > +     foo2 <bar2@frotz>
> > +     EOF
> > +     test_cmp expected actual
> > +
>
> Similarly here and in the parts that follow.
>
> <...>
>
> This seems like a good patch to me but more experienced members will be
> able to comment better I think. Good job anyways.
>

Your comments and encouragement are of great help to me :)

> Regards,
> Shourya Shukla
>

Regards,
ZheNing Hu
