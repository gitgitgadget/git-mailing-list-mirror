Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D875C201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 23:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964807AbdBQXJL (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 18:09:11 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33922 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964788AbdBQXJK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 18:09:10 -0500
Received: by mail-pf0-f195.google.com with SMTP id o64so4955064pfb.1
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 15:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7QwlHxxYKbKYicRVjxCQzXAFs0lAgtl70dqXkCOsfbQ=;
        b=Dwp+ApmpK/gWtQAqsTqgw5/7ZuM5ETrCsjlNnuVDXDCUpM6EcXSzSVm5D3hNpjFP2R
         WkICbmrtJLsq5pLu1rKkyTblC2lbFUJIbHHtPebxa0+kd9Fgcc0dCQGxStDnecMuLkWU
         7sWyNgwdSO+/KM3IgHiW9ojcEgRDtcOxJgtOXI5jEfwQ8L7rbLDlS9yIfk08pkld3U3u
         MEVZHVAlbXoFywjrGahy6cCisw/+BhCOQqoHxTr5gpSX6DgTA2XwnOU+yHOR07oWGpyi
         lLrlpgqzRt+b/JQtvvHdWCwzd3bJ3MefaoJ7wnXCFqzhHT6bSUzitISeArdEcdS5iwff
         5F2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7QwlHxxYKbKYicRVjxCQzXAFs0lAgtl70dqXkCOsfbQ=;
        b=dHiE99tcNdsYllk5v9Gm0HAvxRCk/lZlFGTY3Y+O2fn+pPMCjRE1PWUGCIammRghln
         X56mEubrY6pOg7mEoNcwBL5HxKircDRLgBB+Rhm4+Hy0riCSzSRaWGXVtO60+oMzJ3Zh
         uxPPMtD9FS3E0/EVFdifs5amhZaQp9vj6KgWErlaKsQSiFOnLSUOMRCJpxZlaEYSM9Up
         VWTUTUmj2WQBKrseNVV5NYeLzwEx5uc/HXjXRlQJBCrQKoVF2JFzl6lCkGVl8KbYHSKC
         IBkrSKNGTgjn3Oktc2x5KmGsPuUhLL7tKXaxVQ1JqF9O2V6pbU6oXWWjji1VZaOusp7D
         T8Yw==
X-Gm-Message-State: AMke39nyYhbpBXCFa+iTQkt00CMiMfvvca7IM9cwwH5GeVaKZMZZ92z29Wa8fTomnqCP3w==
X-Received: by 10.99.108.74 with SMTP id h71mr12793263pgc.99.1487372495513;
        Fri, 17 Feb 2017 15:01:35 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id j7sm21397359pfe.84.2017.02.17.15.01.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 15:01:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?=C3=98yvind_A_=2E_Holm?= <sunny@sunbase.org>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 0/6] stash: support pathspec argument
References: <20170212215420.16701-1-t.gummerer@gmail.com>
        <20170217224141.19183-1-t.gummerer@gmail.com>
Date:   Fri, 17 Feb 2017 15:01:33 -0800
In-Reply-To: <20170217224141.19183-1-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Fri, 17 Feb 2017 22:41:35 +0000")
Message-ID: <xmqqfujcpgky.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

[some people may see this message twice, as I forgot to check if the
copy I received had "Some A . Body" not enclosed in dq; blindly
doing "Reply-All" ended up listing an invalid address on my Cc: line
and dropped by vger. apologies]

> diff --git a/git-stash.sh b/git-stash.sh
> index a184b1e274..1446fbe2e8 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -67,51 +67,20 @@ create_stash () {
>  		case "$1" in
>  		-m|--message)
>  			shift
> -			test -z ${1+x} && usage
> -			stash_msg="$1"
> -			new_style=t
> +			stash_msg=${1-"BUG: create_stash () -m requires an argument"}
>  			;;

Did you mean ${1?"BUG: ..."} here and also "-u" below?

>  		-u|--include-untracked)
>  			shift
> -			test -z ${1+x} && usage
> -			untracked="$1"
> -			new_style=t
> +			untracked=${1-"BUG: create_stash () -u requires an argument"}
>  			;;

Other than that the whole series looked sensible to me.

Thanks, will replace but that may not happen today.
