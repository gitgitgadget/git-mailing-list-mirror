Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4933BC4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 20:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiKGUBe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 15:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiKGUBb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 15:01:31 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875422126B
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 12:01:30 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id fz10so7549763qtb.3
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 12:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dpsFwCh1JjL3s7EHJjBKwkbHanNkV2+TilnxiJ8NmUw=;
        b=Klsx0JTWIhBvJLo3ig1wCiE8rOTqCBllZ3RVz487UFNtJFYMIqXfYGyxqI/hQEymBH
         eawHtOvG34mNMW2ZQwuNqbdzliDpEQ0rwSr5I83WPhhy84M09xVDHiXd2EqjEAGGymEi
         v+SehslcFk3KSHywQsxkFXI8WXoIinZNBVGMKmFKIKnwREqvIzyCpEIggMdBdEwN1Qgh
         YEdZxTv4r32a3NglEBAMiQOuT142FGOz6ZPliA6aZRFi+B27iGwgEcwpbx9AWpQhREQw
         1sLRG78E3RfHmJ0sX15C+UhDWErkYMAozCaX/Sp+N/oOxtcDMJ4Wu+B36uufvbn8r2g3
         fMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dpsFwCh1JjL3s7EHJjBKwkbHanNkV2+TilnxiJ8NmUw=;
        b=IAaerQxBIFXLaITNY2X/kugA6RlbIbvtj30GgQixjSXZw6bQOCLYCWZab1Ltor6LhI
         uPz/rdlDDk8ZakDWipsMyNUXT6DN7P5hnpdbmGQPqSZzwtt6R7o5HfYHMmDJc094uCIy
         Z0UuD7PSNRCb+zFnT9WISt8DfbZC6C/OqrHtt2bOXb1jisRk+9NI6J+EWgTMIHcvk2we
         4QqWybJQ9A0KyH3dReFxaCuaraBol+37eRK7ewRA9DRdYe0aRuhgiY7mxy0NPAazpNe2
         ImrjOSc/c8aA6wlcSdR32cgwh9ALJndLG/BUpWeL1+AUNrvracn45K5f2htNNQg+vREu
         zbcg==
X-Gm-Message-State: ACrzQf36w9+c9osKYCSwsg4eZFSiQuioU2ATQgjvCT05yzNjsV3pitNB
        CRE6jeG69mxMkMO8ZTfRD+ekHEeJNtUG
X-Google-Smtp-Source: AMsMyM5K0F0duKGvfccGxxpA4t4kL+BPa3lGFPL/c5UwKXjBMP5lV4F9+lnIF4NT3itvtc9kFobI6w==
X-Received: by 2002:a05:622a:4a10:b0:3a5:6d29:ef6a with SMTP id fv16-20020a05622a4a1000b003a56d29ef6amr13051906qtb.554.1667851289568;
        Mon, 07 Nov 2022 12:01:29 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d948:f30c:63de:b667? ([2600:1700:e72:80a0:d948:f30c:63de:b667])
        by smtp.gmail.com with ESMTPSA id bk2-20020a05620a1a0200b006f9f3c0c63csm7505476qkb.32.2022.11.07.12.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 12:01:29 -0800 (PST)
Message-ID: <0e2de99a-da7e-f65f-aefe-117fb468ce55@github.com>
Date:   Mon, 7 Nov 2022 15:01:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v3] status: long status advice adapted to recent
 capabilities
Content-Language: en-US
To:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Rudy Rigot <rudy.rigot@gmail.com>
References: <pull.1384.v2.git.1667002005494.gitgitgadget@gmail.com>
 <pull.1384.v3.git.1667424467505.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1384.v3.git.1667424467505.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/2/22 5:27 PM, Rudy Rigot via GitGitGadget wrote:> +UNTRACKED FILES AND STATUS SPEED
> +--------------------------------
> +
> +`git status` can be very slow in large worktrees if/when it
> +needs to search for untracked files and directories.  There are
> +many configuration options available to speed this up by either
> +avoiding the work or making use of cached results from previous
> +Git commands.  Since we all work in different ways, there is no
> +single optimum set of settings right for everyone.  Here is a
> +brief summary of the relevant options to help you choose which
> +is right for you.  Each of these settings is independently
> +documented elsewhere in more detail, so please refer to them
> +for complete details.

Sorry I'm late to this series. This new section is a great idea.

> +* `-uno` or `status.showUntrackedFiles=false` : just don't search

Two nits:

1. Is it clear that `-uno` is an option to `git status`? Should
   we say "The `-uno` flag or the `status.showUntrackedfiles=false`
   config"?

2. Drop the "just" as it implies simplicity but is unnecessary. In
   fact, I'd replace the sentence with:

   Indicate that `git status` should not report untracked files.

> +    and don't report on untracked files.  This is the fastest.

  "This is the fastest option." ?

> +    `git status` will not list the untracked files, so you need
> +    to be careful to remember if you create any new files and
> +    manually `git add` them.
> +
> +* `advice.statusUoption=false` : search, but don't complain if it
> +    takes too long.

Perhaps:

	This config option disables a warning message when the
	search for untracked files takes longer than desired.

and maybe even describe why:

	In some large repositories, this message may appear
	frequently and not be a helpful signal.

> +* `core.untrackedCache=true` : enable the untracked cache feature
> +    and only search directories that have been modified since the
> +    previous `git status` command.  Git remembers the set of
> +    untracked files within each directory and assumes that if a
> +    directory has not been modified, then the set of untracked
> +    file within has not changed.  This is much faster than
> +    enumerating the contents of every directory, but still not
> +    without cost, because Git still has to search for the set of
> +    modified directories.

It might be helpful to mention that the untracked cache is stored
in the .git/index file. The reduced cost searching for untracked
files is offset slightly by the increased size of the index and
the cost of keeping it up-to-date. That reduced search time is
usually worth the additional size.

> +* `core.untrackedCache=true` and `core.fsmonitor=true` or
> +    `core.fsmonitor=<hook_command_pathname>` : enable both the
> +    untracked cache and FSMonitor features and only search
> +    directories that have been modified since the previous
> +    `git status` command.  This is faster than using just the
> +    untracked cache alone because Git can also avoid searching
> +    for modified directories.  Git only has to enumerate the
> +    exact set of directories that have changed recently.

It might be worth explicitly mentioning that while the FSMonitor
feature can be enabled without the untracked cache, the benefits
are greatly reduced in that case.

> +Note that after you turn on the untracked cache and/or FSMonitor
> +features it may take a few `git status` commands for the various
> +caches to warm up before you see improved command times.  This is
> +normal.
> +
>  SEE ALSO
>  --------
>  linkgit:gitignore[5]
> diff --git a/t/t7065-wtstatus-slow.sh b/t/t7065-wtstatus-slow.sh
> new file mode 100755
> index 00000000000..23c37ea71e7
> --- /dev/null
> +++ b/t/t7065-wtstatus-slow.sh
> @@ -0,0 +1,40 @@
> +#!/bin/sh
> +
> +test_description='test status when slow untracked files'
> +
> +. ./test-lib.sh
> +
> +DATA="$TEST_DIRECTORY/t7065"
> +
> +GIT_TEST_UF_DELAY_WARNING=1
> +export GIT_TEST_UF_DELAY_WARNING
> +
> +test_expect_success setup '
> +	git checkout -b test
> +'
> +
> +test_expect_success 'when core.untrackedCache and fsmonitor are unset' '
> +	test_must_fail git config --get core.untrackedCache &&
> +	test_must_fail git config --get core.fsmonitor &&
> +    git status | sed "s/[0-9]\.[0-9][0-9]/X/g" >../actual &&
> +    test_cmp "$DATA/no_untrackedcache_no_fsmonitor" ../actual &&
> +    rm -fr ../actual
> +'
> +
> +test_expect_success 'when core.untrackedCache true, but not fsmonitor' '
> +    git config core.untrackedCache true &&
> +	test_must_fail git config --get core.fsmonitor &&
> +    git status | sed "s/[0-9]\.[0-9][0-9]/X/g" >../actual &&
> +    test_cmp "$DATA/with_untrackedcache_no_fsmonitor" ../actual &&
> +    rm -fr ../actual
> +'
> +
> +test_expect_success 'when core.untrackedCache true, and fsmonitor' '
> +    git config core.untrackedCache true &&
> +	git config core.fsmonitor true &&
> +    git status | sed "s/[0-9]\.[0-9][0-9]/X/g" >../actual &&
> +    test_cmp "$DATA/with_untrackedcache_with_fsmonitor" ../actual &&
> +    rm -fr ../actual
> +'
> +
> +test_done
> diff --git a/t/t7065/no_untrackedcache_no_fsmonitor b/t/t7065/no_untrackedcache_no_fsmonitor
> diff --git a/t/t7065/with_untrackedcache_no_fsmonitor b/t/t7065/with_untrackedcache_no_fsmonitor
> diff --git a/t/t7065/with_untrackedcache_with_fsmonitor b/t/t7065/with_untrackedcache_with_fsmonitor

These files are small enough that I think I'd rather see them
be created in the test script. You can use this kind of syntax:

	cat >expect <<-\EOF
	<file contents here>
	EOF &&

and then the test is self-contained. This is particularly
helpful when a test fails due to some future change in this
message.

> +static inline int uf_was_slow(uint32_t untracked_in_ms)
> +{
> +	const char *x;
> +	x = getenv("GIT_TEST_UF_DELAY_WARNING");
> +	if (x) {
> +		untracked_in_ms += UF_DELAY_WARNING_IN_MS + 1;
> +	}
> +
> +	return UF_DELAY_WARNING_IN_MS < untracked_in_ms;
> +}
> +
>  static void show_merge_in_progress(struct wt_status *s,
>  				   const char *color)
>  {
> @@ -1814,6 +1827,7 @@ static void wt_longstatus_print(struct wt_status *s)
>  {
>  	const char *branch_color = color(WT_STATUS_ONBRANCH, s);
>  	const char *branch_status_color = color(WT_STATUS_HEADER, s);
> +	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(s->repo);
>  
>  	if (s->branch) {
>  		const char *on_what = _("On branch ");
> @@ -1870,13 +1884,23 @@ static void wt_longstatus_print(struct wt_status *s)
>  		wt_longstatus_print_other(s, &s->untracked, _("Untracked files"), "add");
>  		if (s->show_ignored_mode)
>  			wt_longstatus_print_other(s, &s->ignored, _("Ignored files"), "add -f");
> -		if (advice_enabled(ADVICE_STATUS_U_OPTION) && 2000 < s->untracked_in_ms) {
> -			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
> -			status_printf_ln(s, GIT_COLOR_NORMAL,
> -					 _("It took %.2f seconds to enumerate untracked files. 'status -uno'\n"
> -					   "may speed it up, but you have to be careful not to forget to add\n"
> -					   "new files yourself (see 'git help status')."),
> -					 s->untracked_in_ms / 1000.0);
> +		if (uf_was_slow(s->untracked_in_ms)) {
> +			if (advice_enabled(ADVICE_STATUS_U_OPTION)) {

Since there isn't an "else" for either of these cases, they can
be combined with "&&" in the top-level if, reducing the tab
depth for the body.

> +				status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
> +				if (fsm_mode > FSMONITOR_MODE_DISABLED) {
> +					status_printf_ln(s, GIT_COLOR_NORMAL,
> +							_("It took %.2f seconds to enumerate untracked files,\n"
> +							"but this is currently being cached."),
> +							s->untracked_in_ms / 1000.0);
> +				} else {
> +					status_printf_ln(s, GIT_COLOR_NORMAL,
> +							_("It took %.2f seconds to enumerate untracked files."),
> +							s->untracked_in_ms / 1000.0);
> +				}
> +				status_printf_ln(s, GIT_COLOR_NORMAL,
> +						_("See 'git help status' for information on how to improve this."));
> +				status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
> +			}
>  		}

other than that nit, the code looks good to me.

Thanks for working on this!
-Stolee
