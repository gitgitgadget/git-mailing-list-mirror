From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 16/44] refs.c: move ref iterators to the common code
Date: Tue, 13 Oct 2015 06:12:42 +0200
Message-ID: <561C84BA.7000001@alum.mit.edu>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com> <1444686725-27660-17-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 06:19:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zlr44-0001sr-U1
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 06:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbbJMETs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 00:19:48 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:63539 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751156AbbJMETr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Oct 2015 00:19:47 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Oct 2015 00:19:47 EDT
X-AuditID: 12074412-f79a76d000007c8b-e6-561c84bc6551
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 0A.DE.31883.CB48C165; Tue, 13 Oct 2015 00:12:44 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2603.dip0.t-ipconnect.de [93.219.38.3])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t9D4CgIB008711
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 13 Oct 2015 00:12:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1444686725-27660-17-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1N3TIhNmcGSpqsX8TScYLbqudDNZ
	/JtQ48DssWBTqceC5/fZPT5vkgtgjuK2SUosKQvOTM/Tt0vgzlh5bjZbwQzxiuOX7zE2MJ4R
	6mLk5JAQMJE4svoKE4QtJnHh3nq2LkYuDiGBy4wS519fZARJCAmcZZI4dFuhi5GDg1dAW6Kr
	1wwkzCKgKnH4y0ewXjYBXYlFPc1gtqhAkMSK5S/AWnkFBCVOznzCAmKLCDhIXN51lBnEZhbQ
	lNi04QUriC0s4C2xe+FaqL1tjBLXFu4BS3AKeEl0Hb/GCtGgJ7Hj+i8oW15i+9s5zBMYBWYh
	2TELSdksJGULGJlXMcol5pTm6uYmZuYUpybrFicn5uWlFuma6eVmluilppRuYoQErtAOxvUn
	5Q4xCnAwKvHwvoiUCRNiTSwrrsw9xCjJwaQkyluXCRTiS8pPqcxILM6ILyrNSS0+xCjBwawk
	wnsuCyjHm5JYWZValA+TkuZgURLn/blY3U9IID2xJDU7NbUgtQgmK8PBoSTBu60ZqFGwKDU9
	tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFKnxxcBYBUnxAO191wCyt7ggMRcoCtF6ilFR
	Spz3LMhcAZBERmke3FhYOnrFKA70pTDvPJAqHmAqg+t+BTSYCWiwEbsUyOCSRISUVAOjwMJ7
	2pdW8W8JFGP4/uHwIosCqasVOvufW5StLwhJUn79UOy0l6KWxOtvZQcqGYLbe99LJs0Vv+39
	J7E65nNE/eJfW/jD+qabLsznPHYw8QDP0y0m96ouTPyxKOBc3f3YS0Xv1M1rJuVx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279479>

On 10/12/2015 11:51 PM, David Turner wrote:
> From: Ronnie Sahlberg <sahlberg@google.com>
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs-be-files.c | 82 ---------------------------------------------------------
>  refs.c          | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 81 insertions(+), 82 deletions(-)
> 
> diff --git a/refs-be-files.c b/refs-be-files.c
> index ecf2b33..46fa43c 100644
> --- a/refs-be-files.c
> +++ b/refs-be-files.c
> [...]
> @@ -2012,40 +1964,6 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
>  	return ret;
>  }
>  
> -int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
> -	const char *prefix, void *cb_data)
> -{
> -	struct strbuf real_pattern = STRBUF_INIT;
> -	struct ref_filter filter;
> -	int ret;
> -
> -	if (!prefix && !starts_with(pattern, "refs/"))
> -		strbuf_addstr(&real_pattern, "refs/");
> -	else if (prefix)
> -		strbuf_addstr(&real_pattern, prefix);
> -	strbuf_addstr(&real_pattern, pattern);
> -
> -	if (!has_glob_specials(pattern)) {
> -		/* Append implied '/' '*' if not present. */
> -		strbuf_complete(&real_pattern, '/');
> -		/* No need to check for '*', there is none. */
> -		strbuf_addch(&real_pattern, '*');
> -	}
> -
> -	filter.pattern = real_pattern.buf;
> -	filter.fn = fn;
> -	filter.cb_data = cb_data;
> -	ret = for_each_ref(filter_refs, &filter);
> -
> -	strbuf_release(&real_pattern);
> -	return ret;
> -}
> -
> [...]
> diff --git a/refs.c b/refs.c
> index 44ee4f4..7714dad 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -781,3 +781,84 @@ const char *prettify_refname(const char *name)
>  		starts_with(name, "refs/remotes/") ? 13 :
>  		0);
>  }
> [...]
> +int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
> +	const char *prefix, void *cb_data)
> +{
> +	struct strbuf real_pattern = STRBUF_INIT;
> +	struct ref_filter filter;
> +	int ret;
> +
> +	if (!prefix && !starts_with(pattern, "refs/"))
> +		strbuf_addstr(&real_pattern, "refs/");
> +	else if (prefix)
> +		strbuf_addstr(&real_pattern, prefix);
> +	strbuf_addstr(&real_pattern, pattern);
> +
> +	if (!has_glob_specials(pattern)) {
> +		/* Append implied '/' '*' if not present. */
> +		if (real_pattern.buf[real_pattern.len - 1] != '/')
> +			strbuf_addch(&real_pattern, '/');

The original has

		strbuf_complete(&real_pattern, '/');

in place of the above two lines. I think you made a mistake when
rebasing on top of

    00b6c178c3 use strbuf_complete to conditionally append slash

> +		/* No need to check for '*', there is none. */
> +		strbuf_addch(&real_pattern, '*');
> +	}
> +
> +	filter.pattern = real_pattern.buf;
> +	filter.fn = fn;
> +	filter.cb_data = cb_data;
> +	ret = for_each_ref(filter_refs, &filter);
> +
> +	strbuf_release(&real_pattern);
> +	return ret;
> +}
> +
> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
