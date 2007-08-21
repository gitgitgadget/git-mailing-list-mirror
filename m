From: Jeff King <peff@peff.net>
Subject: Re: git-stash segfaults ...
Date: Tue, 21 Aug 2007 02:05:10 -0400
Message-ID: <20070821060510.GA7323@coredump.intra.peff.net>
References: <20070820174427.GC7206@artemis.corp> <20070820200255.GD5544@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 08:05:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INMrr-0002kI-QQ
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 08:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754922AbXHUGFR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 02:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754983AbXHUGFR
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 02:05:17 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1406 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754922AbXHUGFP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 02:05:15 -0400
Received: (qmail 32000 invoked by uid 111); 21 Aug 2007 06:05:14 -0000
X-Spam-Status: No, hits=-1.4 required=15.0
	tests=ALL_TRUSTED
X-Spam-Check-By: peff.net
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 21 Aug 2007 02:05:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2007 02:05:10 -0400
Content-Disposition: inline
In-Reply-To: <20070820200255.GD5544@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56279>

On Mon, Aug 20, 2007 at 10:02:55PM +0200, Alex Riesen wrote:

> diff --git a/merge-recursive.c b/merge-recursive.c
> index 16f6a0f..464fc4e 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1701,6 +1701,8 @@ static struct commit *get_ref(const char *ref)
>  	if (get_sha1(ref, sha1))
>  		die("Could not resolve ref '%s'", ref);
>  	object = deref_tag(parse_object(sha1), ref, strlen(ref));
> +	if (!object)
> +		die("Could not resolve ref '%s' down to object", ref);
>  	if (object->type == OBJ_TREE)
>  		return make_virtual_commit((struct tree*)object,
>  			better_branch_name(ref));

I posted the exact same patch almost a month ago, but apparently nobody
was interested in applying it:

  http://mid.gmane.org/20070726050726.GC32617@coredump.intra.peff.net

-Peff
