Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE08C7EE29
	for <git@archiver.kernel.org>; Fri,  9 Jun 2023 23:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbjFIXgH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jun 2023 19:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjFIXfs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2023 19:35:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C404358C
        for <git@vger.kernel.org>; Fri,  9 Jun 2023 16:33:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bb39aebdd87so5110140276.0
        for <git@vger.kernel.org>; Fri, 09 Jun 2023 16:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686353597; x=1688945597;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E17PNLxtLkKJztwDduh6SvkO5nYGv/Wzn48MEWAvAHI=;
        b=2HrDthVFp1sAxckoiXBzzDlotJAypSww369zPDBvnSq7Q1UqJ350E8JeF2IkaGRJFK
         WR5Yt8i3ncG//nFU23gn77lL1JiGkifIW6avffQlplgmxzQnCQTVb0NkOlQsv+bN12pZ
         E0mcw20Uni1wF0Szp10IDtNiexDkHsXPQ6G1j7B/rWau92C+QxGsOydMkXifCUc0YgLy
         GwKaRdJqXkrKh6YhXtiFAsnLGbx2SbrB2iqKk0/QyGWHGkQh1ICSSaS4uwQjegpisdRi
         CHJIaQvA9xDtwJ2rj4ouqnEKBNDHBUFM/KR1NJ7g+q9iILsgZC5KMCdznsRGQ+RoTaAP
         WcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686353597; x=1688945597;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E17PNLxtLkKJztwDduh6SvkO5nYGv/Wzn48MEWAvAHI=;
        b=J8hv4sCLry96l2uPhiBqyjEZ3cqcDn3+maulVvl961n/ju13w0w/xrLl4GDn8axSKF
         hewu5GZ9tMlKnKJY9XSjWz1W4L1h4+6De0ZG5n8sybiIwMMPg1K5Pq6a1ZBR6moopJko
         Q+oc/ZQCS5F12VLtwGGxUUWcTK6LbrADeddsH/EFJgazCGDuxClqE5X89t/+PF5k0NnR
         faUjRm20T0Bpn9lcB+XLn+mJJFksCeDXqop76ldX39zuZTieP18w4t6S13fMyspcoHbM
         N+/bS7qZzS2kSPuZwX3+flImUdkWjkX/7YGKtdF0gQc4/pdgkelP+LQbCUVMr/BrLeM3
         ERfA==
X-Gm-Message-State: AC+VfDyqLeVIK7e1+BkKG4o4gi0RCUTJSIn3LbcoMSifGFynVetjrEWj
        s7pHrzzwIgjVLZYf+nljvEsZLRENQw3uZQ==
X-Google-Smtp-Source: ACHHUZ43owEbfEyAo8dO6yjbBRBcDqISfyKF2ePn1JQOASd5Mlg3ZleQYKeNUsCgvSE3o/iG9zSEhQqe4PF5MQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6902:211:b0:bb1:569c:f381 with SMTP
 id j17-20020a056902021100b00bb1569cf381mr1733284ybs.1.1686353597673; Fri, 09
 Jun 2023 16:33:17 -0700 (PDT)
Date:   Fri, 09 Jun 2023 16:33:10 -0700
In-Reply-To: <f661b54941a12c9bd8e226aebb4f0d53c10479c8.1686178684.git.me@ttaylorr.com>
Mime-Version: 1.0
References: <cover.1683847221.git.me@ttaylorr.com> <cover.1686178684.git.me@ttaylorr.com>
 <f661b54941a12c9bd8e226aebb4f0d53c10479c8.1686178684.git.me@ttaylorr.com>
Message-ID: <kl6lwn0cfbyh.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v5 2/2] gc: introduce `gc.recentObjectsHook`
From:   Glen Choo <chooglen@google.com>
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> When performing a garbage collection operation on a repository with
> unreachable objects, Git makes its decision on what to do with those
> object(s) bed on how recent the objects are or not. Generally speaking,

s/bed/based/ ?

> +gc.recentObjectsHook::
> +	When considering whether or not to remove an object (either when
> +	generating a cruft pack or storing unreachable objects as
> +	loose), use the shell to execute the specified command(s).
> +	Interpret their output as object IDs which Git will consider as
> +	"recent", regardless of their age. By treating their mtimes as
> +	"now", any objects (and their descendants) mentioned in the
> +	output will be kept regardless of their true age.

Thanks! I think this version will be clear to prospective users.

> +static int run_one_gc_recent_objects_hook(struct oidset *set,
> +					    const char *args)
> +{
> +	struct child_process cmd = CHILD_PROCESS_INIT;
> +	struct strbuf buf = STRBUF_INIT;
> +	FILE *out;
> +	int ret = 0;
> +
> +	cmd.use_shell = 1;
> +	cmd.out = -1;
> +
> +	strvec_push(&cmd.args, args);
> +
> +	if (start_command(&cmd))
> +		return -1;
> +
> +	out = xfdopen(cmd.out, "r");
> +	while (strbuf_getline(&buf, out) != EOF) {
> +		struct object_id oid;
> +		const char *rest;
> +
> +		if (parse_oid_hex(buf.buf, &oid, &rest) || *rest) {
> +			ret = error(_("invalid extra cruft tip: '%s'"), buf.buf);

To be consistent with the other error message, perhaps s/extra cruft
tip/additional recent object/?

> +static void load_gc_recent_objects(struct recent_data *data)
> +{
> +	const struct string_list *programs;
> +	int ret = 0;
> +	size_t i;
> +
> +	data->extra_recent_oids_loaded = 1;
> +
> +	if (git_config_get_string_multi("gc.recentobjectshook", &programs))
> +		return;
> +
> +	for (i = 0; i < programs->nr; i++) {
> +		ret = run_one_gc_recent_objects_hook(&data->extra_recent_oids,
> +						       programs->items[i].string);
> +		if (ret)
> +			die(_("unable to enumerate additional recent objects"));

This error message to be exact.

> +test_expect_success 'gc.recentObjectsHook' '
> +	git init repo &&
> +	test_when_finished "rm -fr repo" &&
> +	(
> +		cd repo &&
> +
> +		# Create a handful of objects.
> +		#
> +		#   - one reachable commit, "base", designated for the reachable
> +		#     pack
> +		#   - one unreachable commit, "cruft.discard", which is marked
> +		#     for deletion
> +		#   - one unreachable commit, "cruft.old", which would be marked
> +		#     for deletion, but is rescued as an extra cruft tip

Perhaps we intended to drop "cruft tips" in the test comments too? e.g.
here and..

> +test_expect_success 'multi-valued gc.recentObjectsHook' '
> +	git init repo &&
> +	test_when_finished "rm -fr repo" &&
> +	(
> +		cd repo &&
> +
> +		test_commit base &&
> +		git branch -M main &&
> +
> +		git checkout --orphan cruft.a &&
> +		git rm -fr . &&
> +		test_commit --no-tag cruft.a &&
> +		cruft_a="$(git rev-parse HEAD)" &&
> +
> +		git checkout --orphan cruft.b &&
> +		git rm -fr . &&
> +		test_commit --no-tag cruft.b &&
> +		cruft_b="$(git rev-parse HEAD)" &&
> +
> +		git checkout main &&
> +		git branch -D cruft.a cruft.b &&
> +		git reflog expire --all --expire=all &&
> +
> +		echo "echo $cruft_a" | write_script extra-tips.a &&
> +		echo "echo $cruft_b" | write_script extra-tips.b &&
> +		echo "false" | write_script extra-tips.c &&
> +
> +		git rev-list --objects --no-object-names $cruft_a $cruft_b \
> +			>cruft.raw &&
> +		sort cruft.raw >cruft.expect &&
> +
> +		# ensure that each extra cruft tip is saved by its

here.

Aside from those trivial points, everything looks good.
