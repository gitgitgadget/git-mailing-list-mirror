From: Marc Singer <elf@buici.com>
Subject: Re: gitweb testing with non-apache web server
Date: Fri, 4 Aug 2006 00:30:39 -0700
Message-ID: <20060804073039.GA20417@buici.com>
References: <20060803202703.GA13147@buici.com> <20060803235536.GJ17966@craic.sysops.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 04 09:30:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8u8q-0007wU-4A
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 09:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161092AbWHDHal (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 03:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161094AbWHDHal
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 03:30:41 -0400
Received: from 206-124-142-26.buici.com ([206.124.142.26]:4308 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S1161092AbWHDHak
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 03:30:40 -0400
Received: (qmail 20716 invoked by uid 1000); 4 Aug 2006 07:30:39 -0000
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060803235536.GJ17966@craic.sysops.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24778>

I found that lighttpd works well, though the configuration was a
little more complex.

The recipe that works well is to make the URL

  http://server/git

to the gitweb.cgi script.  I put the script and the CSS file in a
directory, /var/lib/git/, and then put the following into the lighttpd
configuration:

  # Serve GIT
  url.redirect    = ( "^/git$" => "/git/" )
  alias.url       += ( "/git/" => "/var/lib/git/" )
  $HTTP["url"]    =~ "^/git/" {
    cgi.assign            = ( ".cgi" => "" )
    index-file.names      = ( "gitweb.cgi" )
  }

Cheers.
