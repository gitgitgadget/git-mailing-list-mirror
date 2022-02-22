Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05A6C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 15:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbiBVPfY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 10:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiBVPfV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 10:35:21 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4894E160FE8
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 07:34:56 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c6so34975968edk.12
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 07:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=dOzPGcZgqWfeSGw1JKkDGsvDQEArg8zHaqqswDjd9Ck=;
        b=SLBbIIl8gXofREVWZuZKM0kNA86x9wWVozUm6kac6bEmDLyuCf0n406Kpsz9qn4t0v
         L2svv4HuprmVE0ULSxdAAL38f1UT7Gz3iRDMlifl9su1g8n7b1PNHKOjTVzof9b1Vsbf
         YaDNpaqO8Tg4UBGInPlbRcE9Pt/5lyN8Vr7ckJRXGFe70IuuQ1b0TmCwHmJDRpxp1Bd3
         K7f0amklo9NDUiKGB3iHtx9kl+IUnructlEIKv3qSK6dDpYb6P7avbpvsxaZmUU7YoaJ
         kYT2IfPDORMafroBAWFyKAQib3dW3JIz7jCfvL1JBy6xLOyRdi7e3rS3XA5Kv7G9m9M+
         vu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=dOzPGcZgqWfeSGw1JKkDGsvDQEArg8zHaqqswDjd9Ck=;
        b=kVMWoRLdHHCc+Lk4cHjRs0bYkWCAus/lRJBJB9PglLan5No8eBrClKhv+goszDPZfG
         n8VdE8VfRILmJrkres+NnFvGGWbnff9fOj9XjWLtWqIBR82+tDRFPJipfXoAlb9g5jyq
         KtKI+D4Pffqmr53+ZUpAk6u6BBI7QHd9gnzpl44WNJI3+vlhTXZCFoUVupsuZ7P3w7R8
         UXceuU8nXtcP01JmK1PG62ZNHuoNwQ5+bTLG1xVoqab8FRbZa0apKWfjhWFjRUe8MqGS
         7tZ13TMlRiATpPBxJelHchJ6XA6hW9fu5UPotrY0aRBCoMUojKVWWibfDnELw6gRgpAm
         qr4Q==
X-Gm-Message-State: AOAM531xObdybx8ana2j3wAOx7eFS4VSgMYlP/k1cAZ9c0lDY5DIAR93
        fC44kga/W5dpCG3tsqWMMOc=
X-Google-Smtp-Source: ABdhPJzsb0BeNtZwIq6C4Mc255BCncqSvEiE8bFp9EbABwqwlS77kSmd/xXJZ6bV2jLGdKQksXRx9w==
X-Received: by 2002:aa7:dbd6:0:b0:408:4a31:97a5 with SMTP id v22-20020aa7dbd6000000b004084a3197a5mr27370354edt.186.1645544094638;
        Tue, 22 Feb 2022 07:34:54 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g8sm6507348ejt.26.2022.02.22.07.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 07:34:54 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMXBl-006B73-J6;
        Tue, 22 Feb 2022 16:34:53 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 1/2] rebase: help user when dying with preserve-merges`
Date:   Tue, 22 Feb 2022 16:32:59 +0100
References: <pull.1155.git.1645526016.gitgitgadget@gmail.com>
 <cd06aa68c2fc65551cd810a1c2c0941c51433163.1645526016.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <cd06aa68c2fc65551cd810a1c2c0941c51433163.1645526016.git.gitgitgadget@gmail.com>
Message-ID: <220222.86czje7w4i.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 22 2022, Philip Oakley via GitGitGadget wrote:

> From: Philip Oakley <philipoakley@iee.email>
>
> Git will die if a "rebase --preserve-merges" is in progress.
> Users cannot --quit, --abort or --continue the rebase.
>
> This sceario can occur if the user updates their Git, or switches
> to another newer version, after starting a preserve-merges rebase,
> commonly via the pull setting.
>
> One trigger is an unexpectedly difficult to resolve conflict, as
> reported on the `git-users` group.
> (https://groups.google.com/g/git-for-windows/c/3jMWbBlXXHM)
>
> Tell the user the cause, i.e. the existence of the directory.
> The problem must be resolved manually, `git rebase --<option>`
> commands will die, or the user must downgrade. Also, note that
> the deleted options are no longer shown in the documentation.

I can go and read the linked thread for the answer, but:

>  		if (is_directory(buf.buf)) {
> -			die("`rebase -p` is no longer supported");
> +			die("`rebase --preserve-merges` (-p) is no longer supported.\n"
> +			"You still have a `.git/rebase-merge/rewritten` directory, \n"
> +			"indicating a `rebase preserve-merge` is still in progress.\n");
>  		} else {
>  			strbuf_reset(&buf);
>  			strbuf_addf(&buf, "%s/interactive", merge_dir());

As much of an improvement this is, I'd be no closer to knowing what I
should do at this point.

Should I "rm -rf" that directory, downgrade my version of git if I'd
like to recover my work (as the message alludes to).

In either case I'd think that this is getting a bit past the length
where we'd have just a die() v.s. splitting it into a die()/advise()
pair. I.e. to have the advise() carry some bullet-point list about X/Y/Z
solutions, with the die() being a brief ~"we did because xyz dir is
still here".


