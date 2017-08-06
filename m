Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E196C1F991
	for <e@80x24.org>; Sun,  6 Aug 2017 22:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751372AbdHFW5Q (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Aug 2017 18:57:16 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:33293 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbdHFW5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Aug 2017 18:57:16 -0400
Received: by mail-vk0-f54.google.com with SMTP id j189so3765516vka.0
        for <git@vger.kernel.org>; Sun, 06 Aug 2017 15:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Emy0ooiGIWGM8gtMH7T9BsqlBZYNdKftkNpGn94/0h4=;
        b=NpK9kSUZaitjPfVVPV0jThz1UKMBGDCiw/2tFNplSxgwMx+WsR9Pg0c3Sd95b2DE/4
         H8G8O5XfvAluXEXQQGBcqlmY355zB8nJZb89b9fMyD+CzyQeDKwbF5nkkqens9PP/XcH
         cGKuEgRQ1x9HCbc1GGRNRJFWkgV9W44225zcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Emy0ooiGIWGM8gtMH7T9BsqlBZYNdKftkNpGn94/0h4=;
        b=GQtqprpfF934eknfNn3UzPsB7phyvAjMO13jyasvvC5uJ47LugzumEKSMINrO7EnrH
         gwv6i2zQMNmjahzyZKNNRqEa4bxTgX+/CsxihfqnTJ3Af7gG5A9cYTCBQ6yYSYOpCcw2
         YAhqc0ckx/jwKSkwA2waGHlePTE7k6Y/qchn01qvJW3n6jwV304TZ+XoSNM8zsZwX9fu
         RycpteRFjFYj5J2bn48yhS7d4aZCZMuiaoMAFguowpZ+CScR4Mry9S+ZWmTY7Ybd55OB
         bfvzVobkBHJNXG90Z7/06mPj+kGr1Ts7+fnlELrg308ejT77t0Txk8sS1bR96vhPQnoj
         kmKA==
X-Gm-Message-State: AHYfb5hszBo/czNwr+hRv8ZwMuynMOnGOD97q4pQNo0FgidtuHk5M6Pt
        l0HswybWGT3yxbTiW/H2Xa8rHic4mwh+
X-Received: by 10.31.211.70 with SMTP id k67mr5837930vkg.129.1502060235020;
 Sun, 06 Aug 2017 15:57:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.83.7 with HTTP; Sun, 6 Aug 2017 15:56:54 -0700 (PDT)
In-Reply-To: <874ltkzlcf.fsf@gmail.com>
References: <CAJo=hJsOHF0KVmXvbSBiBgxq4zRdt7v7sj_GuKvcpbu8tkujFA@mail.gmail.com>
 <874ltkzlcf.fsf@gmail.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Sun, 6 Aug 2017 15:56:54 -0700
Message-ID: <CAJo=hJuPwEWJEWOUpJ_T-=j0NxnzjOLy_=-qG51_zuYhKbBvrw@mail.gmail.com>
Subject: Re: reftable [v5]: new ref storage format
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <David.Turner@twosigma.com>,
        Ben Alex <ben.alex@acegi.com.au>,
        Kristoffer Sjogren <stoffe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 6, 2017 at 9:56 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Sun, Aug 06 2017, Shawn Pearce jotted:
>
>> 5th iteration of the reftable storage format.
>
> I haven't kept up with all of the discussion, sorry if these comments
> repeat something that's already mentioned.
>
>> ### Version 1
>>
>> A repository must set its `$GIT_DIR/config` to configure reftable:
>>
>>     [core]
>>         repositoryformatversion =3D 1
>>     [extensions]
>>         reftable =3D true
>
> David Turner's LMDB proposal specified a extensions.refStorage config
> variable instead. I think this is a much better idea, cf. the mistake we
> already made with grep.extendedRegexp & grep.patternType. I.e. to have
> 'extensions.refStorage =3D reftable' instead of 'extensions.reftable =3D
> true'.
>
> If we grow another storage backend this'll become messy, and it won't be
> obvious to the user that the configuration is mutually exclusive (which
> it surely will be), so we'll end up having to special case it similar to
> the grep.[extendedRegexp,patternType] (i.e. either make one override the
> other, or make specifying >1 an error, a hassle with the config API).

Good catch. I've fixed this to use extensions.refStorage. Thanks!


>> Performance testing indicates reftable is faster for lookups (51%
>> faster, 11.2 usec vs.  5.4 usec), although reftable produces a
>> slightly larger file (+ ~3.2%, 28.3M vs 29.2M):
>>
>> format    |  size  | seek cold | seek hot  |
>> ---------:|-------:|----------:|----------:|
>> mh-alt    | 28.3 M | 23.4 usec | 11.2 usec |
>> reftable  | 29.2 M | 19.9 usec |  5.4 usec |
>>
>> [mh-alt]: https://public-inbox.org/git/CAMy9T_HCnyc1g8XWOOWhe7nN0aEFyyBs=
kV2aOMb_fe+wGvEJ7A@mail.gmail.com/
>
> Might be worth noting "based on WIP Java implementation". I started
> searching for patches for this new format & found via
> <CAJo=3DhJtrdCOF-RxzXfyLx7R-1f2-7pZVO_UOg28J=3DwUDNdf3yw@mail.gmail.com>
> that it's JGit only.
>
> Also if one wanted to run these tests via JGit using your WIP code where
> does that code live / how to test it?

git fetch https://googlers.googlesource.com/sop/jgit reftable mh-chunk

The reftable branch has my code; mh-chunk has the WIP I did for the
experiments above.

Running from tip of JGit is ... interesting? I load the workspace into
Eclipse and let Eclipse compile, and then use a shell script to pull
in the relevant classes:

--snip--
#!/bin/sh

S=3D$HOME/git/jgit
C=3D$S/org.eclipse.jgit/bin
C=3D$C:$S/org.eclipse.jgit.pgm/bin
C=3D$C:$S/org.eclipse.jgit.http.apache/bin
C=3D$C:$S/org.eclipse.jgit.lfs/bin
C=3D$C:$S/org.eclipse.jgit.ui/bin
C=3D$C:$HOME/Downloads/slf4j-1.7.13/slf4j-api-1.7.13.jar
C=3D$C:$HOME/Downloads/slf4j-1.7.13/slf4j-simple-1.7.13.jar
C=3D$C:$HOME/Documents/jgit/.metadata/.plugins/org.eclipse.pde.core/.bundle=
_pool/plugins/org.kohsuke.args4j_2.0.21.v201301150030.jar
C=3D$C:$HOME/Documents/jgit/.metadata/.plugins/org.eclipse.pde.core/.bundle=
_pool/plugins/com.jcraft.jsch_0.1.54.v20170116-1932.jar

exec java -Xmx1g -Xms1g -cp $C org.eclipse.jgit.pgm.Main "$@"
--snap--

Its commands like:

  ./jgit.sh debug-write-reftable ~/foo.refs ~/foo.reftable

to convert an ls-remote style output into a reftable. Then to benchmark:

  ./jgit.sh debug-benchmark-reftable \
    --test=3DSEEK_HOT --ref=3Drefs/heads/master \
    --tries=3D60000 \
    ~/foo.refs ~/foo.reftable


>> ### LMDB
>>
>> David Turner proposed [using LMDB][dt-lmdb], as LMDB is lightweight
>> (64k of runtime code) and GPL-compatible license.
>>
>> A downside of LMDB is its reliance on a single C implementation.  This
>> makes embedding inside JGit (a popular reimplemenation of Git)
>> difficult, and hoisting onto virtual storage (for JGit DFS) virtually
>> impossible.
>
> This rationale as stated reads a bit too much like https://xkcd.com/927/

Hah. True. :)

But its technically correct. The best kind of correct.
https://www.youtube.com/watch?v=3Dhou0lU8WMgo

> I.e. surely the actual problem isn't that there's a single C
> implementation of LMDB, since that's one more than the C implementation
> that exists of this new format already.

Fair point, but I think this format is easier to implement than LMDB.
We also had bitmap indexes in JGit a year before we had them in C git.

> Also isn't this info out of date now that this exists:
> https://github.com/lmdbjava/lmdbjava ? That project has been implemented
> after David's initial LMDB patches on-list, but I don't know if it
> implements the subset of the LMDB format needed for his proposed ref
> storage.

Looks pretty complete. Its a Java wrapper around the C implementation
of LMDB, which may be sufficient for reference storage. Keys are
limited to 511 bytes, so insanely long reference names would have to
be rejected. Reftable allows reference names up to the file's
`page_size`, minus overhead (~15 bytes) and value (20 bytes).

A downside for JGit is getting these two open source projects cleared.
We would have to get approval from our sponsor (Eclipse Foundation) to
use both lmdbjava (Apache License) and LMDB (LMDB license). Plus it
looks like lmdbjava still relies on local disk and isn't giving us a
way to patch in a virtual filesystem the way I need to at $DAY_JOB.


$DAY_JOB is likely to put reftable into production in the coming
month, even if we don't have consensus about using the format in
git-core.
