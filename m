Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97077211B4
	for <e@80x24.org>; Sat, 12 Jan 2019 03:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfALDKa (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 22:10:30 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50800 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbfALDKa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 22:10:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so4107498wmd.0
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 19:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hkF+0SqKF7+QDPIZVNoA8Ubv/pIHlMqZK6lgg21PB3w=;
        b=Ubq8iFVTN/tRSubPUAWU/fM3K84dCnBGjGxeqQJ5Br+5vam2nZtyewaXvfgq977oUU
         ck4cZKQkeXJ/N1szVwbJwVE7zWABI/qC0qTDvjyQo3iEALBXVi4cLdqMV3NGj0yYrliD
         rG6XU22yOjB3Zjvt17vi/vTNaPTIH2SK5ccf6KQSsAqU9q2S/jTd2w7LT/+wggfRKMMI
         2fH9iU2hEYkDJLCArcg6mzR8knIKHnin3wr3UsJ/1VL88ONgQpeV1W3ZphbNBCjHZ86Y
         57aW3BBRpDua/kzEe9BF/aZG1aS+5UUOnsQR/4kSitHQoHmmLNhvY4FcVQOZaaox9Oup
         o1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hkF+0SqKF7+QDPIZVNoA8Ubv/pIHlMqZK6lgg21PB3w=;
        b=Lk1WwZyFUkH3Q5TdfQNr7/TH4Ch3rFMumAtXampVhz0X3KIp4X9PcfE5VCCWgUXGKb
         yUnU1Zk9xBVHvhSQbD3Q8YhauHAHdfHERtJBZbikMvGZV1R2qLh6vDWo9FC2I2Pm5USy
         6ohDJovUZbgOVyw/Ry/7+s09vg9deVRz5Fz8JDM4JIln6CQ7S9gsJ3S18iQrQEooPs2T
         4RV1uM/FgD4XbJkjhU6W5x4olQczSHl7bhY34M8upmRnwoY/pCkxn9ZNM81a8PZ8tfrA
         EQlwAHRtMjY3pFU3Lyj6YN9lqYFwbpxBghwleNwortdmLtZLjxoPdNB3ogvHAXMlElBT
         Ja3g==
X-Gm-Message-State: AJcUukdRyycpDtveiAwHn0afjUMVSWZdTlcfmA/O+a1IO0GG6XrU35NF
        PGIC+h6CSauTD59WExcplOo=
X-Google-Smtp-Source: ALg8bN5a+Fg2MJptFGDbvA3JmKGKOf6zebMuVtMc2YzV6MMaE/dPqJ84hVpUUjYqYMo2UsD/dP1r+Q==
X-Received: by 2002:a1c:4301:: with SMTP id q1mr4295397wma.44.1547262627714;
        Fri, 11 Jan 2019 19:10:27 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d4sm75373605wrp.89.2019.01.11.19.10.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 19:10:27 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/6] merge-recursive: copy $GITHEAD strings
References: <20190111221414.GA31335@sigill.intra.peff.net>
        <20190111221655.GE10188@sigill.intra.peff.net>
Date:   Fri, 11 Jan 2019 19:10:26 -0800
In-Reply-To: <20190111221655.GE10188@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 11 Jan 2019 17:16:55 -0500")
Message-ID: <xmqqk1jawoyl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If $GITHEAD_1234abcd is set in the environment, we use its value as a
> "better branch name" in generating conflict markers. However, we pick
> these better names early in the process, and the return value from
> getenv() is not guaranteed to stay valid.
>
> Let's make a copy of the returned string. And to make memory management
> easier, let's just always return an allocated string from
> better_branch_name(), so we know that it must always be freed.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/merge-recursive.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Thanks.  Will queue.

>
> diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
> index 9b2f707c29..7545136c2a 100644
> --- a/builtin/merge-recursive.c
> +++ b/builtin/merge-recursive.c
> @@ -7,16 +7,16 @@
>  static const char builtin_merge_recursive_usage[] =
>  	"git %s <base>... -- <head> <remote> ...";
>  
> -static const char *better_branch_name(const char *branch)
> +static char *better_branch_name(const char *branch)
>  {
>  	static char githead_env[8 + GIT_MAX_HEXSZ + 1];
>  	char *name;
>  
>  	if (strlen(branch) != the_hash_algo->hexsz)
> -		return branch;
> +		return xstrdup(branch);
>  	xsnprintf(githead_env, sizeof(githead_env), "GITHEAD_%s", branch);
>  	name = getenv(githead_env);
> -	return name ? name : branch;
> +	return xstrdup(name ? name : branch);
>  }
>  
>  int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
> @@ -26,6 +26,7 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
>  	int i, failed;
>  	struct object_id h1, h2;
>  	struct merge_options o;
> +	char *better1, *better2;
>  	struct commit *result;
>  
>  	init_merge_options(&o);
> @@ -70,13 +71,17 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
>  	if (get_oid(o.branch2, &h2))
>  		die(_("could not resolve ref '%s'"), o.branch2);
>  
> -	o.branch1 = better_branch_name(o.branch1);
> -	o.branch2 = better_branch_name(o.branch2);
> +	o.branch1 = better1 = better_branch_name(o.branch1);
> +	o.branch2 = better2 = better_branch_name(o.branch2);
>  
>  	if (o.verbosity >= 3)
>  		printf(_("Merging %s with %s\n"), o.branch1, o.branch2);
>  
>  	failed = merge_recursive_generic(&o, &h1, &h2, bases_count, bases, &result);
> +
> +	free(better1);
> +	free(better2);
> +
>  	if (failed < 0)
>  		return 128; /* die() error code */
>  	return failed;
