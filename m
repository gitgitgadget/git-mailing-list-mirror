Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54FCC433DF
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 04:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE9AF2193E
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 04:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTPvVVlw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgGNE4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 00:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgGNE4T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 00:56:19 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55252C061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 21:56:19 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b185so14527868qkg.1
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 21:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m/sYtOdGkP/MwV3reH60zmXf4IGB7TlTa10wP+Mu9Rg=;
        b=WTPvVVlw4/YXkt/k7EUp1q6dOLFfb3UsxiLYoPgwx7lB/pYfbUEl1s2ZDstyRxPG0G
         URUjFjbB0V4MKs7xC2g7Lg5AU0gJvAGbUD9Az3N3toB1bTRcIm6xQyCQwajsqn+yyD7h
         f+FZIhgKl940fZOeCVVuZjndi+hx44FmM6Fi5yReXIip5De/dJrvZBNOWkdbqm8gkWgQ
         Y+AJDS3scnabK55UA8RIcC4aOlzmnVZ0B7OlIRDr3YZz/mFC5pOTI2V++9WPF/Z4FYiR
         aGbiLU7Be8DqHo+MbebswSovk7nHhbplA/lUiei1V23wAy5Jfgch51fOjbEzXnLM46X7
         h38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m/sYtOdGkP/MwV3reH60zmXf4IGB7TlTa10wP+Mu9Rg=;
        b=lDo/bCWcu7rwJm1J7068AeVjIKE+nel00BlQXsLNSCfNpD6hnYjCMaQHHYLkLQ1C2t
         3i0gvQzPY1sFw8z6jEvDbzjhZOQK2eH3idfmHpNCjolzK+RUGvsbOmAhPIJbmQEco6Rm
         mUOkFZfiLV+wBqNjU3N3zaxEy5d4rr2osh1mzb1wkGvhxYfYhByjLUKPqxiuqvMguMg+
         8Ya6FCVRfNx1kN9/p/FTJG9lJp8Z85h71/LeCvADeSgfJ0uSn30LqPwO8ajYwGbDF+5J
         r+waEQUErVtC4bmKn9bBI9OB/3+q72i+YYhG7yPw/a85RIgchVVzOCRJ4PtsMAsQ/CUS
         4nTg==
X-Gm-Message-State: AOAM530UFqDcxPzP21oIoiAs8FQoHfBcFGMgrPxXu9Ys25MX3it3JEYX
        Jll6KEyzLqjcpoYb/aos62hlTJSLoXwPo7YaBQKQ4w==
X-Google-Smtp-Source: ABdhPJwhWpmSMCseLYzwIlyw2QDPrhH+0mxIu3Z4Kk9TB+SHCvPT0hujUenascsKQs6TcypEjGSwsMXfnM5wXPfAIbI=
X-Received: by 2002:a37:6609:: with SMTP id a9mr2844355qkc.337.1594702578345;
 Mon, 13 Jul 2020 21:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAGPh-qNrjQ5xwbPcfJdBqrqOJQsVpa2hy-XHwN-8rhPPZe4Vpg@mail.gmail.com>
 <20200713223906.GH8360@camp.crustytoothpaste.net> <CAGPh-qPyTNidqT=K-U8iYtG3udFZVFBhE1RyA1AZ1qEqN_NnZw@mail.gmail.com>
 <xmqq4kqan290.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq4kqan290.fsf@gitster.c.googlers.com>
From:   Jason Xu <jasonx98@gmail.com>
Date:   Tue, 14 Jul 2020 00:56:07 -0400
Message-ID: <CAGPh-qPH+gGYHCy+rQJvzwr-Vp71UJxwr+w-G9GaV_o40K8P-Q@mail.gmail.com>
Subject: Re: Force git diff to create a binary patch?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The "--binary" option was invented as a way to tell Git to produce something that can be applied, where Git stopped at saying "binary files differ".

Doesn't `--text` already do that? Albeit with whitespace warnings.

> So, no, I am less convinced "--binary" that forces "all paths are binary, so show binary patch" is a good idea.

I'm not sure exactly what this means, but if one binary and one text
file changed, then there should be a binary diff and a text diff, like
there is currently.
That's why I propose better binary file detection, instead of (what I
understand to be) "make all patches in a patch file GIT binary
patches, regardless if a file is text". But there is merit to that if
you don't care about readability in a "fully binary patch", or you
insist on not mixing text and binary in patches.

The terminology is confusing because within a file produced by diffing
two directories, there are multiple diff sections for each file
diffed. So while the documentation says "output a binary diff", to be
clearer it should say "output a binary diff only for binary files".

On Tue, Jul 14, 2020 at 12:34 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jason Xu <jasonx98@gmail.com> writes:
>
> >> The description for the --binary option reads as follows:
> >>
> >>   In addition to --full-index, output a binary diff that can be applied
> >>   with git-apply. Implies --patch.
> >>
> >> So we need to fix either the documentation or the code.
> >>
> >> I looked into what it takes to fix the code to do this; it's fairly
> >> straightforward, but it does cause some testsuite failures which assume
> >> the current behavior and will likely involve a small series.  So if
> >> other folks agree, I'm happy to pick this up in the next couple of weeks
> >> and add support for it that would hopefully hit Git 2.29.
>
> I am not convinced.
>
> The "--binary" option was invented as a way to tell Git to produce
> something that can be applied, where Git stopped at saying "binary
> files differ".  So a commit that touches two paths, one text and the
> other binary, used to produce a textual patch for one and a useless
> "binary files differ" for the other in "git show".  Such a commit
> can be made more useful with "git show --binary" to tell the former
> to still produce textual and readable patch while showing the xdelta
> based "binary patch" Git invented.
>
> So, no, I am less convinced "--binary" that forces "all paths are
> binary, so show binary patch" is a good idea.
>
> And viewed with the knowledge of that history,
>
> >>   In addition to --full-index, output a binary diff that can be applied
> >>   with git-apply. Implies --patch.
>
> this description is correct---the choice is not between "showing a
> binary diff and showing a useless textual diff"; the choice is
> between showing "binary files differ" and appliable "binary patch".
