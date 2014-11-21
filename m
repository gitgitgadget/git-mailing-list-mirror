From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] copy.c: make copy_fd preserve meaningful errno
Date: Fri, 21 Nov 2014 10:14:44 +0100
Message-ID: <546F0284.7050904@alum.mit.edu>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>, gitster@pobox.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 21 10:15:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrkJ6-0007rg-Hv
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 10:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754893AbaKUJPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 04:15:05 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:61429 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754699AbaKUJPD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Nov 2014 04:15:03 -0500
X-AuditID: 1207440e-f79d26d000001b6e-21-546f0286bc17
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 5D.9E.07022.6820F645; Fri, 21 Nov 2014 04:14:46 -0500 (EST)
Received: from [192.168.69.130] (p5DDB272E.dip0.t-ipconnect.de [93.219.39.46])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAL9EitA021793
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 21 Nov 2014 04:14:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <1416262453-30349-1-git-send-email-sbeller@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsUixO6iqNvGlB9iMO2wsUXXlW4mi4beK8wW
	b28uYbT4N6HGYvPmdhYHVo+ds+6yeyzYVOpx8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGffP
	dDEW7Bas+HNlMWsD4yneLkZODgkBE4k3M/4wQthiEhfurWfrYuTiEBK4zCjRPGkCE4Rzjkli
	79l/YFW8AtoSnVfXMYHYLAKqEhNOzWUGsdkEdCUW9TSDxUUFgiRO7rnODlEvKHFy5hMWEFtE
	wE9i38UrYDazQITEx2UXwWqEBZwlLrw+wgZiCwk4Sdy+egashhMofuXwaTaIej2JHdd/sULY
	8hLNW2czT2AUmIVkxSwkZbOQlC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGusl5tZopea
	UrqJERLWfDsY29fLHGIU4GBU4uFlWJYXIsSaWFZcmXuIUZKDSUmUd/ofoBBfUn5KZUZicUZ8
	UWlOavEhRgkOZiURXpHvQDnelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeH
	kgTvbob8ECHBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UKzGFwOjFSTFA7S3iBGo
	nbe4IDEXKArReopRUUqclwkkIQCSyCjNgxsLS1avGMWBvhTm7QGp4gEmOrjuV0CDmYAG/12a
	CzK4JBEhJdXAqBP+ROk+m1hymqm2XExL0M7f2o+OWj2M+r/0df8WD94kRpOHeRNj+mIKff5c
	vCTQ+IF1uUTD865AI6YP225pdNx7kLKD/RaHZXfddYV+m/PTlobxn798+8CeWJ23 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/17/2014 11:14 PM, Stefan Beller wrote:
> From: Ronnie Sahlberg <sahlberg@google.com>
> 
> Update copy_fd to return a meaningful errno on failure and also 
> preserve the existing errno variable.
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> As announced in [1], I'm going to take over the 
> ref-transactions-reflog series by Ronnie Sahlberg.
> 
> This patch was sent previously to the list as part of
> that series[2], but it seems to be unrelated to me.
> 
> Thanks,
> Stefan
> 
> [1] http://www.mail-archive.com/git@vger.kernel.org/msg61051.html
> [2] http://www.spinics.net/lists/git/msg240784.html
>  copy.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/copy.c b/copy.c
> index f2970ec..a8d366e 100644
> --- a/copy.c
> +++ b/copy.c
> @@ -8,12 +8,17 @@ int copy_fd(int ifd, int ofd)
>  		if (!len)
>  			break;
>  		if (len < 0) {
> -			return error("copy-fd: read returned %s",
> -				     strerror(errno));
> +			int save_errno = errno;
> +			error("copy-fd: read returned %s", strerror(errno));
> +			errno = save_errno;
> +			return -1;
> +		}
> +		if (write_in_full(ofd, buffer, len) < 0) {
> +			int save_errno = errno;
> +			error("copy-fd: write returned %s", strerror(errno));
> +			errno = save_errno;
> +			return -1;
>  		}
> -		if (write_in_full(ofd, buffer, len) < 0)
> -			return error("copy-fd: write returned %s",
> -				     strerror(errno));
>  	}
>  	return 0;
>  }
> 

Couldn't we save ourselves a lot of this "save_errno" boilerplate by
making error() and warning() preserve errno? They don't do any
meaningful internal error checking anyway, so even if they overwrite
errno, that value is useless to callers (who undoubtedly wouldn't check
such a value anyway). Something like

 int error(const char *err, ...)
 {
 	va_list params;
+	int save_errno = errno;

 	va_start(params, err);
 	error_routine(err, params);
 	va_end(params);
+	errno = save_errno;
 	return -1;
 }

and the same for warning()?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
