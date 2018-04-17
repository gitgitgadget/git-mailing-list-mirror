Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F0441F404
	for <e@80x24.org>; Tue, 17 Apr 2018 17:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeDQRX3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 13:23:29 -0400
Received: from mail-pl0-f42.google.com ([209.85.160.42]:46605 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeDQRX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 13:23:27 -0400
Received: by mail-pl0-f42.google.com with SMTP id 59-v6so12341494plc.13
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 10:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5nQK9vxcZoAxyVtrJNMhKbms5RoPN1FJ5YxhBX/Dlq8=;
        b=Ho+jYK+TrVhVS+MqLyk9a96OWYl7m5AWAf80vodpJI8fzks8zPAu9S7xA0bxjF5iAb
         Ui5wyIxdBljx5nR93uPrUjz5FchzXV3zBYE8eAQS0xHWj6Wb/QNrfmZy3CrJ7RMUqO7n
         hsWyj22j+HyArhgLs6PKDAXSYUgLz8g3RaaW1rXEoufrstANJBoCnRd+smWxlS8vlAtz
         I70AVxbNl6uFAWabIwTHWTIBNUkRQchp8KeD8pa59JeZM20lJGut87HDjuaHVGEtJ3li
         u2xiZckmry/HlJLJGmCFOQPQHwiAo96fl8fH3hpmZVdYcoNFpPh8CH14y1u8/c/ilWS6
         4mcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5nQK9vxcZoAxyVtrJNMhKbms5RoPN1FJ5YxhBX/Dlq8=;
        b=rIKTDHCbX9FWijiUHXmkYJwHJEZRw66A8FR3n3BFjncge2lIpmRFjVU1ruaIMEMtn8
         u33SJgwK/C8g92WSu7L8W0DB1ZngstvCCdl7kS6CfxC0KQv+IToQ0h09YM8gTrHFsd5W
         hTE8GGbjfm79e2ghKyuTwb9//lCF7dGOCFT0lh9OAauwmXaDFUCJm/5jMl1mn8zikDJU
         rMVShCqQ/NDXDdLrhX9Bq/hs8ptL//Q/OUaY9+7WELF6f1DXR9JDMrtS9eMFeSaQqD4C
         9wf4i7WfZyc47y8lVpEJI/BTwCtM/h/Se+E9d6tmive5q06ziQqB9tDbQJAK/6bD3fuL
         lMLQ==
X-Gm-Message-State: ALQs6tAsN63T4w1BZfnoyH/HC4epdyxKEI2ELapuo9eKISxnEbIptQKs
        9hQvFqUhQFDJDmM94MX/njo=
X-Google-Smtp-Source: AIpwx4/rpLsunNKkhz3SPUqOV97qRJS+a3qWmlSP/w7BhfON1cOFeWxdC1fDJBFzJsuK6P6D8cqsZw==
X-Received: by 2002:a17:902:6e8f:: with SMTP id v15-v6mr2897623plk.245.1523985807014;
        Tue, 17 Apr 2018 10:23:27 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id q9sm11573047pgs.5.2018.04.17.10.23.20
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Apr 2018 10:23:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Optimizing writes to unchanged files during merges?
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <8736zvf5gc.fsf@evledraar.gmail.com>
Date:   Tue, 17 Apr 2018 19:23:16 +0200
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, mgorny@gentoo.org,
        rtc@helen.PLASMA.Xg8.DE, winserver.support@winserver.com,
        tytso@mit.edu
Content-Transfer-Encoding: quoted-printable
Message-Id: <976C3B07-6396-4762-B6FF-4092B5D5D8C6@gmail.com>
References: <CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com> <xmqq604w2j4u.fsf@gitster-ct.c.googlers.com> <xmqqtvsg10bu.fsf@gitster-ct.c.googlers.com> <CA+55aFxA9YVLoh_23V8Hi+X7ODEmqg-dhdAYZz1jbq5JhXqBFw@mail.gmail.com> <CA+55aFwM2CaafNGq8_=GkYAw9inpm-4xcyHUmKprLv4Gb3-aVg@mail.gmail.com> <CA+55aFw5mpEcEpPTOWych-kjNLc8pEn8FdjJHe2u7HUBBLy-Fw@mail.gmail.com> <CA+55aFwwVZDetd-SobOzzLQW4_GEwm3krxEGR+cpqzkzK-yiwQ@mail.gmail.com> <CABPp-BHQsOSCJiPU9Ku5b67QTkAjnEBrhx04mTXf2QdPBriHmw@mail.gmail.com> <CA+55aFwi9pTAJT_qtv=vHLgu=B1fdXBoD96i8Y5xnbS=zrfSzg@mail.gmail.com> <xmqqbmekylgc.fsf@gitster-ct.c.googlers.com> <CA+55aFxP8j7YbYaRXt-8Y0n8cHafB=FPKMy8gKFYH5QsKX4S=Q@mail.gmail.com> <F1738316-71EF-4053-82E5-F009F491CCE8@gmail.com> <8736zvf5gc.fsf@evledraar.gmail.com>
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 16 Apr 2018, at 19:04, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>=20
>=20
> On Mon, Apr 16 2018, Lars Schneider wrote:
>=20
>>> On 16 Apr 2018, at 04:03, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>>>=20
>>> On Sun, Apr 15, 2018 at 6:44 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>>>=20
>>>> I think Elijah's corrected was_tracked() also does not care "has
>>>> this been renamed".
>>>=20
>>> I'm perfectly happy with the slightly smarter patches. My patch was
>>> really just an RFC and because I had tried it out.
>>>=20
>>>> One thing that makes me curious is what happens (and what we want =
to
>>>> happen) when such a "we already have the changes the side branch
>>>> tries to bring in" path has local (i.e. not yet in the index)
>>>> changes.  For a dirty file that trivially merges (e.g. a path we
>>>> modified since our histories forked, while the other side didn't do
>>>> anything, has local changes in the working tree), we try hard to
>>>> make the merge succeed while keeping the local changes, and we
>>>> should be able to do the same in this case, too.
>>>=20
>>> I think it might be nice, but probably not really worth it.
>>>=20
>>> I find the "you can merge even if some files are dirty" to be really
>>> convenient, because I often keep stupid test patches in my tree that =
I
>>> may not even intend to commit, and I then use the same tree for
>>> merging.
>>>=20
>>> For example, I sometimes end up editing the Makefile for the release
>>> version early, but I won't *commit* that until I actually cut the
>>> release. But if I pull some branch that has also changed the =
Makefile,
>>> it's not worth any complexity to try to be nice about the dirty =
state.
>>>=20
>>> If it's a file that actually *has* been changed in the branch I'm
>>> merging, and I'm more than happy to just stage the patch (or throw =
it
>>> away - I think it's about 50:50 for me).
>>>=20
>>> So I don't think it's a big deal, and I'd rather have the merge fail
>>> very early with "that file has seen changes in the branch you are
>>> merging" than add any real complexity to the merge logic.
>>=20
>> I am happy to see this discussion and the patches, because long =
rebuilds
>> are a constant annoyance for us. We might have been bitten by the =
exact
>> case discussed here, but more often, we have a slightly different
>> situation:
>>=20
>> An engineer works on a task branch and runs incremental builds =E2=80=94=
 all
>> is good. The engineer switches to another branch to review another
>> engineer's work. This other branch changes a low-level header file,
>> but no rebuild is triggered. The engineer switches back to the =
previous
>> task branch. At this point, the incremental build will rebuild
>> everything, as the compiler thinks that the low-level header file has
>> been changed (because the mtime is different).
>>=20
>> Of course, this problem can be solved with a separate worktree. =
However,
>> our engineers forget about that sometimes, and then, they are annoyed =
by
>> a 4h rebuild.
>>=20
>> Is this situation a problem for others too?
>> If yes, what do you think about the following approach:
>>=20
>> What if Git kept a LRU list that contains file path, content hash, =
and
>> mtime of any file that is removed or modified during a checkout. If a
>> file is checked out later with the exact same path and content hash,
>> then Git could set the mtime to the previous value. This way the
>> compiler would not think that the content has been changed since the
>> last rebuild.
>>=20
>> I think that would fix the problem that our engineers run into and =
also
>> the problem that Linus experienced during the merge, wouldn't it?
>=20
> Could what you're describing be prototyped as a post-checkout hook =
that
> looks at the reflog? It sounds to me like it could, but perhaps I've
> missed some subtlety.

Yeah, probably. You don't even need the reflog I think. I just wanted
to get a sense if other people run into this problem too.


> Not re-writing out a file that hasn't changed is one thing, but I =
think
> for more complex behaviors (such as the "I want everything to have the
> same mtime" mentioned in another thread on-list), and this, it makes
> sense to provide some hook mechanism than have git itself do all the
> work.
>=20
> I also don't see how what you're describing could be generalized, or
> even be made to work reliably in the case you're describing. If the
> engineer runs "make" on this branch he's testing out that might =
produce
> an object file that'll get used as-is once he switches back, since
> you've set the mtime in the past for that file because you re-checked =
it
> out.

Ohh... you're right. I thought Visual Studio looks *just* at ctime/mtime=20=

of the files. But this seems not to be true [1]:
=20
   "MSBuild to build it quickly checks if any of a project=E2=80=99s =
input files=20
    are modified later than any of the project=E2=80=99s outputs"

In that case my idea outlined above is garbage.

Thanks,
Lars


[1] =
https://blogs.msdn.microsoft.com/kirillosenkov/2014/08/04/how-to-investiga=
te-rebuilding-in-visual-studio-when-nothing-has-changed/=
