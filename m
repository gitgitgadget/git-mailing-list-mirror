From: Francis Daly <francis@daoine.org>
Subject: Re: gitweb testing with non-apache web server
Date: Fri, 4 Aug 2006 00:55:36 +0100
Message-ID: <20060803235536.GJ17966@craic.sysops.org>
References: <20060803202703.GA13147@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Blu Corater <blu@daga.cl>, Marc Singer <elf@buici.com>
X-From: git-owner@vger.kernel.org Fri Aug 04 01:56:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8n34-0004ob-PB
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 01:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWHCX4O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 19:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbWHCX4O
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 19:56:14 -0400
Received: from craic.sysops.org ([217.75.2.2]:19586 "EHLO craic.sysops.org")
	by vger.kernel.org with ESMTP id S1030217AbWHCX4M (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 19:56:12 -0400
Received: from craic.sysops.org (craic.sysops.org [127.0.0.1])
	by craic.sysops.org (8.13.1/8.12.11) with SMTP id k73NtaeF002537;
	Fri, 4 Aug 2006 00:55:37 +0100
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060803202703.GA13147@buici.com>
User-Agent: Mutt/1.4.1i
X-Virus-Scanned: ClamAV 0.88/1634/Wed Aug  2 23:32:49 2006 on craic.sysops.org
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.6
X-Spam-Checker-Version: SpamAssassin 3.0.6 (2005-12-07) on craic.sysops.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24759>

> Marc Singer wrote: 
> On Thu, Aug 03, 2006 at 03:21:52PM -0400, Blu Corater wrote:

Hi there,

> > If I request http://server/~blu/scm, Cherokee returns Cherokee's default
> > index page. Only if I request http://server/~blu/scm/, Cherokee returns
> > the expected output from gitweb.

This is due to one apparent bug in Cherokee's Directory handling.

> I can see the project overview page, but all of the links bring me
> back to the same top-level page, no summary, not logs.  I've verified
> that the web server's user can read the git repo. 

And this is due a a different, but arguably related, one.  (The 301
handler ignores things it shouldn't.)

> I don't doubt that this is a cherokee issue.

Cherokee's handling of both Directory and Request sections with cgi and
Scriptalias seems a bit funky (in different ways).  If you want to use
Cherokee configured this way, you may find it handy to add

$my_uri .= '/';

to your version of gitweb.cgi shortly after it is set -- that should
break most of the generated links in a way that causes them to work with
this server.

$my_url is only used in a few places, but it may be worth doing the same
thing to it too.

Or use a web server which isn't broken in this particular way.

Good luck,

	f
-- 
Francis Daly        francis@daoine.org
