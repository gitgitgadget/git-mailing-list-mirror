From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 3/7] git push: New options --matching and --current
Date: Mon, 9 Mar 2009 19:49:47 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903091938150.19665@iabervon.org>
References: <1236638151-6465-1-git-send-email-finnag@pvv.org> <1236638151-6465-4-git-send-email-finnag@pvv.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Tue Mar 10 00:51:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgpFf-0004bT-L1
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 00:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbZCIXtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 19:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752434AbZCIXtu
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 19:49:50 -0400
Received: from iabervon.org ([66.92.72.58]:53436 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752380AbZCIXtt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 19:49:49 -0400
Received: (qmail 10293 invoked by uid 1000); 9 Mar 2009 23:49:47 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Mar 2009 23:49:47 -0000
In-Reply-To: <1236638151-6465-4-git-send-email-finnag@pvv.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112763>

On Mon, 9 Mar 2009, Finn Arne Gangstad wrote:

> diff --git a/transport.h b/transport.h
> index 6bbc1a8..b897d0c 100644
> --- a/transport.h
> +++ b/transport.h
> @@ -34,6 +34,15 @@ struct transport {
>  #define TRANSPORT_PUSH_DRY_RUN 4
>  #define TRANSPORT_PUSH_MIRROR 8
>  #define TRANSPORT_PUSH_VERBOSE 16
> +#define TRANSPORT_PUSH_MATCHING 32
> +#define TRANSPORT_PUSH_CURRENT 64
> +/**
> + * All push flags that imply a certain set of refspecs to be pushed must
> + * be combined into TRANSPORT_PUSH_MODE_MASK
> + **/
> +#define TRANSPORT_PUSH_MODE_MASK \
> +    (TRANSPORT_PUSH_ALL | TRANSPORT_PUSH_MIRROR | TRANSPORT_PUSH_MATCHING | \
> +    TRANSPORT_PUSH_CURRENT)

It's kind of odd that you define these flags as TRANSPORT_PUSH_*, but 
implement them before entering transport_push(). I'm not sure which is 
right, but the combination is odd. I think just taking care of it in 
builtin-push with flags or options defined there is probably the best 
thing, currently.

	-Daniel
*This .sig left intentionally blank*
