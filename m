Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 048961F453
	for <e@80x24.org>; Fri, 26 Apr 2019 04:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbfDZE7t (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 00:59:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38289 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfDZE7t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 00:59:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id w15so2410151wmc.3
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 21:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fDqX1zSiHILLWiT4wkVZhk98Et8EsWqEcwLJTkp9aB8=;
        b=r05xr4AffkJAZpK7XD2gTcYhmdTrSaGN81mWgh5LN8kaBECrmlXM0+s4EIBSFbk1F6
         udNk10+3dqqMMI3xltbRSzN7ShSVY2T1FEcvB8ZLKw9NLS2C2yct4U26KABYlfjNYPIh
         EnEtrtjORNzDRmdM+zG4pTzt9SFnQhLq9PjfDlODnOV0piTv8X4AHaix9ZvgH/5DT1LJ
         wK+EDO8vYOrTQpWvnRIR4kqSgA/T04Ny0l8rz0wlK7iB9p8WAR2WU6w/wPaTx5KElRew
         jaJYrqafxoeVrTwFGhQvUDZtPaHYD6vViMCe0hAPfi2TC/xQfgg/jkI4Z609f1+FDD4N
         1bYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fDqX1zSiHILLWiT4wkVZhk98Et8EsWqEcwLJTkp9aB8=;
        b=sXIMwXuommyEalqIs1XdKymnMbezhEKEv3YG2oDHllj6GlIt/2lMzUyxpv6lkT8/gk
         P17GQ7pkleVqtj/IcS4MQhZZGuJR/1rIzcKCaHwwPHuFGr/1R0vJnKSDn5IbUsNwNOSZ
         mPSU7TF7J+g4smmkzuLUUtcVfaAxY7nsDZKujQ/9Su7Wr6QXQh1drh2jWjmXSAQFVWFX
         y/hLPOW0m2ufdjko4U4fkP+sy9Qd6Dya+A29sQUvUOGhatheofl3VfNM8bI2IvzpJO9E
         ZO59aKVr0Ddmt3wUWEChgSpJ6/kXgRU5zCCm5x7oYi9/e2r+AckVp3CxUU7rnMUIswsI
         riUA==
X-Gm-Message-State: APjAAAU9oSwT1N0VuVBp4xh0TIHzpRaXOk3Q4hJ+FKHrxECyOO0S/JMN
        BnXKDB45Z3HJFVNmg29ecPc=
X-Google-Smtp-Source: APXvYqzKQUeywwkIuzmvRCuyjxZ4k8jOZxTykJKteyhp7wPHxYCb2DV4wPN0pV7PhbJdXoOuFUwbRg==
X-Received: by 2002:a1c:ef08:: with SMTP id n8mr6263664wmh.85.1556254787338;
        Thu, 25 Apr 2019 21:59:47 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id a13sm8244052wmj.39.2019.04.25.21.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 21:59:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] checkout: allow -b/-B to work on a merge base
References: <cover.1556226502.git.liu.denton@gmail.com>
        <031780431d790c16b3862d6f155693e197bb74ed.1556226502.git.liu.denton@gmail.com>
        <xmqqmukdv57q.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 26 Apr 2019 13:59:45 +0900
In-Reply-To: <xmqqmukdv57q.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 26 Apr 2019 12:02:49 +0900")
Message-ID: <xmqqh8aluzsu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Denton Liu <liu.denton@gmail.com> writes:
>
>> -	new_branch_info->name = arg;
>> +	new_branch_info->name = strstr(arg, "...") ?
>> +		xstrdup(oid_to_hex(rev)) :
>> +		arg;
>
> Can we do better?
>
> I am not sure why we want to hardcode the knowledge of "..." syntax
> like this here.  "git checkout A...B" introduced in 2009 needed only
> a single-liner change from get_sha1() to get_sha1_mb() without making
> the ugly implementation detail seep into this layer.

I _think_ what you are trying to work around is that a syntax that
is not understood as a reference to a single revision by get_oid()
but is understood as such by get_oid_mb() can be in the .name field,
and that eventually gets passed to branch.c::create_branch() as
"start_name" in the codepath.  The function ought to know that
start_name wants to name a single revision and never a revision
range, but fails to use get_oid_mb() but just a plain get_oid(),
and fails.

If that is the case, wouldn't a better fix be more like the
attached?  This hasn't even been compile tested, but I suspect that
without taking this approach, you would introduce a new "bug",
namely, that

	$ git checkout -b newbranch master...

ought to behave exactly like

	$ git branch newbranch master...
	$ git checkout newbranch

But the first step would hit the same branch.c::create_branch()
and would not work, no?

The reason I care about hiding syntax details like "..." from users
of get_*_mb() is because I anticipate that we'll want to extend it
to things other than just "merge base between two" with syntax
different from "..." (while probably renaming _mb suffix to
something else).

The codebase is not ready to replace get_oid() with get_oid_mb()
blindly and wholesale, I think, as the former is used as an
implementation detail of parsing range syntax like A..B but places
that are end user facing *and* expect to take only a single revision
(e.g. "rebase --onto <commit>", "checkout <commit>", etc.) and never
a range that currently use get_oid() should be able to get replaced
with get_oid_mb() to learn "A...B means their merge base, not a
symmetric range" semantics for free.

 branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/branch.c b/branch.c
index 28b81a7e02..a84c8aaca2 100644
--- a/branch.c
+++ b/branch.c
@@ -268,7 +268,7 @@ void create_branch(struct repository *r,
 	}
 
 	real_ref = NULL;
-	if (get_oid(start_name, &oid)) {
+	if (get_oid_mb(start_name, &oid)) {
 		if (explicit_tracking) {
 			if (advice_set_upstream_failure) {
 				error(_(upstream_missing), start_name);

