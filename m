From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] add--interactive: handle initial commit better
Date: Wed, 13 Feb 2008 12:19:26 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802131213270.30505@racer.site>
References: <C50196C5-B0C5-4536-AD4A-0F9C553782EE@gmail.com> <20080213101649.GA18444@coredump.intra.peff.net> <20080213105051.GA26522@coredump.intra.peff.net> <20080213112504.GA26627@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Rhodes, Kate" <masukomi@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 13 13:19:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPGai-0000QB-82
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 13:19:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756381AbYBMMTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 07:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756378AbYBMMTV
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 07:19:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:42735 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756334AbYBMMTV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 07:19:21 -0500
Received: (qmail invoked by alias); 13 Feb 2008 12:19:18 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 13 Feb 2008 13:19:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ewz06XSFeN9yIBq9rXW5nLQcsgt4ItcMp2krhdH
	MA9/dkiuGTHYdT
X-X-Sender: gene099@racer.site
In-Reply-To: <20080213112504.GA26627@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73781>

Hi,

On Wed, 13 Feb 2008, Jeff King wrote:

> diff --git a/sha1_file.c b/sha1_file.c
> index 4179949..1a6c7c8 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1845,6 +1845,15 @@ static struct cached_object {
>  } *cached_objects;
>  static int cached_object_nr, cached_object_alloc;
>  
> +static struct cached_object empty_tree = {
> +	/* empty tree sha1: 4b825dc642cb6eb9a060e54bf8d69288fbee4904 */
> +	"\x4b\x82\x5d\xc6\x42\xcb\x6e\xb9\xa0\x60"
> +	"\xe5\x4b\xf8\xd6\x92\x88\xfb\xee\x49\x04",
> +	OBJ_TREE,
> +	"",
> +	0
> +};
> +
>  static struct cached_object *find_cached_object(const unsigned char *sha1)
>  {
>  	int i;
> @@ -1854,6 +1863,8 @@ static struct cached_object *find_cached_object(const unsigned char *sha1)
>  		if (!hashcmp(co->sha1, sha1))
>  			return co;
>  	}
> +	if (!hashcmp(sha1, empty_tree.sha1))
> +		return &empty_tree;
>  	return NULL;
>  }

Heh.  This is cute.  But it is also a bit hard to reference, no?  I mean, 
you have to remember the SHA-1 of it...

Maybe {} ?

Ciao,
Dscho
