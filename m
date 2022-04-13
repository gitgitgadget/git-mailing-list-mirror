Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6805C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237439AbiDMTgm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiDMTgk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:36:40 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574661D8
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:34:17 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l7so6062900ejn.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=lgdXSzQ/UUhX7/bRtC1UJiOBnPiekNOUX9XiRdiiebs=;
        b=jnvlTjpYoU9AULWxBM+nUXUsbgfVpZLa2JBpXaxFoHnQAIbi4d1euVYE5t3y5T5nk6
         /ej8p982YEgKEFDUpNCsGH042bS2AvVV+x0QOWxfCi36Fgj0B4idsS7FXJUu6oSDZnbY
         iIe0pemJuIKAHvtqA9G6hnAxXXYv/ZjQOoedx22442c6JcZitfzG8GuGh5JVDzWF+X0C
         6AbmRrK9+/8gDeEIRWsGpRJNJ8KRP3kZ1mPCkMoAtH6bv1I6t8RWsuZ8yIYux3Tm3B50
         yBs2fTENFbbqsu97spfZ6B3wvjweu/DOa6dKN4fL6RIfVPPJaUx6jesvIq5gp2C6e5/1
         NYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=lgdXSzQ/UUhX7/bRtC1UJiOBnPiekNOUX9XiRdiiebs=;
        b=OTxUndTfuC/IAHxeKD4qhyLW87SMrD/FSg8Y5GIhaTmaSl3LHwBDom2TbW3shuSc29
         nLM1kb3cAUUjEJd0H4xfrVjKUVqR2jmw8SOFvB3yT1IIt4sb2bC2UtiQat6z1kCChTK/
         PykgLJi0JNkvaW1KhPYoMz+vBalzctgRoNdLgfNplE6nf+9JMQlxnMcsnr+oVIe7RSBq
         Xvwyo+DPvcQtiS9RJFPcizt3Q/SAdYt6XMvKGxGad+FjMgHSvN2Hrsx2v5j6g9o34OvF
         fibgYeOoyzNZU03PIUF/rVAKiZxO/xEdPHwzRp0Jr2H6Ea2/hHR7DINSKjmcqBk9XsCU
         4XRg==
X-Gm-Message-State: AOAM532PdJL+HY+WuGZmYXZER7eVPNkZrQGEHvaiXn8WrILL+UxAdwlo
        h9A3eQkPjk8RZ1DvRVKGV6OPd0+p+PM=
X-Google-Smtp-Source: ABdhPJxWxgCYFreHLqKOn2XquKyFCDt/tiF6Ajv98qZsWEFgGSHUOlhZRcMHA/ZzjJ9p7ynKlhb2iA==
X-Received: by 2002:a17:906:7947:b0:6da:892f:2503 with SMTP id l7-20020a170906794700b006da892f2503mr39120328ejo.710.1649878455711;
        Wed, 13 Apr 2022 12:34:15 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m24-20020a170906161800b006d420027b63sm286073ejd.18.2022.04.13.12.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:34:15 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1neiko-005AnI-QZ;
        Wed, 13 Apr 2022 21:34:14 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeremy Maitin-Shepard <jeremy@jeremyms.com>
Cc:     git@vger.kernel.org
Subject: Re: Limitations of ownership checking fox for CVE-2022-24765
Date:   Wed, 13 Apr 2022 21:21:53 +0200
References: <CAKJfoCEgiNvQJGt=rGYTaKQ1i2ihrPmX2Sz3Zxg-y66L+1Qh6g@mail.gmail.com>
 <220413.86v8vdf46n.gmgdl@evledraar.gmail.com>
 <CAKJfoCHWYaQGgK1_Wv0j1qW--pwD3=T9A5m8zQJRwwVOrRLx_Q@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAKJfoCHWYaQGgK1_Wv0j1qW--pwD3=T9A5m8zQJRwwVOrRLx_Q@mail.gmail.com>
Message-ID: <220413.86fsmgeq15.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 13 2022, Jeremy Maitin-Shepard wrote:

> On Wed, Apr 13, 2022, 07:28 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com> wrote:
>>
>>
>> On Tue, Apr 12 2022, Jeremy Maitin-Shepard wrote:
>>
>> > The current fix for CVE-2022-24765 prevents unsafe command execution
>> > in some cases but does not address all cases:
>> >
>> > - Ownership by the current user should not be taken to mean "trusted":
>> > the user may have retrieved a directory tree from an untrusted source,
>> > including:
>> >   - Another version control system (which won't prevent a .git directo=
ry)
>> >   - Unpacking an archive
>> >   - FUSE mounting a remote filesystem
>>
>> Those would be good to fix, but I don't think it's correct that it's
>> within the scope of CVE-2022-24765.
>>
>> That CVE is specifically about the multi-user case where we'd previously
>> pick up another user's .git directory.
>
> I can see the distinction but I would say the CVE addresses a specific
> case of the more general problem that commands like `status` for
> inspecting a repository aren't safe by default.
>
> By solving the more general problem we also solve the case described
> in the CVE.  On the other hand if the more general problem is not
> solved then it is still not safe to run `git status` automatically.
> The fix for this CVE might give users the impression that it is safe,
> when given how most users do things, it is probably not.

Yes, let's be clear. I'm not saying it doesn't suck, just that the git
project has maintained for approximate forever that thou shalt be
careful with a repo you unpack via a tarball, for exactly this reason.

So I think fixing that is needed, but that it would fall under future
feature development, not an immediate follow-up to the CVE.

I recognize that the CVE somewhat blurred the lines though, i.e. it's
really just a special-case of the old tarball case, for which we never
cared about ownership.

But that's also an artifact of git's *nix legacy, where you don't need
to worry about /.git or /home/.git, except if your root user creates it,
and then you're hosed anyway.

>> As noted in [1] the solution that got committed does suffer from that
>> edge case, but I think [1] also summarizes why that approach was taken.
>
>
> The argument in the thread seemed to be that by broadly blocking the
> multi-user issue, there is less risk of discovering another multi-user
> vulnerability.  But since it does nothing to address the more general
> issue of `git status` being unsafe to run from untrusted directories,
> the real mitigation is to ensure `git status` isn't run automatically
> (and carefully inspect any untrusted directories before running it).
> And if users employ that mitigation, the additional ownership check
> isn't necessary.
>
> Other tools such as direnv and the Emacs dir-locals mechanism have
> exactly the same issue of needing to decide whether to trust
> configuration files in the current directory.  They solve the issue
> with an allowlist.  I'm not aware of any tool that trusts based on
> ownership.

Yes, I think we're on the wrong path with considering ownership of the
config at all, and I've been advocating for adopting something more like
Emacs's model for years :) E.g.:

	https://lore.kernel.org/git/87zi6eakkt.fsf@evledraar.gmail.com/

It also came up in the git-security@ discussion...

But that's a somewhat larger change, so just because that's a sensible
eventual goal doesn't mean that a shorter term mitigation is the wrong
thing for now.

But I for one would be estatic to have someone add the Emacs-like model
to git *hint* *hint* :)

>>
>> A way of mitigating that case is to put something like this in one's
>> .bashrc:
>>
>>         git () {
>>                 command git -c core.fsmonitor=3Dfalse "$@";
>>         }
>>
>> Then, even if you need to use that safe.directory feature you won't be
>> vulnerable to someone sneaking up on you and adding this to the
>> .git/config of the (presumably core.sharedRepository) repo:
>>
>>     [core]
>>     fsmonitor =3D rm -rf /
>
>
> It fixes the current known issue by disabling that feature altogether,
> but unlike a hypothetical --safe option it doesn't protect against any
> similar config options that may be added in the future (or existing
> ones found in the future to be unsafe).

Aside from anything else I think it's safe to say that we'll probably be
much more careful in adding these arbitrary execution options in the
future, so I'm not too worried about that.

> Additionally it doesn't provide a mechanism for allowing specific
> commands or specific repositories.

*nod*. I'm just saying that this should get you out of the woods when
doing "basic inspection", it would probably be a good idea to add -c
core.pager=3Dless or whatever to that though.
