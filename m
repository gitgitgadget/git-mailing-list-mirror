From: Petr Baudis <pasky@suse.cz>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Mon, 19 Apr 2010 13:51:13 +0200
Message-ID: <20100419115113.GC3563@machine.or.cz>
References: <201004150630.44300.chriscool@tuxfamily.org>
 <201004181950.19610.jnareb@gmail.com>
 <20100418195623.GA3563@machine.or.cz>
 <201004191243.24209.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Sam Vilain <sam@vilain.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 13:51:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3pVd-0002K4-Mm
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 13:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752943Ab0DSLvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 07:51:16 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53927 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752328Ab0DSLvP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 07:51:15 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 6F05E86208E; Mon, 19 Apr 2010 13:51:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201004191243.24209.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145290>

On Mon, Apr 19, 2010 at 12:43:22PM +0200, Jakub Narebski wrote:
> On Sun, Apr 18, 2010 at 21:56 +0200, Petr Baudis wrote:
> > If the project is a success, I wanted to use it for mob branch editing
> > on repo.or.cz. It could also be used as open-source Gist alternative.
> 
> For that you would need editing file / editing contents action, but
> this is explicitely excluded in current version of Pavan's proposal :-(

Is it? I see it only being omitted.

> > But it needs to be coded so that it does not require an actual checked
> > out copy (which shouldn't be too much hassle).
> 
> It would require using 'git hash-object -t blob -w --stdin' (from body
> submitted via POST from textarea) plus 'git update-index --cacheinfo'.

Yes. Not a whole lot of effort, seems to me. A downside is that you
cannot use the working tree - index dichotomy, but life isn't perfect.

> There is however complication that you would need to do open2/open3
> because git-hash-object would require bidirectional communication unless
> you would use temporary file (command_bidi_pipe in Git.pm, untested).

I think even just going through a temporary file is fine for initial
implementation.

> So additional step would be
> 
>         cp -fvR gitweb/lib /var/www/cgi-bin/    ;# as root

Yes!

> I hope that we could make installing gitweb as easy as
> 
>         make webscriptdir=/var/www/cgi-bin/ \
>              gitweb-install
>  
> or in more complicated case (gitweb modules not installed in cgi-bin)
> 
>         make webscriptdir=/var/www/cgi-bin/gitweb \
>              GITWEB_BASE="/gitweb/" \
>              GITWEBPERLLIB=/usr/local/lib/perl5 \
>              gitweb-install
> 
> or something like that (I do not know any standard for the name of build
> configuration variable which tells where to install web aplication; 
> do you?)

Ideally, yes, but that's not directly tied to the splitting effort.
(No clue about the configuration variable.)

> Well, I would perhaps start simply with 
> 
>   gitweb.perl
>   lib/Gitweb.pm
> 
> We can modify file organization later; what's important is the build
> infrastructure (even if it is instruction in gitweb/INSTALL).

That sounds like the best way. :)

-- 
				Petr "Pasky" Baudis
http://pasky.or.cz/ | "Ars longa, vita brevis." -- Hippocrates
