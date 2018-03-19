Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 290431F404
	for <e@80x24.org>; Mon, 19 Mar 2018 18:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968434AbeCSSAw (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 14:00:52 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54706 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967136AbeCSSAs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 14:00:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id h76so16868630wme.4
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 11:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5elZ1G93Av5CYjUTRKRNvjbAVw/7ACQVJcUKOxc0OKk=;
        b=iDRJnUVFeXcU9D1uBEIDFva6Hj3uh6RSN0izK+lngFG6D9/E9unnrbbiwbl5f4Sedx
         xIdkAqm+HdO1ty8Iv2BHBq/StaxTBswktxm8dAa7lBjRFy76vgbE/L0N57dEV0wGNxI7
         Z+yHztqEztnSFJCAQC1BR+ssGt5WxhWus9eA1RN+keGzDgbrQsO9t0NuyypD9/8uPOcT
         sdwEMCEDJ0sCRULLgmf/BbAGMktBhhJk18SoO/X8VrpfrC4GHM7KzO9PPUpa66Mgotvy
         FGRV2kgELZI7yV6B+p1/bA/kkMtQMlLNa8MVkBpShpql2aspgsS32FmdrxejAWufiHDl
         C10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5elZ1G93Av5CYjUTRKRNvjbAVw/7ACQVJcUKOxc0OKk=;
        b=Ogxo6Z3O49MguZ8xt0N1jkkZteLeinN2rStLGEXD2JdyEjnozt/ppv6o1m/TWKYJe7
         J4XbnpVBzMT42VoHnbOjXvNQdp9v6t83gB8jCSO9S5eaPBq8VliBTizGSNYcdeNILIOu
         ho1uTPqIo2mcyswfLUUfy1cLIzXr+1BlG46LKGKtzemFpDCos+6+I8y1+tPVY2GXLPlE
         1R1q25U4LfA7WLXDRIWLV97KJnG5PTAwalFyFeI9DTOvV9vTP8lbQkng1ueffpU8k7F0
         5Sbc3LGVuc32j9ai5bH3orKGCrgEKBVfOR2gDHQzceRbrzAs1yWBvJ9Nh8cLM1B/BZsd
         El+g==
X-Gm-Message-State: AElRT7HOLJXAy3+UWXig6bX9xIez1RwG8v+d/uOyL6oWUqRwAadGoHLt
        643tvx38wBb979MBLqmdiIQ=
X-Google-Smtp-Source: AG47ELv+GkMtxVqR3GhtdvoDKNqQbxZ73GW7gDCVHOgLJld/USUCfT6K6/kK/AMHOHY+dgz9yTv7CA==
X-Received: by 10.28.69.90 with SMTP id s87mr2460657wma.152.1521482446886;
        Mon, 19 Mar 2018 11:00:46 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k130sm1157059wmg.9.2018.03.19.11.00.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 11:00:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michele Locati <michele@locati.it>
Cc:     git@vger.kernel.org, charles@hashpling.org
Subject: Re: [PATCH v2] filter-branch: use printf instead of echo -e
References: <20180319144905.11564-1-michele@locati.it>
        <20180319155259.13200-1-michele@locati.it>
Date:   Mon, 19 Mar 2018 11:00:45 -0700
In-Reply-To: <20180319155259.13200-1-michele@locati.it> (Michele Locati's
        message of "Mon, 19 Mar 2018 16:52:59 +0100")
Message-ID: <xmqqtvtcuer6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michele Locati <michele@locati.it> writes:

> In order to echo a tab character, it's better to use printf instead of
> "echo -e", because it's more portable (for instance, "echo -e" doesn't work
> as expected on a Mac).
>
> This solves the "fatal: Not a valid object name" error in git-filter-branch
> when using the --state-branch option.
>
> Furthermore, let's switch from "/bin/echo" to just "echo", so that the
> built-in echo command is used where available.
>
> Signed-off-by: Michele Locati <michele@locati.it>
> ---

Thanks; will queue.

>  git-filter-branch.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 1b7e4b2cd..98c76ec58 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -627,12 +627,12 @@ then
>  				print H "$_:$f\n" or die;
>  			}
>  			close(H) or die;' || die "Unable to save state")
> -	state_tree=$(/bin/echo -e "100644 blob $state_blob\tfilter.map" | git mktree)
> +	state_tree=$(printf '100644 blob %s\tfilter.map\n' "$state_blob" | git mktree)
>  	if test -n "$state_commit"
>  	then
> -		state_commit=$(/bin/echo "Sync" | git commit-tree "$state_tree" -p "$state_commit")
> +		state_commit=$(echo "Sync" | git commit-tree "$state_tree" -p "$state_commit")
>  	else
> -		state_commit=$(/bin/echo "Sync" | git commit-tree "$state_tree" )
> +		state_commit=$(echo "Sync" | git commit-tree "$state_tree" )
>  	fi
>  	git update-ref "$state_branch" "$state_commit"
>  fi
