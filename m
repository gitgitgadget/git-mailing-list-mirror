From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [PATCH 4/9] http-fetch: Actually watch the file descriptors of interest.
Date: Wed, 1 Feb 2006 07:03:27 -0800
Message-ID: <20060201150327.GH3873@reactrix.com>
References: <20060201112822.5042.41256.stgit@metalzone.distorted.org.uk> <20060201114433.5042.22737.stgit@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 16:04:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4JWN-00076n-0L
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 16:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbWBAPDo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 10:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWBAPDo
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 10:03:44 -0500
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:27619 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932466AbWBAPDo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 10:03:44 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k11F3S5Q022830;
	Wed, 1 Feb 2006 07:03:28 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k11F3RtG022828;
	Wed, 1 Feb 2006 07:03:28 -0800
To: Mark Wooding <mdw@distorted.org.uk>
Content-Disposition: inline
In-Reply-To: <20060201114433.5042.22737.stgit@metalzone.distorted.org.uk>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15417>

On Wed, Feb 01, 2006 at 11:44:33AM +0000, Mark Wooding wrote:

> Presumably this was just some kind of oversight.

I was never able to make this work reliably across multiple versions of
curl.

> Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
> ---
> 
>  http.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/http.c b/http.c
> index 0a70e1c..521323c 100644
> --- a/http.c
> +++ b/http.c
> @@ -425,6 +425,8 @@ void run_active_slot(struct active_reque
>  			FD_ZERO(&excfds);
>  			select_timeout.tv_sec = 0;
>  			select_timeout.tv_usec = 50000;
> +			curl_multi_fdset(curlm, &readfds, &writefds,
> +					 &excfds, &max_fd);
>  			select(max_fd, &readfds, &writefds,
>  			       &excfds, &select_timeout);
>  		}
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
