Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44D311F516
	for <e@80x24.org>; Thu, 21 Jun 2018 21:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933522AbeFUVAu (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 17:00:50 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40582 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933520AbeFUVAs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 17:00:48 -0400
Received: by mail-wr0-f194.google.com with SMTP id g18-v6so4542397wro.7
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 14:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rsr0CuSHTtgoyJjFrZnraqaDPpfw1RCoPEKtRBWCiZ4=;
        b=lcbe3HvfU+Fpt2of6QdVDf5OMfigjnh5/l2T7QuMiU9Uupauv55zNOZUTou39WciyT
         /1xW5wIxv2VgNny2WGWhwplhq6bwJHugkveJbnQQJQkrGYHYodTnm8w6lN1ybX8mR1Ab
         c2GEc5KgTR9ak1WMu4WewDj7dT3+Cp9RoWQqs4o7KEN0bUyc3ZOia5PbHrfrKssJ3UQy
         c+KdnsFu+EW76gkjr7O+mCtjzTljBeROalSC8BAjHEiBXjwsQRUJw+D+PzL2sp5Nt2do
         u/s2gaIZ8xuebK29s2bY86lCGdEA9fXDWMzG4BUS3a+eA+AOMeDSJ8wuEdNgHVExJMRJ
         +UNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rsr0CuSHTtgoyJjFrZnraqaDPpfw1RCoPEKtRBWCiZ4=;
        b=KEt7PeJzt7VVttZEQaHW2qunLdhY2PkK7FnM30KK49g+BjxcXIrYFv90YIXK4sc8pz
         u4MoUtMYMZHGJ0VTuVHJkad4XPlCFlcX796feu4xDXzS1AcmbHxEumUtFCEgkZPl9srE
         fKTpVe97+leHd6Av2TBh2UBJVWgUuyfDec3P+b/LL9KViNqh3sWzbz2qVD31SLn2XupX
         dYqZbsv6dzJQS1FUH7K5OwbV/mpVgiEJl0cZL5D2wRZEHV/CQS0YeTdEoskcT+NF46m9
         U/gQfy4Kup9wos/I/Ie+1ANF03oBdSIFLbbr+w6TDJjdk0MKfDqDylDiuTGwQDaoQkWr
         XFIQ==
X-Gm-Message-State: APt69E1SVCuXyvLbwGxFCNb0TmM+3yI4SRyW0UycGGUaQqRVKlXDj59O
        fgCKJLHlw6WNQGznM1LYxh8=
X-Google-Smtp-Source: ADUXVKJ6wZNX71vs2H1HSJht2DyjuTKt6i0zlwDPT767Vxwpqlva3isgiM867d63DD2TGjLGfJNF6w==
X-Received: by 2002:a5d:4204:: with SMTP id n4-v6mr21588707wrq.55.1529614847111;
        Thu, 21 Jun 2018 14:00:47 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w3-v6sm5832394wrr.88.2018.06.21.14.00.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 14:00:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] submodule.c: report the submodule that an error occurs in
References: <20180620223253.226092-1-sbeller@google.com>
Date:   Thu, 21 Jun 2018 14:00:46 -0700
In-Reply-To: <20180620223253.226092-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 20 Jun 2018 15:32:53 -0700")
Message-ID: <xmqqvaabrh1d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> When an error occurs in updating the working tree of a submodule in
> submodule_move_head, tell the user which submodule the error occurred in.
>
> The call to read-tree contains a super-prefix, such that the read-tree
> will correctly report any path related issues, but some error messages
> do not contain a path, for example:
>
>   ~/gerrit$ git checkout --recurse-submodules origin/master
>   ~/gerrit$ fatal: failed to unpack tree object 07672f31880ba80300b38492df9d0acfcd6ee00a
>
> Give the hint which submodule has a problem.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c               | 2 +-
>  t/lib-submodule-update.sh | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 939d6870ecd..ebd092a14fd 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1668,7 +1668,7 @@ int submodule_move_head(const char *path,
>  	argv_array_push(&cp.args, new_head ? new_head : empty_tree_oid_hex());
>  
>  	if (run_command(&cp)) {
> -		ret = -1;
> +		ret = error(_("Submodule '%s' could not be updated."), path);
>  		goto out;
>  	}

OK.  The function uses path in messages elsewhere so we know path
must not be empty and have a reasonable string content at this
point, which makes this a reasonably safe patch to apply ;-)

Thanks.

> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
> index 1f38a85371a..e27f5d8541d 100755
> --- a/t/lib-submodule-update.sh
> +++ b/t/lib-submodule-update.sh
> @@ -781,7 +781,8 @@ test_submodule_recursing_with_args_common() {
>  		(
>  			cd submodule_update &&
>  			git branch -t invalid_sub1 origin/invalid_sub1 &&
> -			test_must_fail $command invalid_sub1 &&
> +			test_must_fail $command invalid_sub1 2>err &&
> +			grep sub1 err &&
>  			test_superproject_content origin/add_sub1 &&
>  			test_submodule_content sub1 origin/add_sub1
>  		)
