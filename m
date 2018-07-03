Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4566F1F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 21:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753085AbeGCVJF (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 17:09:05 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36131 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752872AbeGCVJE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 17:09:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id s14-v6so3638195wmc.1
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 14:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=r/F84z7BtUFiXOV2/Y/GgDekOR0GUuOyYlL9IpuuKBQ=;
        b=KN/2hj6LmhzvEMY3JZIFVZMgYkpVfyGiJ9/Gmu0uOTCU5slmxGOullDWFgKecpAFzh
         RC7SvERTQFnXFc2Mlnwe26Q9ToYxgVQRoZrHDkyMnPJazlC16/Ht6RJJzzJjYeVYRLZb
         lJUQzUXuesmErL75OHateYWpLxPwkTbidcyod7PSCdmU/2vPYY6YS4BY3luax89M4bJw
         PGvLof3W14cneOFNzDjpfJLq1gdV12n4N3f9xVFKxJCvJ8G1L/PVavYGlGUXqB+oJsUw
         RHZ6HH1LZq063xWZO/uq3sdDAZk6Z7CzZrjN4CnXgn9tbVXIzTSCByKsdCcATCEbcPv2
         mH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=r/F84z7BtUFiXOV2/Y/GgDekOR0GUuOyYlL9IpuuKBQ=;
        b=lV+32LiS3guuj6dukkSE76sbwMmihT+SwX/DlWJOmFyuRENtx4wKjqCAVelk8RFYNs
         E+enM+IrG9xONmevgafCaMIrLBQuwY5YSjN4/+DMdtGQOS6fI0u4Z5B7wnRT60S4iL1C
         irXBnQu7oE2fHHtVdHJbdpLTMb95bamcI6FSbNGIU/tWvxgYrK8K/o7RZyFzge7O8avm
         oXnpcfkZvTV7emNUkLvvOPtBN5d1XeO2HYjvGoh/cu3zu/wpUsekX4vQo3jDOE5QcpTX
         1KwH4DpZ5XCke4Dg5PAREc3E05+sp2C1k9lUlJeXKDFjEJ715Nk8wpjsMU4PPMXF7uAm
         fbZw==
X-Gm-Message-State: APt69E068BEILkw3CQXU8DI92PscX2jjyl4uLcCz+OCFFq2HvIv5JON4
        PAO4kw3XlwLQws3gp+msJEY=
X-Google-Smtp-Source: AAOMgpc5+2eKCtYJ/ub1OPetw3J3n2ZC6Nt+fujWfWYj+cD2+TKVsd4iqlvTB6EgGG7zf50g/Rn/8Q==
X-Received: by 2002:a1c:37cd:: with SMTP id e196-v6mr9381851wma.84.1530652142341;
        Tue, 03 Jul 2018 14:09:02 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 39-v6sm4144632wrv.79.2018.07.03.14.09.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 14:09:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        Johannes.Schindelin@gmx.de, sbeller@google.com,
        alban.gruin@gmail.com
Subject: Re: [PATCH v2 1/4] rebase: start implementing it as a builtin
References: <20180628074655.5756-1-predatoramigo@gmail.com>
        <20180702091509.15950-1-predatoramigo@gmail.com>
        <20180702091509.15950-2-predatoramigo@gmail.com>
Date:   Tue, 03 Jul 2018 14:09:00 -0700
In-Reply-To: <20180702091509.15950-2-predatoramigo@gmail.com> (Pratik Karki's
        message of "Mon, 2 Jul 2018 15:00:06 +0545")
Message-ID: <xmqqva9wni1f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratik Karki <predatoramigo@gmail.com> writes:

> This commit imitates the strategy that was used to convert the
> difftool to a builtin, see be8a90e (difftool: add a skeleton for the
> upcoming builtin, 2017-01-17) for details: This commit renames the
> shell script `git-rebase.sh` to `git-legacy-rebase.sh` and hands off to
> it by default.

I'd appreciate it if mentors can teach a bit more log message
writing to students, thanks.

> diff --git a/builtin/rebase.c b/builtin/rebase.c
> new file mode 100644
> index 000000000..c0c9d6cd2
> --- /dev/null
> +++ b/builtin/rebase.c
> @@ -0,0 +1,55 @@
> +/*
> + * "git rebase" builtin command

Nice ;-)

> + * Copyright (c) 2018 Pratik Karki
> + */
> +
> +#include "builtin.h"
> +#include "run-command.h"
> +#include "exec-cmd.h"
> +#include "argv-array.h"
> +#include "dir.h"
> +
> +static int use_builtin_rebase(void)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	struct strbuf out = STRBUF_INIT;
> +	int ret;
> +
> +	argv_array_pushl(&cp.args,
> +			 "config", "--bool", "rebase.usebuiltin", NULL);
> +	cp.git_cmd = 1;
> +	if (capture_command(&cp, &out, 6))
> +		return 0;
> +
> +	strbuf_trim(&out);
> +	ret = !strcmp("true", out.buf);
> +	strbuf_release(&out);
> +	return ret;
> +}

OK.  As we give "--bool", it is perfectly OK to check with "true"
and no other forms of positive setting.

> +int cmd_rebase(int argc, const char **argv, const char *prefix)
> +{
> +	/*
> +	* NEEDSWORK: Once the builtin rebase has been tested enough
> +	* and git-legacy-rebase.sh is retired to contrib/, this preamble

Align these asterisks, i.e.

	/*
	 * NEEDSWORK: ...
	 */

> +	if (!use_builtin_rebase()) {
> +		const char *path = mkpath("%s/git-legacy-rebase",
> +					  git_exec_path());
> +
> +		if (sane_execvp(path, (char **)argv) < 0)
> +			die_errno("could not exec %s", path);
> +
> +		return 0;

Hmph, I know this was inherited from the old commit you modelled
this patch after, but can sane_execvp() ever give us control back
with non-negative value returned?  IOW I am wondering if this should
be more like

	if (sane_execvp(...) < 0)
		die_errno(...);
	else
		die("sane_execvp() returned???");

Not worth a reroll, but something to think about.

> diff --git a/git-rebase.sh b/git-legacy-rebase.sh
> similarity index 100%
> rename from git-rebase.sh
> rename to git-legacy-rebase.sh
> diff --git a/git.c b/git.c
> index 9dbe6ffaa..bacfefb2d 100644
> --- a/git.c
> +++ b/git.c
> @@ -518,6 +518,12 @@ static struct cmd_struct commands[] = {
>  	{ "pull", cmd_pull, RUN_SETUP | NEED_WORK_TREE },
>  	{ "push", cmd_push, RUN_SETUP },
>  	{ "read-tree", cmd_read_tree, RUN_SETUP | SUPPORT_SUPER_PREFIX},
> +	/*
> +	 *NEEDSWORK: Until the rebase is independent and needs no redirection
> +	 to rebase shell script this is kept as is, then should be changed to
> +	 RUN_SETUP | NEED_WORK_TREE
> +	*/

Likewise.

> +	{ "rebase", cmd_rebase },
>  	{ "rebase--helper", cmd_rebase__helper, RUN_SETUP | NEED_WORK_TREE },
>  	{ "receive-pack", cmd_receive_pack },
>  	{ "reflog", cmd_reflog, RUN_SETUP },
