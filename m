Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C59DC433E1
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 22:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4795D2082E
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 22:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTIEXryO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgG2WTJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgG2WTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 18:19:09 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091BCC061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 15:19:09 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id p1so12656910pls.4
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 15:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z1wrI3giFXYpEc+CN0iwCrrG3RfJMy0nDjpRsb2DE10=;
        b=ZTIEXryOVquL9F8BPFdIHt8eK0i/iUXJ+x+zmZ/miVnYWaVzjH0DH2zGo8BtlWCfJQ
         nQY8/M/maZo1HTVujG/K3W1DhN3KKYTARSJVnMP7h4cYIWXGD7wUC302EqKbjUqWPeuO
         I1bUAIDjoBwjusk4DAsIxT2qTRvUNdQ8+6ViJaYG4uEedWqX4FJX5Ja4A9Y3dPI53Dmk
         I6m2ONOcC6mEDk5oEtPeq46TnroO3WEbWBO3lud4NkjKh4HdoK2kcNimvcky7d6lvll1
         jnnp7yu1PZi554CBJT660dr2ldv+c5dYK7VP7yQ1dKG58g6tMiOIDuG3G5+vdUdpjCFr
         1ZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z1wrI3giFXYpEc+CN0iwCrrG3RfJMy0nDjpRsb2DE10=;
        b=mNn5/zVUBeXDIvnwUmbq+wlRqJ0QHbipl7VqFcxwk46BRbu8mNfw4YdzhYUK/U0Qda
         NToAmcgOXgu5fImcEAJzKJ5UJ0aDBxeA6u8NE5r+YwXvCQrmoV3nazc2SVp9S1SjLSb7
         u85hjTej7VeBPjx/So6mWv3Je4uv2LZXHLve/sdUJelblQioR2lYaziVWEb+DVrBaiCd
         4vKGU2X+0ru+Jxf29ooxKkfQXG/Wm4BKu9ro9Sxqikiq3ARGhkVPDYf9kBLundOLtKIs
         aigQs31Ndq6+YlcDq+7Xk4Vhtyty7WqgTliy+Pld636sblPN9kGg0Xfr7J+KYEcpPqYJ
         dCJA==
X-Gm-Message-State: AOAM5316vuhXOCYp36ZYXOIKPWnWn9YCcsehPjSS/42tWn/nC6VgupJT
        x/Z4Rxx7zebcotergoRYoeA=
X-Google-Smtp-Source: ABdhPJyjCcU12lRyMaPJHJpXiwxCe48wtLyTlPAyzvLZjZTJHvJBwO/9xkyplprEmQduKJCcNMevyw==
X-Received: by 2002:a17:90a:cf05:: with SMTP id h5mr11437592pju.219.1596061148482;
        Wed, 29 Jul 2020 15:19:08 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id q22sm3493195pgn.91.2020.07.29.15.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 15:19:07 -0700 (PDT)
Date:   Wed, 29 Jul 2020 15:19:05 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 01/18] maintenance: create basic maintenance runner
Message-ID: <20200729221905.GB519065@google.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <63ec602a07756a41f8ccddd745562c567a4b3ed7.1595527000.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63ec602a07756a41f8ccddd745562c567a4b3ed7.1595527000.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Derrick Stolee wrote:

> [Subject: maintenance: create basic maintenance runner]

Seems sensible, and a good way to set up for the later patches.  Let's
take a look at how it does that.

[...]
> --- /dev/null
> +++ b/Documentation/git-maintenance.txt
> @@ -0,0 +1,57 @@
[...]
> +SUBCOMMANDS
> +-----------
> +
> +run::
> +	Run one or more maintenance tasks.

[jrnieder] How do I supply the tasks on the command line?  Are they
parameters to this subcommand?  If so, it could make sense for this to
say something like

	run <task>...::

What is the exit code convention for "git maintenance run"?  (Many Git
commands don't document this, but since we're making a new command
it seems worth building the habit.)

[...]
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -699,3 +699,62 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
[...]
> +static struct maintenance_opts {
> +	int auto_flag;
> +} opts;

Packing this in a struct feels a bit unusual.  Is the struct going to
be passed somewhere, or could these be individual locals in
cmd_maintenance?

[...]
> +
> +static int maintenance_task_gc(void)
> +{
> +	int result;
> +	struct argv_array cmd = ARGV_ARRAY_INIT;
> +
> +	argv_array_pushl(&cmd, "gc", NULL);
> +
> +	if (opts.auto_flag)
> +		argv_array_pushl(&cmd, "--auto", NULL);

These are both pushing single strings, so they can use argv_array_push.

[...]
> --- /dev/null
> +++ b/t/t7900-maintenance.sh
> @@ -0,0 +1,22 @@
> +#!/bin/sh
> +
> +test_description='git maintenance builtin'
> +
> +GIT_TEST_COMMIT_GRAPH=0
> +GIT_TEST_MULTI_PACK_INDEX=0

Why does this disable commit graph and multipack index?  Is that setting
up for something that comes later?

[...]
> +test_expect_success 'gc [--auto]' '
> +	GIT_TRACE2_EVENT="$(pwd)/run-no-auto.txt" git maintenance run &&
> +	GIT_TRACE2_EVENT="$(pwd)/run-auto.txt" git maintenance run --auto &&
> +	grep ",\"gc\"]" run-no-auto.txt  &&
> +	grep ",\"gc\",\"--auto\"]" run-auto.txt

This feels a little odd in two ways:

- the use of "git gc" isn't a user-facing detail, so this is testing
  implementation instead of the user-facing behavior.  That's okay,
  though --- it can be useful to test internals sometimes.

- the way that this tests for "git gc" feels brittle: if the trace
  emitter changes some day to include a space after the comma, for
  example, then the test would start failing.  I thought that in the
  spirit of fakes, it could make sense to write a custom "git gc"
  command using test_write_script, but that isn't likely to work
  either since gc is a builtin.

Perhaps this is suggesting that we need some central test helper for
parsing traces so we can do this reliably in one place.  What do you
think?

Thanks,
Jonathan
