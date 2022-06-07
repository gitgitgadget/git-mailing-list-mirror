Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305AEC433EF
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 08:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238301AbiFGIiL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 04:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238288AbiFGIiK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 04:38:10 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081942409A
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 01:38:08 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bg6so13867676ejb.0
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 01:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=5hCKsmfeCxnxPGpcO07N+D6Ru/KMovWWz4kosrMp5hc=;
        b=PLgJahPS9HkY8VbQR8zRaUlO5VkaYu5+jCe7YrdoaDFx5sq1nOO9q8ELBdMA9ezx3m
         RGDqzh2PYNhVl9oOEuoy0uNv1i21h7vOg2csw23Z1uzmWX1WYG1mFsqzM1qLOt2AgZhB
         foCF/R5v6BJRnrTQVHHuXjZZTBZVKA/IK/Q4/GbGXORqnlVUd8+EjQxsQpm8GuSVoliN
         NpKHnTon5zCqIN230jMUZikCpLFYHXJQ3KsYPfyGQFEhTFw9mNyFhd/jnk9KF5FrYcNu
         WK7QQ4g5Hxct06mTMSNEWlx212q/Uiejh7FGFmWDU2sTPGaBWov01swggp1hiY+Ua3wL
         KRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=5hCKsmfeCxnxPGpcO07N+D6Ru/KMovWWz4kosrMp5hc=;
        b=3Cw4gZE6/1H3VEOcU46HUS4TJXMDakdycToIORFWGgt98El5TlbK4CdE7Pwg2aSNnv
         BEeLFAVMHdKLK6DYw8lJwWmsm5aRrbnS/EDL5PuB2aEotI5gSYT6bAySwYruRbdCWngw
         mTdY8BkROJ5fahj/YhxVxnuQpQLG/uV26DVb3TtyA4rKbAZPMs8xkMYp0mzilFXLBCrH
         UHfE/JvtGrQiNEKHWtWFw9KWzN20aPU0vODoF2fuxnaUIA6LZ2HGNypDU0ofWycSohSK
         VMghLLPgUTLGVPx8oBbrScfEqpkknutTcujMEhbihhzkY0T/49+a8p/eU0ZvRLMyl/Nz
         CWDg==
X-Gm-Message-State: AOAM531avb5TzWWg08Z9YQaBVqow7UOxUmGMeEcCmXqZkvNfbsekBgRU
        ESs56uVgUZFSxfWErQRV1uc=
X-Google-Smtp-Source: ABdhPJyjtS50BKzzIsulWEp+FILTAQirSYWU0leNBGT3Boezsz/ca/PVhcy/O7gnria2zYldaRAdHA==
X-Received: by 2002:a17:906:3ed5:b0:6f5:108c:a45 with SMTP id d21-20020a1709063ed500b006f5108c0a45mr25113879ejj.623.1654591086342;
        Tue, 07 Jun 2022 01:38:06 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id d15-20020a056402000f00b0042e1cbc4471sm7884707edu.3.2022.06.07.01.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 01:38:05 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nyUiz-002N0b-8e;
        Tue, 07 Jun 2022 10:38:05 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        derrickstolee@github.com
Subject: Re: [PATCH 0/2] builtin/show-ref.c: support `--count` for limiting
 output
Date:   Tue, 07 Jun 2022 10:18:56 +0200
References: <cover.1654552560.git.me@ttaylorr.com>
 <xmqqo7z54d7g.fsf@gitster.g> <Yp6GRccc5UElNrZb@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <Yp6GRccc5UElNrZb@nand.local>
Message-ID: <220607.86mteovpg2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 06 2022, Taylor Blau wrote:

> On Mon, Jun 06, 2022 at 03:52:19PM -0700, Junio C Hamano wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>>
>> > This short patch series adds support for a new `--count` argument for =
limiting
>> > the output of `show-ref` (=C3=A0-la the `for-each-ref` option by the s=
ame name).
>>
>> It makes me wonder why we limit this to show-ref.
>>
>>     $ git --pipe-to-head-N=3D3 any-command args...
>>
>> IOW, having to add an option like this feels absurd.
>
> I don't disagree. But `--pipe-to-head-N=3D3` feels like too broad a
> stroke. This series at least imitates `for-each-ref`'s `--count`
> option, which makes it feel acceptable to me (if not a little silly).

Yeah, although I do think it's worthwhile to think about where certain
UX decisions are leading us, i.e. the logical conclusion here is to have
every command that emits >1 lines support --count, which as your patch
here shows needs special support, and even in your case you haven't
implemented it in a way that's compatible with all existing options.

B.t.w. why would a --count for --verify not just by supported have these
be equivalent:

    # same
    git tag --count=3D3 --verify <name>
    git tag --verify <name> | head -n 3

>> > This is useful in contexts where a caller wants to avoid enumerating m=
ore
>> > references than necessary (e.g., they only care whether a tag exists, =
but not
>> > how many or what they are called) but doesn't have control of the outp=
ut stream
>> > (e.g., they are in Ruby and can't pipe the output to `head -n 1`).
>>
>> Are you saying that Ruby is incapable of run a command line like
>>
>>    av[0] =3D "sh"
>>    av[1] =3D "-c"
>>    av[2] =3D "git show-ref blah | head -n 1"
>>    av[3] =3D NULL
>
> No, Ruby is perfectly capable of doing that. But it involves an extra
> process (two, if `head` isn't a shell builtin) [...]

Maybe this really is a limitation of ruby, or maybe I'm missing
something, but doesn't it support just opening a process without "sh -c"
and piping the output to your current process, as this perl command
which makes use of execve() will do:

    $ perl -Mautodie=3D:all -wE '
        my $i =3D 0; my $lim =3D shift;
        open my $fh, "-|", qw(git show-ref master);
        while (<$fh>) {
            last if $i++ >=3D $lim;
            print "$.: $_";
        };' 10

Some quick searching for docs online suggests that Ruby's Open3 and/or
Process.spawn might be the equivalent.

Note that if you replace that qw(git show-ref master) with e.g.:

    "git show-ref master | tail -n 20"

That you'll get 3x execve(), one sh -c, another for "git" and another
for "tail", but in the first case you'll only get the execve().

Isn't that something that would make this workaround unnecessary? Well,
maybe not because...

> [...]and the additional
> overhead of creating a pipe and passing data through it instead of
> writing directly to stdout.

It wouldn't take care of this part, but I'm struggling to think of cases
where you'd be running this in the context of github.com and not already
need to capture the output of the command. I.e. surely you're already
piping stdout/stderr into your program, no?
