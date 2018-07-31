Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBBB71F597
	for <e@80x24.org>; Tue, 31 Jul 2018 21:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732251AbeGaXgH (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 19:36:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39250 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbeGaXgH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 19:36:07 -0400
Received: by mail-wm0-f67.google.com with SMTP id h20-v6so4707283wmb.4
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 14:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Gu+cDPmP5zRICuuiacPO4Xhs5adrZNYqZn9oXuQHRwE=;
        b=gq+14sdLw/xsSgnxqucc5FBGePKuVz9uafivL+ObFK1EyBuuo9IFkrJrSDls82bYIa
         J+6wqkWToKCumVRsLuGem2ojpXnmAK5pHqFAYaN0p+2nDcEUEajfmvtd7vkFxoFdDeVY
         gCbp/6um4/BcVc9jtOlUaD7444FXIlKv6ivSf5qqq+Dkeq4pdKuKI1dCL2Eigz0dQ9+2
         +8kHtaccje8upoZDcG8gJBS52BtEPYee3iOcnR716s5wqdwfbNXuerH4qT5hgWu7cNbR
         zsebjnL8Pt6eHBAHEF7A1yVW3uGfUt2Ia9d8WHzGa96ZT9JqHlEfKTpZ3Kthd5380Upk
         7+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Gu+cDPmP5zRICuuiacPO4Xhs5adrZNYqZn9oXuQHRwE=;
        b=Kv1DqQ3nf12toKZuDrv+thoaH0xf70OBwm/zOkUQb12b38Dxz3PkdmZx7n4V1ILOP0
         8nnQZQmKxACihrto1PM6xn3pVwP1g/eQENOM+XL9IVe2/bh7+Frl70DeUWMRdX3TEQpe
         Bjek7CTBkhb1ps/p22gsDqpYh1ijVfdR5A6Vws1LVqgHyQlBiamJ7U+f3HovP98hyEJC
         xTSFJGodGbTwpnONRLjv962rDTtClElRS6K2rOzv03mWfeGo98TStUgSRN4wwB6pcPjT
         4m8bc5+zgn8VZxz48+B+B7V7wL4EBc5CTnqvs70Tj+ABtaGJQdOVBdpdh5+kIcyvXqFu
         k/vw==
X-Gm-Message-State: AOUpUlEmLGB5r5aPYEMcBfg0dYEHWF7bFKMtgFSJ75CoFVkOTQYYNu9i
        2raGErPBd4OhMa9q8GpYego=
X-Google-Smtp-Source: AAOMgpfthpyMBtQrpC1JfgzUVPsYP+8J7NvVmHFH2xNfkvOBaSZ7kTLh8+5MEYIILiAlUYUMGH1uLQ==
X-Received: by 2002:a1c:3a8f:: with SMTP id h137-v6mr920069wma.72.1533074022811;
        Tue, 31 Jul 2018 14:53:42 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i205-v6sm4247538wmf.30.2018.07.31.14.53.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 14:53:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] remote: prefer exact matches when using refspecs
References: <20180731211832.142014-1-jonathantanmy@google.com>
Date:   Tue, 31 Jul 2018 14:53:41 -0700
In-Reply-To: <20180731211832.142014-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 31 Jul 2018 14:18:32 -0700")
Message-ID: <xmqq600v9imy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When matching a non-wildcard LHS of a refspec against a list of refs,
> find_ref_by_name_abbrev() returns the first ref that matches using the
> DWIM rules used by refname_match() in refs.c, even if an exact match
> occurs later in the list of refs.

When you have refs/heads/refs/heads/s and refs/heads/s, and if you
ask for refs/heads/s, you want that exact match (i.e. the latter) to
take precedence over DWIMmed refs/heads/refs/heads/s.

What is unfortunate is that ref_rev_parse_rules[] array already
expresses that preference by listing the "fullname" choice "%.*s"
before other DWIM choices like "refs/heads/%.*s".

Now we iterate over refs we say from ls-remote output, and with the
updated one, the logic _manually_ gives the precedence to the first
entry in ref_rev_parse_rules[], so in that "I have a branch s and
also another branch refs/heads/s" case, that may happen to work, but
would the updated code do the right thing when you have entries that
can match, say, both second and third entry in the rules[] and
tiebreak correctly the same way?  Say you ask for "tags/T" when
there are "refs/tags/T" and "refs/heads/tags/T" at the same time in
the refs linked list.  None of the ref on refs list trigger
!strcmp() as there is no exact mqatch, and refname_match() would say
"Yeah I see a match" when checking "refs/heads/tags/T" and say it is
the best match.  Then it finds "refs/tags/T" also on the refs list
and finds it also matches user-supplied "tags/T".

In order to resolve this correctly with the precedence rules, I
think you need to make refname_match() return the precedence number
(e.g. give 1 to "%.*s", 2 to "refs/%.*s", etc., using the index in
ref_rev_parse_rules[] array), and make this loop keep track of the
"best" match paying attention to the returned precedence.

> This causes unexpected behavior when (for example) fetching using the
> refspec "refs/heads/s:<something>" from a remote with both
> "refs/heads/refs/heads/s" and "refs/heads/s". (Even if the former was
> inadvertently created, one would still expect the latter to be fetched.)
>
> This problem has only been observed when the desired ref comes after the
> undesired ref in alphabetical order. However, for completeness, the test
> in this patch also checks what happens when the desired ref comes first
> alphabetically.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  remote.c         |  7 +++++--
>  t/t5510-fetch.sh | 28 ++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/remote.c b/remote.c
> index 3fd43453f..eeffe3488 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1687,12 +1687,15 @@ static struct ref *get_expanded_map(const struct ref *remote_refs,
>  
>  static const struct ref *find_ref_by_name_abbrev(const struct ref *refs, const char *name)
>  {
> +	const struct ref *best_match = NULL;
>  	const struct ref *ref;
>  	for (ref = refs; ref; ref = ref->next) {
> -		if (refname_match(name, ref->name))
> +		if (!strcmp(name, ref->name))
>  			return ref;
> +		if (refname_match(name, ref->name))
> +			best_match = ref;
>  	}
> -	return NULL;
> +	return best_match;
>  }
>  
>  struct ref *get_remote_ref(const struct ref *remote_refs, const char *name)
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index e402aee6a..da88f35f0 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -535,6 +535,34 @@ test_expect_success "should be able to fetch with duplicate refspecs" '
>  	)
>  '
>  
> +test_expect_success 'LHS of refspec prefers exact matches' '
> +	mkdir lhs-exact &&
> +	(
> +		cd lhs-exact &&
> +		git init server &&
> +		test_commit -C server unwanted &&
> +		test_commit -C server wanted &&
> +
> +		git init client &&
> +
> +		# Check a name coming after "refs" alphabetically ...
> +		git -C server update-ref refs/heads/s wanted &&
> +		git -C server update-ref refs/heads/refs/heads/s unwanted &&
> +		git -C client fetch ../server refs/heads/s:refs/heads/checkthis &&
> +		git -C server rev-parse wanted >expect &&
> +		git -C client rev-parse checkthis >actual &&
> +		test_cmp expect actual &&
> +
> +		# ... and one before.
> +		git -C server update-ref refs/heads/q wanted &&
> +		git -C server update-ref refs/heads/refs/heads/q unwanted &&
> +		git -C client fetch ../server refs/heads/q:refs/heads/checkthis &&
> +		git -C server rev-parse wanted >expect &&
> +		git -C client rev-parse checkthis >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  # configured prune tests
>  
>  set_config_tristate () {
