From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv19 00/11] Expose submodule parallelism to the user
Date: Mon, 29 Feb 2016 12:59:40 -0800
Message-ID: <CAGZ79kaHm_GDtmjzeBqonS9JbCCjov6W23dNw_EKM5vL6a4=yA@mail.gmail.com>
References: <CAPc5daWbkNXp8T4U2tiYftB4kSOjf9Cv1fgmbYbpuoKdJPRHGA@mail.gmail.com>
	<1456444119-6934-1-git-send-email-sbeller@google.com>
	<56D4AE8A.2050403@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Feb 29 21:59:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaUux-0005GH-0r
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 21:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbcB2U7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 15:59:43 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:37144 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbcB2U7m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 15:59:42 -0500
Received: by mail-ig0-f169.google.com with SMTP id z8so4053801ige.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 12:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ByoFV2r5STyGhMA1rMLXLZhRR9/luZkuaWF8u5utSGw=;
        b=DQGLwyTZrYs1D315hjmwjPbQi4m1ke1pGTQrsvlAUkoNZSzYb5lefArcSi+DhOV/wz
         QsmlbHOdnKd9p+U8Pyiqay+lGPLTjLbXDlTZCWdNlpBmmW5hqIoEop5YO+/24H/mJpqK
         /FztZxqzuMMLax9TWF0wVoxhAB9wx2/CbXisv9Ukop2dWr37zZKJNtHZ0LjXwY6IK/rt
         w5OsChdR9ZFFdSHahZ2lhIlM5JII5BuzXoygCv5+kSdcSLzsTDdmDoADJUMSJh+z/1it
         3nOXMhqR39vGrEuKZmRhvL7dBMCbOsqhLvnW9vUskI1CMcDZvV6EL9O4yHdnIjWXFD82
         AqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ByoFV2r5STyGhMA1rMLXLZhRR9/luZkuaWF8u5utSGw=;
        b=g6CU8LrUKdsz0yYdSWntcrwRLlfZEumuiEgNcxyI6JHrC5gAlaILrONoDbJ/D4V3P9
         1txtRLBsvPgAdYTcOv4xF9cuYwkdVxDfeLGlS+AQSkseWCLkg5fgkxVkOi1eXL2W0dn6
         267xGOLY9Tay3e057uWsA+tHFKcrmYvZEoO+Bu7aOKwJdQYdEsl/5mCy9AWGgZ+wxGmo
         nuTSYb0L54jfuqdPR86mKfrndZDQS4IjfQKCBO6iB0eZLeGAnzsvHeRccIt4qaQEhO6/
         S3i8DGLg/W2GU/D6O86RX0HNL6FukqYf3FjRCHNKMseHQk7owNZxaDa8TkYKvJwA2KSZ
         lbhw==
X-Gm-Message-State: AD7BkJL7YBYJtmi1DdNZhs0+XxnVxlo1Am+m8XctQKiDJIi/W035YGSuGXoAda6JQt4mv4sM2gbofs2nVidyt3St
X-Received: by 10.50.28.105 with SMTP id a9mr4593igh.94.1456779580708; Mon, 29
 Feb 2016 12:59:40 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Mon, 29 Feb 2016 12:59:40 -0800 (PST)
In-Reply-To: <56D4AE8A.2050403@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287899>

On Mon, Feb 29, 2016 at 12:48 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Hi folks,
>
> we have a major breakage in the parallel tasks infrastructure, and I'm
> afraid it is already in master.
>
> Instrument the code in sb/submodule-parallel-update like this and enjoy
> the fireworks of './t7400-submodule-basic.sh -v -i -x --debug':
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 0322282..482c7f6 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -690,8 +690,9 @@ cmd_update()
>                 cmd_init "--" "$@" || return
>         fi
>
> +       set -x
>         {
> -       git submodule--helper update-clone ${GIT_QUIET:+--quiet} \
> +       valgrind git submodule--helper update-clone ${GIT_QUIET:+--quiet} \
>                 ${wt_prefix:+--prefix "$wt_prefix"} \
>                 ${prefix:+--recursive-prefix "$prefix"} \
>                 ${update:+--update "$update"} \
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 5572327..717e491 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -337,6 +337,7 @@ test_expect_success 'update should fail when path is used by a file' '
>
>         echo "hello" >init &&
>         test_must_fail git submodule update &&
> +       false &&
>
>         test_cmp expect init
>  '
>
> The culprit seems to be default_task_finished(), which accesses argv[]
> of the struct child_process after finish_command has released it,
> provided the child exited with an error, for example:
>
> ==3395== Invalid read of size 8
> ==3395==    at 0x54F991: default_task_finished (run-command.c:932)
> ==3395==    by 0x49158F: update_clone_task_finished (submodule--helper.c:421)
> ==3395==    by 0x5504A2: pp_collect_finished (run-command.c:1122)
> ==3395==    by 0x5507C7: run_processes_parallel (run-command.c:1194)
> ==3395==    by 0x4918EB: update_clone (submodule--helper.c:483)
> ==3395==    by 0x4919D8: cmd_submodule__helper (submodule--helper.c:527)
> ==3395==    by 0x405CBE: run_builtin (git.c:353)
> ==3395==    by 0x405EAA: handle_builtin (git.c:540)
> ==3395==    by 0x405FCC: run_argv (git.c:594)
> ==3395==    by 0x4061BF: main (git.c:701)
> ==3395==  Address 0x5e49370 is 0 bytes inside a block of size 192 free'd
> ==3395==    at 0x4C2A37C: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==3395==    by 0x4A26EE: argv_array_clear (argv-array.c:73)
> ==3395==    by 0x54DFC4: child_process_clear (run-command.c:18)
> ==3395==    by 0x54EFA7: finish_command (run-command.c:539)
> ==3395==    by 0x550413: pp_collect_finished (run-command.c:1120)
> ==3395==    by 0x5507C7: run_processes_parallel (run-command.c:1194)
> ==3395==    by 0x4918EB: update_clone (submodule--helper.c:483)
> ==3395==    by 0x4919D8: cmd_submodule__helper (submodule--helper.c:527)
> ==3395==    by 0x405CBE: run_builtin (git.c:353)
> ==3395==    by 0x405EAA: handle_builtin (git.c:540)
> ==3395==    by 0x405FCC: run_argv (git.c:594)
> ==3395==    by 0x4061BF: main (git.c:701)
>
> I haven't thought about a solution, yet. Perhaps you have ideas.
>
> -- Hannes
>

What about unfolding finish_command like so:

diff --git a/run-command.c b/run-command.c
index 863dad5..659abd9 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1115,11 +1115,13 @@ static int pp_collect_finished(struct
parallel_processes *pp)
                if (i == pp->max_processes)
                        break;

-               code = finish_command(&pp->children[i].process);
+               code = wait_or_whine(pp->children[i].process.pid,
+                                    pp->children[i].process.argv[0], 0);

                code = pp->task_finished(code, &pp->children[i].process,
                                         &pp->children[i].err, pp->data,
                                         &pp->children[i].data);
+               child_process_clear(&pp->children[i].process);

                if (code)
                        result = code;
