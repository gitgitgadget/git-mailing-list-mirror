From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] run-command: Remove set_nonblocking
Date: Thu, 5 Nov 2015 14:20:57 -0800
Message-ID: <CAGZ79kZs8HQegNy=L5nGMUGJ98s-xgce1Ncrxpxe_ReaJXMjKw@mail.gmail.com>
References: <1446747439-30349-1-git-send-email-sbeller@google.com>
	<1446747439-30349-2-git-send-email-sbeller@google.com>
	<563BBBBC.7070807@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Nov 05 23:21:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuStz-0001bu-1O
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 23:21:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756809AbbKEWU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 17:20:58 -0500
Received: from mail-yk0-f174.google.com ([209.85.160.174]:33819 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbbKEWU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 17:20:57 -0500
Received: by ykdr3 with SMTP id r3so157923376ykd.1
        for <git@vger.kernel.org>; Thu, 05 Nov 2015 14:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lA4EwaEU7CX1RbEzwGRQAbs9K15thgf4GZ63rDs5Drs=;
        b=oVWn+qdY1FQNRLnPLuq/JAStYFIoxOulDM4ZFUe0rDXeSqj+T64oH65sx9dVc+iSpo
         Jz5Pj+Yh9xwcRz5aktjX5hSCcLs0NaOa9Z9DwHr33WCWoFf8yLTolSk3mXlVEnhoeQIJ
         oOjcmmiHT3IdqnBP3cd0IoREQ6JX3ql5HgI+xq6pzxYFVW77i3ruQPR2gUNt+ceOwsZ9
         QOdsLbSCh+/V1FM6SQifOr1D2AnB+k6yuCY8khHvUV1K3zl5Cnxibqw0bYrAZ+oa2ZhW
         MRUrB9G347LQC5l7aY8P1eTe3iMrR39GvqiEhh8tWMST766DdESFjeJu/EQUr8tr/V6c
         +IWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=lA4EwaEU7CX1RbEzwGRQAbs9K15thgf4GZ63rDs5Drs=;
        b=SyRdEe2fw/v28DrDEmAKankCYExxPTX9d82RxY1ibSh/y2e+8U0FGngkve5f0BVPMt
         wAfyYj0/Ee3bjFW+XMNjVbjFrVba7ner3wjkaUbenGP9TvvJiun5SNOrQ0pTWl0ogX8c
         6x9L6OKeaLbVQXX8hKDAoLy8MY6PDOmZT4pSGQ5UemBmH+jvUeHeGItCIldhzK1pEEqr
         +lTXxXe3N+Z+23sX2wVEsW6GwyFYQ4kzYMkuV6UWgMUTEIR1isWpR5zlrmeO4gDkRs/D
         /fsCSMhNVWBdfB7ZPRVtENANBWPIra/yeFMBR78dJ6S3IPrRoOvomdfbcZB+KYHk/C+a
         yfJA==
X-Gm-Message-State: ALoCoQmJ25CwnslcVGt0v+5NiCkMDeLCXyRR6CylFIEfQ0vWz//UVfhGS5BAIyPF1lrM/lzuCUUJ
X-Received: by 10.13.254.69 with SMTP id o66mr8243377ywf.252.1446762057128;
 Thu, 05 Nov 2015 14:20:57 -0800 (PST)
Received: by 10.37.29.213 with HTTP; Thu, 5 Nov 2015 14:20:57 -0800 (PST)
In-Reply-To: <563BBBBC.7070807@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280942>

On Thu, Nov 5, 2015 at 12:27 PM, Johannes Sixt <j6t@kdbg.org> wrote:

> diff --git a/run-command.c b/run-command.c
> index 51d078c..3e42299 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -977,7 +977,7 @@ static struct parallel_processes *pp_init(int n,
>         for (i = 0; i < n; i++) {
>                 strbuf_init(&pp->children[i].err, 0);
>                 child_process_init(&pp->children[i].process);
> -               pp->pfd[i].events = POLLIN;
> +               pp->pfd[i].events = POLLIN|POLLHUP;
>                 pp->pfd[i].fd = -1;
>         }
>         sigchain_push_common(handle_children_on_signal);
> @@ -1061,11 +1061,17 @@ static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
>         /* Buffer output from all pipes. */
>         for (i = 0; i < pp->max_processes; i++) {
>                 if (pp->children[i].in_use &&
> -                   pp->pfd[i].revents & POLLIN)
> -                       if (strbuf_read_once(&pp->children[i].err,
> -                                            pp->children[i].process.err, 0) < 0)
> +                   pp->pfd[i].revents & (POLLIN|POLLHUP)) {
> +                       int n = strbuf_read_once(&pp->children[i].err,
> +                                            pp->children[i].process.err, 0);
> +                       if (n == 0) {
> +                               close(pp->children[i].process.err);
> +                               pp->children[i].process.err = -1;

So you set .err to -1 to signal the process has ended here...

> -
>                 for (i = 0; i < pp->max_processes; i++)
>                         if (pp->children[i].in_use &&
> -                           pid == pp->children[i].process.pid)
> +                           pp->children[i].process.err == -1)
>                                 break;

to make a decision here if we want to finish_command on it.


> +               code = finish_command(&pp->children[i].process);

> -               child_process_clear(&pp->children[i].process);

but .err stays stays -1 here for the next iteration?
We would need to reset it to 0 again.

So .err is
  0 when the slot is not in use
 -1 when the child has finished awaiting termination
 >0 when the child is living a happy life.
