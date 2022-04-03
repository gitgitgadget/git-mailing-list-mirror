Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11CEC433EF
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 14:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358981AbiDCOC5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 10:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237059AbiDCOCq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 10:02:46 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEB037A3B
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 07:00:51 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id q26so509256edc.7
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 07:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=AvrYjWAywaP8EtfJlAa0VsVWsktXSSjpQUE2LtVmgCw=;
        b=pOBK8m5xcDzEJplCYcNorBH1ZpHz2vBZsu+qVW1y4OKAIfkkl+5G9iJKdoO2+JJLrg
         pPw6d7SynTPKEnVZKWjJq0J275+5e5LsA0aTnE8lDwvwbqKfOgEk+W0SKQx9KRtiB8of
         7iNmoagPHn7h2VDPvDQspDyNFJVjMGjguwEn8JPDswMth3sK9gh0t5Kb6zawvBZCDmBf
         tVQGjqyoMMyqqei7P7to5aSFSEyfr/kKXLJ/bL98E5xtArp898KYrV74T6EH5VuAJs0a
         RnAF9CFP0EwHcGHSLCfYaKMYsHWe2WSmmIcUQU6t3rYgWl5QeolyePDyK7+g/DbGoqC6
         tSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=AvrYjWAywaP8EtfJlAa0VsVWsktXSSjpQUE2LtVmgCw=;
        b=vjLIWyxL6/1som9fDy4rBiY1XaPmioBrIXDQyF4DotOkuQqp8ZzP0ePllTgqFFwvzW
         D7utqzfrtvkwPWxyXGhU/Q1+GRYLSuvMUO9aez8MFLbBSRgZlg4PvuxEqAukxPBpX4jS
         Ai6O9CYZw6okLot69fS1RfFPpaZRm6sC+zeoJsEl+4dmdHHPG7YIRbwnMynszs159Vwm
         xLhPEVQWnxVNtrA4Mboy1oHWd9zig6vHyy9ugMkugl/j+XjPf7uDplBpq8kF/dWFJqbv
         ETUXNEDvdI//RrEBI+AomBqbbyCxLrhPIhTDHFIKI2+KED0dW2hCM84GDYdqv/b7h8D/
         ZamA==
X-Gm-Message-State: AOAM532sIspCCwDSAXuXjEV6dnT85tdMF/5jyhNCB5rKqBXs/KHuQz25
        n+GSEKkgBJKW78LwKjUnB8vsBH3+HPo=
X-Google-Smtp-Source: ABdhPJyUs/E+fU5+vjPl/LtBoX9yKZBWKPiNPl6OYw+0pEfkKeslSGjkPQqwZwQqIQDyAMx5mOE4bg==
X-Received: by 2002:aa7:d9d1:0:b0:41c:bd61:b076 with SMTP id v17-20020aa7d9d1000000b0041cbd61b076mr4035395eds.41.1648994449911;
        Sun, 03 Apr 2022 07:00:49 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y14-20020a056402440e00b00416046b623csm4019020eda.2.2022.04.03.07.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 07:00:49 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nb0me-002Dm2-PG;
        Sun, 03 Apr 2022 16:00:48 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v5 17/27] revisions API: have release_revisions()
 release "mailmap"
Date:   Sun, 03 Apr 2022 15:57:48 +0200
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
 <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
 <patch-v5-17.27-ca659940ee5-20220402T102002Z-avarab@gmail.com>
 <5044b964-0605-356c-3e03-1aad8cbbe619@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <5044b964-0605-356c-3e03-1aad8cbbe619@gmail.com>
Message-ID: <220403.86ilrqmflb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 03 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> On 02/04/2022 11:49, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Extend the the release_revisions() function so that it frees the
>> "mailmap" in the "struct rev_info".
>> The log family of functions now calls the clear_mailmap() function
>> added in fa8afd18e5a (revisions API: provide and use a
>> release_revisions(), 2021-09-19), allowing us to whitelist some tests
>> with "TEST_PASSES_SANITIZE_LEAK=3Dtrue".
>> Unfortunately having a pointer to a mailmap in "struct rev_info"
>> instead of an embedded member that we "own" get a bit messy, as can be
>> seen in the change to builtin/commit.c.
>> When we free() this data we won't be able to tell apart a pointer to
>> a
>> "mailmap" on the heap from one on the stack. As seen in
>> ea57bc0d41b (log: add --use-mailmap option, 2013-01-05) the "log"
>> family allocates it on the heap, but in the find_author_by_nickname()
>> code added in ea16794e430 (commit: search author pattern against
>> mailmap, 2013-08-23) we allocated it on the stack instead.
>> Ideally we'd simply change that member to a "struct string_list
>> mailmap" and never free() the "mailmap" itself, but that would be a
>> much larger change to the revisions API.
>
> I agree it makes sense to leave that for now
>
>> We have code that needs to hand an existing "mailmap" to a "struct
>> rev_info", while we could change all of that, let's not go there
>> now.
>> The complexity isn't in the ownership of the "mailmap" per-se, but
>> that various things assume a "rev_info.mailmap =3D=3D NULL" means "doesn=
't
>> want mailmap", if we changed that to an init'd "struct string_list
>> we'd need to carefully refactor things to change those assumptions.
>> Let's instead always free() it, and simply declare that if you add
>> such a "mailmap" it must be allocated on the heap. Any modern libc
>> will correctly panic if we free() a stack variable, so this should be
>> safe going forward.
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>   builtin/commit.c                   | 5 ++---
>>   revision.c                         | 9 +++++++++
>>   t/t0056-git-C.sh                   | 1 +
>>   t/t3302-notes-index-expensive.sh   | 1 +
>>   t/t4055-diff-context.sh            | 1 +
>>   t/t4066-diff-emit-delay.sh         | 1 +
>>   t/t7008-filter-branch-null-sha1.sh | 1 +
>>   7 files changed, 16 insertions(+), 3 deletions(-)
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index c7eda9bbb72..cd6cebcf8c8 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -1100,7 +1100,6 @@ static const char *find_author_by_nickname(const c=
har *name)
>>   	struct rev_info revs;
>>   	struct commit *commit;
>>   	struct strbuf buf =3D STRBUF_INIT;
>> -	struct string_list mailmap =3D STRING_LIST_INIT_NODUP;
>>   	const char *av[20];
>>   	int ac =3D 0;
>>   @@ -1111,7 +1110,8 @@ static const char
>> *find_author_by_nickname(const char *name)
>>   	av[++ac] =3D buf.buf;
>>   	av[++ac] =3D NULL;
>>   	setup_revisions(ac, av, &revs, NULL);
>> -	revs.mailmap =3D &mailmap;
>> +	revs.mailmap =3D xmalloc(sizeof(struct string_list));
>> +	string_list_init_nodup(revs.mailmap);
>
> This is a common pattern in one of the previous patches, is it worth
> adding helpers to allocate and initialize a struct string_list? Maybe=20
> string_list_new_nodup() and string_list_new_dup().

Maybe, but generally in the git codebase things malloc and then init(),
if we're going to add something like this *_new() that would be a change
for a lot more APIs than just mailmap.

And if it's just for mailmap I don't see how the inconsistency with
other code would be worth it.

>>   	read_mailmap(revs.mailmap);
>>     	if (prepare_revision_walk(&revs))
>> @@ -1122,7 +1122,6 @@ static const char *find_author_by_nickname(const c=
har *name)
>>   		ctx.date_mode.type =3D DATE_NORMAL;
>>   		strbuf_release(&buf);
>>   		format_commit_message(commit, "%aN <%aE>", &buf, &ctx);
>> -		clear_mailmap(&mailmap);
>>   		release_revisions(&revs);
>>   		return strbuf_detach(&buf, NULL);
>>   	}
>> diff --git a/revision.c b/revision.c
>> index 553f7de8250..622f0faecc4 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -2926,10 +2926,19 @@ int setup_revisions(int argc, const char **argv,=
 struct rev_info *revs, struct s
>>   	return left;
>>   }
>>   +static void release_revisions_mailmap(struct string_list
>> *mailmap)
>> +{
>> +	if (!mailmap)
>> +		return;
>> +	clear_mailmap(mailmap);
>> +	free(mailmap);
>> +}
>
> It's not a big issue but if there are no other users of this then it
> could just go inside release_revisions, my impression is that this=20
> series builds a collection of very small functions whose only caller
> is release_revisions()

Yes, these are just trivial static helpers so that each line in
release_revisions() corresponds to a member of the struct, without
loops, indentation for "don't free this" etc.

To the machine code it makes no difference at higher optimization
levels.
