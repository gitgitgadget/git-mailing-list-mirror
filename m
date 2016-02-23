From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] credential-cache--daemon: change to the socket dir
 on startup
Date: Tue, 23 Feb 2016 16:10:46 -0500
Message-ID: <20160223211046.GA25905@sigill.intra.peff.net>
References: <20160223071427.GA7489@sigill.intra.peff.net>
 <20160223071604.GC8395@sigill.intra.peff.net>
 <xmqqfuwjyw59.fsf@gitster.mtv.corp.google.com>
 <20160223210725.GA25854@sigill.intra.peff.net>
 <xmqqbn77yvzb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jon Griffiths <jon_p_griffiths@yahoo.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 22:10:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYKEO-0008RN-Qk
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 22:10:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755375AbcBWVKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 16:10:49 -0500
Received: from cloud.peff.net ([50.56.180.127]:47802 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755279AbcBWVKt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 16:10:49 -0500
Received: (qmail 24470 invoked by uid 102); 23 Feb 2016 21:10:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Feb 2016 16:10:48 -0500
Received: (qmail 32301 invoked by uid 107); 23 Feb 2016 21:10:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Feb 2016 16:10:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Feb 2016 16:10:46 -0500
Content-Disposition: inline
In-Reply-To: <xmqqbn77yvzb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287125>

On Tue, Feb 23, 2016 at 01:09:44PM -0800, Junio C Hamano wrote:

> I tentatively squashed this, which I think reads better.
> 
> diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
> index 9a3a7a3..6b00ee0 100644
> --- a/credential-cache--daemon.c
> +++ b/credential-cache--daemon.c
> @@ -237,12 +237,13 @@ static void init_socket_directory(const char *path)
>  			die_errno("unable to mkdir '%s'", dir);
>  	}
>  
> -	/*
> -	 * We don't actually care what our cwd is; we chdir here just to
> -	 * be a friendly daemon and avoid tying up our original cwd.
> -	 * If this fails, it's OK to just continue without that benefit.
> -	 */
> -	chdir(dir);
> +	if (chdir(dir))
> +		/*
> +		 * We don't actually care what our cwd is; we chdir here just to
> +		 * be a friendly daemon and avoid tying up our original cwd.
> +		 * If this fails, it's OK to just continue without that benefit.
> +		 */
> +		;
>  
>  	free(path_copy);
>  }

That looks great, thanks.

-Peff
