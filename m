From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3/GSoC 3/5] git-credential-cache: put socket to
 xdg-compatible path
Date: Fri, 25 Mar 2016 06:00:42 -0400
Message-ID: <20160325100041.GC8880@sigill.intra.peff.net>
References: <1458728005-22555-1-git-send-email-huiyiqun@gmail.com>
 <1458728005-22555-3-git-send-email-huiyiqun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pickfire@riseup.net
To: Hui Yiqun <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 11:00:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajOXy-0007In-9I
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 11:00:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbcCYKAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 06:00:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:38116 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751337AbcCYKAp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 06:00:45 -0400
Received: (qmail 5887 invoked by uid 102); 25 Mar 2016 10:00:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 25 Mar 2016 06:00:45 -0400
Received: (qmail 22340 invoked by uid 107); 25 Mar 2016 10:01:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 25 Mar 2016 06:01:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Mar 2016 06:00:42 -0400
Content-Disposition: inline
In-Reply-To: <1458728005-22555-3-git-send-email-huiyiqun@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289871>

On Wed, Mar 23, 2016 at 06:13:23PM +0800, Hui Yiqun wrote:

> move .git-credential-cache/socket to xdg_runtime_dir("credential-cache.sock")

Motivation?

> diff --git a/credential-cache.c b/credential-cache.c
> index f4afdc6..40d838b 100644
> --- a/credential-cache.c
> +++ b/credential-cache.c
> @@ -105,7 +105,7 @@ int main(int argc, const char **argv)
>  	op = argv[0];
>  
>  	if (!socket_path)
> -		socket_path = expand_user_path("~/.git-credential-cache/socket");
> +		socket_path = xdg_runtime_dir("credential-cache.sock");
>  	if (!socket_path)
>  		die("unable to find a suitable socket path; use --socket");

We do our own mkdir and chmod in credential-cache; this should be
redundant with what xdg_runtime_dir() does, and can be removed, right?

-Peff
