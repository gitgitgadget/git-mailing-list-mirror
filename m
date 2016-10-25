Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEE062022A
	for <e@80x24.org>; Tue, 25 Oct 2016 10:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941625AbcJYKeS (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 06:34:18 -0400
Received: from mout.gmx.net ([212.227.17.22]:50859 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941505AbcJYKeF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 06:34:05 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MXqV1-1cRs4h2Tnr-00Wn0b; Tue, 25 Oct 2016 12:33:56
 +0200
Date:   Tue, 25 Oct 2016 12:33:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Eric Wong <e@80x24.org>, larsxschneider@gmail.com,
        git@vger.kernel.org, jnareb@gmail.com
Subject: Re: [PATCH v2 2/2] read-cache: make sure file handles are not
 inherited by child processes
In-Reply-To: <xmqqwpgx4j89.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610251230150.3264@virtualbox>
References: <20161024180300.52359-1-larsxschneider@gmail.com> <20161024180300.52359-3-larsxschneider@gmail.com> <20161024183900.GA12769@starla> <xmqqwpgx4j89.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:X/wvb8O7ks6p7G+lGPr4Hk9EIoLhMeZ/qyrwF6sc8uRA+WrFboT
 SbAcC/Xfj62S0/G5bNdxHkQDbrs8N8ERbw67757lasIZ1NMXL2+mZUo4mf35gKyNAYa1wDo
 YQkRjiAa8hgWiPFIu+usobvzJTURmKb+9oJ/vNVucci/l7sk81XOgvEOQAbuUiELkH5AP8u
 xgDzzL50SA4MKS9MtzEWw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wyWAXTiI3Gw=:oArxRM5Y+/HWDOr9mYcmHq
 YoiThzOZognVcllExJYQcWUVi4EgvyuXr0SSMw4EsPMRr/lYjV6bmBHN7v4gsiEiaN5y/xJCl
 EyasqiISslEu1VQ8lJK7Bn/rHyrUDM96NIMfoc/ueoDbUYrZg0Lpc+MwhFjrwodtAkLsQIgOa
 a4tC7OIU3FX6tbijXoaj3An7lOlSEVVTEJjwY+OFEncObDgQvdGXRJDwTgnrJRSvIaWXvxTcU
 F0yE47d0KCAFBM+PqMmy/11P069InakWjr0gnUqHUNGsgjERCeY9wJji4pvkX6UohEiW0E32m
 l+hGuv07ZmjYom9tGF16BEMDKb1VwwOFrgtOfGHtvbSoxxDVwj86lF1bRC8SwtnQzlj0DGPAl
 1h1rXgmqvYhjDS3PVNt8s3O7E3rWblrXOJDo0Tl5/OTaGVPW3wqxIlQYzUysW3EjZRhM+jrbI
 7XlqRsY6LTioqfMTrnb/8rL5VlKRPWiLgyN4Oj85jc766LLT74Aodr5JPJF2O30LnkOuaYwE+
 z4VhOsqFi18zGapzzV+ctH4FpfNX5tjxDFDff3rybBlt92Wx/uJK4bbWya1w7UqcpD6Kbxi8O
 0I6A3KRTzuVBD3/EPRJas8L4fU6xH6pa+ormV+SoJX134iOVxoJlwuY1mJ7DeJGxvFegltndn
 J0pm6Wdl8PQ6MgAki0KldBDLqsDXhsRmTXI/qdoSipClhFkMhzcd9bkb+qo0FRSrb5v21C4sO
 9+ayKH0UdpvXB61p696yiPwtp8QBUjY4NV9P3+DboZoB7Q0GmyCa3nJJDYADogwZ4LBxjjCg+
 lvUVETW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 24 Oct 2016, Junio C Hamano wrote:

> Eric Wong <e@80x24.org> writes:
> 
> > larsxschneider@gmail.com wrote:
> >> +++ b/read-cache.c
> >> @@ -156,7 +156,11 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
> >>  static int ce_compare_data(const struct cache_entry *ce, struct stat *st)
> >>  {
> >>  	int match = -1;
> >> -	int fd = open(ce->name, O_RDONLY);
> >> +	int fd = open(ce->name, O_RDONLY | O_CLOEXEC);
> >> +
> >> +	if (O_CLOEXEC && fd < 0 && errno == EINVAL)
> >> +		/* Try again w/o O_CLOEXEC: the kernel might not support it */
> >> +		fd = open(ce->name, O_RDONLY);
> >
> > In the case of O_CLOEXEC != 0 and repeated EINVALs,
> > it'd be good to use something like sha1_file_open_flag as in 1/2
> > so we don't repeatedly hit EINVAL.  Thanks.
> 
> Sounds sane.  
> 
> It's just only once, so perhaps we do not mind a recursion like
> this?
> 
>  read-cache.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/read-cache.c b/read-cache.c
> index b594865d89..a6978b9321 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -156,11 +156,14 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
>  static int ce_compare_data(const struct cache_entry *ce, struct stat *st)
>  {
>  	int match = -1;
> -	int fd = open(ce->name, O_RDONLY | O_CLOEXEC);
> +	static int cloexec = O_CLOEXEC;
> +	int fd = open(ce->name, O_RDONLY | cloexec);
>  
> -	if (O_CLOEXEC && fd < 0 && errno == EINVAL)
> +	if ((cloexec & O_CLOEXEC) && fd < 0 && errno == EINVAL) {
>  		/* Try again w/o O_CLOEXEC: the kernel might not support it */
> -		fd = open(ce->name, O_RDONLY);
> +		cloexec &= ~O_CLOEXEC;
> +		return ce_compare_data(ce, st);
> +	}
>  

That still looks overly complicated, repeatedly ORing cloexec and
recursing without need. How about this instead?

	static int oflags = O_RDONLY | O_CLOEXEC;
	int fd = open(ce->name, oflags);

	if ((O_CLOEXEC & oflags) && fd < 0 && errno == EINVAL) {
  		/* Try again w/o O_CLOEXEC: the kernel might not support it */
		oflags &= ~O_CLOEXEC;
		fd = open(ce->name, oflags);
	}

Ciao,
Dscho
