Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742B4C43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 13:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45887206DF
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 13:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XH1+5dSC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfLFNqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 08:46:43 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36064 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfLFNqm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 08:46:42 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so7742183ljg.3
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 05:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6YoK37DbXR5iDMDpiq3BzbStR1Ut7Lj9WI8NnFzDc/8=;
        b=XH1+5dSCcFshJsNUzV5kU3hWJqFedJNHWS2mE4RzUg3TtmBBtc9NwMmrTnXIQGKPzg
         Ev1nguAdyUY52DRQUFFJ5invostPYH5wQmiZXoJC66HehDCisU+i4Ratc538W4bKiysE
         cZAu6EM/eLMmAHtI/4S0wYm5MJolXpSTmm3PTRscptVkrwrzLMvP5vE72QgJYQGe7EXu
         bqP5tTs4Aomn+MD3XJyiqCDaQ8fXGdN/3AxJpF6Ty1jfx+Yhq8daBCVmj9DEFwcf6b9j
         Dlv1WwWEvlr8rcKC7BqCn8Osh3JjkFjj8IzD/bOJ89SXKQBYTsBWMIB8pHsLSv7UV3WM
         vUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6YoK37DbXR5iDMDpiq3BzbStR1Ut7Lj9WI8NnFzDc/8=;
        b=NTjT7i06avN7R8amnSVQc2as4Wr2sk2hY6V8LrF37VUkgoBXReS8QWG3sDBCnx5dUk
         sOyAEZB78w82XL2Z1BvkLbFW8uxsvzlA4qKqBmfO4nMGJLzPD0GxzLOrLXrJh7Kw4bQu
         WKRAUCzpuS3xpujXfoo8lo4+nb43op9gphMs9pg5ScuxD2d4bX9PK8vAJ/jhdBNiIm8T
         R6QSmHIyiSm31btSz+BfW3bSKeAD/HrPy4r8yaK8f75huKJv23wybsavIdZqufP3S+eq
         v74nAKWmU5L5loIu4nENMhAMzyXTO/dKLZZKC+zr/uIcVZ/gMPtT8omZzCUI9ti78NW7
         RgWA==
X-Gm-Message-State: APjAAAXrYqv93S5gaVxTs8YMF9ptLzDSQ2iCH+BKpT3GLI42GIqAKxqV
        BSCPOTWId7+300OpHrSK8YuU+cohDnbOk/drdTk=
X-Google-Smtp-Source: APXvYqyL8euGmPLKp0jMu5kKrDgBv+Pw3GY9uTlg7RiZ4VKWHse7rEJ+UcerAO8AkCXggTPkKGEMi9wyZ64MD4YDGV4=
X-Received: by 2002:a2e:a163:: with SMTP id u3mr2132795ljl.13.1575640000883;
 Fri, 06 Dec 2019 05:46:40 -0800 (PST)
MIME-Version: 1.0
References: <20191205225322.5529-1-alext9@gmail.com> <20191205235704.31385-1-alext9@gmail.com>
 <20191205235704.31385-3-alext9@gmail.com> <20191206014828.GB16183@generichostname>
 <e898ad43-5649-8f4c-7c93-fab09197fc92@gmail.com>
In-Reply-To: <e898ad43-5649-8f4c-7c93-fab09197fc92@gmail.com>
From:   Alex Torok <alext9@gmail.com>
Date:   Fri, 6 Dec 2019 08:46:29 -0500
Message-ID: <CANmPhj38UqZiePEPbPJBwUTOEJrfA6j3aP8KBHvAY6EA-J7Nsw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rebase: find --fork-point with full ref
To:     phillip.wood@dunelm.org.uk
Cc:     Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for the feedback Denton & Phillip!

On Fri, Dec 6, 2019 at 5:52 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> On 06/12/2019 01:48, Denton Liu wrote:
> > nit: * should be attached to the variable name.
>
> I think you also need to free it once you've called get_fork_point() as
> well.

Yup. Got it.

> On 06/12/2019 01:48, Denton Liu wrote:
> >
> >> +            dwim_ref_or_die(options.upstream_name, strlen(options.upstream_name), &full_name);
> >
> > Also, thinking about this more, would it be possible to put the dwim_ref
> > logic into get_fork_point() directly? There are currently only these two
> > callers so I suspect it should be fine and it'll result in cleaner
> > logic.
>
> If you do that then it would be better to use error() rather than die()
> in get_fork_point() and return an error to the caller as we try to avoid
> adding code to libgit that dies. This lets the caller handle any cleanup
> that they need to before exiting.

Would the signature of get_fork_point change to be something like:
int get_fork_point(const char *refname, struct commit *commit,
   struct commit **fork_point, struct strbuf *err)

If not, could you point me to an example of some existing code
that does what you're talking about?


> On 06/12/2019 01:48, Denton Liu wrote:
> > It's not obvious why this was failing in the first place. Perhaps we
> > could document it better in the commit message?
> >
> > Maybe something like:
> >
> >       We used to pass in the upstream_name directly into the
> >       get_fork_point() machinery. However, get_fork_point() was
> >       expecting a fully qualified ref name even though most users use
> >       the short name for branches. This resulted in `--fork-point` not
> >       working as expected since, without the full ref name, the reflog
> >       lookup would fail and it would behave as if we weren't passing
> >       in `--fork-point` at all.

Sounds good.

> > Also, I'm not why this test case in particular that was duplicated (and
> > not the one above) given that the first three `--fork-point` test cases
> > fail without the change to rebase. Perhaps we want to duplicate all
> > "refs/heads/master" tests with a corresponding "master" test?

I only duplicated one so that there would only be one test case that
would fail if a regression around getting the fork point with a short
ref name was introduced.

I just happened to pick that one because it was closest to the rebase
command I was running when I found the bug :)

I can include some of the above reasoning in the commit message.
Alternatively:
* I could duplicate all of tests
* I could change all of the tests to use the short ref name

I'm leaning towards just leaving one test (maybe with a comment?)
for the short ref name --fork-point so that there is more resolution
around where a bug could be on test failure.

Let me know what you think,
Alex
