From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] ident.c: add support for IPv6
Date: Fri, 30 Oct 2015 18:26:16 +0100
Message-ID: <5633A838.3070801@web.de>
References: <1446216487-11503-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net
To: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 30 18:26:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsDRq-00067x-7t
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 18:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754040AbbJ3R0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 13:26:38 -0400
Received: from mout.web.de ([212.227.17.11]:55287 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751704AbbJ3R0h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 13:26:37 -0400
Received: from macce.local ([93.222.59.94]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0McFTf-1aAAKs1QrH-00JeOD; Fri, 30 Oct 2015 18:26:25
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
In-Reply-To: <1446216487-11503-1-git-send-email-gitter.spiros@gmail.com>
X-Provags-ID: V03:K0:aDjLKBcLixmQ/Yun5qylEp81ofTqTAx/Oia7h8MNU5h7UmyAE/K
 UN/D96DJ1KOf/nHsOJ4ZYWsAB8ba98lqwBHuHHX74KfKT8qjnLTAy2vuvexSiBdEifw8KqD
 AUZUsH4UBoqmQU5sqDNWPJm0EDB9MzH1nuTbmWIdW7ZQsO+dNr2h2xKf4QgH7WEhwoQeb2R
 o2FdUhRe4SwET6E8U8Pmg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vundrdKHVQA=:INhF4vQuow+EO9rCUsmYVS
 kvUTwWBex5wBy3no9sTKZRnWqqw42jOWWzVsCE/rYl6fB9PQKsgXMmoOp+jpy80+pkSEJNd3P
 3EOTZukKlvURvYvTGl042OTzMWBGFBeL1HelP8cmwlON2f49D2011UFvNgiERQST98aeQf5dv
 vfqjfYMduMxeUo8iT7rG4Wbp9QRsu1sGzWLJ8zth3O/6GkC7GVZa64GCm6ltK/NxDBBrSASIk
 lQ5gJoOuws4ceLWEXKlHene/tSS1imlhprASlBnh8s+8snuR8UerNoc2bOWevsO9cbGE73TBR
 vKrQD3PnUaUl/dgfWEeJcKoSElQFDGVEqS/GdH70RLR610MEm/Urt2su1Rpc0Kkor0SPVlKd7
 8CEcPeCp3ZDEaeis0mlT2GQIDA7B4SZKR5YxuuvU9xqSDXe/TVi98jPNZYWuNoBqUOLpWyV1z
 1qyPLPP8Ul3W27UF72VCcizDlDuyQLgNuymnRHu+dEQIuIeihZbZr2O+W21QqCmhtOhMtyYxq
 iIyMOSBY5FpdKfAh7TTBo05pLndVOPPAuT8reL1QiWlyc7otTrhf1iAmxfYROBVLqskqlT4ed
 4f8FDfDeeUBvJALF7sqt2SEob9BLRQR8OyBHv41BTePeT5cApc84ZdWzsW1tF6eaumqniAN5F
 wtiRAnMEPNfLQ3n7TC2IxZNS8no3DJI6lq9vzLyPsoBvlaeXz7ke19BrE9bYe2haBXgZCOBjE
 MDOYkCd+PcSjs6jycL40FiRO3Wb7LWMTfMop0V81k1yU2LT5n/mKk6OxA5/WGkjRwY/Cu3ic 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280497>

On 2015-10-30 15.48, Elia Pinto wrote:
> Add IPv6 support by implementing name resolution with the
Minor question: How is this related to IPV6?
Could the header line be written something like

"ident.c: Use getaddrinfo() instead of gethostbyname() if available"

On which systems has the patch been tested ?
Linux ?
Mac OS X ?
Windows ?
BSD ?

The motivation on which platforms the usage of getaddrinfo() is preferred
over gethostbyname() could be helpful to motivate this patch:
System XYZ behaves bad when gethostbyname() is used.
Fix it by using getaddrinfo() instead.

A more defensive patch could call getaddrinfo() (If available, iow
when NO_IPV6 is false), and if that fails for whatever reason,
fall back to gethostbyname(), which should be available on all systems.


> protocol agnostic getaddrinfo(3) API. The old gethostbyname(3)
> code is still available when git is compiled with NO_IPV6.
> 
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  ident.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/ident.c b/ident.c
> index 5ff1aad..86b62be 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -69,6 +69,34 @@ static int add_mailname_host(struct strbuf *buf)
>  	fclose(mailname);
>  	return 0;
>  }
> +#ifndef NO_IPV6
> +
> +static void add_domainname(struct strbuf *out)
> +{
> +	char buf[1024];
> +	struct addrinfo hints, *ai;
> +	int gai;
The scope of these variables can be narrowed, by moving them into the "{" block,
where they are needed. (Before the memset())
> +
> +	if (gethostname(buf, sizeof(buf))) {
> +		warning("cannot get host name: %s", strerror(errno));
> +		strbuf_addstr(out, "(none)");
> +		return;
> +	}
> +	if (strchr(buf, '.'))
> +		strbuf_addstr(out, buf);
> +	else	{
Many ' ' between else and '{', one should be enough
> +		memset (&hints, '\0', sizeof (hints));
> +		hints.ai_flags = AI_CANONNAME;
> +		if (!(gai = getaddrinfo(buf, NULL, &hints, &ai)) && ai && strchr(ai->ai_canonname, '.')) {
> +			strbuf_addstr(out, ai->ai_canonname);
> +			freeaddrinfo(ai);
> +		}
> +		else
Colud be written in one line as "} else"
> +			strbuf_addf(out, "%s.(none)", buf);
> +	}
> +}
> +#else /* NO_IPV6 */
