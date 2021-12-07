Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC4BC433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 12:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbhLGMa6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 07:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbhLGMa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 07:30:56 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5755BC061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 04:27:26 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z5so56729660edd.3
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 04:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Lfur0wFXgMeGHY84yC5Su0KrkhBQeDk4OFbZabfJ4Xs=;
        b=BcvgM0IC9s1FiBj3SRKSTvDH3ik6VaEe+nZN8hNebc7LigCXZtHOkFomqvhLcyWSH0
         xITKKSwTZJFJyriqq5ZuedVW/4+kjtFy7G/OygMy41d26gPuV+AEkS90oKY4c95yavgr
         m5jVs30Yb63dlrdsccWhMwcKZilnINCRv/Jg3EuxeDcUUwoqklLwT0ieBX2XZrc/sXR/
         6xkqGBgk3ySyz+qg1rtlsyX5RnuF3YEd/RmXDhnIo7Z2U/oaueopTnTOVm0lMG9lU+vT
         iR8z1/VKmMJqvnhhsSNjG9uYhsTl5FR52CKZ+JZ0vyu1OYiQmlUZVs+k0+NVTI+PAqjv
         njQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Lfur0wFXgMeGHY84yC5Su0KrkhBQeDk4OFbZabfJ4Xs=;
        b=muaQYLaNFPeQCY1LmC25SUFX4SYxFdIjEVHQKiS3yO+6y1gh6d/39y60yZciyBB6J1
         9O2IYyzBcozKllp1mSO/T9A5GeluMq2zyiQ6JRf4rgvBMT/2d2V8mXG30rFCv7G2C1jG
         iQYwcWVg+QoTDQ5l96lnacXwoIs7PcwTaFwQVz1e3yuDjvSsdwydxdiexcspzwmUz71h
         yuD6URj6s1ZPlPCdet2v5v9PUU8ly2JjywRj0JMWiwyN4N7jiiQhWgxluBAmh2dnUtBG
         8GYd7zrTMMU4iECmmdPbtyn0Id6/BwUaAYAqLac0mWL5j6l+SVKteiggv8cF4wEnQXtQ
         BipA==
X-Gm-Message-State: AOAM5311oQk+IjT/ITUN65CD7tutyjvfD0YoPBZR0aKMybAwo8/yGz+k
        ijG+jeRm7qTOcPKHVZ/0dSIheRcwW2iTiw==
X-Google-Smtp-Source: ABdhPJxbzIA8MJyZk9mCXLpVR3LA45M2oxXm2SDHqywKOHX0C27ItZu26W+BUsDvvVI8UfHoz7N6XA==
X-Received: by 2002:a05:6402:1cb2:: with SMTP id cz18mr8759650edb.99.1638880044565;
        Tue, 07 Dec 2021 04:27:24 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ar2sm8389116ejc.20.2021.12.07.04.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 04:27:23 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1muZZ5-0018hk-64;
        Tue, 07 Dec 2021 13:27:23 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com, bagasdotme@gmail.com,
        newren@gmail.com, nksingh85@gmail.com, ps@pks.im,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 1/3] core.fsyncmethod: add writeout-only mode
Date:   Tue, 07 Dec 2021 13:18:31 +0100
References: <pull.1093.git.1638588503.gitgitgadget@gmail.com>
 <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com>
 <e79522cbdd4feb45b062b75225475f34039d1866.1638845211.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <e79522cbdd4feb45b062b75225475f34039d1866.1638845211.git.gitgitgadget@gmail.com>
Message-ID: <211207.861r2opplg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 07 2021, Neeraj Singh via GitGitGadget wrote:

> From: Neeraj Singh <neerajsi@microsoft.com>
>
> This commit introduces the `core.fsyncmethod` configuration

Just a commit msg nit: core.fsyncMethod (I see the docs etc. are using
it camelCased, good..

> diff --git a/compat/win32/flush.c b/compat/win32/flush.c
> new file mode 100644
> index 00000000000..75324c24ee7
> --- /dev/null
> +++ b/compat/win32/flush.c
> @@ -0,0 +1,28 @@
> +#include "../../git-compat-util.h"

nit: Just FWIW I think the better thing is '#include
"git-compat-util.h"', i.e. we're compiling at the top-level and have
added it to -I.

(I know a lot of compat/ and contrib/ and even main-tree stuff does
that, but just FWIW it's not needed).

> +	if (!strcmp(var, "core.fsyncmethod")) {
> +		if (!value)
> +			return config_error_nonbool(var);
> +		if (!strcmp(value, "fsync"))
> +			fsync_method = FSYNC_METHOD_FSYNC;
> +		else if (!strcmp(value, "writeout-only"))
> +			fsync_method = FSYNC_METHOD_WRITEOUT_ONLY;
> +		else

As a non-nit comment I think this config schema looks great so far.

> +			warning(_("unknown %s value '%s'"), var, value);

Just a suggestion maybe something slightly scarier like:

    "unknown core.fsyncMethod value '%s'; config from future git version? ignoring requested fsync strategy"

Also using the nicer camelCased version instead of "var" (also helps
translators with context...)

> +int git_fsync(int fd, enum fsync_action action)
> +{
> +	switch (action) {
> +	case FSYNC_WRITEOUT_ONLY:
> +
> +#ifdef __APPLE__
> +		/*
> +		 * on macOS, fsync just causes filesystem cache writeback but does not
> +		 * flush hardware caches.
> +		 */
> +		return fsync(fd);
> +#endif
> +
> +#ifdef HAVE_SYNC_FILE_RANGE
> +		/*
> +		 * On linux 2.6.17 and above, sync_file_range is the way to issue
> +		 * a writeback without a hardware flush. An offset of 0 and size of 0
> +		 * indicates writeout of the entire file and the wait flags ensure that all
> +		 * dirty data is written to the disk (potentially in a disk-side cache)
> +		 * before we continue.
> +		 */
> +
> +		return sync_file_range(fd, 0, 0, SYNC_FILE_RANGE_WAIT_BEFORE |
> +						 SYNC_FILE_RANGE_WRITE |
> +						 SYNC_FILE_RANGE_WAIT_AFTER);
> +#endif
> +
> +#ifdef fsync_no_flush
> +		return fsync_no_flush(fd);
> +#endif
> +
> +		errno = ENOSYS;
> +		return -1;
> +
> +	case FSYNC_HARDWARE_FLUSH:
> +		/*
> +		 * On some platforms fsync may return EINTR. Try again in this
> +		 * case, since callers asking for a hardware flush may die if
> +		 * this function returns an error.
> +		 */
> +		for (;;) {
> +			int err;
> +#ifdef __APPLE__
> +			err = fcntl(fd, F_FULLFSYNC);
> +#else
> +			err = fsync(fd);
> +#endif
> +			if (err >= 0 || errno != EINTR)
> +				return err;
> +		}
> +
> +	default:
> +		BUG("unexpected git_fsync(%d) call", action);

Don't include such "default" cases, you have an exhaustive "enum", if
you skip it the compiler will check this for you.

> +	}
> +}
> +
>  static int warn_if_unremovable(const char *op, const char *file, int rc)

Just a code nit: I think it's very much preferred if possible to have as
much of code like this compile on all platforms. See the series at
4002e87cb25 (grep: remove #ifdef NO_PTHREADS, 2018-11-03) is part of for
a good example.

Maybe not worth it in this case since they're not nested ifdef's.

I'm basically thinking of something (also re Patrick's comment on the
2nd patch) where we have a platform_fsync() whose return
value/arguments/whatever capture this "I want to return now" or "you
should be looping" and takes the enum_fsync_action" strategy.

Then the git_fsync() would be the platform-independent looping etc., and
another funciton would do the "one fsync at a time, maybe call me
again".

Maybe it would suck more, just food for thought... :)
