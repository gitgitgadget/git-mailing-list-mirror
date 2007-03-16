From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] user-manual: ensure generated manual references stylesheet
Date: Fri, 16 Mar 2007 10:24:31 -0400
Message-ID: <20070316142431.GE31722@fieldses.org>
References: <1173045556191-git-send-email-bfields@citi.umich.edu> <11730455574115-git-send-email-bfields@citi.umich.edu> <1173045558959-git-send-email-bfields@citi.umich.edu> <11730455591178-git-send-email-bfields@citi.umich.edu> <loom.20070316T134149-54@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Pluim <rpluim+git@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 15:24:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSDME-0004Tl-ID
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 15:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbXCPOYe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 10:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbXCPOYe
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 10:24:34 -0400
Received: from mail.fieldses.org ([66.93.2.214]:43361 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965055AbXCPOYd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 10:24:33 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HSDM7-0003a3-Gp; Fri, 16 Mar 2007 10:24:31 -0400
Content-Disposition: inline
In-Reply-To: <loom.20070316T134149-54@post.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42363>

On Fri, Mar 16, 2007 at 12:44:19PM +0000, Robert Pluim wrote:
> J. Bruce Fields <bfields <at> citi.umich.edu> writes:
> 
> 
> > +XSLT = http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl
> > +XSLTOPTS = --nonet --xinclude --stringparam html.stylesheet docbook-xsl.css
> > +
> >  user-manual.html: user-manual.xml
> > -	xmlto html-nochunks $<
> > +	xsltproc $(XSLTOPTS) -o $ <at>  $(XSLT) $<
> 
> Does this actually work for you?  I get:
> 
>   xsltproc --nonet --xinclude --stringparam html.stylesheet docbook-xsl.css -o
> user-manual.html
> http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl user-manual.xml
>   I/O error : Attempt to load network entity
> http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl
>   warning: failed to load external entity
> "http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl"
>   cannot parse http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl
>   make[1]: *** [user-manual.html] Error 4
> 
> 
> If I remove the --nonet it works fine.

Yes, it works for me.  From a quick strace, it appears to find the file
by opening /etc/xml/catalog, aplying some URL-rewriting rules found
there, then finding a file on my local filesystem under
/usr/share/sgml/docbook/.  Those files appear to be provided by a
package named docbook-style-xsl on my fedora box, and something called
docbook-xsl on my debian box.

I'd prefer the build not require network access, if possible.

--b.
