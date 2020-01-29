Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5A7C33C9E
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 01:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1051420CC7
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 01:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4wmn/vR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgA2BJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 20:09:35 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33295 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgA2BJe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 20:09:34 -0500
Received: by mail-ed1-f65.google.com with SMTP id r21so16860784edq.0
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 17:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fwX5tHMWM1Elsm4Oike2dVoURlYIx86Xk30JDH+5kT0=;
        b=J4wmn/vRgcNqcPIcXf6gn4Ld2ZrP9hQUj8dgAjhF33oXdiZWRYiJ+AHKxsB7vXQIud
         nR/PARB1uUm8ZluMX2XBexJErqSmQpHOQMqvdlEUJ6TGD4sWwpshGowKjySuO4DpPT/2
         7+A482bgxt8rq+tjgGZimqjBgNgjfJ73VHhYw3CAMn8B+0S4gimU+iuRelwdHXbNWYSb
         N2+4MDfgrmT/Kdtk3Z1AgYuGtjDm3LILJb+iox6NNW76iP0h+DMHYV19mxF1YJXqskB8
         P3FT2DwH7qTkVxNXeyxZjbypPwDZMcV14eeih0deX72swLEjMvnI+3u1SPU8g8vdcqZG
         9a7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fwX5tHMWM1Elsm4Oike2dVoURlYIx86Xk30JDH+5kT0=;
        b=eYjRR4b7gEb9bEkSUAHU7WXnMYoc1OKFB9KS11pL7keiV2s9JjRyE09wRbkVRGTJ7h
         mba7aYBq2FmPl84NsCGY9ewDr2pg2gx9/x/1KXq+sHqN6IQbi6RvWl0HhYgM2gnha4W9
         XMnUFgCk/FXET9CZ1WYwCpbREAxTlvxV8P98rDr22QQGwblFGd1CIfJjJFKFWNKvsxS+
         o73of65j14jJEqsRgor5IQx3qoBgqWk6UjT6XT1+XP5xTwnD/NKiMovbChXvpITWFJHS
         dA5yPwP+p0jBsEx7R+EopwMENHVRjcYRQWuqNtBlvblpWwvvip9ywzMLxxquizTVaArZ
         SByA==
X-Gm-Message-State: APjAAAVIdhEFn/C985rpdhLD2EG35dSzkQH7bHrP7tQWoY+U8NyDG1ZE
        snzGUC0w9WpzfJCpoNo8mVRklQt8aV2Eu+EqlA0=
X-Google-Smtp-Source: APXvYqzY6GlxLDWhvjZWd7soUiYyxXkqGpz5nFdhSl95hPQYg3iix8k2a/iZB8FGk3xXOZkZNmFb+lRDAkYfvGpouP8=
X-Received: by 2002:a17:906:22cf:: with SMTP id q15mr5332134eja.77.1580260173291;
 Tue, 28 Jan 2020 17:09:33 -0800 (PST)
MIME-Version: 1.0
References: <pull.508.git.1577934241.gitgitgadget@gmail.com>
 <pull.508.v2.git.1578438752.gitgitgadget@gmail.com> <9f9febd3f4f7f82178fceac98fcc91cb28a1b3b9.1578438752.git.gitgitgadget@gmail.com>
 <20200127235210.GC233139@google.com>
In-Reply-To: <20200127235210.GC233139@google.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Wed, 29 Jan 2020 14:09:21 +1300
Message-ID: <CACg5j26DEXuxwqRYHi5UOBUpRwsu_2A9LwgyKq4qB9wxqasD7g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] add: use advise function to display hints
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 28, 2020 at 12:52 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> Hmm, I wonder if addNothing really makes sense/is understandable when
> I'm configuring? I see two cases you're addressing; first, adding an
> ignored file ("Use -f if you really want to add") - which "addNothing"
> doesn't really make sense for - and second, "add" with nothing
> specified ("did you mean 'git add .'"), where "addNothing" makes sense
> in context. Out of context though, perhaps "hint.addIgnoredFile" and
> "hint.addEmptyPathspec" make more sense? Of course naming is one of the
> two hardest problems in computer science (next to race conditions and
> off-by-one errors) so probably someone else can suggest a better name :)
>

I agree, as this patch was my first interaction with the advice
library, but now after many discussions on different threads it makes
more sense to add two config variables for the two messages.

>
> As mentioned earlier, I'm not sure that tying this advice to the same
> config as the next one you change really makes sense.
>
> Nitwise, it's somewhat common for advice hints to also tell you how to
> disable them; see sha1-name.c:get_oid_basic's 'object_name_msg' for an
> example.
>

I can see that this was followed in only three locations around the
code base, which means that not telling the user how to disable the
hint is more common.
Initially I tended to think of it as noise as I suspect the user will
ignore this extra line about disabling the message more often. But
after taking a second look at Documentation/config/advice.txt I
realized how hard it will be for the user to find the corresponding
configuration variable to the message that he/she would like to turn
off,
specially when the list is getting longer. So seems like displaying
the extra note will make the user's life easier *when* s/he wants to
turn it off.

> >               exit_status = 1;
> >       }
> >
> > @@ -480,7 +481,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
> >
> >       if (require_pathspec && pathspec.nr == 0) {
> >               fprintf(stderr, _("Nothing specified, nothing added.\n"));
> > -             fprintf(stderr, _("Maybe you wanted to say 'git add .'?\n"));
> > +             if (advice_add_nothing)
> > +                     advise( _("Maybe you wanted to say 'git add .'?\n"));
>
> Same nit as above.
>
> >               return 0;
> >       }
> >
> > diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> > index c325167b90..a649805369 100755
> > --- a/t/t3700-add.sh
> > +++ b/t/t3700-add.sh
> > @@ -326,7 +326,7 @@ test_expect_success 'git add --dry-run of an existing file output' "
> >  cat >expect.err <<\EOF
> >  The following paths are ignored by one of your .gitignore files:
> >  ignored-file
> > -Use -f if you really want to add them.
> > +hint: Use -f if you really want to add them.
> >  EOF
> >  cat >expect.out <<\EOF
> >  add 'track-this'
> > --
> > gitgitgadget
>
> Finally, you'd better update Documentation/config/advice.txt too.

Yeah, got that on my todo list :)

Thanks,
Heba
