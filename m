Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 435371F453
	for <e@80x24.org>; Thu, 17 Jan 2019 22:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfAQWIo (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 17:08:44 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37995 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfAQWIo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 17:08:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so12798147wrw.5
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 14:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2NFX2clNbRnxmKSk0f3jdSTd7UjqFCvdL82MRSsmyOI=;
        b=eDjLN3hzkv+2017k+1y0Dk7CwB38bP8hkfPwMXX9PTV04PspMkES5H8cu96r+GZbkM
         WEuc6q518nh2u55uIeMwBQWN2VBlT1qTf1bA34ng1RUnxZWOXBvLwc/EnbPYUfw07ib0
         EScsFwcVTkPK76qiKATfyr/bq9TNjSid8SdI7UPTPAkkD1TxO6mUcH4HAgCKNxEs7Twx
         TXiluplWGZigY3AF9xXEfFA1Be6NTEJb1P0Uivt4uJZ4ysKjZjdyzKzIPtt0vS1w4JJA
         Fmsuum2mN1/10Q2abpkVvvNtCCgSzVOqvkz5Fn/Pl1i1qAGdPDEIRIMK8VZWo1Jxssnx
         s/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2NFX2clNbRnxmKSk0f3jdSTd7UjqFCvdL82MRSsmyOI=;
        b=NYRjPJt0n2PSJ9FEOdC9qRY6d1dIjAwMQyZIewwdiw5a34LvBaVvZGyJ5WYhEJXDOu
         56MauDyz7WBExBtZEhfXoThzznU5arsSlyQCUZ9wcCms6wgmdu0aHiizPlYDdx7cnP4z
         f8hkuW1tmmPUSFvbvt7Xo4LzapXLVKSUgLSad2kGNy8x55UH03AK56wyaKLiGbj40oxh
         I8cPUEaKFehiWjzE4peFzCiNq1uri8osKOz6xRvTANtb3KW+BWTEiImPwlISX8FwPvp2
         wrGc36qWQNHD+sdSKU0sT5A1Vb8MV06XcN+QjjMY5YnRNL/xTkZ2///67htIa7WMXws9
         nw+A==
X-Gm-Message-State: AJcUukeEkfthm1KOaQcotvezYR5m1vr3kbaxJT5/keNSsu+/f6j5hpDk
        1EzJalGWgKDspLfVymk5Wro=
X-Google-Smtp-Source: ALg8bN5PEvRS8RPFu7g1efxm1/Y0SoGfjYEsegE4lJrgMRYcIYeCdztsyzsS8abfqurm06TF+J84BA==
X-Received: by 2002:adf:e5d0:: with SMTP id a16mr13624026wrn.89.1547762922309;
        Thu, 17 Jan 2019 14:08:42 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o3sm66290434wrs.30.2019.01.17.14.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 14:08:41 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] ls-refs: filter refs based on non-namespace name
References: <20190117200207.81825-1-jonathantanmy@google.com>
Date:   Thu, 17 Jan 2019 14:08:41 -0800
In-Reply-To: <20190117200207.81825-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Thu, 17 Jan 2019 12:02:07 -0800")
Message-ID: <xmqq8szjlyxi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Protocol v2 allows for filtering of ref advertisement based on a
> client-given name prefix, but inclusion/exclusion is determined based on
> the non-namespace-stripped version (e.g. matching a ref prefix of
> "refs/heads" against "refs/namespaces/my-namespace/refs/heads/master")
> instead of the namespace-stripped version, which is the one that the
> user actually sees.
>
> Determine inclusion/exclusion based on the namespace-stripped version.
>
> This bug was discovered through applying patches [1] that override
> protocol.version to 2 in repositories when running tests, allowing us to
> notice differences in behavior across different protocol versions.
>
> [1] https://public-inbox.org/git/cover.1547677183.git.jonathantanmy@google.com/
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> Another bug discovered through GIT_TEST_PROTOCOL_VERSION.

OK, so "ls-refs: filter based on non-namespace name" (in the title) is a
means to the objective 'ls-refs: make sure it honors namespaces"
which is a bugfix?

The new test peeks at the protocol level, but wouldn't we be able to
see the breakage by running ls-remote or something and observing its
result as well, or is the bug only observable with test-tool and not
triggerable by end-user facing git commands?

> If the patches in [1] above are merged with this patch, a test that
> previously failed on GIT_TEST_PROTOCOL_VERSION=2 now passes.
>
> I'm not sure of the relevance of the last paragraph and the "[1]" in the
> commit message - feel free to remove it. Since the relevant patches are
> not merged yet, the e-mails are probably the best reference, and I have
> tried to summarize what they do concisely.
> ---
>  ls-refs.c            |  2 +-
>  t/t5701-git-serve.sh | 21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/ls-refs.c b/ls-refs.c
> index a06f12eca8..7782bb054b 100644
> --- a/ls-refs.c
> +++ b/ls-refs.c
> @@ -40,7 +40,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
>  	const char *refname_nons = strip_namespace(refname);
>  	struct strbuf refline = STRBUF_INIT;
>  
> -	if (!ref_match(&data->prefixes, refname))
> +	if (!ref_match(&data->prefixes, refname_nons))
>  		return 0;
>  
>  	strbuf_addf(&refline, "%s %s", oid_to_hex(oid), refname_nons);
> diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
> index ae79c6bbc0..ec13064ecd 100755
> --- a/t/t5701-git-serve.sh
> +++ b/t/t5701-git-serve.sh
> @@ -112,6 +112,27 @@ test_expect_success 'basic ref-prefixes' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'ref prefix with namespaced repository' '
> +	# Create a namespaced ref
> +	git update-ref refs/namespaces/ns/refs/heads/master "$(git rev-parse refs/tags/one)" &&
> +
> +	test-tool pkt-line pack >in <<-EOF &&
> +	command=ls-refs
> +	0001
> +	ref-prefix refs/heads/master
> +	0000
> +	EOF
> +
> +	cat >expect <<-EOF &&
> +	$(git rev-parse refs/tags/one) refs/heads/master
> +	0000
> +	EOF
> +
> +	GIT_NAMESPACE=ns git serve --stateless-rpc <in >out &&
> +	test-tool pkt-line unpack <out >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'refs/heads prefix' '
>  	test-tool pkt-line pack >in <<-EOF &&
>  	command=ls-refs
