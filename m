From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: bug with gitweb on kernel.org
Date: Tue, 24 Apr 2007 00:50:48 -0700
Message-ID: <1177401048.5357.27.camel@localhost.localdomain>
References: <alpine.LFD.0.98.0704192255180.4504@xanadu.home>
	 <f0jkvm$31p$1@sea.gmane.org>
	 <1177376808.5357.13.camel@localhost.localdomain>
	 <200704240933.58680.johherla@online.no>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johan Herland <johherla@online.no>
X-From: git-owner@vger.kernel.org Tue Apr 24 09:51:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgFnr-0004Yf-Kw
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 09:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161701AbXDXHvI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 03:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161702AbXDXHvH
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 03:51:07 -0400
Received: from shards.monkeyblade.net ([192.83.249.58]:56212 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161701AbXDXHvG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 03:51:06 -0400
Received: from [172.19.0.252] (c-76-21-106-12.hsd1.ca.comcast.net [76.21.106.12])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.13.8/8.13.8) with ESMTP id l3O7ov5Y004898
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Tue, 24 Apr 2007 00:50:58 -0700
In-Reply-To: <200704240933.58680.johherla@online.no>
X-Mailer: Evolution 2.8.3 (2.8.3-2.fc6) 
X-Virus-Scanned: ClamAV 0.88.7/3153/Mon Apr 23 19:26:21 2007 on shards.monkeyblade.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45424>

On Tue, 2007-04-24 at 09:33 +0200, Johan Herland wrote:
> On Tuesday 24 April 2007, J.H. wrote:
> > On Tue, 2007-04-24 at 03:06 +0200, Jakub Narebski wrote:
> > > J.H. wrote:
> > > > Well the only difference in the pages being served is the mime
> > > > type application/html vs. application/xhtml+xml.  Does anyone
> > > > know the original impetus to using application/xhtml+xml (despite
> > > > the fact that it's technically the correct choice) vs. just using
> > > > application/html for everything?  I'm sure there was a good
> > > > reason behind it and I'd rather know what that reason was before
> > > > I got changing things
> > >
> > > The idea was to serve application/xhtml+xml to browsers which
> > > _explicitely_ support it. But coupled with the fact that gitweb on
> > > kernel.org is modified gitweb with caching, and it looks like it
> > > caches also HTTP headers... I think simplest solution would be to
> > > remove complication, and always serve text/html (at least for
> > > kernel.org gitweb with caching modifications).
> >
> > It's either that or store only the data not the headers and deal with
> > the headers on each request - but that might have other unintended
> > consequences I haven't thought of yet.  Anyway I think your right -
> > short term solution if nothing else is serve out text/html and look
> > more closely at the problem when I rebase.
> 
> Actually, if the caching mechanism supports the spec properly 
> (specifically RFC 2616, section 14.44), you should be able to work 
> around this, without disabling the cache:
> 
> You can return different responses to different clients as long as you 
> use the HTTP Vary header (RFC 2616, section 14.44) to indicate the 
> criteria for selecting which response to return.
> 
> Finally, you can use the client's HTTP Accept header to figure out 
> whether the browser support XHTML or not. Basically just check 
> if "application/xhtml+xml" is listed with a greater (or equal, but 
> non-zero) Q-value than "text/html". I've attached a snippet of python 
> code that I use in my webapps for this purpose. It should be easily 
> translatable to the language of your choice.
> 
> A similar solution using PHP is sketched out here: 
> http://keystonewebsites.com/articles/mime_type.php
> 

I'm not even remotely following a normal caching RFC.  The code is all
up online if you want to look at it
http://git.kernel.org/?p=git/warthog9/gitweb.git;a=summary it's not
pretty but it works, and if nothing else it will give me a decent number
of data points and such for when I do the rebase that I can take into
consideration.

- John
