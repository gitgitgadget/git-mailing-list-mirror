Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92694C4332F
	for <git@archiver.kernel.org>; Wed,  4 Jan 2023 06:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjADG6F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Jan 2023 01:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjADG6E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2023 01:58:04 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846FCDFD0
        for <git@vger.kernel.org>; Tue,  3 Jan 2023 22:58:03 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 7so21650752pga.1
        for <git@vger.kernel.org>; Tue, 03 Jan 2023 22:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ddz8I0DOPlpCOFtVNj8I4/iQpFlAL90gFr2Ox5HTyBM=;
        b=IXz5OYrEKw6i6HGhc71C4WyAbh6XM0xMAobiNh0keLE/s8Z1timJ7VP/P+YY8IcHxO
         fVe+k2ml/ko2x2y2VtQbxrL64nk8R7Lqg6CYZQgV1BP2r0xmsRs9e9DfgzO277HcqAjO
         YsjDpeZRk3AALedUX6R0V0wuRZ8ltDuLs63MoT6uuYTJBRwRy9jOvu5k6Wd1k2Ubyq88
         oFjxNaHltPbGtF0zkd1f1mbJ//N6KpAnKIDGhcXse18vnjxQqB9CcalLx+7fh6pr5RL9
         dxqvrVQYDe6xncNXtv9SMFeVG394Ul3HVTmYvYITeYq1Jb7ZWsMsq0PX3omXfVEW1mIW
         qxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ddz8I0DOPlpCOFtVNj8I4/iQpFlAL90gFr2Ox5HTyBM=;
        b=5PsS70xNvpVv+4KRIgZVlkBFVu6BPI+HYatILzT5/Qlp1b07uFdSPKNF0mPxsmxb79
         NLxUlWw87cwuH2gXA7ZSYq/kQIS5pllfiWwJsML8Q+YbfJX+Wem/QGCEJzUKxRvVy2VF
         b1HKCPhqxamvIwhjn4b1NvzZibML2jQYGthPbReGubcqgJWRVQgAzsrxebBFj0kFBYUH
         iKyj6JLIbKjeEh68ntCmeKamjYq7bk4a5/6prpagvggblPD6/7WuRIcNapakO18tZVrN
         fL3GIz21wxpITYXFMHRoFQ7LgWuEsGvRa/6BYU6N4UDoJ6I6bPuhA3RkORhAse/d1hNn
         a6Hw==
X-Gm-Message-State: AFqh2ko9RsJ0QKP4OidlS+Vnb9Bl4C7cUY/MGv5sf+6jA+kM5yLq1KcI
        t0bZq2ETVOVfNCeOXd8F3klz+opZqAcFqw==
X-Google-Smtp-Source: AMrXdXuQKA0l35hNQB42pziSRrnNKTeZWwMJwl9GQDGfiGsuLLC3i6zDm+8Jg9P3n9q92oUkU1qdTA==
X-Received: by 2002:a62:506:0:b0:56d:d678:aecd with SMTP id 6-20020a620506000000b0056dd678aecdmr45853043pff.23.1672815482927;
        Tue, 03 Jan 2023 22:58:02 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y9-20020a62ce09000000b00574866d619asm10054058pfg.119.2023.01.03.22.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 22:58:02 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/2] branch: description for orphan branch errors
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
        <dd86016b-3232-563b-940e-03bc36af917a@gmail.com>
        <xmqqy1qmhq8k.fsf@gitster.g>
        <18ca1e65-3e26-8352-cabd-daebdd0cf7f2@gmail.com>
Date:   Wed, 04 Jan 2023 15:58:02 +0900
Message-ID: <xmqqr0wau6px.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo <rjusto@gmail.com> writes:

> On 01-ene-2023 12:45:47, Junio C Hamano wrote:
>> Rubén Justo <rjusto@gmail.com> writes:
>> 
>> Isn't branch_checked_out() a fairly heavyweight operation when you
>> have multiple worktrees?  The original went to the filesystem
>> (i.e. check ref_exists()) only after seeing that a condition that
>> can be computed using only in-core data holds (i.e. the branch names
>> are the same or we are doing a copy), which is an optimum order to
>> avoid doing unnecessary work in most common cases, but I am not sure
>> if the order the checks are done in the updated code optimizes for
>> the common case.  If branch_checked_out() is more expensive than a
>> call to ref_exists() for a single brnch, that would change the
>> equation.  Calling such a heavyweight operation twice would make it
>> even more expensive but that is a perfectly fine thing to do in the
>> error codepath, inside the block that is entered after we noticed an
>> error condition.
>
> I share your concern, I thought about it.
>
> My thoughts evaluating the change were more or less:
>
>  - presumably there should be many more references than worktrees, and
>    more repositories with 0 or 1 workdirs than more, so, arbitrarily,
>    calling ref_exists() last still sounds sensible
>
>  - strcmp() to branch_checked_out() introduces little change in the
>    logic
>
>  - I like branch_checked_out(), it expresses better what we want there
>
>  - branch_checked_out() considers refs, strcmp considers branch names
>    (we have a corner case with @{-1} pointing to HEAD, that this
>    resolves)
>
>  - finally, perhaps branch_checked_out() has optimization possibilities.
>    Maybe in the common case we can get close to the amount of work we
>    are doing now.  Here we can alleviate a bit by removing the
>    unconditional resolve_refdup(HEAD) we are doing at the beginning of
>    cmd_branch().
>
> In the end, it seems to me that we have some places where we are
> considering HEAD and we may need to consider HEADs.

I am not sure what you share with me after reading the above,
though.  As I already said, I am not opposed to the use of
branch_checked_out(), or checking the state of other worktrees
connected to the same repository, at all.

I was merely looking at this:

> -	if ((copy || strcmp(head, oldname)) && !ref_exists(oldref.buf)) {
> -		if (copy && !strcmp(head, oldname))
> +	if ((copy || !branch_checked_out(oldref.buf)) && !ref_exists(oldref.buf)) {

and wondering if the evaluation order to call branch_checked_out()
unconditionally and then calling ref_exists() still makes sense, or
now the strcmp() part of the original has become so much more
costly, if we are better off doing the same thing in a different
order, e.g.

	if (!ref_exists(oldref.buf) && (copy || !branch_checked_out(oldref.buf))) {

>> Do we already cover existing "No branch named" case the same way in
>> this test script, so that it is OK for these new tests to cover only
>> the "not yet" cases?  I am asking because if we have existing
>> coverage, before and after the change to the C code in this patch,
>> some of the existing tests would change the behaviour (i.e. they
>> would have said "No branch named X" when somebody else created an
>> unborn branch in a separate worktree, but now they would say "No
>> commit on branch X yet"), but I see no such change in the test.  If
>> we lack existing coverage, we probably should --- otherwise we would
>> not notice when somebody breaks the command to say "No commit on
>> branch X yet" when it should say "No such branch X".
>
> I think we do, bcfc82bd (branch: description for non-existent branch
> errors).

If we already have checks that current code triggers the "no branch
named X" warning, and because the patch is changing the code to give
that warning to instead say "branch X has no commits yet" in some
cases, if the existing test coverage were thorough, some of the
existing tests that expect "no branch named X" warning should now
expect "branch X has no commits yet" warning.  Your patch did not
have any such change in the tests, which was an indication that the
existing test coverage was lacking, no?

And given that, do we now have a complete test coverage for all
cases with the patch we are discussing?

Thanks.

