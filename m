Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07EEB1F404
	for <e@80x24.org>; Thu, 22 Mar 2018 18:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751599AbeCVS1l (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 14:27:41 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36384 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbeCVS1k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 14:27:40 -0400
Received: by mail-wr0-f193.google.com with SMTP id d10so9693226wrf.3
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 11:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=taM9AXnoB4AAiPfUSL6aT3NwGRgxXGyR21p0MhpwBK4=;
        b=ZWz7Ncrne+0QoakzjLPbDs8tcMdyvl4jTVkdIvOXe/r6X3x/5R8AHXvVrcEajiQvgn
         VuihJNDNuqmo0Kglexa2P7pcekM2MrlHY3Gu/ZfIK8SjUT22elpCBcz9bRn7npYItJwO
         n7bfVo8oO0HP75RIB7QWGzU7SSJrPM0M2fRXjMTmjbOBoM3AVBAX5XARuCglH/tmUvU7
         pXN2vEAuZOUjQhvdQm8Z3WOUkGw9kGasWmdx95guMFlYUjjei5qe/adUiposo9Zlf7Hz
         V5ICbOrBRUpVjjyJBR5YjvrfuUgSnAVc45IVX7URlmvPt3Pao+LNyaxqnUDlNIeGFgSB
         oK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=taM9AXnoB4AAiPfUSL6aT3NwGRgxXGyR21p0MhpwBK4=;
        b=TaIGqw3uBsuIpv4ou3H9xT4Enn0fCcey+PX9DSHbb/tARlkvqpOy+ND1yS1KevEu6J
         r9ur02yGmHbSH5uQyizxDc/w1eJPjhB5T8ZYyrVrFR4EPKPEnTeoeqkm2Fhd6VW6DVIJ
         CjTTh1qeq2LrFHXb2BwYiVp2TitQJKPrqs8mSCbW2RMV8O9/6RbcsDF22y2UWG0O2TvZ
         Xu2jCkqvGnhCMa6HqBfp2ATEs0zsVom0hiKEEsQf1z1/Y8JnrUshPEViNSC3AeDKYEcA
         /JpYg/Rk/UUVtmuinwa2D32s7ypMdX5Yfs4D3JV9jRml9DewmFk0tLxFNdVRV3pby+gA
         3jwQ==
X-Gm-Message-State: AElRT7FEgoCwXX7N55whfqrM+aZyLpl0wmJE4/Dt2ckgRTkQ75yGqTyo
        f+laU072OhNM0comRH//Vm4=
X-Google-Smtp-Source: AG47ELuzNY1v2KMcWPDvLiRRxXusGEIXPuZZGS9ST8hFl/ITrbzoOSz/xSby9hGcCzh1Y6IHAQAW4g==
X-Received: by 10.223.144.41 with SMTP id h38mr9613133wrh.60.1521743258603;
        Thu, 22 Mar 2018 11:27:38 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o2sm6966311wro.31.2018.03.22.11.27.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Mar 2018 11:27:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wink Saville <wink@saville.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [RFC PATCH v3 2/9] Call git_rebase__interactive from run_specific_rebase
References: <cover.1521690197.git.wink@saville.com>
        <cover.1521690197.git.wink@saville.com>
        <47b224af1c22900a69d0e292935f37a719b6a9f3.1521690197.git.wink@saville.com>
Date:   Thu, 22 Mar 2018 11:27:37 -0700
In-Reply-To: <47b224af1c22900a69d0e292935f37a719b6a9f3.1521690197.git.wink@saville.com>
        (Wink Saville's message of "Thu, 22 Mar 2018 09:57:22 -0700")
Message-ID: <xmqqpo3wklt2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wink Saville <wink@saville.com> writes:

> Instead of indirectly invoking git_rebase__interactive this invokes
> it directly after sourcing.
>
> Signed-off-by: Wink Saville <wink@saville.com>
> ---
>  git-rebase--interactive.sh | 11 -----------
>  git-rebase.sh              | 11 +++++++++--
>  2 files changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 561e2660e..213d75f43 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -740,15 +740,6 @@ get_missing_commit_check_level () {
>  	printf '%s' "$check_level" | tr 'A-Z' 'a-z'
>  }
>  
> -# The whole contents of this file is run by dot-sourcing it from
> -# inside a shell function.  It used to be that "return"s we see
> -# below were not inside any function, and expected to return
> -# to the function that dot-sourced us.
> -#
> -# However, older (9.x) versions of FreeBSD /bin/sh misbehave on such a
> -# construct and continue to run the statements that follow such a "return".
> -# As a work-around, we introduce an extra layer of a function
> -# here, and immediately call it after defining it.

We still enclose the whole thing (including the returns that are
problematic for older FreeBSD shells) in a shell function, so it's
not like we are dropping the workaround for these systems.  It's
just the caller of the function moved.

I think the removal of this large comment is justifiable, but the
structure still needs a bit of explanation, especially given that
the caller in git-rebase.sh needs to treat this scriptlet a bit
differently from others.

If we were not in the (longer term) process of getting rid of
git-rebase.sh, it might even make sense to port the same
"dot-sourced scriptlet defines a shell function to be called, and
the caller calls it after dot-sourcing it" pattern to other rebase
backends, so that the calling side can be unified again to become
something like:

	. git-rebase--$type
	git_rebase__$type
	ret=$?




>  git_rebase__interactive () {
>  
>  case "$action" in
> @@ -1029,5 +1020,3 @@ fi
>  do_rest
>  
>  }
> -# ... and then we call the whole thing.
> -git_rebase__interactive
> diff --git a/git-rebase.sh b/git-rebase.sh
> index a1f6e5de6..c4ec7c21b 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -196,8 +196,15 @@ run_specific_rebase () {
>  		export GIT_EDITOR
>  		autosquash=
>  	fi
> -	. git-rebase--$type
> -	ret=$?
> +	if test "$type" = interactive
> +	then
> +		. git-rebase--interactive
> +		git_rebase__interactive
> +		ret=$?
> +	else
> +		. git-rebase--$type
> +		ret=$?
> +	fi
>  	if test $ret -eq 0
>  	then
>  		finish_rebase
