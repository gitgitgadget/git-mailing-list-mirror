Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D745BC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 04:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF3706109F
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 04:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236891AbhHZEH4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 00:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhHZEHz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 00:07:55 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E83BC061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 21:07:06 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id b200so1966895iof.13
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 21:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XBSYI/SyAPKYs4H1jWZls76iW8Vz3vh2zwOerTqFMYc=;
        b=B8pJDb+3ixX0qPVlNhAuZhkdi9dmPUuaXAPAqk84SxIrPminvcOpyYr0UpsU6SYgP9
         dvoJs8noz3R75qGDwJxDu2MHaJV/aJ2XkAX6o6rfPjN79zDIf3dmDSxtW818vCsl4q28
         OItpa19An3ifGmiWierymO1txHfV5FSc20uLefBlK8XiLBV8pLm2iSHQaRbk1EAQeriz
         ZZf+nluyqMv220qoaeWIXK2eQ8QnpGd6ObpIS5ynOt5hTrfR4b29TEdTmIR4hmdwil6/
         9dzjvuBfkIkdd1InIdoj7WCSjpBujNqxdDtw5fSiNIbU7BG77gpuDRuMBKApIJBq4HUn
         lafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XBSYI/SyAPKYs4H1jWZls76iW8Vz3vh2zwOerTqFMYc=;
        b=NQZ8tAPSF0VtatEwUZ7KuMsENlbdKbUK40nQ9Fnz6SDEyLcFcpQCnrFsbRekf49Ymn
         3SLxX+NHrjysLSwt5R/YBzX2rdeC+hvoSvO0f2hW3hDKeP/svn3JgoRkE58YBZ8MZlAN
         oS96siTqf58w3+KO0918zosIbB+CsZfIrJUasL3Nu6DE9mX4JJjdWhfAyGZSJf6rLi0N
         58Uyfd4oaKBcDWDAuE8xp1jSbsFIySgwwwGHXZwYaZoDCsS7o8hdGdR2HCaFwk4X4hjK
         aCusKrfKYtXlD+1GGG9HtYW9adHo7L2+OOoQ2VulrA7OSGcwl53ouqwZl3ba+MdvbZJd
         KIwA==
X-Gm-Message-State: AOAM5304M7RJ6E0aRJTK586/+uLMNregJSJfY9UaCMT5ZUzrWMc0hojL
        3k03VkYJLLxOafYY3rJqUY18Yw==
X-Google-Smtp-Source: ABdhPJxJLWKvnKXDXahm0iR3D1YxliJrJ1T4KjyhaYCakKQlyqbZ/AwcTXsA1tzzc4zp2gzAI4W/ZQ==
X-Received: by 2002:a05:6638:1495:: with SMTP id j21mr1707077jak.117.1629950825771;
        Wed, 25 Aug 2021 21:07:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a4sm924122ioe.19.2021.08.25.21.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 21:07:05 -0700 (PDT)
Date:   Thu, 26 Aug 2021 00:07:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 6/6] tr2: log N parent process names on Linux
Message-ID: <YScTaDcPTs1nrP2Y@nand.local>
References: <87o8agp29o.fsf@evledraar.gmail.com>
 <cover-0.6-00000000000-20210825T231400Z-avarab@gmail.com>
 <patch-6.6-da003330800-20210825T231400Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-6.6-da003330800-20210825T231400Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 26, 2021 at 01:19:24AM +0200, Ævar Arnfjörð Bjarmason wrote:
> In 2f732bf15e6 (tr2: log parent process name, 2021-07-21) we started
> logging parent process names, but only logged all parents on Windows.
> on Linux only the name of the immediate parent process was logged.
>
> Extend the functionality added there to also log full parent chain on
> Linux. In 2f732bf15e6 it was claimed that "further ancestry info can
> be gathered with procfs, but it's unwieldy to do so.".
>
> I don't know what the author meant by that, but I think it probably
> referred to needing to slurp this up from the FS, as opposed to having
> an API.

I don't think that this (specifically, "I don't know what the author
meant by that") is necessary information to include in a patch message.

If you're looking for a replacement (and you may not be, but just my
$.02) I would suggest:

    "2f732bf15e6 does not log the full parent chain on Linux; implement
    that functionality here."

> What is more complex on Linux is getting at the process name, a
> simpler approach is to use fscanf(), see [1] for an implementation of
> that, but as noted in the comment being added here it would fail in
> the face of some weird process names, so we need our own
> parse_proc_stat() to parse it out.

This is helpful information to have for readers that aren't familiar
with procfs (especially the detail about why the naive approach doesn't
work).

> diff --git a/compat/linux/procinfo.c b/compat/linux/procinfo.c
> index 46a751c9a1d..937084126a6 100644
> --- a/compat/linux/procinfo.c
> +++ b/compat/linux/procinfo.c
> @@ -4,27 +4,129 @@
>  #include "strvec.h"
>  #include "trace2.h"
>
> -static void get_ancestry_names(struct strvec *names)
> +/*
> + * We need more complex parsing instat_parent_pid() and
> + * parse_proc_stat() below than a dumb fscanf(). That's because while
> + * the statcomm field is surrounded by parentheses, the process itself
> + * is free to insert any arbitrary byte sequence its its name. That
> + * can include newlines, spaces, closing parentheses etc. See
> + * do_task_stat() in fs/proc/array.c in linux.git, this is in contrast
> + * with the escaped version of the name found in /proc/%d/status.
> + *
> + * So instead of using fscanf() we'll read N bytes from it, look for
> + * the first "(", and then the last ")", anything in-between is our
> + * process name.
> + *
> + * How much N do we need? On Linux /proc/sys/kernel/pid_max is 2^15 by
> + * default, but it can be raised set to values of up to 2^22. So
> + * that's 7 digits for a PID. We have 2 PIDs in the first four fields
> + * we're interested in, so 2 * 7 = 14.
> + *
> + * We then have 4 spaces between those four values, which brings us up
> + * to 18. Add the two parentheses and it's 20. The "state" is then one
> + * character (now at 21).

Hmm, aren't there three spaces, not four?

> + * Finally the maximum length of the "comm" name itself is 15
> + * characters, e.g. a setting of "123456789abcdefg" will be truncated
> + * to "123456789abcdef". See PR_SET_NAME in prctl(2). So all in all
> + * we'd need to read 21 + 15 = 36 bytes.

Ah, 36 is the right number even though you and I counted a different
number of spaces, since the name is truncated when it goes over *16*
characters, but that includes the NUL byte. So we both arrive at the
same number in the end ;).

But I agree it's safer to just read more (but not too much more) than
what we need.

> + * Let's just read 2^6 (64) instead for good measure. If PID_MAX ever
> + * grows past 2^22 we'll be future-proof. We'll then anchor at the
> + * last ")" we find to locate the parent PID.
> + */
> +#define STAT_PARENT_PID_READ_N 64
> +
> +static int parse_proc_stat(struct strbuf *sb, struct strbuf *name,
> +			    int *statppid)

Going to think aloud to make sure that this parsing looks right.

>  {
> +	const char *lhs = strchr(sb->buf, '(');
> +	const char *rhs = strrchr(sb->buf, ')');

lhs and rhs are going to be on either side of the comm field (which may
be helpful to indicate by calling these comm_lhs and comm_rhs). And
strrchr makes sure to handle process names that have a ')' in them.
Looks right.

> +	const char *ppid_lhs, *ppid_rhs;
> +	char *p;
> +	pid_t ppid;
> +
> +	if (!lhs || !rhs)
> +		goto bad_kernel;
> +

OK.

>  	/*
> -	 * NEEDSWORK: We could gather the entire pstree into an array to match
> -	 * functionality with compat/win32/trace2_win32_process_info.c.
> -	 * To do so, we may want to examine /proc/<pid>/stat. For now, just
> -	 * gather the immediate parent name which is readily accessible from
> -	 * /proc/$(getppid())/comm.
> +	 * We're at the ")", that's followed by " X ", where X is a
> +	 * single "state" character. So advance by 4 bytes.
>  	 */
> +	ppid_lhs = rhs + 4;
> +
> +	ppid_rhs = strchr(ppid_lhs, ' ');

Skipping over the state field gives us the first character of ppid as
you say, good. And reading until the first space character will point us
right after the end, good.

> +	if (!ppid_rhs)
> +		goto bad_kernel;
> +
> +	ppid = strtol(ppid_lhs, &p, 10);
> +	if (ppid_rhs == p) {

Then parse the ppid and make sure we stopped at the right-hand side
where we should have. Good.

> +		const char *comm = lhs + 1;

Skipping past the '(', but now I feel like we really should
s/lhs/comm_&/.

> +		int commlen = rhs - lhs - 1;

This is right, but you could simplify the expression to be "rhs - comm",
since you just took into account the left-hand parenthesis in the
previous line. Also recommend a size_t here: it's obvious we're not
going to overflow int here, but it saves future readers of having to
wonder the same thing.

> +
> +		strbuf_addf(name, "%.*s", commlen, comm);
> +		*statppid = ppid;
> +
> +		return 0;
> +	}
> +
> +bad_kernel:
> +	/*
> +	 * We were able to read our STAT_PARENT_PID_READ_N bytes from
> +	 * /proc/%d/stat, but the content is bad. Broken kernel?
> +	 * Should not happen, but handle it gracefully.
> +	 */
> +	return -1;
> +}

Phew, all seems good. Thanks for bearing with me while I read through
all of that ;).

> +static int stat_parent_pid(pid_t pid, struct strbuf *name, int *statppid)
> +{
>  	struct strbuf procfs_path = STRBUF_INIT;
> -	struct strbuf name = STRBUF_INIT;
> +	struct strbuf sb = STRBUF_INIT;
> +	size_t n;
> +	FILE *fp = NULL;

fopen() will return NULL, and you call it unconditionally, so no need to
initialize here.

> +	int ret = -1;
>
>  	/* try to use procfs if it's present. */
> -	strbuf_addf(&procfs_path, "/proc/%d/comm", getppid());
> -	if (strbuf_read_file(&name, procfs_path.buf, 0) > 0) {
> -		strbuf_trim_trailing_newline(&name);
> -		strvec_push(names, name.buf);
> -		strbuf_release(&name);
> -	}
> +	strbuf_addf(&procfs_path, "/proc/%d/stat", pid);
> +	fp = fopen(procfs_path.buf, "r");
> +	if (!fp)
> +		goto cleanup;
> +
> +	n = strbuf_fread(&sb, STAT_PARENT_PID_READ_N, fp);
> +	if (n != STAT_PARENT_PID_READ_N)
> +		goto cleanup;

Hmm. Wouldn't we always goto cleanup here, since STAT_PARENT_PID_READ_N
is deliberately oversized (and not constant anyways, since process ids
could be anywhere from 1-7 digits long)?

I think we could probably drop 'n' entirely here, and instead:

    if (strbuf_fread(...) < 0)
      goto cleanup;

> +	if (parse_proc_stat(&sb, name, statppid) < 0)
> +		goto cleanup;
>
> +	ret = 0;
> +cleanup:
> +	if (fp)
> +		fclose(fp);
>  	strbuf_release(&procfs_path);
> +	strbuf_release(&sb);
> +
> +	return ret;
> +}
> +
> +static void push_ancestry_name(struct strvec *names, pid_t pid)
> +{
> +	struct strbuf name = STRBUF_INIT;
> +	int ppid;
> +
> +	if (stat_parent_pid(pid, &name, &ppid) < 0)
> +		goto cleanup;
> +
> +	strvec_push(names, name.buf);
> +
> +	/*
> +	 * Both errors and reaching the end of the process chain are
> +	 * reported as fields of 0 by proc(5)
> +	 */
> +	if (ppid)
> +		push_ancestry_name(names, ppid);
> +cleanup:
> +	strbuf_release(&name);
>  	return;
>  }

The rest looks good to me, but it looks like you overwrote all of the
work that you did in patch 4/6. I guess separating them out makes sense
if this patch wasn't taken, but I probably would have gone right to this
patch instead of fixing leaks that you were going to get rid of anyway.

Thanks,
Taylor
