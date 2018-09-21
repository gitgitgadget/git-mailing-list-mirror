Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8B191F453
	for <e@80x24.org>; Fri, 21 Sep 2018 21:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391562AbeIVDE7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 23:04:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32968 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391560AbeIVDE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 23:04:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id n11-v6so2864034wro.0
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 14:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kQ78opCnJPi9dDQWHrUAtoZfJvgDRlpGaknneIhRArQ=;
        b=jmLh+wPO9DQl6q6FX0HfhYHfDALVeYcFihaGBsw/9jvlen6lmd7Gl4iWQA73Xuymye
         o5biL/ef8/P+pBk26eh1CRQAQbeB13Yli8wfNvPei6KAUNRGeb2A49QHGEf6ph1IUf0u
         x9vv6xCxR/Xperr1n9X27ML8WiIPy3GxNbP4YznQZh8v0LDRzSR1VGSANn0T3MHam8VB
         5IqYrQ1K3FStj4hzziuh7qSUkqa2AygJ2nCLKwy04PCH8JUKP0mAkVGlmu3f6+AjVRxX
         PtLWNMwJdNFjQqbbUwVVgTuUtGwHLdDX2VXzl26jkwrDKOiRsSnCEZtp00xWtoTLsgSi
         NC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kQ78opCnJPi9dDQWHrUAtoZfJvgDRlpGaknneIhRArQ=;
        b=cULAZK4C2JDY0rU/QHRUrd5mGWuDxZlqaB1uVQMBLSGPfPj4tlL8Y2vnJao7YBNCww
         24HuKrP9qouNyBZzBk9ZArKZQ9mj2jBECZN0GHZKpswoEgmh3/RBSaOJ6ibw0G0Clq27
         my+SMpPlwdew1L8oJIJkyYNMJISJbccBgdCBOsY376wGzvg31tP994uwRXkpB0jV2iTA
         S3gKhbb+gykvkeiH8t66jy8JUPxSXy9YC8mwXJVJCmuUcbcq91j+7euNWiy4+8JY7a3R
         tQIL0qzhCtzyuCIn5Ih5kDe38DgNAFYUrSmuJbTi+Gc8R8OysvGm5ndP34mt+uLLydf7
         JrrA==
X-Gm-Message-State: APzg51BhsRCEyRIaZxo56LChd/2YOYRkw0WaWuB2pP7afbmAg0epA84s
        2pc8pAEIcl2Mh2FQ0aq/i/g=
X-Google-Smtp-Source: ANB0VdZKk5/d5kHx4gIrzIHZHDkF6nwoqDJQgBzTbHJouJN5eSJP0ZuqGW0zi03enOsSmfSQ0oC0vw==
X-Received: by 2002:adf:8103:: with SMTP id 3-v6mr39939006wrm.213.1537564458489;
        Fri, 21 Sep 2018 14:14:18 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y10-v6sm25844325wrl.87.2018.09.21.14.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 14:14:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
        sbeller@google.com
Subject: Re: [PATCH v2 3/3] transport.c: introduce core.alternateRefsPrefixes
References: <cover.1537466087.git.me@ttaylorr.com>
        <cover.1537555544.git.me@ttaylorr.com>
        <6e8f65a16dc0be84234d2be93bb4a5c9a585dd57.1537555544.git.me@ttaylorr.com>
Date:   Fri, 21 Sep 2018 14:14:17 -0700
In-Reply-To: <6e8f65a16dc0be84234d2be93bb4a5c9a585dd57.1537555544.git.me@ttaylorr.com>
        (Taylor Blau's message of "Fri, 21 Sep 2018 14:47:45 -0400")
Message-ID: <xmqqbm8qv9hy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> +core.alternateRefsPrefixes::
> +	When listing references from an alternate, list only references that begin
> +	with the given prefix. Prefixes match as if they were given as arguments to
> +	linkgit:git-for-each-ref[1]. To list multiple prefixes, separate them with
> +	whitespace. If `core.alternateRefsCommand` is set, setting
> +	`core.alternateRefsPrefixes` has no effect.

We do not allow anything elaborate like "refs/tags/release-*" but we
still allow "refs/tags/" and "refs/heads/" by listing them together,
and because these are only prefixes, whitespace is a reasonable list
separator as they cannot appear anywhere in a refname.  OK.

Why is this "core"?  I thought this was more about receive-pack;
even if this is going to be extended to upload-pack's negotiation,
"core" is way too wide a hierarchy.  We have "transport.*" for
things like this, no?

The exact same comment applies to 2/3, of course.


> diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
> index 2f21f1cb8f..b656c9b30c 100755
> --- a/t/t5410-receive-pack.sh
> +++ b/t/t5410-receive-pack.sh
> @@ -51,4 +51,12 @@ test_expect_success 'with core.alternateRefsCommand' '
>  	test_cmp expect actual.haves
>  '
>  
> +test_expect_success 'with core.alternateRefsPrefixes' '
> +	test_config -C fork core.alternateRefsPrefixes "refs/tags" &&
> +	expect_haves one three two >expect &&
> +	printf "0000" | git receive-pack fork >actual &&
> +	extract_haves <actual >actual.haves &&
> +	test_cmp expect actual.haves
> +'
> +
>  test_done
> diff --git a/transport.c b/transport.c
> index e7d2cdf00b..9323e5c3cd 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1341,6 +1341,11 @@ static void fill_alternate_refs_command(struct child_process *cmd,
>  		argv_array_pushf(&cmd->args, "--git-dir=%s", repo_path);
>  		argv_array_push(&cmd->args, "for-each-ref");
>  		argv_array_push(&cmd->args, "--format=%(objectname) %(refname)");
> +
> +		if (!git_config_get_value("core.alternateRefsPrefixes", &value)) {
> +			argv_array_push(&cmd->args, "--");
> +			argv_array_split(&cmd->args, value);
> +		}
>  	}
>  
>  	cmd->env = local_repo_env;
