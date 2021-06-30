Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3596C11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 06:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C368361CD6
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 06:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhF3GS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 02:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhF3GS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 02:18:28 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1772DC061766
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 23:15:59 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id i24so1578574edx.4
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 23:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=h1vlFrFd8AEZyQ1KNHDsqWbAqU9BOSp8ORwxmpdyHl0=;
        b=mDYp+gAjccSrKhdedwO7X+Y7iCuPZ9tY8p0B1zVMfx+OAYJv2hx84Oj7oE0fR9crhh
         q42sgfO7cnu8rJIjnKkZ7lcJTedK5Q7eH0l/TC9eAKIvQQeBk0IyaJbx00hul+wuDfDc
         Kdun3VtIu3ySt549dIJti1pMYBP8NY9/uChm6xgKnOgD6aoT3347sczHQGhhvfICvvqL
         0Rz1+X+GLxd3njDAkiEIVXks7+22T9FItqBAZ4IrmiFpIM7L/LRxFVLaQcXfKD14s8am
         GnKKeQgXEbPPm9JRtd1nXIwg4gNTkCc2nwNxMckSzx778OvISeaOwK4m5edHJy6p+W24
         /z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=h1vlFrFd8AEZyQ1KNHDsqWbAqU9BOSp8ORwxmpdyHl0=;
        b=JnDJ8Wnw+SZFkfet7df6occpPsSXV1Lu5vb+iqePik/iwnHQ6BUB12WjICxrUoo36l
         3xjodQOdKdiqwwxhKPqr0VivI4PS3IBewnIf3l3ai4hNNzZXwyqetGblqXTAy3nIbmoT
         eDmOlOT9gErodxUmrDC4kSKHvNri4MKSyBKB1saNjiPeOA+2DEYRGmn9veVXmSGU5O6l
         V0pCh6vqIH3vYA4GrUVNXmcT2tuZmMcg12Qpe8bYf/BqVkpGnVWNMd2+Cp4nC/D126ft
         mI91KVvWCktLu5SMn9IbKPgy7n3V5JxoXCcRo0ZIh/IqoPZIk8WzF3gTf81uSdEEH89R
         Su4A==
X-Gm-Message-State: AOAM533wE8wnZwN5iMBUutt2xMeW8/ZVXFlAkqdb4BIkDY/QeOv3WEfG
        DpGFvSp/gdt2s4D6EZcgShQ=
X-Google-Smtp-Source: ABdhPJx0K9alU0fEOBEIYxELwvr3o+DirYR22CXQ2luyGzNTKx/tyQlji9Z8rAKxnFwuqGkbsIvQjA==
X-Received: by 2002:a05:6402:6ca:: with SMTP id n10mr27002157edy.122.1625033757613;
        Tue, 29 Jun 2021 23:15:57 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id p23sm8830589edw.94.2021.06.29.23.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 23:15:56 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v5] tr2: log parent process name
Date:   Wed, 30 Jun 2021 08:10:59 +0200
References: <20210608221059.1935021-1-emilyshaffer@google.com>
 <3327f108-6cd1-1d3d-eae9-2cdff96e1375@jeffhostetler.com>
 <YNux62he9Mk43Y1B@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YNux62he9Mk43Y1B@google.com>
Message-ID: <87a6n7g9np.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 29 2021, Emily Shaffer wrote:

> On Mon, Jun 28, 2021 at 12:45:24PM -0400, Jeff Hostetler wrote:
>> On 6/8/21 6:10 PM, Emily Shaffer wrote:
>> > Range-diff against v4:
>> > 1:  efb0a3ccb4 ! 1:  7a7e1ebbfa tr2: log parent process name
>> >      @@ compat/procinfo.c (new)
>> >       +	strbuf_addf(&procfs_path, "/proc/%d/comm", getppid());
>> >       +	if (strbuf_read_file(&name, procfs_path.buf, 0)) {
>> >       +		strbuf_release(&procfs_path);
>> >      ++		strbuf_trim_trailing_newline(&name);
>> >       +		strvec_push(names, strbuf_detach(&name, NULL));
>> >       +	}
>> >       +
>> 
>> You're only getting the name of the command (argv[0]) and not the
>> full command line, right?  That is a good thing.
>
> Roughly. The name can be reset by the process itself (that's what
> happened, I guess, in the tmux case I pasted below) but by default it's
> argv[0]. It's also truncated to 15ch or something.

16 including the \0. See prctl(2). Linux has two different ways to
set/get the name, one is the argv method, the other is
prctl(PR_SET_NAME). They don't need to match at all. The ps(1) utility
and some top-like utilities allow you to switch between viewing the two
versions.

As noted in the linked manual pages you'll also potentially need to deal
with multithreaded programs having different names for each thread.

I don't think we use this now, but FWIW one thing I've wanted to do for
a while was to have the progress.c code update this, so you see if git's
at N% counting objects or whatever in top.

>> > +#ifdef HAVE_PROCFS_LINUX
>> > +	/*
>> > +	 * NEEDSWORK: We could gather the entire pstree into an array to match
>> > +	 * functionality with compat/win32/trace2_win32_process_info.c.
>> > +	 * To do so, we may want to examine /proc/<pid>/stat. For now, just
>> > +	 * gather the immediate parent name which is readily accessible from
>> > +	 * /proc/$(getppid())/comm.
>> > +	 */
>> > +	struct strbuf procfs_path = STRBUF_INIT;
>> > +	struct strbuf name = STRBUF_INIT;
>> > +
>> > +	/* try to use procfs if it's present. */
>> > +	strbuf_addf(&procfs_path, "/proc/%d/comm", getppid());
>> > +	if (strbuf_read_file(&name, procfs_path.buf, 0)) {
>> > +		strbuf_release(&procfs_path);
>> > +		strbuf_trim_trailing_newline(&name);
>> > +		strvec_push(names, strbuf_detach(&name, NULL));
>> > +	}
>> > +
>> > +	return;
>> > +#endif
>> > +	/* NEEDSWORK: add non-procfs-linux implementations here */
>> > +}
>> 
>> Perhaps this has already been discussed, but would it be better
>> to have a "compat/linux/trace2_linux_process_info.c"
>> or "compat/procfs/trace2_procfs_process_info.c" source file and
>> only compile it in Linux-compatible builds -- rather than #ifdef'ing
>> the source.  This is a highly platform-specific feature.
>> 
>> For example, if I convert the Win32 version to use your new event,
>> I wouldn't want to move the code.
>> 
>> I just noticed that you have both "BASIC_CFLAGS+=" and a "COMPAT_OBSJ+="
>> lines.  If you made this source file procfs-specific, you wouldn't need
>> the ifdef and you could avoid the new CFLAG.


In general we've preferred not using ifdefs at all except for the small
bits that absolutely need it.

So e.g. in this case the whole code should compile on non-Linux, we just
need a small boolean guard somewhere to check what the platform is.

It means we don't have significant pieces of code that don't compile
except on platform X. It's easy to get into your code not compiling if
you overuse ifdefs.
