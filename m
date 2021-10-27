Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D250C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 21:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78D9460E73
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 21:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239333AbhJ0VUB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 17:20:01 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53220 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235594AbhJ0VUA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 17:20:00 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D051714BCF3;
        Wed, 27 Oct 2021 17:17:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/iv40dEZmpjhwt53mpzNEn3pkq1kBijH5Q1D2V
        V/b90=; b=J4iStFzCvtUdEoIXm4huUKcX/8ikgCRLQ/lg9CCk5b0bv3Atw5+avi
        ekEx4qzVF4a8cigR1h4c5Sb6Wzn5TnYHvex09JzfrUO8EkLb2Q3CLtD8BQlCzUO6
        Qo84j5MxhaqXI6+grrobMf9rUVlDRE8WCO8+buXR2Hwpz6dcBP2G0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C90AE14BCF2;
        Wed, 27 Oct 2021 17:17:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2E27614BCF0;
        Wed, 27 Oct 2021 17:17:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 2/2] docs: add headers in MyFirstObjectWalk
References: <pull.1063.git.1635343531.gitgitgadget@gmail.com>
        <33cd9b2e8a675bf79132d312da8b7d8f4a2b84a3.1635343531.git.gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 14:17:31 -0700
In-Reply-To: <33cd9b2e8a675bf79132d312da8b7d8f4a2b84a3.1635343531.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Wed, 27 Oct 2021 14:05:31
        +0000")
Message-ID: <xmqqk0hyupzo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C416B80-376B-11EC-B303-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  Add usage text and `-h` handling, like all subcommands should consistently do
> -(our test suite will notice and complain if you fail to do so).
> +(our test suite will notice and complain if you fail to do so). We'll need to include
> +the "parse-options.h" header.

OK, but wrap this overlong line.  All the lines updated by this
patch, except the one in the last hunk, have become overly long.

[jc: cc'ed the primary author of the document to sanity checking]

Thanks.

>  
>  ----
> +#include "parse-options.h"
> +
> +...
> +
>  int cmd_walken(int argc, const char **argv, const char *prefix)
>  {
>  	const char * const walken_usage[] = {
> @@ -195,9 +200,13 @@ Similarly to the default values, we don't have anything to do here yet
>  ourselves; however, we should call `git_default_config()` if we aren't calling
>  any other existing config callbacks.
>  
> -Add a new function to `builtin/walken.c`:
> +Add a new function to `builtin/walken.c`. We'll also need to include the "config.h" header:
>  
>  ----
> +#include "config.h"
> +
> +...
> +
>  static int git_walken_config(const char *var, const char *value, void *cb)
>  {
>  	/*
> @@ -229,8 +238,14 @@ typically done by calling `repo_init_revisions()` with the repository you intend
>  to target, as well as the `prefix` argument of `cmd_walken` and your `rev_info`
>  struct.
>  
> -Add the `struct rev_info` and the `repo_init_revisions()` call:
> +Add the `struct rev_info` and the `repo_init_revisions()` call. We'll also need to include
> +the "revision.h" header:
> +
>  ----
> +#include "revision.h"
> +
> +...
> +
>  int cmd_walken(int argc, const char **argv, const char *prefix)
>  {
>  	/* This can go wherever you like in your declarations.*/
> @@ -624,9 +639,14 @@ static void walken_object_walk(struct rev_info *rev)
>  ----
>  
>  Let's start by calling just the unfiltered walk and reporting our counts.
> -Complete your implementation of `walken_object_walk()`:
> +Complete your implementation of `walken_object_walk()`. We'll also need to
> +include the "list-objects.h" header.
>  
>  ----
> +#include "list-objects.h"
> +
> +...
> +
>  	traverse_commit_list(rev, walken_show_commit, walken_show_object, NULL);
>  
>  	printf("commits %d\nblobs %d\ntags %d\ntrees %d\n", commit_count,
