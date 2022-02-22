Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53246C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 11:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiBVLI5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 06:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiBVLIi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 06:08:38 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927D1CFB96
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 03:08:07 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a8so41831578ejc.8
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 03:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ueeq5ZAwFhbXCNC1jBCOVNx48uraf/BsLnXLmnjq9j0=;
        b=Dsqtb+9CoygnTtQNZXZPUyQfK2Ar4ZD6rNjUEoHMyBroX87XWuwIcrHbmXR3b9JbVt
         +aCvV3KXj8xel2ZK5LsVCKhOWnz+i6vRz+C63k+bbfOgmtQeZQyQJHX6E1ZPmsMJ55fF
         cN4ENbq/J0lzoAsjsyCzgtjqBDZNryBa9UfF3Jle2Jf96LQwUXZdHLJAmwx5ovFXf9gC
         WKBmJoOI0k7P7PjxNfgWBJLFk4Q16H2JFRkekPG9O/WhB/S2yty8xFTOHq5BSZlSnrOD
         e80um16gsqIKKg2/M+8tN6un2SZnV/q0/ji7GsgUI159uhXds++0bFJmCYxH0kQOVJ+O
         ZBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ueeq5ZAwFhbXCNC1jBCOVNx48uraf/BsLnXLmnjq9j0=;
        b=DXgslfGg48QWt8CRlbEzMMEKa39dq7LqA1ihqz6pr6CFYlUGVq/2GEsjcmdceOkYOb
         uOIj+t0Iw+tKSZaA6pzZKGC7ndH1CC6A1AQVYR3uCYququaRQ4W/bEr5I5kug/Maua9K
         d7bowkpnVTuK58p+crIR/qBjDwu5HiBpykB/lqoyHwKhWK/LSGYXqQutzCq6lFJHaBf+
         DcPBDHmm+fBrVo0VK0iiwgeKG2p1tzrWVLdXbFuroohJ4L857OASA8jngn4t4+O6qysr
         +FzNJmq5tsK94PyTghHsU9cNvVnIujvOuWhZJVHko7P/5VJ6gRSUHLEvUQyuPGL/QwK0
         5ggQ==
X-Gm-Message-State: AOAM532X6TejkP41jY0K0j4e3+ML8PDG5NFKsyLKKjPu6mNNUZUaTnES
        RQJJ3Qub3AedmHJeRCofE0z6lhutaD7YZyOg
X-Google-Smtp-Source: ABdhPJxkWzYA4DJ4XSD4f1hpWmJbYTwppofwUJ3vv3qYTRPhfeM8C6XMilXM/mrO7CFs2+vBzaFrGg==
X-Received: by 2002:a17:906:3152:b0:6cf:d100:a8b2 with SMTP id e18-20020a170906315200b006cfd100a8b2mr19061061eje.529.1645528085892;
        Tue, 22 Feb 2022 03:08:05 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 27sm6124682eji.66.2022.02.22.03.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 03:08:05 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMT1Y-005yn3-NM;
        Tue, 22 Feb 2022 12:08:04 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     John Cai <johncai86@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] stash: call reflog_delete from reflog.c
Date:   Tue, 22 Feb 2022 11:51:19 +0100
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
 <bcc1eae053124f6e68f60a7a02cbee4744a022f0.1645209647.git.gitgitgadget@gmail.com>
 <220218.86o834gej9.gmgdl@evledraar.gmail.com>
 <DAF4762E-6376-44BC-9E8C-B9C32B65D92B@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <DAF4762E-6376-44BC-9E8C-B9C32B65D92B@gmail.com>
Message-ID: <220222.86fsob88h7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 21 2022, John Cai wrote:

> Hi =C3=86var,
>
> On 18 Feb 2022, at 14:20, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Fri, Feb 18 2022, John Cai via GitGitGadget wrote:
>>
>>> From: John Cai <johncai86@gmail.com>
>>>
>>> Now that cmd_reflog_delete has been libified an exported it into a new
>>> reflog.c library so we can call it directly from builtin/stash.c. This
>>> not only gives us a performance gain since we don't need to create a
>>> subprocess, but it also allows us to use the ref transactions api in the
>>> future.
>>>
>>> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>>> Signed-off-by: John Cai <johncai86@gmail.com>
>>
>> Very nicely done, and nice that despite the ~500 lines added/removed in
>> the diffstat that the "actual" changes in this series are so small.q
>>
>>> @@ -635,18 +636,9 @@ static int reflog_is_empty(const char *refname)
>>>  static int do_drop_stash(struct stash_info *info, int quiet)
>>>  {
>>>  	int ret;
>>> -	struct child_process cp_reflog =3D CHILD_PROCESS_INIT;
>>> -
>>
>> Nit: We usually separate variables decls with a \n\n, as is done in the
>> pre-image, but you end up dropping that.
>>
>>> -	/*
>>> -	 * reflog does not provide a simple function for deleting refs. One w=
ill
>>> -	 * need to be added to avoid implementing too much reflog code here
>>> -	 */
>>> -
>>> -	cp_reflog.git_cmd =3D 1;
>>> -	strvec_pushl(&cp_reflog.args, "reflog", "delete", "--updateref",
>>> -		     "--rewrite", NULL);
>>> -	strvec_push(&cp_reflog.args, info->revision.buf);
>>> -	ret =3D run_command(&cp_reflog);
>>> +	ret =3D reflog_delete(info->revision.buf,
>>> +			    EXPIRE_REFLOGS_REWRITE | EXPIRE_REFLOGS_REWRITE,
>>> +			    0);
>>>  	if (!ret) {
>>>  		if (!quiet)
>>>  			printf_ln(_("Dropped %s (%s)"), info->revision.buf,
>>
>> I think per the above squashing this in would be nice, i.e. you get rid
>> of the long line & it'sclear that "ret" is not used for anything now:
>>
>> diff --git a/builtin/stash.c b/builtin/stash.c
>> index d0967b3d3c3..7b939576720 100644
>> --- a/builtin/stash.c
>> +++ b/builtin/stash.c
>> @@ -635,11 +635,9 @@ static int reflog_is_empty(const char *refname)
>>
>>  static int do_drop_stash(struct stash_info *info, int quiet)
>>  {
>> -	int ret;
>> -	ret =3D reflog_delete(info->revision.buf,
>> -			    EXPIRE_REFLOGS_REWRITE | EXPIRE_REFLOGS_REWRITE,
>> -			    0);
>> -	if (!ret) {
>> +	unsigned int flags =3D EXPIRE_REFLOGS_REWRITE | EXPIRE_REFLOGS_REWRITE;
>> +
>> +	if (!reflog_delete(info->revision.buf, flags, 0)) {
>>  		if (!quiet)
>>  			printf_ln(_("Dropped %s (%s)"), info->revision.buf,
>>  				  oid_to_hex(&info->w_commit));
>>
>> But, having written that I notice that we have *_REWRITE twice there, so
>> I almost just carried forward a new bug in 3/3 when composing this :)
>>
>> So one should be EXPIRE_REFLOGS_UPDATE_REF, presumably.
>>
>> And perhaps it's a big pain, but that suggests that the code isn't
>> either used at all, or that we're missing a test for it.
>>
>> So adding a prep commit to this series where we either drop it, or add
>> the missing test would be a very nice addition.
>>
>> See my quite recent 5ac15ad2509 (reflog tests: add --updateref tests,
>> 2021-10-16) for adding such tests, but in that case I just covered "git
>> reflog" itself, not "git stash". Maybe we can just add something to that
>> for-loop in t1417 (or similar for a new stash test).
>
> So I was trying to write a test to exercise the reflog --updateref and --=
rewrite
> cases. --updateref is pretty straightforward, but with --rewrite I notice=
d that
> it rewrites the old sha in the .git/log/refs/stash file. But, I was having
> trouble finding somewhere that read this value. The test could reach into=
 this file
> and check the literal contents, but wondering if there is a better way. A=
ny help appreciated!

I can check it out, but to make that easier can you share the WIP diff
you have for getting the test setup that far?

I think you mean that it munges the SHA-1 on the LHS of
.git/refs/logs/stash, I tried to do that now locally and I didn't come
up with some way where you could observably make "git stash show", "git
stash list" etc. show anything different.

I.e. it'll just promiscuously show whatever OID is on the RHS, even in
cases where some of them are turned into "deadbeef..." (i.e. "list", but
"show" will die).

So maybe it's just observable with a subsequent "git fsck", but I just
tried composing a reflog with these entries:

    0000000000000000000000000000000000000000 A
    A B
    B C

And then manually changing it to:

    0000000000000000000000000000000000000000 A
    A B
    A C

Which "git fsck" will pass, and only complain if that "A" isn't a valid
OID at all.

Anyway, if there isn't a way to get fsck/reflog to spew it out, but we
want to assert that it's correct wouldn't this catch it (will need to
depend on REFFILES) (untested):

	cut -d' ' -f1-2 .git/logs/refs/stash >actual &&
	cat >expect <<-EOF &&
	$(test_oid zero) $(git rev-parse ...)
	$(git rev-parse ...) $(git rev-parse ...)
	EOF
	test_cmp expect actual

I.e. to simply run whatever operation we do now, check that the OIDs
match what we expect, and which would be different if one of these flags
wasn't given?

>>
>> Also, a s/unsigned int flags/enum expire_reflog_flags/ while we're at it
>> would be very nice here, but that could be done as another small prep
>> commit. I.e. it's *not* a new issue since cmd_reflog_delete() had it
>> before, but when converting this to a documented API it would be very
>> nice to have it reflect the actual type we end up using.

