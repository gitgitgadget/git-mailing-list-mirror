Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E40D1F406
	for <e@80x24.org>; Tue, 15 May 2018 12:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753198AbeEOMSw (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 08:18:52 -0400
Received: from mout.gmx.net ([212.227.17.22]:55367 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753189AbeEOMSv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 08:18:51 -0400
Received: from MININT-HARFK7P.southpacific.corp.microsoft.com
 ([37.201.195.106]) by mail.gmx.com (mrgmx102 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 0MXVr0-1eoGkY16tK-00WVWC; Tue, 15 May 2018 14:18:40 +0200
Date:   Tue, 15 May 2018 14:18:39 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     bmwill@google.com, gitster@pobox.com, git@vger.kernel.org,
        ao2@ao2.it
Subject: Re: [PATCH] grep: handle corrupt index files early
In-Reply-To: <20180515010425.149200-1-sbeller@google.com>
Message-ID: <nycvar.QRO.7.76.6.1805151418170.77@tvgsbejvaqbjf.bet>
References: <20180515010425.149200-1-sbeller@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:guQ1YfDck6BJtBuD784wbRlYt+oWeNwxtcM4FxnQBpE+GwGe8Zn
 L/7f1WufH2wGfiHFU+2ZITrp5cgc0B2mq06iU4H5pifQNSBaTyOZiW2BIBx24ozOI84KvzK
 0gzNbW3jSEzBkzXGXo/O2n+lImShpQ3w6Fgxq4ob/OFsKkj2GzF05e2I3TQzgxyPcT5ha2T
 1zajjcJIOjJFLIJhFE8wA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KGg1Xq21518=:wunNXOvqnk7xs0tFJ2F/ld
 o1NgncftRsQdgF+xtGHFK5tyPzLB8lJOo1jVkKdmtAGlu5EzHjJrqL00C7Va7gRPPU9H3z0I3
 qzfVPjSrbties7Lq57e1Dnc4xm9DHuu8gGOo/Fe2ypAcp4WUp0Jfy0e2mBhmjoGP5BtJ/F9CT
 51RjNn7djJWmqrEP6383hf51JpwBou1XcyCDzP4pK09NumS/KRAxive6lO3Vc3YNRgrs2aAyg
 DcbDlGvrwEU+pCgO2UjpdLOYUkQQbjSSoSht9BCqq9MwH872eXaDsaZCLuP8p7z7cSZ8LbLmZ
 apMiUDwW8lmc/6RJmPVkVi/tAeOaMBKhEB5vNF9NNOT4vx8TTfegpyXRbu9WgdmQuuF1LG7i9
 a1HYCADKfbyLCO7dAmYtvgKZnLj5xizh7QZDz/mvfRuhCtcBea7qFm5JUX/12npt2ZmuZrJoL
 wd5c0SCziE0fe0kWYQy0zTbb3oaIkR2Mw4gi469qMAQglZpx4UdSFm4r/n6N2HUe+BaOs96nn
 Wc+ts0GLBdQasFuyElLQcGf/jgVl8/4MBgh6GGQCGp0TPnqwbbhveA+Fp9eKObLVfeKtewzc6
 xCi+6iwFCFE7ixD95Yy3n6SQ03V4C4E3/lnaMSDbACzjm+JdnAMRoWKGtT0a8wjwteJlel6EX
 FF2brir8Ji9hVVK048LKB+yKyfJ6gQ/lDaEccZetzpIWJ2+j6TNJhssMPcnl3PdBKAr+Ya5Gc
 5toHmUakJiOWq4n/RR9JWZWR4Q3pN8Frk1q254HXC+n8HthFIRhaoUnfz6xPkuKto0f35rJuI
 JeUqHNu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Mon, 14 May 2018, Stefan Beller wrote:

> Any other caller of 'repo_read_index' dies upon a negative return of
> it, so grep should, too.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
> Found while reviewing the series
> https://public-inbox.org/git/20180514105823.8378-1-ao2@ao2.it/
> 
>  builtin/grep.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 6e7bc76785a..69f0743619f 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -488,7 +488,8 @@ static int grep_cache(struct grep_opt *opt, struct repository *repo,
>  		strbuf_addstr(&name, repo->submodule_prefix);
>  	}
>  
> -	repo_read_index(repo);
> +	if (repo_read_index(repo) < 0)
> +		die("index file corrupt");

Looks obviously correct, thanks!

Ciao,
Dscho
