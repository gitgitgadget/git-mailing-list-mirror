From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Use startup_info->prefix rather than prefix.
Date: Fri, 02 Mar 2012 23:30:55 -0800
Message-ID: <7v8vji87kg.fsf@alter.siamese.dyndns.org>
References: <cover.1330740964.git.jaredhance@gmail.com>
 <b564d95b1efcd91874beb6d410253f86617f8fa6.1330740964.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jared Hance <jaredhance@gmail.com>,
	Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 08:31:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3jRJ-0008BH-CR
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 08:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312Ab2CCHbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 02:31:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63285 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004Ab2CCHbA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 02:31:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 122CF3383;
	Sat,  3 Mar 2012 02:31:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S5XOqIDjivfCE1ejyMEPlCwxY48=; b=Z0WXRJ
	zq0Ag5+AUEBBDpgyKeAmJyxZvT0ON6NxAKVT69hXX3luB0yFOfX2Zrfxm2vIvh9h
	4WGdVPAPr7Wy5gQ2on2vVLO5e5Febu/k7uNI5ITyIR5Q5nN9nE64Fxn+s0ukHgS4
	wTtGTkC9I8YPRys4v1AhLHx0ONjY+V114NXGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qrJiPlA41Nssxq9lmvUilPvRS2YySng9
	+dq21A1DSHvrPIu3n03IX+B7uTTMo0CivuE1V06vkchg6a1fPW9JTGATUlQUiINw
	aMkw59JmjPe5iVzEEDkq6Nry4XCMFLVNmKaxcRfPK1GgKMevMaPBvgPx+yedmolu
	r5/ydHdE5gA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0732B3382;
	Sat,  3 Mar 2012 02:31:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC4AE3380; Sat,  3 Mar 2012
 02:30:56 -0500 (EST)
In-Reply-To: <b564d95b1efcd91874beb6d410253f86617f8fa6.1330740964.git.jaredhance@gmail.com> (Jared Hance's message of "Fri, 2 Mar 2012 21:31:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D0F47EA8-6502-11E1-9401-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192096>

Jared Hance <jaredhance@gmail.com> writes:

> In trace_repo_setup, prefix is passed in as startup_info->prefix. But, as
> indicated but a FIXME comment, trace_repo_setup has access to
> startup_info. The prefix parameter has therefor been eliminated.
>
> Signed-off-by: Jared Hance <jaredhance@gmail.com>
> ---

This comes from a9ca8a8 (builtins: print setup info if repo is found,
2010-11-26) and hasn't ever changed over time, even across f07d6a1 (setup:
save prefix (original cwd relative to toplevel) in startup_info,
2010-12-01) that did add the necessary "prefix" field to the startup_info
and was done reasonably close to the patch that wanted to have the field
in the first place.

The fix looks too easy to be correct X-<; in other words, I find it hard
to believe that such a triviality was left without a good reason, but I do
not think of any.

Well, but perhaps something too good to be true is indeed true sometimes.

>  cache.h |    2 +-
>  git.c   |    2 +-
>  trace.c |   10 +++++-----
>  3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index e12b15f..baa8852 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1211,7 +1211,7 @@ extern void trace_printf(const char *format, ...);
>  extern void trace_vprintf(const char *key, const char *format, va_list ap);
>  __attribute__((format (printf, 2, 3)))
>  extern void trace_argv_printf(const char **argv, const char *format, ...);
> -extern void trace_repo_setup(const char *prefix);
> +extern void trace_repo_setup(void);
>  extern int trace_want(const char *key);
>  extern void trace_strbuf(const char *key, const struct strbuf *buf);
>  
> diff --git a/git.c b/git.c
> index 3805616..7dcc527 100644
> --- a/git.c
> +++ b/git.c
> @@ -296,7 +296,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>  
>  		if ((p->option & (RUN_SETUP | RUN_SETUP_GENTLY)) &&
>  		    startup_info->have_repository) /* get_git_dir() may set up repo, avoid that */
> -			trace_repo_setup(prefix);
> +			trace_repo_setup();
>  	}
>  	commit_pager_choice();
>  
> diff --git a/trace.c b/trace.c index d953416..ebacf24 100644 ---
> a/trace.c +++ b/trace.c @@ -152,8 +152,7 @@ static const char
> *quote_crnl(const char *path) return new_path;
>  }
>  
> -/* FIXME: move prefix to startup_info struct and get rid of this arg */
> -void trace_repo_setup(const char *prefix)
> +void trace_repo_setup(void)
>  {
>  	static const char *key = "GIT_TRACE_SETUP";
>  	const char *git_work_tree;
> @@ -168,13 +167,14 @@ void trace_repo_setup(const char *prefix)
>  	if (!(git_work_tree = get_git_work_tree()))
>  		git_work_tree = "(null)";
>  
> -	if (!prefix)
> -		prefix = "(null)";
> +	if (!startup_info->prefix)
> +		startup_info->prefix = "(null)";
>  
>  	trace_printf_key(key, "setup: git_dir: %s\n", quote_crnl(get_git_dir()));
>  	trace_printf_key(key, "setup: worktree: %s\n", quote_crnl(git_work_tree));
>  	trace_printf_key(key, "setup: cwd: %s\n", quote_crnl(cwd));
> -	trace_printf_key(key, "setup: prefix: %s\n", quote_crnl(prefix));
> +	trace_printf_key(key, "setup: prefix: %s\n", 
> +			 quote_crnl(startup_info->prefix));
>  }
>  
>  int trace_want(const char *key)
