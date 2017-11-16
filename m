Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F407E202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 13:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964822AbdKPNLX (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 08:11:23 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:52408 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934875AbdKPNLV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 08:11:21 -0500
Received: by mail-pf0-f175.google.com with SMTP id m88so12341809pfi.9
        for <git@vger.kernel.org>; Thu, 16 Nov 2017 05:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+L+7OLtSmOtQFBZ+XEdyXZRl9sYlg5oA3DEvCB+3+mg=;
        b=hVwGMEn/tvb6bIiCtY3/mPpZnebdfgFbDYDVRIaWKd3Z8M704cdUkfeJYAxIHutXk+
         HmHoJ6N2owurAxKXe2NILq5oYVPTvOp8/h+BxkFJtpwS5GeU3rM77vuGeP0l8QCLUeVT
         QNYkXjubWnbABIYe8Dm/oVNCCVBv/Zqy2dmg81XZPO12kxxgxBDtw2rzykUN79N80P9g
         SpOl2eCfMEKT9jVMCAyaA47cQ6ReggXIZMnqnDcUUALT80kTz5eIlMIZE8metZdgBWFi
         j4b/x+7BYjpcdmkAO46fXvBU3fWUaj8XdgHrfO+x6qgVgMwyE7lbJ8XkUJeewIbiHOYx
         kOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+L+7OLtSmOtQFBZ+XEdyXZRl9sYlg5oA3DEvCB+3+mg=;
        b=GzY5TkZeqjv1DPQ1gvB+IpmTAajHdgKZj+QTpDLgc1VGiR2Go6XbmhsLDDfgBEPrEL
         H1/wG8wbxniJE7qUcw19RvWYuC63R4MJ/Wj+0M966fYSBqeeeyQogd4MhoIa0/kAOtN+
         E6O8w81B/EsHH4/N47M7hTs7Gaqsgyqo0qJh6ccdf1v9Ep66T37QoAK1y4lp6K0pGJYJ
         tXEPhSWV0FRxEufJJrBrW43zjkNh5s8EpZ2xVx/IeBv9o8rhS8EuC4+h6fF+eDi2TOmQ
         S6vlmsiz/+sNVAKO54bZ6TZyHGgfq6e8bWmHROJqcnSwXqxJMLplb02v1/ibrUMSLqLe
         8bwg==
X-Gm-Message-State: AJaThX7C7J8zjSovD47QE80VnqOhKOrFKDpjDBdPiNP5elFjwjKpe3j0
        oVZx47+FXA/lPLSLeu9TMS0=
X-Google-Smtp-Source: AGs4zMaZ3oaHUFQhEn0k6qzOOMb66Bz3WT43+emZCZseZ9o7Qh91jnRBDdNmvMhPsQAh6fopYc6Z8A==
X-Received: by 10.98.48.3 with SMTP id w3mr1803472pfw.219.1510837880971;
        Thu, 16 Nov 2017 05:11:20 -0800 (PST)
Received: from ?IPv6:2405:204:72c0:fc36:f2a4:a5ab:70fc:f807? ([2405:204:72c0:fc36:f2a4:a5ab:70fc:f807])
        by smtp.gmail.com with ESMTPSA id c185sm2889995pfb.112.2017.11.16.05.11.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Nov 2017 05:11:19 -0800 (PST)
Subject: Re: [PATCH 3/4] branch: correctly reject refs/heads/{-dash,HEAD}
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
References: <20171013051132.3973-1-gitster@pobox.com>
 <20171114114259.8937-1-kaartic.sivaraam@gmail.com>
 <0f8166ab-7955-aa78-7d32-0ec80944f007@gmail.com>
 <xmqq375g3nkf.fsf@gitster.mtv.corp.google.com>
 <bb3485d0-71bc-452e-e4b9-8a7d767753a5@gmail.com>
 <xmqqpo8jyyti.fsf_-_@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <471c7b6e-d3a0-4aee-8f80-282ff0b8d972@gmail.com>
Date:   Thu, 16 Nov 2017 18:41:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqpo8jyyti.fsf_-_@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday 16 November 2017 03:44 AM, Junio C Hamano wrote:
>      Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
>      >> Are these two patches follow-up fixes (replacement of 3/3 plus an
>      >> extra patch) to jc/branch-name-sanity topic?
>      >
>      > Yes, that's right.
>      >
>      >> Thanks for working on these.
>      >
>      > You're welcome. Please do be sure I haven't broken anything in
>      > v2. These patches should cleanly apply on 'next', if they don't let me
>      > know.
> 
>      OK, so here is a replacement for your replacement, based on an
>      additional analysis I did while I was reviewing your changes.
>      The final 4/4 is what you sent as [v2 2/2] (which was meant to
>      be [v2 4/3]).  I think with these updates, the resulting 4-patch
>      series is good for 'next'.
> 

I guess this series is not yet ready for 'next'. When I tried to apply 
this patch it doesn't seem to be applying cleanly. I get some conflicts 
in 'sha1_name.c' possibly as a consequence of the changes to the file 
that aren't accounted by the patch. As to which change,

$ git whatchanged  jch/jc/branch-name-sanity..origin/next sha1_name.c

lists at least 5 of them, so there's possibly a lot of change that 
hasn't been taken into account by this patch. Particularly, the function 
'strbuf_check_branch_ref' itself is found at line 1435 in the version 
found in 'next' though this patch expects it to be near line 1332, I guess.

Further comment inline.

>   sha1_name.c             | 14 ++++++++++++--
>   t/t1430-bad-ref-name.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/sha1_name.c b/sha1_name.c
> index c7c5ab376c..67961d6e47 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -1332,9 +1332,19 @@ void strbuf_branchname(struct strbuf *sb, const char *name, unsigned allowed)
>   int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
>   {
>   	strbuf_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
> -	if (name[0] == '-')
> -		return -1;
> +
> +	/*
> +	 * This splice must be done even if we end up rejecting the
> +	 * name; builtin/branch.c::copy_or_rename_branch() still wants
> +	 * to see what the name expanded to so that "branch -m" can be
> +	 * used as a tool to correct earlier mistakes.
> +	 */
>   	strbuf_splice(sb, 0, 0, "refs/heads/", 11);
> +
> +	if (*name == '-' ||
> +	    !strcmp(sb->buf, "refs/heads/HEAD"))

I guess this check should be made more consistent. Possibly either of,

	if (starts_with(sb->buf, "refs/heads/-") ||
	    !strcmp(sb->buf, "refs/heads/HEAD"))

or,

	if (*name == '-' ||
	    !strcmp(name, "HEAD"))


might make them consistent (at least from my perspective).


I tried to reproduce this patch manually and other than the above this 
one LGTM. Though I can't be very sure as I couldn't apply it (I did it 
"manually" to some extent, you see ;-)


> +		return -1;
> +
>   	return check_refname_format(sb->buf, 0);
>   }
>   
> diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
> index e88349c8a0..c7878a60ed 100755
> --- a/t/t1430-bad-ref-name.sh
> +++ b/t/t1430-bad-ref-name.sh
> @@ -331,4 +331,47 @@ test_expect_success 'update-ref --stdin -z fails delete with bad ref name' '
>   	grep "fatal: invalid ref format: ~a" err
>   '
>   
> +test_expect_success 'branch rejects HEAD as a branch name' '
> +	test_must_fail git branch HEAD HEAD^ &&
> +	test_must_fail git show-ref refs/heads/HEAD
> +'
> +
> +test_expect_success 'checkout -b rejects HEAD as a branch name' '
> +	test_must_fail git checkout -B HEAD HEAD^ &&
> +	test_must_fail git show-ref refs/heads/HEAD
> +'
> +
> +test_expect_success 'update-ref can operate on refs/heads/HEAD' '
> +	git update-ref refs/heads/HEAD HEAD^ &&
> +	git show-ref refs/heads/HEAD &&
> +	git update-ref -d refs/heads/HEAD &&
> +	test_must_fail git show-ref refs/heads/HEAD
> +'
> +
> +test_expect_success 'branch -d can remove refs/heads/HEAD' '
> +	git update-ref refs/heads/HEAD HEAD^ &&
> +	git branch -d HEAD &&
> +	test_must_fail git show-ref refs/heads/HEAD
> +'
> +
> +test_expect_success 'branch -m can rename refs/heads/HEAD' '
> +	git update-ref refs/heads/HEAD HEAD^ &&
> +	git branch -m HEAD tail &&
> +	test_must_fail git show-ref refs/heads/HEAD &&
> +	git show-ref refs/heads/tail
> +'
> +
> +test_expect_success 'branch -d can remove refs/heads/-dash' '
> +	git update-ref refs/heads/-dash HEAD^ &&
> +	git branch -d -- -dash &&
> +	test_must_fail git show-ref refs/heads/-dash
> +'
> +
> +test_expect_success 'branch -m can rename refs/heads/-dash' '
> +	git update-ref refs/heads/-dash HEAD^ &&
> +	git branch -m -- -dash dash &&
> +	test_must_fail git show-ref refs/heads/-dash &&
> +	git show-ref refs/heads/dash
> +'
> +
>   test_done
> 

