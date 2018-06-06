Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC4E31F403
	for <e@80x24.org>; Wed,  6 Jun 2018 15:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbeFFPt3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 11:49:29 -0400
Received: from mout.web.de ([212.227.15.14]:53789 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752042AbeFFPt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 11:49:28 -0400
Received: from localhost ([213.64.64.87]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Ldn19-1g9aDr3XTn-00j0FT; Wed, 06
 Jun 2018 17:49:20 +0200
Date:   Wed, 6 Jun 2018 17:53:09 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Anthony Sottile <asottile@umich.edu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] config.c: fix regression for core.safecrlf false
Message-ID: <20180606155309.GA5624@atze2.lan>
References: <20180604201742.18992-1-asottile@umich.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180604201742.18992-1-asottile@umich.edu>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:saw9juWAvg339lzZaQUAisYm3NR5cjAvciyANfMheCgPawK3EtQ
 McXhWutGc5cLbIBNVz1pJgb96pftYXp3tBVy9oRzBjhEpDG+UxGeh+R8oJsCZH1V7xtfSmw
 9KSLq5dUXQOUzEZkKbfmDsV6otE3/2DLgNWqyys1AZ2XsTIljOkYDFvaCDLbjlNwTP7LRsz
 ZoCC1W66d9Q9FBanzzsMA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cJRQ8tNgXks=:Mu5pkVtCZqFSEy2keurlPO
 1sgtmEePKi/FoekUxzDEc7oPFoy8hJ3VlmfcFY07qvwO1/R9ojPB+IxqhwZRPXxllpaYcxSNn
 X40KdgkGKOOAitRqo7Id0cNr2w3xL3/Kcmy5/rX6UMg3YnAYWX6RbSu/vgi5zoaNfOirmzSy4
 RG3XvprpPuH0PmdCYCca8pFZL1b2jDqvX5zr3MapdOy/gYkpLPOnFxRPrjZZFR3YDsw4EGUL2
 +nj+f2j+SjX3gLfwaUCS/XmQVrdNPR2LbLiZR2VfGnANY9A05Tb8c1h5E0gFXQ5IkIgluRnID
 wEgIf+bLTIz2Q+In7jRH643ryMIGkCoamSu4afOknpsQkfan6+8v9c5EvOrbLzFgx4vcGvOax
 uPJqssZw2oOQswGtXh3ekopHfJNRAt/DEk9jqNeP4/tDg4Z/MwIij9AWJYW4kz9EBi3zp3vs1
 lXDW5uwa9eurUtJL5rlPokoTvB5DAfh2P2FwA67XHRQXqoFBsDWKfg7k/IDPCRmLncSamD0FI
 2cV2nmhgfqJ/xMz+KWXNaN2BKbdrcPE4zSbNNo9VYOJZwSPm7c5zOsaV5FXELizNJBN5UIuUm
 mKU7z3CyD9wGvAKWynMose0BS77oxgbzso63n/+aoz0XOn8QsE6fUrjxyyyTdm8/ujuh45PTw
 o/GXJGcVRqK5VkRmvqIsSfiYvDmgCcDwnRWtEWT3sbULL67P2+LO3xEdIlMup8sXcPScKTrhX
 zWxZ/1bJFjqY6SobUuajVczsQ+MUnJHSSYMdN30p1CHFbpZ5f5QX/mc7I4U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 04, 2018 at 01:17:42PM -0700, Anthony Sottile wrote:
> A regression introduced in 8462ff43e42ab67cecd16fdfb59451a53cc8a945 caused
> autocrlf rewrites to produce a warning message despite setting safecrlf=false.
> 
> Signed-off-by: Anthony Sottile <asottile@umich.edu>
> ---
>  config.c        |  2 +-
>  t/t0020-crlf.sh | 10 ++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/config.c b/config.c
> index fbbf0f8..de24e90 100644
> --- a/config.c
> +++ b/config.c
> @@ -1233,7 +1233,7 @@ static int git_default_core_config(const char *var, const char *value)
>  		}
>  		eol_rndtrp_die = git_config_bool(var, value);
>  		global_conv_flags_eol = eol_rndtrp_die ?
> -			CONV_EOL_RNDTRP_DIE : CONV_EOL_RNDTRP_WARN;
> +			CONV_EOL_RNDTRP_DIE : 0;
>  		return 0;
>  	}
>  
> diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
> index 71350e0..5f05698 100755
> --- a/t/t0020-crlf.sh
> +++ b/t/t0020-crlf.sh
> @@ -98,6 +98,16 @@ test_expect_success 'safecrlf: git diff demotes safecrlf=true to warn' '
>  '
>  
>  
> +test_expect_success 'safecrlf: no warning with safecrlf=false' '
> +	git config core.autocrlf input &&
> +	git config core.safecrlf false &&
> +
> +	for w in I am all CRLF; do echo $w; done | append_cr >allcrlf &&
> +	git add allcrlf 2>err &&
> +	test_must_be_empty err
> +'
> +
> +
>  test_expect_success 'switch off autocrlf, safecrlf, reset HEAD' '
>  	git config core.autocrlf false &&
>  	git config core.safecrlf false &&
> -- 
> 2.7.4
> 

Looks good to me, thanks for cleaning my mess.

Acked-By: Torsten Bögershausen <tboegi@web.de>
