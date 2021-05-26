Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFEDC2B9F7
	for <git@archiver.kernel.org>; Wed, 26 May 2021 09:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75A7A613D3
	for <git@archiver.kernel.org>; Wed, 26 May 2021 09:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbhEZJTm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 05:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbhEZJTm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 05:19:42 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F938C061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 02:18:11 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id n10so259543ion.8
        for <git@vger.kernel.org>; Wed, 26 May 2021 02:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AuDIuJE7CU16sZPYBiC4jcg2VSTEcxwsXqaqm66VjZ4=;
        b=Z9VS0wzBDFqpGoBCZoqD4GbkB8dNa31O/6MT9hswaTDZCZ6IJ0NQWM+T90hpVT5GOz
         WlAnJ8pl3M0NEMRTb2eWCONFrrq+4v7j/iDKGPbyE5+29RC/bdzY1zlxdh3LAuwzGAN6
         HZkO5hrvpAIRx/0Ky3353hYjm1RuNM/1+Ss4yiPP2NyV1wUTw2ZGny75D3GVgOs2XlZx
         /5Tn3uLPkdTTmvT7HEW76SIFCdDUM/c9ZJ5eVB7fuzA0CIc2jogxjkhCJclSFMAXVHaj
         eJ25dXxT1oWN3sVVy9k6gq5KSrd6yTJbzHpn6TCTz/WOeIS6vqOzjW7d7YrJp/V5hDl9
         OEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AuDIuJE7CU16sZPYBiC4jcg2VSTEcxwsXqaqm66VjZ4=;
        b=AUkP5IfQKEOet4KJMIm7ktg2jVqqRI+00yH5VXIdfC7hI8BMGeYPDLevcjetlJrEVS
         8YgZ8FN4CHWdMMMmBVmLYcchVtU1ZwKWUOvzc4bAdj08p1wCDm12/vyqx0LSze0SMAyP
         BgX4AniuyoKOkp9fuzGlvwnx0kxPfvCWLHRlO4vycNTTOJ1fvz6TiRjMyTeydPwozjhs
         SNbE2EAWgMayG/G5PUaVqfv31Ky43JEx5AG5V/ZQ9ScaegE+O2sWWBiQP7XeCNNz1h/g
         ijwe/vanyO/Nb1831sjHaH5G65PD+UY3PHzc360Q0VbjXC6lkSkO0jIgicDPtyUpoDpy
         8cfA==
X-Gm-Message-State: AOAM533YIIH44pHWZRZyukHIP5oiJGMsQGr9XuFmhFhK0hqmyrq8GYfZ
        LFEKfKzZmKbGU46EbPhfu+4Qw5Nn6WrQKW6aPgI=
X-Google-Smtp-Source: ABdhPJyv8ZEhIFUcbL2gEau2ELEe1AozaEuYw6EBwHpBqrGXWTimQcZW3o1ZzM8WeLaX6GFasdNKLID8JfmNw24NamY=
X-Received: by 2002:a05:6638:150d:: with SMTP id b13mr2170513jat.51.1622020690464;
 Wed, 26 May 2021 02:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <pull.959.git.1621763612.gitgitgadget@gmail.com>
 <xmqq1r9xndjf.fsf@gitster.g> <xmqq8s42cnyb.fsf@gitster.g> <CAOLTT8ReZffY5gznSDD=Fgbt7YTtA5aJWX+f8Q8npcj0OwcuFQ@mail.gmail.com>
 <xmqqpmxeas8p.fsf@gitster.g>
In-Reply-To: <xmqqpmxeas8p.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 26 May 2021 17:17:55 +0800
Message-ID: <CAOLTT8QR_GRm4TYk0E_eazQ+unVQODc-3L+b4V5JUN5jtZR8uA@mail.gmail.com>
Subject: Re: [PATCH 0/3] [GSOC][RFC] ref-filter: add contents:raw atom
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=8826=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=883:06=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > $ printf '%b' "name=3D'a\\\0b\\\0c'\necho -e \"\$name\"" | sh | od -c
> > 0000000   a  \0   b  \0   c  \n
> > 0000006
>
> This is wrong.  In the above, the variable name does not have a NUL
> in it.  It insead has 2-byte sequence "\" and "0" in it, and you are
> letting "echo -e" to convert it into binary, which is not portable
> at all.
>

Indeed I was wrong, the var name does not contain '\0'.

> I'd suggest instead to declare that some host languages, like shell,
> are not binary-clean and either refuse to process atoms whose values
> have NUL in them.  Silently truncating strings at NUL or striping
> NULs in strings are also acceptable options if clearly documented.
> Claiming that we stuff binaries into variables of the host language,
> while not doing so and instead assigning a quoted form, is not good.
>

Makes sense. Either choose to truncate, or choose to reject.

> I have not thought about Python3 very much.  For the purpose of most
> %(placeholders), it is vastly more preferrable to use str (i.e. text
> sequence type) as opposed to bytes, as you do not have to .decode()
> to use the resulting "string", but even for things like %(refname),
> it is not technically kosher to assume that the contents are UTF-8
> encoded text, as filenames used to represent refnames are merely a
> sequence of bytes except NUL, but for consistency with binary gunk,
> we might have to emit everything as bytes.  I dunno.
>
> > In shell or python2/3, we can replace'\0' with "\\0".
>
> Not for shell.  We should declare that it is not supported to feed
> binary to shell.

Eh, it seems that we adopt a "reject" strategy.

$ git hash-object a.out -w | xargs git update-ref refs/myblobs/aoutblob
$ git for-each-ref --format=3D"name=3D%(raw)" refs/myblobs/aoutblob
--python | python2
  File "<stdin>", line 1
SyntaxError: Non-ASCII character '\x8b' in file <stdin> on line 2, but
no encoding declared;
 see http://python.org/dev/peps/pep-0263/ for details

$ git for-each-ref --format=3D"name=3D%(raw)" refs/myblobs/aoutblob
--python |python3
SyntaxError: Non-UTF-8 code starting with '\x8b' in file <stdin> on
line 2, but no encoding declared;
 see http://python.org/dev/peps/pep-0263/ for details

It seems that --python also needs to "reject", no matter python2 or python3=
.
What about tcl and perl?

$ cat a.out | od >1.od
$ git for-each-ref --format=3D"set name %(raw)
puts -nonewline \$name" refs/myblobs/aoutblob --tcl | tclsh | od > 2.od
$ diff 1.od 2.od | head
7,12c7,12
< 0000140 114303 000002 000000 000000 141400 001230 000000 000000
< 0000160 000000 000010 000000 000000 000000 000003 000000 000004
< 0000200 000000 001430 000000 000000 000000 001430 000000 000000
< 0000220 000000 001430 000000 000000 000000 000034 000000 000000
< 0000240 000000 000034 000000 000000 000000 000001 000000 000000
< 0000260 000000 000001 000000 000004 000000 000000 000000 000000
---
> 0000140 001330 000000 000000 000000 001330 000000 000000 000000
> 0000160 000010 000000 000000 000000 000003 000000 000004 000000
> 0000200 001430 000000 000000 000000 001430 000000 000000 000000
> 0000220 001430 000000 000000 000000 000034 000000 000000 000000
> 0000240 000034 000000 000000 000000 000001 000000 000000 000000
> 0000260 000001 000000 000004 000000 000000 000000 000000 000000

It seems that a.out contents passed into tcl and then the output is
very different...

But,

$ cat a.out | od >1.od
$ git for-each-ref --format=3D"\$name=3D %(raw);
print \"\$name\"" refs/myblobs/aoutblob --perl | perl | od >6.od
$ diff 1.od 2.od

There was no error this time, so for perl, it's ok...
The "binary security" we care about is currently only complied with
by the Perl language.

So I think we better reject them all languages together for normative.
The clear definition of this rejection strategy is that %(raw) and --langua=
ge
cannot be used at the same time. If our binary data is passed to a variable
in the host language, there may be escape errors for the host language.

Thanks.
--
ZheNing Hu
