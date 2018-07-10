Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 229E71F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 19:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732447AbeGJTGf (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 15:06:35 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50459 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732289AbeGJTGe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 15:06:34 -0400
Received: by mail-wm0-f65.google.com with SMTP id v25-v6so118435wmc.0
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 12:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XOSCzH8vKLDd5l1b3P0oYhjp9imhqeMCUJxhW6P2gcI=;
        b=J36lD4WBVCQZ0TF2XZ146g6fDRihP2MuQSx/zzSyl+qGkp0eAD4/LerDnY6TBpuVUx
         tPqFXmVwSVT9KU87Xeu29mpfpTagXIDBtnl4eOZjfAYqzUfmYN/2JRDXYXYd6LWlIADp
         bA4aFzBxvlf/E5YDVnw54yE2DgAcfJtb3nEMAVR8aJYH0IWuOFQlYoLhm2W42y9MFvRJ
         6sAfkOf4U6odw0kkX+OuciqaGJb1KRJmvTFunQ7jMtfjxoVjuZyOhSqUHsr7vfjw4oCz
         NrSIS4BbEtihEE8wkdmZgt9fVgGlRY0a95VlEDpr2g+ZVl800k6niFzg2yVwPKZFktqh
         bbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XOSCzH8vKLDd5l1b3P0oYhjp9imhqeMCUJxhW6P2gcI=;
        b=EivL3JLV5VpIxkYOC2MSet2G2kENJPCkPXsG7gbklhJqBuMydLOR0I8TVSHAQRjCn2
         jX3DAM4tpdTns1WX41TXjevM0FjvEOA9VQuIro19Z/L3Hrvja6q3rhEb4cUO/Hwyquw7
         COq1CD2buyE+CifalgGPrQliW3dyuTGxvdBl3YYCIaF+wTb2jNeBX7zFKTiPadNO0AdT
         +1L1A61N5HOgU+q2zc8/8IHPGPe4KZcMSCpJzDbjMcQcyY7g7F4ILKPrLQRmE+XBFWjC
         aZXbdY3dkXGWMVJDxlJv5rX1gYKvPuZ8HWQDYjy5Cf+vB3Si1F0u7u5T1/LEELkOTWRz
         /ipg==
X-Gm-Message-State: APt69E3ieGCXtPkMSrcrSPwTPX5joRPXVRR72wPDuzA1sDcYrhAODMNv
        QAVUp4SoCpsBXxwTfUdUCN8=
X-Google-Smtp-Source: AAOMgpd7oPFbZRXkFetlJnf7E8rpz8UZB2mAYu4c5o0L18UptbNtNMdF7izf633wRkuHcYRH3Vhwaw==
X-Received: by 2002:a1c:2208:: with SMTP id i8-v6mr12099159wmi.105.1531249569345;
        Tue, 10 Jul 2018 12:06:09 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y102-v6sm96571wmh.9.2018.07.10.12.06.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 12:06:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     William Chargin <wchargin@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] sha1-name.c: for ":/", find detached HEAD commits
References: <20180710154106.5356-1-wchargin@gmail.com>
Date:   Tue, 10 Jul 2018 12:06:08 -0700
In-Reply-To: <20180710154106.5356-1-wchargin@gmail.com> (William Chargin's
        message of "Tue, 10 Jul 2018 08:41:06 -0700")
Message-ID: <xmqqwou26hcv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

William Chargin <wchargin@gmail.com> writes:

> This patch broadens the set of commits matched by ":/" pathspecs to
> include commits reachable from HEAD but not any named ref. This avoids
> surprising behavior when working with a detached HEAD and trying to
> refer to a commit that was recently created and only exists within the
> detached state.
>
> Signed-off-by: William Chargin <wchargin@gmail.com>
> Based-on-patch-by: Jeff King <peff@peff.net>
> ---
>  Documentation/revisions.txt   | 10 +++++-----
>  sha1-name.c                   |  1 +
>  t/t4208-log-magic-pathspec.sh | 14 ++++++++++++++
>  3 files changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index 7d1bd4409..aa56907fd 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -181,11 +181,11 @@ existing tag object.
>    the '<rev>' before '{caret}'.
>  
>  ':/<text>', e.g. ':/fix nasty bug'::
> -  A colon, followed by a slash, followed by a text, names
> -  a commit whose commit message matches the specified regular expression.
> -  This name returns the youngest matching commit which is
> -  reachable from any ref. The regular expression can match any part of the
> -  commit message. To match messages starting with a string, one can use
> +  A colon, followed by a slash, followed by a text, names a commit whose
> +  commit message matches the specified regular expression. This name
> +  returns the youngest matching commit which is reachable from any ref
> +  or from HEAD. The regular expression can match any part of the commit
> +  message. To match messages starting with a string, one can use

Please avoid unnecessary reflowing of earlier lines of the paragrpah
when the only change is to insert "or from HEAD" in the middle of its
fourth line.  That wastes reviewers time (and typically there are
more readers than there are writers).  If you did this instead:

  A colon, followed by a slash, followed by a text, names
  a commit whose commit message matches the specified regular expression.
  This name returns the youngest matching commit which is
  reachable from any ref or from HEAD.
  The regular expression can match any part of the
  commit message. To match messages starting with a string, one can use

the resulting patch would have been much easier to follow.

Also, I am not sure if "or from HEAD" is even needed when we say
"from ANY ref" already, as we count things like HEAD as part of the
ref namespace.  It may only feel necessary for the person who made
the change to call handle_one_ref() not only with for_each_ref() but
also with head_ref()---in other words, I am wondering if it was
merely a bug to ignore HEAD in the code when the documentation said
"from any ref" already.  If that is the case, then the above change
is not necessary.

> diff --git a/sha1-name.c b/sha1-name.c
> index 60d9ef3c7..641ca12f9 100644
> --- a/sha1-name.c
> +++ b/sha1-name.c
> @@ -1650,6 +1650,7 @@ static int get_oid_with_context_1(const char *name,
>  			struct commit_list *list = NULL;
>  
>  			for_each_ref(handle_one_ref, &list);
> +			head_ref(handle_one_ref, &list);

Makes sense.

>  			commit_list_sort_by_date(&list);
>  			return get_oid_oneline(name + 2, oid, list);
>  		}
> diff --git a/t/t4208-log-magic-pathspec.sh b/t/t4208-log-magic-pathspec.sh
> index 62f335b2d..41b9f3eba 100755
> --- a/t/t4208-log-magic-pathspec.sh
> +++ b/t/t4208-log-magic-pathspec.sh
> @@ -25,6 +25,20 @@ test_expect_success '"git log :/a -- " should not be ambiguous' '
>  	git log :/a --
>  '
>  
> +test_expect_success '"git log :/detached -- " should find a commit only in HEAD' '
> +	test_when_finished "git checkout master" &&
> +	git checkout --detach &&
> +	test_tick &&
> +	git commit --allow-empty -m detached &&
> +	test_tick &&
> +	git commit --allow-empty -m something-else &&
> +	git log :/detached --
> +'
> +
> +test_expect_success '"git log :/detached -- " should not find an orphaned commit' '
> +	test_must_fail git log :/detached --
> +'
> +

OK.

I found these tests (including the existing ones) misleading, by the
way. We are interested in seeing that ":/string" is understood as a
valid object name, and this is not limited to "log" at all.  Instead
of "git log", perhaps "git rev-parse --verify :/detached" may have
been more to the point of what we are actually trying to see.

But that is a fault of having test for ":/<string>" in "magic pathspec"
test script; correcting that mistake is totally outside of the scope
of this fix.

Thanks.
