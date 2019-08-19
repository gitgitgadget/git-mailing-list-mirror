Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29AB01F461
	for <e@80x24.org>; Mon, 19 Aug 2019 09:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfHSJlq (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 05:41:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50830 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfHSJlq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 05:41:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id v15so996223wml.0
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 02:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G7TaG6K3AXzd9r1xaUmBDyc+Hj0jhUqxQHSEMRfQ0XU=;
        b=DPCUPyEbZJ/QANegZmgffSAl0O+WRKDecL5tEH80mR0KyTUSQynj3MP/UmBN6/bRPw
         u4GJ0TDMnuXKQG4WEp59Vijx+cuWxdU+rc8dpSZPRhYCGl6cEQtu3XZVLPndueBv9Cyb
         T6kdZH0viWgw56H6/l5rwxYJz9cMDDB1Rn0PbWTJVMoY5UuT+eoyPjDB8hmV2najvpzg
         voyUHEs9WMWxp5GYCzNtSAfrRuO0EMFw6w4thgAAD4ro2liD2YPOuMyJwqQo5VLBRTeL
         o17Ii1W40Y+Sm0GsvEtWzhuhJ+qliiVzpOzZvr4nvbOkiJYbvs5xAtbB8RrFExJLDqFS
         WDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=G7TaG6K3AXzd9r1xaUmBDyc+Hj0jhUqxQHSEMRfQ0XU=;
        b=D7I1rFBHEnRRnlc/GanD1nJYHEhS4c9TsBlII+NsCJX6DCB2BJI9zBtuh+mTpA2B96
         e3FDKr+jLBQhxFU5aoi5/otu6xn07lhJkLUThuEJg5IPo9vvWDPzoxF2JZVNKcBpzf9d
         swmh5JfsopH7D8TPJE1iBS3fYCeuzxOg40o3ekTLtzcgn90wx1tVsalvHJmlwmZowlGy
         fOBexahewaw7CDRqT3rX49/U3x7zCtlPq5UCrJg3PgvP9oxHw6j4ptCzaZtw/dFmSk7Y
         ztnDYGjBeZSLn1O8TPNMo5W2v5Xua+v0KtKAPLnxU130/bx/5GqwUPeKnDW+azmeiCcq
         XMVA==
X-Gm-Message-State: APjAAAVMXqrmxvKZktINdJnzMI++0IjOeH6o2QXurfho9jCc7GVGjJJi
        08o155ZnqsP9kT1xqpnkvdQ=
X-Google-Smtp-Source: APXvYqwwImQcy8PF1XRZVw3te2jUOAYDBnjv526GOCx5iBkkYXk8Axe98sWCULvkXn4iU1EPuyTTZA==
X-Received: by 2002:a1c:61d4:: with SMTP id v203mr20312853wmb.164.1566207703885;
        Mon, 19 Aug 2019 02:41:43 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-12-34.as13285.net. [92.22.12.34])
        by smtp.gmail.com with ESMTPSA id q20sm46766546wrc.79.2019.08.19.02.41.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 02:41:43 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/2] apply: reload .gitattributes after patching it
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
 <20190818184403.861907-1-sandals@crustytoothpaste.net>
 <20190818184403.861907-3-sandals@crustytoothpaste.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <9b940950-666a-0c4c-58c0-1e61ac9e654c@gmail.com>
Date:   Mon, 19 Aug 2019 10:41:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190818184403.861907-3-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian

On 18/08/2019 19:44, brian m. carlson wrote:
> When applying multiple patches with git am, or when rebasing using the
> am backend, it's possible that one of our patches has updated a
> gitattributes file. Currently, we cache this information, so if a
> file in a subsequent patch has attributes applied, the file will be
> written out with the attributes in place as of the time we started the
> rebase or am operation, not with the attributes applied by the previous
> patch. This problem does not occur when using the -m or -i flags to
> rebase.

Do you know why -m and -i aren't affected?

> To ensure we write the correct data into the working tree, expire the
> cache after each patch that touches a path ending in ".gitattributes".
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>   apply.c           |  7 +++++++
>   convert.c         |  9 ++++++++-
>   convert.h         |  6 ++++++
>   t/t3400-rebase.sh | 36 ++++++++++++++++++++++++++++++++++++
>   4 files changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/apply.c b/apply.c
> index cde95369bb..d57bc635e4 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -4643,6 +4643,7 @@ static int apply_patch(struct apply_state *state,
>   	struct patch *list = NULL, **listp = &list;
>   	int skipped_patch = 0;
>   	int res = 0;
> +	int flush_attributes = 0;
>   
>   	state->patch_input_file = filename;
>   	if (read_patch_file(&buf, fd) < 0)
> @@ -4670,6 +4671,10 @@ static int apply_patch(struct apply_state *state,
>   			patch_stats(state, patch);
>   			*listp = patch;
>   			listp = &patch->next;
> +
> +			if ((patch->new_name && ends_with_path_components(patch->new_name, GITATTRIBUTES_FILE)) ||
> +			    (patch->old_name && ends_with_path_components(patch->old_name, GITATTRIBUTES_FILE)))
> +				flush_attributes = 1;

style nit - these lines are very long compared to 80 characters

>   		}
>   		else {
>   			if (state->apply_verbosity > verbosity_normal)
> @@ -4746,6 +4751,8 @@ static int apply_patch(struct apply_state *state,
>   	if (state->summary && state->apply_verbosity > verbosity_silent)
>   		summary_patch_list(list);
>   
> +	if (flush_attributes)
> +		reset_parsed_attributes();
>   end:
>   	free_patch_list(list);
>   	strbuf_release(&buf);
> diff --git a/convert.c b/convert.c
> index 94ff837649..030e9b81b9 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -1293,10 +1293,11 @@ struct conv_attrs {
>   	const char *working_tree_encoding; /* Supported encoding or default encoding if NULL */
>   };
>   
> +static struct attr_check *check;

I was concerned about the impact adding a file global if we ever want to 
multi-thread this for submodules, but looking through the file there are 
a couple of others already so this isn't creating a new problem.

Best Wishes

Phillip

> +
>   static void convert_attrs(const struct index_state *istate,
>   			  struct conv_attrs *ca, const char *path)
>   {
> -	static struct attr_check *check;
>   	struct attr_check_item *ccheck = NULL;
>   
>   	if (!check) {
> @@ -1339,6 +1340,12 @@ static void convert_attrs(const struct index_state *istate,
>   		ca->crlf_action = CRLF_AUTO_INPUT;
>   }
>   
> +void reset_parsed_attributes(void)
> +{
> +	attr_check_free(check);
> +	check = NULL;
> +}
> +
>   int would_convert_to_git_filter_fd(const struct index_state *istate, const char *path)
>   {
>   	struct conv_attrs ca;
> diff --git a/convert.h b/convert.h
> index 831559f10d..3710969d43 100644
> --- a/convert.h
> +++ b/convert.h
> @@ -94,6 +94,12 @@ void convert_to_git_filter_fd(const struct index_state *istate,
>   int would_convert_to_git_filter_fd(const struct index_state *istate,
>   				   const char *path);
>   
> +/*
> + * Reset the internal list of attributes used by convert_to_git and
> + * convert_to_working_tree.
> + */
> +void reset_parsed_attributes(void);
> +
>   /*****************************************************************
>    *
>    * Streaming conversion support
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 80b23fd326..23469cc789 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -301,6 +301,42 @@ test_expect_success 'rebase --am and --show-current-patch' '
>   	)
>   '
>   
> +test_expect_success 'rebase --am and .gitattributes' '
> +	test_create_repo attributes &&
> +	(
> +		cd attributes &&
> +		test_commit init &&
> +		git config filter.test.clean "sed -e '\''s/smudged/clean/g'\''" &&
> +		git config filter.test.smudge "sed -e '\''s/clean/smudged/g'\''" &&
> +
> +		test_commit second &&
> +		git checkout -b test HEAD^ &&
> +
> +		echo "*.txt filter=test" >.gitattributes &&
> +		git add .gitattributes &&
> +		test_commit third &&
> +
> +		echo "This text is smudged." >a.txt &&
> +		git add a.txt &&
> +		test_commit fourth &&
> +
> +		git checkout -b removal HEAD^ &&
> +		git rm .gitattributes &&
> +		git add -u &&
> +		test_commit fifth &&
> +		git cherry-pick test &&
> +
> +		git checkout test &&
> +		git rebase master &&
> +		grep "smudged" a.txt &&
> +
> +		git checkout removal &&
> +		git reset --hard &&
> +		git rebase master &&
> +		grep "clean" a.txt
> +	)
> +'
> +
>   test_expect_success 'rebase--merge.sh and --show-current-patch' '
>   	test_create_repo conflict-merge &&
>   	(
> 
