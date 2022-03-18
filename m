Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE58C433F5
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 13:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbiCRNnM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 09:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236759AbiCRNnK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 09:43:10 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E9C2D7AAE
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 06:41:51 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id a17so9268983edm.9
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 06:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=NYjATph9/K30Uq0MBWYLY1sR+w/yMoQJ5klHfP5myTc=;
        b=gAZG4oj0l2fwpwmogx41SCnCemTmctC+9NpOUe0bw4B/nU6sGGHEZUHFkBYZeF1BhD
         HMPvNrUgxANTBfUkWQFI6zJf/CuJp5AAt+x0nFhlsJIugv9Q2SNrrFMUU7Vm6dhqPpGz
         UNWDGdhuPcfQaxWP+IeIyoIr0xx4EjjvPXV8xHnjNN1Wk70GBvs2XyPwh/LVMg3OTshB
         jAeUGHBVPffVGDQBWCy9SXm6P/b56INiVOIbBtBKjBrpQYU6t/VAE/9DKgkPVH8bUe6k
         rB7JO0xvuc9memkQEiP90G25Lw0EtH3h0A9LzbjwxXGDkY641+sT9BC9CYdZQI2q/WTB
         FLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=NYjATph9/K30Uq0MBWYLY1sR+w/yMoQJ5klHfP5myTc=;
        b=5xp0m1MAaeISbGe3qdZ+AZpiHCYVoCwQQWxX590EO3Jt4vs7xvKjCh/zr/3fFy27K+
         zDI+FWEEGpS7Et6I6bos6cynL0vQ53au2IDXrAtv5+WhNu2+aWarcRGITfQkXTfGbbVE
         T6hfHaH/kLDQBo4QSBDPNleJ4X9fX8WzsL1M2WX1d4zhn8rUFkR+5fIi/EPdngDbMwKI
         8+bJ3l9lzxt4R5WlAqrb8w15lh3XG66M7i/b1KmsO0tPgraO4vhNzwfvPnRzxYbk9TVT
         jp1TNGemg+UBNrHBj7z7prHAB+ilxpcorFS7A6PfePfRTpo552h63aT1h46IWSLaO+t3
         SwwQ==
X-Gm-Message-State: AOAM5328TJ9wzDV8lXIuY8/Hz64FudLSrIdJmr8m4qZ31er1fqFftsbj
        lcdnA/q1+eKUOCPCriTvGMI=
X-Google-Smtp-Source: ABdhPJzVkhBn3ADRBK4tpE8r6Q5bQBnhMlPdWyFd4pLvx0Ed9ViZyr0gH6RAZTLAPJ+umbmz0EYESg==
X-Received: by 2002:a05:6402:516c:b0:419:92c:a2a with SMTP id d12-20020a056402516c00b00419092c0a2amr3931023ede.175.1647610909943;
        Fri, 18 Mar 2022 06:41:49 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b9-20020a056402278900b004186d013655sm4141357ede.33.2022.03.18.06.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 06:41:49 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nVCrU-002lXN-RU;
        Fri, 18 Mar 2022 14:41:48 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: C99 %zu support (on MSVC) (was: [PATCH 4/6] builtin/stash: provide
 a way to export stashes to a ref)
Date:   Fri, 18 Mar 2022 14:34:35 +0100
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220310173236.4165310-5-sandals@crustytoothpaste.net>
 <220311.86bkydi65v.gmgdl@evledraar.gmail.com>
 <2422376f-79aa-2d35-2646-c3611e2ef8d6@gmail.com>
 <YjJbJ9ZXlUAd2evC@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <YjJbJ9ZXlUAd2evC@camp.crustytoothpaste.net>
Message-ID: <220318.86bky3cr8j.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 16 2022, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> On 2022-03-14 at 21:19:10, Phillip Wood wrote:
>> Hi Brian and =C3=86var
>>=20
>> Firstly I think this is a useful feature to add to git stash, thanks for
>> working on it Brian
>
> Thanks.  I'm glad folks other than me will find it useful.
>
>> On 11/03/2022 02:08, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> >=20
>> > On Thu, Mar 10 2022, brian m. carlson wrote:
>> >=20
>> > > +	size_t author_len, committer_len;
>> > > +	struct commit *this =3D NULL;
>> > > +	const char *orig_author =3D NULL, *orig_committer =3D NULL;
>> > > +	char *author =3D NULL, *committer =3D NULL;
>> > > +	const char *buffer =3D NULL;
>> > > +	unsigned long bufsize;
>> > > +	const char *p;
>> > > +	char *msg =3D NULL;
>> >=20
>> > These shouldn't be initialized unless they really need to..
>> >=20
>> > > +	this =3D lookup_commit_reference(the_repository, &info->w_commit);
>> >=20
>> > ..and some are clobbered right away here, so all of these should not b=
e initializzed.
>
> This function got hoisted out of what would otherwise be duplicated
> code, and that's why they're all initialized (because we would otherwise
> have called free on an uninitialized value).  I can remove the ones that
> aren't strictly needed.
>
>> > > +	buffer =3D get_commit_buffer(this, &bufsize);
>> > > +	orig_author =3D find_commit_header(buffer, "author", &author_len);
>> > > +	orig_committer =3D find_commit_header(buffer, "committer", &commit=
ter_len);
>> > > +	p =3D memmem(buffer, bufsize, "\n\n", 2);
>>=20
>> You could start searching from orig_committer rather than buffer but I'm
>> sure it doesn't make any real difference. The sequencer does something
>> similar to this to replay commits when rebasing - is there any scope for
>> sharing code between the two?
>
> I can look into it.  The amount of code that would be duplicated here is
> very minimal, so I'm okay with just adding a few lines here.
>
>> > ...since by doing so we hide genuine "uninitialized"
>> > warnings. E.g. "author_len" here isn't initialized, but is set by
>> > find_commit_header(), but if that line was removed we'd warn below, but
>> > not if it's initialized when the variables are declared..
>> >=20
>> > > +		for (size_t i =3D 0;; i++, nitems++) {
>>=20
>> Do we need i and nitems?
>
> I can look into removing them.
>
>> > > +			char buf[32];
>> > > +			int ret;
>> > > +
>> > > +			if (nalloc <=3D i) {
>> > > +				size_t new =3D nalloc * 3 / 2 + 5;
>> > > +				items =3D xrealloc(items, new * sizeof(*items));
>> > > +				nalloc =3D new;
>> >=20
>> > Can't we just use the usual ALLOC_GROW() pattern here?
>> ALLOC_GROW_BY() zeros out the memory which would mean we could remove the
>> memset() calls in the loops. I noticed in some other loops we know the s=
ize
>> in advance and could use CALLOC_ARRAY().
>
> Yeah, I can switch to that.  I was looking for that, but I was thinking
> of a function and not a macro, so I missed it.
>
>> > > +			}
>> > > +			snprintf(buf, sizeof(buf), "%zu", i);
>> >=20
>> > Aren't the %z formats unportable (even with our newly found reliance on
>> > more C99)? I vaguely recall trying them recently and the windows CI jo=
bs
>> > erroring...
>>=20
>> According to [1] it has been available since at least 2015. It is certai=
nly
>> much nicer than casting every size_t to uintmax_t and having to use PRIu=
MAX.
>
> If we're relying on a new enough MSVC for C11, then it's much newer than
> 2015, so we should be fine.  It's mandatory on POSIX systems.

FWIW I dug into my logs and I ran into it with %zu (not %z), but that's
what you're using.

Sorry about being inaccurate, it seems %z's portability isn't the same
as %z.

I ran into it in mid-2021 in the GitHub CI, but those logs are deleted
now (and I didn't re-push that specific OID):

    https://github.com/avar/git/runs/2298653913

Where it would emit output like:

    builtin/log.c: In function 'gen_message_id':
    311
    builtin/log.c:1047:29: error: unknown conversion type character 'z' in =
format [-Werror=3Dformat=3D]
    312
     1047 |  strbuf_addf(&fmt, "%%s-%%0%zud.%%0%zud-%%s-%%s-%%s", tmp.len, =
tmp.len);

This SO post, whose accuracy I can't verify, claims it is supported in
VS 2013 or later, and that the way to check for it is with "_MSC_VER >=3D
1800":

    https://stackoverflow.com/questions/44382862/how-to-printf-a-size-t-wit=
hout-warning-in-mingw-w64-gcc-7-1

So if we are going to use it and that's true (which would be great!) it
would IMO make sense to introduce it in some prep commit where we delete
e.g. "_MSC_VER>=3D1310" and other things you'll see in-tree if you look
through:

    git grep _MSC_VER

I.e. to push out some canary commit for using that specific feature, and
along with it delete the old MSVC compatibility shims (which presumably
we can't use if we're going to hard depend on %zu).
