From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] gitweb fix validating pg (page) parameter
Date: Sun, 17 Sep 2006 23:38:38 +0200
Message-ID: <20060917213838.GA12782@moooo.ath.cx>
References: <20060917115245.GA15658@moooo.ath.cx> <7vlkoi2nqr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 23:38:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GP4Ld-0000mg-Qe
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 23:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbWIQVin (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 17:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbWIQVin
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 17:38:43 -0400
Received: from moooo.ath.cx ([85.116.203.178]:12978 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S965116AbWIQVim (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Sep 2006 17:38:42 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vlkoi2nqr.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27208>

Junio C Hamano <junkio@cox.net> wrote:
> Matthias Lederhofer <matled@gmx.net> writes:
> 
> > Currently it is possible to give any string ending with a number as
> > page.  -1 for example is quite bad (error log shows probably 100
> > warnings).
> >
> > @@ -259,7 +259,7 @@ if (defined $hash_parent_base) {
> >  
> >  our $page = $cgi->param('pg');
> >  if (defined $page) {
> > -	if ($page =~ m/[^0-9]$/) {
> > +	if ($page =~ m/[^0-9]/) {
> >  		die_error(undef, "Invalid page parameter");
> >  	}
> >  }
> 
> Are we complaining if $page is not a validly formatted number
> here?  If so why not
> 
> 	unless ($page =~ /^\d+$/ && 1 <= $page) {
>         	barf(...);
> 	}
The first page seems to have number 0.  After removing the 1 <= $page
this code should do the same as my patch, apply whatever you think is
easier to read (I prefer if over unless most of the time).
