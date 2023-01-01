Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE24FC4332F
	for <git@archiver.kernel.org>; Sun,  1 Jan 2023 03:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjAADpw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Dec 2022 22:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjAADpu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2022 22:45:50 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D81BE63
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 19:45:48 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id fy4so26651053pjb.0
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 19:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QH+HugJArEskCgKN0B7F35R4UEGp05GowZ8NpzO/MAk=;
        b=fpf24/8A3HUw1utSFD6daHO5pWUG2HQ+kfiS9eyoZTDXDe04nHBZspmLOO5e5Qy6r7
         3FNmSBia/+MVEoZSjBY8ibUmiXRxEx7/0G/p/OPHhcgxEfJYVCw4aFPCR+3fIzfPFcWa
         slG7dOfyxqRShnUJVQ7zcu4etCJyKsx5a7jVEVDf8+alIvB0RD82yDRYEoUQlnMBVOgl
         JC9j0dbBAkVaJNrjILVjckh/twLw9gLVElcZF5k7ojxRSwd/caQ1gwyiDivPDf1p/cUX
         uwqKF1D45SYnr7ZjvSMRvVKEJl+/9TcA2xQQrtW7O0fiAt9WqQWmiSko1Q9yWx3xxftz
         2M+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QH+HugJArEskCgKN0B7F35R4UEGp05GowZ8NpzO/MAk=;
        b=u3Z0sYZhupwKcGnOOS8bdq10Vk0KU6ZlYytefkoNUUJ2Jh6Mm29dcTj61aNfzIOgVp
         JgvKyXMgFHs9Y6n0/SRl0cmyPPXzHoP9WAjfFw/nBKSFRsrIFFL/QyvU4lKEbrQ/g7Pe
         DWO/JNiuAb931p2Kso+/UuazmxIcwZzX+MRuvpW4Uihvks9FNIMPxRhuDbwLQRqHWwaC
         ldz40GNWd9jxfbGV6kIBNVOlfFEKZ2Kz8yKV0nMGeI6H7N1x4X6wDzT5JRLMr7/64aDH
         QrJYVzCjeQjceMGqrnuP/mAp6B2fd0AHot8DBZDZ/QixvaW5Krsyt+HqCSoipZRQe1O2
         fyQg==
X-Gm-Message-State: AFqh2kpTrZ8tRDvHXoAL1HTWpqsCD1sYQw/vpFSXz86OQGBuINTsq21u
        GJndjOhKoLGDTSc9DfDvFDE=
X-Google-Smtp-Source: AMrXdXuuGgIp9Pl8Olsh+TyQ6DsrkODVpK8qGjDuJyFwHdZP3is/O6EM84Tn3i90JUhn1pyBXTyKSw==
X-Received: by 2002:a05:6a21:2d85:b0:aa:7ed2:6f39 with SMTP id ty5-20020a056a212d8500b000aa7ed26f39mr67006656pzb.41.1672544747776;
        Sat, 31 Dec 2022 19:45:47 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id n12-20020a63e04c000000b00478162d9923sm14638330pgj.13.2022.12.31.19.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 19:45:47 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/2] branch: description for orphan branch errors
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
        <dd86016b-3232-563b-940e-03bc36af917a@gmail.com>
Date:   Sun, 01 Jan 2023 12:45:47 +0900
In-Reply-To: <dd86016b-3232-563b-940e-03bc36af917a@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Sat, 31 Dec 2022 00:04:51 +0100")
Message-ID: <xmqqy1qmhq8k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo <rjusto@gmail.com> writes:

> In bcfc82bd48 (branch: description for non-existent branch errors,
> 2022-10-08) we used "strcmp(head, branch)" to check if we're asked to
> operate in a branch that is the current HEAD, and
> "ref_exists(branch_ref)" to check if it points to a valid ref, i.e. it
> is an orphan branch.  We are doing this with the intention of avoiding
> the confusing error: "No branch named..."

I agree that it is good to notice "the user thinks the branch should
already exist, for they have 'checked out' that branch, but there is
no commit on the branch yet".  I am not sure checked out on a separate
worktree as an unborn branch is always the indication that the user
thinks the branch should exist (e.g. "you allowed somebody else, or
yourself, prepare a separate worktree to work on something a few
weeks ago, but no single commit has been made there and you forgot
about the worktree---should the branch still exist?"), but that is a
separate topic.  Let's assume that the two are equivalent.

> diff --git a/builtin/branch.c b/builtin/branch.c
> index f63fd45edb..954008e51d 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -528,8 +528,8 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
>  			die(_("Invalid branch name: '%s'"), oldname);
>  	}
>  
> -	if ((copy || strcmp(head, oldname)) && !ref_exists(oldref.buf)) {
> -		if (copy && !strcmp(head, oldname))
> +	if ((copy || !branch_checked_out(oldref.buf)) && !ref_exists(oldref.buf)) {
> +		if (copy && branch_checked_out(oldref.buf))
>  			die(_("No commit on branch '%s' yet."), oldname);
>  		else
>  			die(_("No branch named '%s'."), oldname);

Isn't branch_checked_out() a fairly heavyweight operation when you
have multiple worktrees?  The original went to the filesystem
(i.e. check ref_exists()) only after seeing that a condition that
can be computed using only in-core data holds (i.e. the branch names
are the same or we are doing a copy), which is an optimum order to
avoid doing unnecessary work in most common cases, but I am not sure
if the order the checks are done in the updated code optimizes for
the common case.  If branch_checked_out() is more expensive than a
call to ref_exists() for a single brnch, that would change the
equation.  Calling such a heavyweight operation twice would make it
even more expensive but that is a perfectly fine thing to do in the
error codepath, inside the block that is entered after we noticed an
error condition.

> +test_expect_success 'error descriptions on orphan or unborn-yet branch' '
> +	cat >expect <<-EOF &&
> +	error: No commit on branch '\''orphan-branch'\'' yet.
> +	EOF
> ...
> +'
> +
> +test_expect_success 'fatal descriptions on orphan or unborn-yet branch' '
> +	cat >expect <<-EOF &&
> +	fatal: No commit on branch '\''orphan-branch'\'' yet.
> +	EOF
> ...
> +'

Do we already cover existing "No branch named" case the same way in
this test script, so that it is OK for these new tests to cover only
the "not yet" cases?  I am asking because if we have existing
coverage, before and after the change to the C code in this patch,
some of the existing tests would change the behaviour (i.e. they
would have said "No branch named X" when somebody else created an
unborn branch in a separate worktree, but now they would say "No
commit on branch X yet"), but I see no such change in the test.  If
we lack existing coverage, we probably should --- otherwise we would
not notice when somebody breaks the command to say "No commit on
branch X yet" when it should say "No such branch X".

