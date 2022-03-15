Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E311C433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 20:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351678AbiCOU0c (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 16:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbiCOU0b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 16:26:31 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114B31AD98
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 13:25:19 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id l20so377823lfg.12
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 13:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LHRokckFs1e8iSRAYH+3jpvE7V2QWoHxaDRf+47gIlw=;
        b=pONvEALqmuib3wJ3OwhzR1KQFTeImf/PEF3Hgvz28tsnQ9XfcEZ8l23tzxV8aAq2XS
         mvtQOgifgxneTk63XgOGGXC5rGJZsj4rLX2RF/+jXZekQ0QQx16iODZbBMPUF/sNoPOb
         PxvNR+Bj8nML5avLQKX6KbKM5YqhnQjltd+reTaujEHnNNIWL9sbJ8/zgySIGL9/eGW8
         dz8S4AIEKC1eBB7KlszyF3Tdm77CCHAZX2JTtBY4H/W9rx89Hl2346uAT85DxqavChN7
         blQsLQ4+JjCQsLXuHAkWZrRBiEwqnxGvnK6lmSWnnnuhFHKP9r2JpKEQLe01oWl1le8Q
         1agw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LHRokckFs1e8iSRAYH+3jpvE7V2QWoHxaDRf+47gIlw=;
        b=yhTnglETRh8BxEg73gS+J+HB0pErpPaViE0DxoDygKS7o7CyJhGFJy1wOZXg9Wzqlm
         +R8o9PRYeyk9N3t4Ul7+vBru66g1tbkhfnTXmnsF0rMdbqLR8uqDHpZAPDaPJhJ3CwSn
         HTaXDCy9F+T2UiyulKg0sjBL3aB9sVwY8gfldqEHNDnl81CeyHuhqDjgxFNRPQPAiu/A
         JXxKwJKBafsJD0bKyaqWBaXv6EeKVUd7/K/e97lwaT1dzqjNTM9eq01pN7WAvAWaylh2
         IOIynk9QlBpnatC2EUhp/NfM4e+lYJlfQPQKheRsN9XqZ/DQHFQCMqZPGmWcvceAxoIB
         bYfg==
X-Gm-Message-State: AOAM532/l0i89iglYasp0Rgb+KB1kKRjh3TLyAu3LgrROp1hBMyHjSQd
        jVTRIDNFPnWgtlFuUEAq7f1gyUP8zJhctgp4weTkUxfaRtJ84w==
X-Google-Smtp-Source: ABdhPJyUXLe/Efqx8VzTxIMfrZcpKG1MToPjtzZSWNy88Nh9KFyRn7Tq5Ba7agci/NoVbMIvDNe71yRxvJ99v8vVLyo=
X-Received: by 2002:a05:6512:691:b0:448:a39d:d41d with SMTP id
 t17-20020a056512069100b00448a39dd41dmr3607096lfe.385.1647375917122; Tue, 15
 Mar 2022 13:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <028301d837b1$173aacd0$45b00670$@nexbridge.com> <220315.86lexbdm4d.gmgdl@evledraar.gmail.com>
In-Reply-To: <220315.86lexbdm4d.gmgdl@evledraar.gmail.com>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Tue, 15 Mar 2022 13:25:05 -0700
Message-ID: <CAJoAoZmBdgFez5Mrx9_GMaNtcTrTixEOjE+Gshs0umTbbXAOPw@mail.gmail.com>
Subject: Re: Follow-up on hooks series
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As threatened in IRC yesterday, adding Git list as well ;)

On Tue, Mar 15, 2022 at 12:57 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, Mar 14 2022, rsbecker@nexbridge.com wrote:
>
> > 1 I am not sure of the usefulness of the git hook list <hook> form. If =
you know the name of the hook, then you don=E2=80=99t need it listed. I get=
 that it seems like a whereis style command. How
> >  about this:
> >  git hook list [ <hook-pattern> =E2=80=A6 ]
> >  that displays all hooks if none specified or those matching a pattern.=
 The current message of hooks in hookdir is not particularly meaningful to =
me. hook bob found in .git/hooks explicitly
> >  would be more useful and better if you have patterns.
>
> That might be a good idea, I honestly haven't re-paged this into my brain=
.
>
> In any case this isn't in master/next or in-flight, there's just "git
> hook run" there, so let's discuss it when those patches are submitted
> (I'll CC you).


I'm a little unsure about what the semantics of this looks like, actually.

The way it works as implemented is like so:

$ git list pre-commit
# Because pre-commit can run more than one script, they all appear in
the output:
/usr/share/some-package/very-cool-pre-commit-hook
~/my-repo/hooks/project-specific-hook
~/src/script-i-wrote-to-watch-for-debug-printfs

That is, I know that I'm about to make a commit, but I don't remember
if I configured very-cool-pre-commit-hook and I need it for this
commit, so I want to list all my pre-commit hooks as a sanity check.

So I'm a little bit confused why it would be useful to grep with a
pattern. Are you expecting instead for something like:
$ git hook list '.*project-specific'
pre-commit: ~/my-repo/hooks/project-specific-hook
prepare-commit-msg: ~/my-repo/hooks/project-specific-check-commit-msg-hook

Or maybe even, given a config:
[hook "very-cool"]
  command =3D /usr/share/some-package/very-cool-pre-commit-hook
  event =3D pre-commit
[hook "very-cool-other-hook"]
  command =3D /usr/share/some-package/very-cool-pre-push-hook
  event =3D pre-push

to run something like
$ git hook list 'very-co*'
hook."very-cool".command=3D/usr/share/some-package/very-cool-pre-commit-hoo=
k
hook."very-cool".event=3Dpre-commit
hook."very-cool-other-hook".command=3D/usr/share/some-package/very-cool-pre=
-push-hook
hook."very-cool-other-hook".event=3Dpre-push

Both these examples I see a little less usefulness, but especially the
last one (which is essentially a thinly veiled 'git config
--get-regexp') doesn't seem useful to me. The "hook name" ("very-cool"
and "very-cool-other-hook" in this example) is pretty much an
implementation detail local to the config parse, and user will never
refer to it by that name after the config setup, right?

>
>
> > 2 I may have missed something, but I thought that this series might
> > allow execution of hooks if not in a repository =E2=80=93 that was my h=
ope
> > anyway. To do this, maybe add a --repository=3D<path> argument so that
> > git will know where to find the ./git/hooks directory, and then run
> > it.
>
> Yeah, some version of those patches does that, not sure which offhand...

Hrm. Well, I have a bit of a personal grudge against .git/hooks/ hooks
in general :) so I would say, if you will go through the pain of
wanting to reuse some hook in some specific repo all over your
machine, why not just set it up in your ~/.gitconfig instead, so you
don't have to pass this argument?

Better yet, if this argument is targeted for scripting, I think you
could achieve the same thing with 'git -c
core.hooksPath=3D~/myproject/.git/hooks/ hook run sendemail-validate',
and we wouldn't have to implement anything new at all.

 - Emily
