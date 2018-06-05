Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 541AC1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 21:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbeFEVZl (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 17:25:41 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45182 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751989AbeFEVZk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 17:25:40 -0400
Received: by mail-pl0-f66.google.com with SMTP id c23-v6so2331419plz.12
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 14:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BcYVsA9mYZKl6OFZsG9Qbgb1WhT6QkSJ9vKntF5Lkf8=;
        b=Wc0GimML/MvdO6EmOZ+DNtEVbXjQMveNdkEJzBYdtxYBEtOq6CbYNzUSSOTc+AaPhG
         ydVhrgY54lfvfRcunKJvXzjYax16jycq0uw1/UGd2Tagx83slQd6aMNLmzOkyjkvLFqc
         nMMPTX4+bAlQaPW73IgZfq7hFig3GTH/jIp1q5ls09IhMa0ipg5dbR6R6jqUi2Se9e4e
         TGehnfIuAJxH2EqYbuewkYIdglXcIKTeqJ7zzZWRadyI6bcs+YsFri+s3nPdTgDW3nIp
         KFo3oVi7XbGL7x+QGTxh2DlfYo24rXloCBrI9QGGXorKF/3M/pLTa8l7YC90VY4F3lFi
         piUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BcYVsA9mYZKl6OFZsG9Qbgb1WhT6QkSJ9vKntF5Lkf8=;
        b=NfkdNg5UyGuK6qo834tlF0GwoCGS1gCQmTnslzvD94sJZOWDWqWd65D4KYDOkTfcmK
         plX6P1/O5BQoiOSCpeFpSof2PO7LFYM5kcjmk1b+LMY44BLHjz/47F+ChPwKp+H8QEzf
         o6PIA7r4ACZWzyVHXSUSCAv3RO9tsWyhoiG2JniBisTeYgg7JiwxxVcXBPiBdvWAC3Yd
         jIv0vAE+O+TYjlJLEdhARGLlMECzlb9ijxAo4dq74t+KZ2v7S2y4hPpjqA0ynsFf4mQA
         KJ7sC4BB0dppUYWE2GN9IxsXH4xf/oyG02s4EEF9Tg7PAaXUBF57exemq3xKE5PXTpgR
         jJpw==
X-Gm-Message-State: APt69E1gwNLNfWXJfG1ifRNeXHcVl2pZnadDafIoayvfdkzQltmHaB28
        Vb/6ILGrpSxJyDkZw+Qr4MY9Ng==
X-Google-Smtp-Source: ADUXVKLCnrTlrzkCdKEEU35X/xTNBS2xGVIpvR+nZqdG5elbjXygy/tHasMyNQ+JzL5mYJ4KvyuUNw==
X-Received: by 2002:a17:902:584b:: with SMTP id f11-v6mr302081plj.222.1528233939850;
        Tue, 05 Jun 2018 14:25:39 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id j127-v6sm13407098pgc.10.2018.06.05.14.25.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 14:25:38 -0700 (PDT)
Date:   Tue, 5 Jun 2018 14:25:37 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] fetch: send "refs/tags/" prefix upon CLI refspecs
Message-ID: <20180605212537.GF158365@google.com>
References: <cover.1528233146.git.jonathantanmy@google.com>
 <4d69aa14dadbbc53defa6d7d6c9a62f2b02a0bfb.1528233146.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d69aa14dadbbc53defa6d7d6c9a62f2b02a0bfb.1528233146.git.jonathantanmy@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/05, Jonathan Tan wrote:
> When performing tag following, in addition to using the server's
> "include-tag" capability to send tag objects (and emulating it if the
> server does not support that capability), "git fetch" relies upon the
> presence of refs/tags/* entries in the initial ref advertisement to
> locally create refs pointing to the aforementioned tag objects. When
> using protocol v2, refs/tags/* entries in the initial ref advertisement
> may be suppressed by a ref-prefix argument, leading to the tag object
> being downloaded, but the ref not being created.
> 
> Commit dcc73cf7ff ("fetch: generate ref-prefixes when using a configured
> refspec", 2018-05-18) ensured that "refs/tags/" is always sent as a ref
> prefix when "git fetch" is invoked with no refspecs, but not when "git
> fetch" is invoked with refspecs. Extend that functionality to make it
> work in both situations.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>

Test t5702-protocol-v2.sh doesn't pass with this patch.

> ---
>  builtin/fetch.c        |  2 +-
>  t/t5702-protocol-v2.sh | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index ea5b9669a..1f447f1e8 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -359,7 +359,7 @@ static struct ref *get_ref_map(struct transport *transport,
>  		refspec_ref_prefixes(&transport->remote->fetch, &ref_prefixes);
>  
>  	if (ref_prefixes.argc &&
> -	    (tags == TAGS_SET || (tags == TAGS_DEFAULT && !rs->nr))) {
> +	    (tags == TAGS_SET || tags == TAGS_DEFAULT)) {
>  		argv_array_push(&ref_prefixes, "refs/tags/");
>  	}
>  
> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index 261e82b0f..6733579c1 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -406,6 +406,24 @@ test_expect_success 'fetch supports various ways of have lines' '
>  		$(git -C server rev-parse completely-unrelated)
>  '
>  
> +test_expect_success 'fetch supports include-tag and tag following' '
> +	rm -rf server client trace &&
> +	git init server &&
> +
> +	test_commit -C server to_fetch &&
> +	git -C server tag -a annotated_tag -m message &&
> +
> +	git init client &&
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
> +		fetch "$(pwd)/server" to_fetch:to_fetch &&
> +
> +	grep "fetch> ref-prefix to_fetch" trace &&
> +	grep "fetch> ref-prefix refs/tags/" trace &&
> +	grep "fetch> include-tag" trace &&
> +
> +	git -C client cat-file -e $(git -C client rev-parse annotated_tag)
> +'
> +
>  # Test protocol v2 with 'http://' transport
>  #
>  . "$TEST_DIRECTORY"/lib-httpd.sh
> -- 
> 2.17.0.768.g1526ddbba1.dirty
> 

-- 
Brandon Williams
