From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH GSoC 1/3] gitweb: Create Gitweb::Config module
Date: Thu, 3 Jun 2010 18:06:05 +0200
Message-ID: <20100603160605.GF20775@machine.or.cz>
References: <1275573356-21466-1-git-send-email-pavan.sss1991@gmail.com>
 <20100603152030.GD20775@machine.or.cz>
 <201006031755.29814.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 18:06:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKCvv-0002QN-Sl
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 18:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510Ab0FCQGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 12:06:10 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50656 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184Ab0FCQGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 12:06:09 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 00016862094; Thu,  3 Jun 2010 18:06:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201006031755.29814.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148341>

On Thu, Jun 03, 2010 at 05:55:28PM +0200, Jakub Narebski wrote:
> But from what I've heard FindBin is not recommended anymore, although
> perhaps the disadvantages of FindBin doesn't matter in our situation.

Ah, never mind then. It's probably more trouble than it's worth, even if
it's not problematic for us right at the moment.

> > > +
> > > +use Gitweb::Config;
> > >  
> > >  BEGIN {
> > >  	CGI->compile() if $ENV{'MOD_PERL'};
> > >  }
> > >  
> > > -our $version = "++GIT_VERSION++";
> > > +$version = "++GIT_VERSION++";
> 
> This change is not necessary.
> 
>   our $version = "++GIT_VERSION++";
> 
> would keep working even if '$version' is declared in other module and
> exported by this module (is imported into current scope).

Hmm, that's right, but it feels dirty since it strongly suggests that
$version is then a variable local to this package. It would reduce the
diff size, but I perosnally don't think it's worth it. I'll leave this
up to Pavan personally, though.

> Perhaps we should provide some sane default fallback values, like for
> example
> 
>   	our $GIT = "git";

I considered that, but I'm not too fond of this within this patch,
I'd rather keep the pieces simple and stupid.

> > >  # name of your site or organization to appear in page titles
> > >  # replace this with something more descriptive for clearer bookmarks
> > > -our $site_name = "++GITWEB_SITENAME++"
> > > +$site_name = "++GITWEB_SITENAME++"
> > >                   || ($ENV{'SERVER_NAME'} || "Untitled") . " Git";
> > 
> > This looks like some new feature; please do that in a separate patch.
> > (BTW, I assume that there are no other changes like this in the rest of
> > the moved code blocks!)
> 
> No, it isn't.  And without 'our $var = VALUE' -> '$var = VALUE' change,
> which is not necessary and artifically inflates the size of patch, this
> chunk wouldn't even be present.

I'm sorry, I was just blind.

-- 
				Petr "Pasky" Baudis
The true meaning of life is to plant a tree under whose shade
you will never sit.
