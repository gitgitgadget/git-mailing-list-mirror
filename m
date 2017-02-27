Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CC491F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 22:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751787AbdB0WEt (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 17:04:49 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36771 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751039AbdB0WEF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 17:04:05 -0500
Received: by mail-wr0-f194.google.com with SMTP id l37so3116292wrc.3
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 14:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F6eV5YBwkN1p7npLuf/BBECJZEyhiilJq1sj9Jp3+oI=;
        b=AHF3/HAVg1F50p5UVa9PNi+eGDLEUoQza/vfRzg8+MhOTgrsvBVoj++fptXWzjgoiH
         cR0R0GQt7MMVFYWheC1zMW2904RVdaTxtNGplIrgUudzOPgrIHnFXmT49gHj+hks+DpN
         i/nz9f4y3cgQM2lLvU2Hl3Q9EuXbSl57ia9LQLotatuUNKKM/SSBNB/8UWRk/UGQc31H
         KAAbhNLcPZ2hT3AwLdR7IrGACxiBRYxRegMm/xPcbAMMWLw7/88MCPWzoL/nn1twGJPT
         plc7Uc5++BThsRcp5pW+W+LHLRxJqHl9rTtmUWDo29ceu06RZ+sHCmezoSDQLCCkvXPv
         beIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F6eV5YBwkN1p7npLuf/BBECJZEyhiilJq1sj9Jp3+oI=;
        b=d5TvGx2KeSylc3zSDl7YpYGAc1VfgL89jp+pSAqa8Rbuk4468zGan2QJdGjrVNegs1
         8Jw2Gj/pM8dT0+KO+t+L+apy98ME2sx7DEmmR/OTlA6khGQ9fWoTw+Urp7xtweGfqq0M
         XKIfW1NOdBBHwnOjZ0pYVzbEtpytHPsKQEbJCnzo5ZpzBkyXbfT3+bnLLH5qY6HjfGTV
         aFWgDlnWh8vGT/l0A+ZLJH0zqvpLRob6gfaZkwi44XTRP9ojLteGyKhVv7BpRUw8N+mI
         HBZIVrQYTOuzYSccxKSGk8I4n9KfDqtCoKTXST0YKZTz4HjFvFVbgcbcGYW5SLuZLgTI
         iE8Q==
X-Gm-Message-State: AMke39mvl4Mk8X2qPu29qaw2bj2W7U5Us0c0lYE8TZLZXFKQ61xmtVL3B1Zye38GbTL4Pw==
X-Received: by 10.223.139.137 with SMTP id o9mr17799531wra.88.1488232431606;
        Mon, 27 Feb 2017 13:53:51 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id 136sm15878800wms.32.2017.02.27.13.53.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Feb 2017 13:53:51 -0800 (PST)
Date:   Mon, 27 Feb 2017 21:53:51 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sunny@sunbase.org,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 4/6] stash: teach 'push' (and 'create_stash') to honor
 pathspec
Message-ID: <20170227215351.GA17065@hank>
References: <20170219110313.24070-1-t.gummerer@gmail.com>
 <20170225213306.2410-1-t.gummerer@gmail.com>
 <20170225213306.2410-5-t.gummerer@gmail.com>
 <xmqqwpcbuyrd.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwpcbuyrd.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/27, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> >  	if test -z "$patch_mode"
> >  	then
> > -		git reset --hard ${GIT_QUIET:+-q}
> > +		if test $# != 0
> > +		then
> > +			git reset ${GIT_QUIET:+-q} -- "$@"
> > +			git checkout ${GIT_QUIET:+-q} HEAD -- $(git ls-files -z --modified "$@")
> 
> "ls-files -z" on the command line?  
> 
> Apparently new tests do not cover the correctness of this codepath.
> 
> I wonder if this
> 
> 	git ls-files -z --modified "$@" |
> 	git checkout-index -z --force --stdin
> 
> is what the above "checkout" wanted to do.  The "reset" in the
> previous step presumably updated the index entries that match
> specified pathspec to those of the HEAD, so checking out the paths
> that match "$@" from the index would be the same as checking them
> out from the HEAD (while updating the index with them).

Yes, you're completely right, this is exactly what it should have
done.  Sorry for being slow on getting this right.

> Perhaps squash the following into an appropriate patch in the
> series?

Thanks, I'll squash this in and re-roll.

>  git-stash.sh     |  3 ++-
>  t/t3903-stash.sh | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/git-stash.sh b/git-stash.sh
> index 28d0624c75..9c70662cc8 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -300,7 +300,8 @@ push_stash () {
>  		if test $# != 0
>  		then
>  			git reset ${GIT_QUIET:+-q} -- "$@"
> -			git checkout ${GIT_QUIET:+-q} HEAD -- $(git ls-files -z --modified "$@")
> +			git ls-files -z --modified -- "$@" |
> +			git checkout-index -z --force --stdin
>  			git clean --force ${GIT_QUIET:+-q} -d -- "$@"
>  		else
>  			git reset --hard ${GIT_QUIET:+-q}
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index f7733b4dd4..e868aafab2 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -891,4 +891,20 @@ test_expect_success 'stash without verb with pathspec' '
>  	test_path_is_file bar
>  '
>  
> +test_expect_success 'stash with pathspec matching multiple paths' '
> +	echo original >file &&
> +	echo original >other-file &&
> +	git commit -m "two" file other-file &&
> +	echo modified >file &&
> +	echo modified >other-file &&
> +	git stash -- "*file" &&
> +	echo original >expect &&
> +	test_cmp expect file &&
> +	test_cmp expect other-file &&
> +	git stash pop &&
> +	echo modified >expect &&
> +	test_cmp expect file &&
> +	test_cmp expect other-file
> +'
> +
>  test_done
