Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B5FC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 03:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238E8206D7
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 03:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hovM2tMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfLSDsy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 22:48:54 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34398 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfLSDsx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 22:48:53 -0500
Received: by mail-ed1-f68.google.com with SMTP id l8so3488050edw.1
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 19:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PU0NByoL2IsAkg3FyC8VDagiy9zTMTMew4Q08yInrq8=;
        b=hovM2tMViJX/1gfu5tcLtiGyswVGEWdd1gkrkVucd3GWgL6Wx7FndreF9MbNTMJQbX
         8lNLP4rqNdiY2aj6goXyY9jxESYusaltgSv5W3eIOXN39luHKriQXpZabD7KUvfgj/1f
         lTE0WzwDbIY+uE5tD775L3YqpjjAP5+yCariqcyO2aPCWBsms1O1DjiKCZCACeHlWpNG
         wtMwx8MoGn/ELDTby20qGnRra2ENLefVijsCwtnqSLjwDLs3NIkGzMY9AjYd2cwueFgW
         APLg0ypcbYQgIsBqJ9ojC4kjGSxNH9gLmMLcvtMzcWyI/w/19g4KkzaMOlZUWw10fanf
         oAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PU0NByoL2IsAkg3FyC8VDagiy9zTMTMew4Q08yInrq8=;
        b=l6ZKFAk4ScGi4v9Ut3gq+ipm33zmnBm+NEcyc7hA0Op0sg+NukypnVEN8HQEouaS5X
         NjwXLfhnP09ODpGykakQicS5KbSl72XXjbfVrewPxPP6iBcTZhcVJm9yl38RlGcDCX6C
         Yf+R9N7iTG3g67vR57DJHVUL7VA/27pcMCo8hQ18UxFim0IA2hDMuWxYjD3hWq5WSQHH
         KE5Fenz5j272FNAglzKGoNDVqm2SJ2omVOQfUJSywUVXMmUKRe0ek7dqAscFyInc1YIu
         RN8gix1NRP9Xsn9x93ZrBzk682032B6s25aaB2/x+IhUnnLzeV5cNf/DeGn1kRgTOigE
         IYpQ==
X-Gm-Message-State: APjAAAWZgSJ99ZP588OEoH6NsTQR/B6WO5gsPzeSjki3HS8wlItXf9ec
        Jvlk9COOudcGT761DOyVnJ0fPjaVilhsE7euBlg=
X-Google-Smtp-Source: APXvYqxlLQG0gPtq0aoqAkPd1+pVXKwPCnksl0E3hRBE+8Qo87aTrZrpeiU6+leFSMQaGqvS4XbuqZZ/MiTXD1fWun0=
X-Received: by 2002:a17:906:bc51:: with SMTP id s17mr6895438ejv.137.1576727332194;
 Wed, 18 Dec 2019 19:48:52 -0800 (PST)
MIME-Version: 1.0
References: <f23477c5a32e5d638310024194040146026972b8.1576574242.git.gitgitgadget@gmail.com>
 <20191218031338.203382-1-jonathantanmy@google.com>
In-Reply-To: <20191218031338.203382-1-jonathantanmy@google.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Thu, 19 Dec 2019 16:48:41 +1300
Message-ID: <CACg5j258jHGjzxEeUS7OccHsmk=XVj9+bvZM9TvcdZ0+musnUg@mail.gmail.com>
Subject: Re: [PATCH 1/1] commit: display advice hints when commit fails
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 18, 2019 at 4:13 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > From: Heba Waly <heba.waly@gmail.com>
> >
> > Display hints to the user when trying to commit without staging the modified
> > files first (when advice.statusHints is set to true). Change the output of the
> > unsuccessful commit from e.g:
>
> Wrap your commit messages at 72 characters.
>
OK

> >   # [...]
> >   # Changes not staged for commit:
> >   #   modified:   builtin/commit.c
> >   #
> >   # no changes added to commit
> >
> > to:
> >
> >   # [...]
> >   # Changes not staged for commit:
> >   #   (use "git add <file>..." to update what will be committed)
> >   #   (use "git checkout -- <file>..." to discard changes in working directory)
> >   #
> >   #   modified:   ../builtin/commit.c
>
> For tidiness, can this line also be "builtin/commit.c" (that is, without
> the "../" at the beginning) to match what's before "to:"?
>

Sure.

> > In ea9882bfc4 (commit: disable status hints when writing to COMMIT_EDITMSG,
> > 2013-09-12) the intent was to disable status hints when writing to
> > COMMIT_EDITMSG, but in fact the implementation disabled status messages in
> > more locations, e.g in case the commit wasn't successful, status hints
> > will still be disabled and no hints will be displayed to the user although
> > advice.statusHints is set to true.
> >
> > Signed-off-by: Heba Waly <heba.waly@gmail.com>
> > ---
> >  builtin/commit.c                          | 1 +
> >  t/t7500-commit-template-squash-signoff.sh | 9 +++++++++
>
> I wondered if there was a better place to put the test, but I couldn't
> find one, so this is fine.
>
> > @@ -961,6 +961,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
> >        */
> >       if (!committable && whence != FROM_MERGE && !allow_empty &&
> >           !(amend && is_a_merge(current_head))) {
> > +             s->hints = advice_status_hints;
> >               s->display_comment_prefix = old_display_comment_prefix;
> >               run_status(stdout, index_file, prefix, 0, s);
> >               if (amend)
>
> I checked that this undoing of "s->hints = 0" is safe, because s is no
> longer used in this function nor in the calling function cmd_commit()
> (which is the one that declared s locally).
>
> Still probably worth a comment, though. For example:
>
>   This status is to be printed to stdout, so hints will be useful to the
>   user. Reset s->hints to what the user configured.
>

Ok.

> The corresponding comment on "s->hints = 0" might need to be tweaked,
> too, but I can't think of anything at the moment.
>
> > +test_expect_success 'commit without staging files fails and displays hints' '
> > +     echo "initial" >>file &&
> > +     git add file &&
> > +     git commit -m initial &&
> > +     echo "changes" >>file &&
> > +     test_must_fail git commit -m initial >actual &&
>
> Use another commit message for this, since this is no longer "initial".
> (Maybe "after initial" or something like that.)

Makes sense.

Thank you Jonathan.

Heba


Heba
