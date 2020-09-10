Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619B2C433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 02:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A8B21D6C
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 02:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6L8BUMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbgIJCAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730030AbgIJBrq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 21:47:46 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F9BC061347
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 17:32:00 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id l126so3618560pfd.5
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 17:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l0ohdfCq1t1R7/wS8gWCZeHb6rMWLZGqDgQCtWWwlV4=;
        b=p6L8BUMB4rpjRQDtFr7dZzg1KZLrFnV8bOOt9zPNgMT45CLrZP+frwhUYiDIySJXx8
         D+H0LeMI+XX7C+05JUwut+u3VoA8RILBFp5rDDMr5d1VGxMgVydks3zR5fIvFwlprOY5
         nOhVQJc/epvJaz/YmLwlOUoBZZqlqX2cSUFplfQWYAK7JAH2dzw5AHDJJC22J3FlafvE
         2Umo8JqfnGbFHvgxQT0vvnnwhiR7gC0rd5vaxPQejzPH/ztftv13/vsmDWLxRSXQoXtg
         6ORS8M207DVFliSXOfrXxG90qLwwcFQ4++qRQcN/TFeU8VpcsFaZkj1swFSNrGXgSzuE
         +PzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l0ohdfCq1t1R7/wS8gWCZeHb6rMWLZGqDgQCtWWwlV4=;
        b=k4bLNEz18C96UMW+E8/iFxjmqxY4Gs2cpGiY4Gi6z3KaXUnNJuWrGdcUDrSXa7/kpq
         lPpfAxkcLtYs2gbkLM3txD8UUyN0DRo5x5NYJ25LbSo9+pxF3jhsSHNmgVOYUwWcL/Fi
         dJTMBFYQk6e4WELyda+ZgZKsJY4KzGpOMzyAhSoXWc2PXz1GTjBhZw7vu1ISye1aX5Fz
         fM414287O/GwjefJziXzyCivWxTis3qadxZinbiY4Lm6DECps6L4s8wUqRhDBamSJJC4
         sxnwW8bIgRWoYErOzk1TSMorHov1qLrdRM4XjI5lWzSkGXZChMBmdsfS1vzQrK7GZFCV
         gNxA==
X-Gm-Message-State: AOAM530To1pmVRPDHaGexe6fGJBy81PMOEMbo8sPpTXIAarT+3vQGhTu
        c8mHtMLoDxKNaxqFL+rH8IBhFBwhnCo=
X-Google-Smtp-Source: ABdhPJwKyKHduyh66a3VDft9Shb1HWciz/LBEPq3yAwQRa6MQyQNs+rrmGgX8TpZhKpBpQQo8tsnfg==
X-Received: by 2002:a63:1443:: with SMTP id 3mr2314762pgu.291.1599697920069;
        Wed, 09 Sep 2020 17:32:00 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id n21sm3303664pgl.7.2020.09.09.17.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 17:31:59 -0700 (PDT)
Date:   Wed, 9 Sep 2020 17:31:57 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] progress: create progress struct in 'verbose' mode
Message-ID: <20200910003157.GB667601@google.com>
References: <20200710014242.1088216-1-emilyshaffer@google.com>
 <20200710014242.1088216-2-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710014242.1088216-2-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Emily Shaffer wrote:

> Before now, the progress API is used by conditionally calling
> start_progress() or a similar call, and then unconditionally calling
> display_progress() and stop_progress(), both of which are tolerant of
> NULL or uninitialized inputs.

Being super nitpicky for a moment:

- Git's commit messages describe the behavior without the patch in
  the present tense, as though the author were writing a bug report.
  so "Before now" can be "Today".

- with an uninitialized input, display_progress would produce undefined
  behavior and likely crash ;-)

[...]
> Since this changes the API, also modify callers of start_progress() and
> friends to drop their conditional and pass a new argument in instead.

If I understand correctly, the calling sequence before this patch is
something like

	struct progress *progress =
		want_progress ? start_progress(title, n) : NULL;

	for (int i = 0; i < n; i++) {
		... do some work ...
		display_progress(progress, i);
	}

	stop_progress(progress);

and this patch changes it to

	struct progress *progress = start_progress(title, n, want_progress);

	for (int i = 0; i < n; i++) {
		... do some work ...
		display_progress(progress, i);
	}

	stop_progress(progress);

A few consequences:

- it's a little briefer, which is nice

- progress is always non-NULL, so we can't express

	if (progress) {
		for ( ... ) {
			... do one chunk of work ...
			display_progress(...);
		}
	} else {
		... do work slightly more efficiently, all in one chunk ...
	}

- even if we don't want progress, we always spend the overhead of
  allocating a progress struct (not a big deal)

- if 'n' is a more complex expression (e.g. a function call), it gets
  computed even if we don't want progress.  For example, in "git fsck",
  as Junio noticed, this means accumulating the object counts from all
  idx files just to throw them away.

- the motivation: it means the progress API can be aware of whether
  the caller wants to write progress to the terminal and has control
  over what to do with that information.

  In particular this makes the function name display_progress even
  more of a misnomer --- before this patch, display_progress on a
  non-NULL progress struct would display some progress information and
  possibly also write something to traces, but after this patch it
  sometimes only writes something to traces.

Overall I think it's an improvement in the API.  It opens the door to
future changes like making the progress API handle isatty checks in
some cases, perhaps.

[...]
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
[...]
> @@ -836,16 +836,15 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
>  			uint32_t total = 0, count = 0;
>  			struct progress *progress = NULL;
>  
> -			if (show_progress) {
> -				for (p = get_all_packs(the_repository); p;
> -				     p = p->next) {
> -					if (open_pack_index(p))
> -						continue;
> -					total += p->num_objects;
> -				}
> -
> -				progress = start_progress(_("Checking objects"), total);
> +			for (p = get_all_packs(the_repository); p;
> +			     p = p->next) {
> +				if (open_pack_index(p))
> +					continue;
> +				total += p->num_objects;
>  			}
> +
> +			progress = start_progress(_("Checking objects"), total,
> +						  show_progress);

As Jonathan mentions[1], this is nothing next to the work that fsck is
about to do on those objects, so although it's aesthetically
unappealing to have to compute this total just in order to throw it
away, it's not likely to make a big difference.

That said, what would an API look like that avoids that?

One possibility would be to make separate initialization and
start-of-progress calls:

	struct progress *progress = progress_new(show_progress, the_repository);

	if (progress_is_enabled(progress)) {
		for (...) {
			...
			total += ...
		}

		start_progress(progress, _("Checking objects"), total);
	}

Using a callback to supply the title and total like Jonathan suggests
is another possibility.  It seems a bit more fussy, though.

[...]
> --- a/progress.h
> +++ b/progress.h
> @@ -13,11 +13,13 @@ void progress_test_force_update(void);
>  
>  void display_throughput(struct progress *progress, uint64_t total);
>  void display_progress(struct progress *progress, uint64_t n);
> -struct progress *start_progress(const char *title, uint64_t total);
> -struct progress *start_sparse_progress(const char *title, uint64_t total);
> -struct progress *start_delayed_progress(const char *title, uint64_t total);
> +struct progress *start_progress(const char *title, uint64_t total, int verbose);
> +struct progress *start_sparse_progress(const char *title, uint64_t total,
> +				       int verbose);
> +struct progress *start_delayed_progress(const char *title, uint64_t total,
> +					int verbose);
>  struct progress *start_delayed_sparse_progress(const char *title,
> -					       uint64_t total);
> +					       uint64_t total, int verbose);
>  void stop_progress(struct progress **progress);
>  void stop_progress_msg(struct progress **progress, const char *msg);

This header contains no comments and there's no API docs for it in
Documentation/technical/ waiting to be copied into comments, so we end
up having to reverse engineer it.  Not about this patch, but it would
be nice to add an overview of the progress API to this file (e.g., to
show a typical calling sequence).

Since display_progress and display_throughput are no longer about
display, would it make sense to rename them (in a separate patch)?
For example,

	update_progress(progress, ++i);
	update_throughput(progress, bytes);

"update" is a bit vague but it may convey more clearly that this
affects traces too and not just what is written to the terminal.

> --- a/prune-packed.c
> +++ b/prune-packed.c
> @@ -31,8 +31,8 @@ static int prune_object(const struct object_id *oid, const char *path,
>  
>  void prune_packed_objects(int opts)
>  {
> -	if (opts & PRUNE_PACKED_VERBOSE)
> -		progress = start_delayed_progress(_("Removing duplicate objects"), 256);
> +	progress = start_delayed_progress(_("Removing duplicate objects"), 256,
> +					  (opts & PRUNE_PACKED_VERBOSE));

style nit: no need for parens around the function parameter (likewise
for most of these)

[...]
> --- a/t/t0500-progress-display.sh
> +++ b/t/t0500-progress-display.sh
> @@ -309,4 +309,31 @@ test_expect_success 'progress generates traces' '
>  	grep "\"key\":\"total_bytes\",\"value\":\"409600\"" trace.event
>  '
>  
> +test_expect_success 'progress generates traces even quietly' '

Nice.

With whatever subset of the changes discussed makes sense,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

[1] https://lore.kernel.org/git/20200909224253.866718-1-jonathantanmy@google.com
