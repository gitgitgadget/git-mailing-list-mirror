Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CE9C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 16:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B8E5613C8
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 16:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhDTQSt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 12:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbhDTQSt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 12:18:49 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E65EC06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 09:18:16 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id s190so4048292vkd.6
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 09:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UBBBC1yY/b0TVDAjn9jQyiMp4eFejuQ6GiATPofRuh4=;
        b=H8fEjNidWJgdM0nSb/H/4vpXbosqvyejMLKfP7FhIOlDBgbHJ1kAy2B4qybN0b0pEi
         dbURpXEecxAF3oB9EKGmhQPx+u2F42x19sfjTI8DQDjWSai4Q8yU1GVhWIi+wePp1ZU+
         OZnBBJNyfXb1q4hAn4FFqznfssiKYiRUrC2a79U+J9wojmrnhOs63hTJoi/zzUZ6hTcb
         fyqbsL+na47b6ANZzvdWj1dRxyUkpTxm3YurNzvTqizHjil4JWdZ5QrGyCVNRBOZvsX4
         em94Dw3DKey5JjDx6S6mRIQXeS6Yw3IGVDYEqybhJFAZHVLA7aB16QTG9mhBiOMrTGdc
         k5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UBBBC1yY/b0TVDAjn9jQyiMp4eFejuQ6GiATPofRuh4=;
        b=hULulqR7DLDoVjahFIwnVJQ5Aq5ScXykDNhxHGhsphG4HorfBRsQCMyAWiC0sXnlGl
         gHPjpkwThg7ZpZBtHgEgio2w2Jc0qUiLjNZaG5tGmG38jKwoT22jeK1SIbBE0b+4pYfR
         cAVFJUEJ3nnTVZ5nHVRUw6Fz9u3Vou3IaoSaeTBG/K0ncLmVZrW+Ek1f1AQRmtMRveqj
         4AylYN+5oKkDfxibaVlXUpydWdeSNcpya+k1bTvZxolOjaLDLqFbU5kisYsQpQFHjsAx
         0DgAhAGurWotaqBpwqBc0ybkZo75yEqYMfVDCqfLqz45bQvSpC/s5/98sZbQChXRwn6H
         25Xg==
X-Gm-Message-State: AOAM531bx6UnJOFvf1aG+Xk1a2cnXtCZm6REJKJj/YXrLND9gv2ZsQKg
        H7oeo8fThCfNomWcqSCnoD4tzglZkVSrm8LAp9E=
X-Google-Smtp-Source: ABdhPJx3BueILAGDFX3NmverZRBVJAn+vEhwjdjMlicfH7JJrd56DBCP3a50QLdhIwFNUY8znD3e9k09LYUN94iBwCk=
X-Received: by 2002:a1f:5682:: with SMTP id k124mr20888845vkb.20.1618935495569;
 Tue, 20 Apr 2021 09:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <YHofmWcIAidkvJiD@google.com> <CA+P7+xqzsD+pU=-9YUYdGDAqT4uVk=XS4sdxA5WnAXL_7GwM5Q@mail.gmail.com>
 <013401d73552$287f49e0$797ddda0$@nexbridge.com>
In-Reply-To: <013401d73552$287f49e0$797ddda0$@nexbridge.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 20 Apr 2021 09:18:05 -0700
Message-ID: <CA+P7+xrOuhG5ujQRYS0=o7S9=xD5zm6BGp5mBRt493Lme9xYcw@mail.gmail.com>
Subject: Re: RFC/Discussion - Submodule UX Improvements
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertcui@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 19, 2021 at 12:28 PM Randall S. Becker
<rsbecker@nexbridge.com> wrote:
> On April 19, 2021 3:15 PM, Jacob Keller wrote:
> > A sort of dream I had was a flow where I could do something from the pa=
rent
> > like "git blame <path/to/submodule>/submodule/file" and have it present=
 a
> > blame of that files contents keyed on the *parent* commit that changed =
the
> > submodule to have that line, as opposed to being forced to go into the
> > submodule and figure out what commit introduced it and then go back to =
the
> > parent and find out what commit changed the submodule to include that
> > submodule commit.
>
> Not going to disagree, but are you looking for the blame on the submodule=
 ref file itself or files in the submodule? It's hard to teach git to do a =
blame on a one-line file.
>

Well, I would like if "git blame <path/to/submodule>" did.. something
other than just fail. Sometimes my brain is working in a "blame where
this came from" and I type that out and then get frustrated when it
fails. Additionally...

> Otherwise, and I think this is what you really are going for, teaching it=
 to do a blame based on "git blame <path/to/submodule>/submodule/file" woul=
d be very nice and abstracts out the need for the user (or more importantly=
 to me =3D scripts) to understand that a submodule is involved; however, it=
 is opening up a very large door: "should/could we teach git to abstract su=
bmodules out of every command". This would potentially replace a significan=
t part of the use cases for the "git submodule foreach" sub-command. In you=
r ask, the current paradigm "cd <path/to/submodule>/submodule && git blame =
file" or pretty much every other command does work, but it requires the use=
r/script to know you have a submodule in the path. So my question is: is th=
is worth the effort? I don't have a good answer to that question. Half of m=
y brain would like this very much/the other half is scared of the impact to=
 the code.
>
> Just my musings.

I'm not asking for "git blame <path/to/submodule>/<file>" to give the
the same outout as "cd <path/to/submodule> && git blame <file>"

What i'm asking is: given this file, tell me which commit in the
parent did the line get introduced. So basically I want to walk over
the changes to the submodule pointer and find out when it get
introduced into the parent, not when it got introduced into the
submodule itself.

This is a related question, but it is actually not trivial to go
instantly from "it was in xyz submodule commit" to "it was then pulled
in by xyz parent commit". It's something that is quite tedious to do
manually, especially since the submodule pointer could change
arbitrarily so knowing the submodule commit doesn't mean you can
simply grep for which commit set the submodule exactly to that commit.
Essentially, I want a 'git blame' that ignores all changes which
aren't actually the submodule pointer, update.

I think that's something that is much harder to do manually, but feels
like it should be relatively simple to implement within the blame
algorithm. I don't feel like this is something strictly replaceable by
"git submodule foreach"

>
> Randall
>
