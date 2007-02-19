From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Change "refs/" references to symbolic constants
Date: Mon, 19 Feb 2007 15:12:49 -0500
Message-ID: <20070219201249.GC27565@spearce.org>
References: <200702191839.05784.andyparkins@gmail.com> <7vlkit7vy5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 19 21:12:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJEsa-0001tp-Uh
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 21:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbXBSUMx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 15:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbXBSUMx
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 15:12:53 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:50858 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932563AbXBSUMw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 15:12:52 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HJEsN-0008RC-Id; Mon, 19 Feb 2007 15:12:43 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6410120FBAE; Mon, 19 Feb 2007 15:12:49 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vlkit7vy5.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40146>

Junio C Hamano <junkio@cox.net> wrote:
> > diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
> > index 3de9b3e..ac7543d 100644
> > --- a/builtin-pack-refs.c
> > +++ b/builtin-pack-refs.c
> > @@ -36,7 +36,7 @@ static int handle_one_ref(const char *path, const unsigned char *sha1,
> >  	/* Do not pack the symbolic refs */
> >  	if ((flags & REF_ISSYMREF))
> >  		return 0;
> > -	is_tag_ref = !strncmp(path, "refs/tags/", 10);
> > +	is_tag_ref = !strncmp(path, PATH_REFS_TAGS, STRLEN_PATH_REFS_TAGS);
> 
> These repeated strncmp(p, X, STRLEN_X) almost makes me wonder if we
> want to introduce:
> 
> 	inline int prefixcmp(a, b)
>         {
>         	return (strncmp(a, b, strlen(b));
>         }
> 
> with clever preprocessor optimization to have compiler do strlen()
> when b is a string literal.

This may be worthwhile.  We use strncmp so often in Git that I
tend to write strncmp even when I mean strcmp.  Yes, my fingers are
trained to write strncmp, and only strncmp...  *sigh* At least the
compiler checks for me.  ;-)

-- 
Shawn.
