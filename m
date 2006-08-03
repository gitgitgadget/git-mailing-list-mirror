From: Marc Singer <elf@buici.com>
Subject: Re: gitweb testing with non-apache web server
Date: Thu, 3 Aug 2006 08:34:03 -0700
Message-ID: <20060803153403.GA30729@buici.com>
References: <20060803075403.GA5238@buici.com> <easbev$act$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 03 17:34:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8fD8-000765-BE
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 17:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWHCPeF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 11:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWHCPeF
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 11:34:05 -0400
Received: from 206-124-142-26.buici.com ([206.124.142.26]:27102 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S964800AbWHCPeE
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 11:34:04 -0400
Received: (qmail 31021 invoked by uid 1000); 3 Aug 2006 15:34:03 -0000
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <easbev$act$1@sea.gmane.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24732>

On Thu, Aug 03, 2006 at 10:18:07AM +0200, Jakub Narebski wrote:
> <opublikowany i wys?any>
> 
> Marc Singer wrote:
> 
> 
> > I did some debugging on the latest repo version.  The lines
> > 
> >   our $project = ($cgi->param('p') || $ENV{'PATH_INFO'});
> >   if (defined $project) {
> >      ...
> > 
> > are being executed even though the url is
> > 
> >   http://server/git
> > 
> > I think that the problem is that Cherokee translates the request URL
> > into
> > 
> >   http://server/git/
> > 
> > which means that the $ENV{'PATH_INFO'} is the string "/" insted of
> > being undefined.
> 
> Try changing
> 
> my $project = ($cgi->param('p') || $ENV{'PATH_INFO'});
> if (defined $project) {
>         $project =~ s|^/||; $project =~ s|/$||;
> 
> to
> 
> my $project = ($cgi->param('p') || $ENV{'PATH_INFO'});
> $project =~ s|^/||; $project =~ s|/$||;
> if (defined $project && $project) {     
> 
> (and send patch if it works, please).

That isn't enough.  I did something like that when I was exploring the
script.  While the change *does* eliminate the 403 error, it doesn't
make the rest of the script work properly.  All of the links return to
the same page that lists the projects.


> 
> -- 
> Jakub Narebski
> Warsaw, Poland
> ShadeHawk on #git
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
