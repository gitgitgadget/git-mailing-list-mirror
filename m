From: Eric Raible <raible@gmail.com>
Subject: Re: git am with MIME
Date: Thu, 21 Aug 2008 03:34:03 +0000 (UTC)
Message-ID: <loom.20080821T033231-805@post.gmane.org>
References: <48AAEBB6.9070306@gmail.com> <20080819170731.GA2424@coredump.intra.peff.net> <20080820195734.GE16626@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 05:35:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW0xJ-00037W-6C
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 05:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879AbYHUDeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 23:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752686AbYHUDeU
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 23:34:20 -0400
Received: from main.gmane.org ([80.91.229.2]:49290 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477AbYHUDeU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 23:34:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KW0wA-00010d-Ds
	for git@vger.kernel.org; Thu, 21 Aug 2008 03:34:14 +0000
Received: from adsl-75-24-105-96.dsl.pltn13.sbcglobal.net ([75.24.105.96])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 03:34:14 +0000
Received: from raible by adsl-75-24-105-96.dsl.pltn13.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 03:34:14 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 75.24.105.96 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.1) Gecko/2008070208 Firefox/3.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93107>

Alex Riesen <raa.lkml <at> gmail.com> writes:

> 
> Jeff King, Tue, Aug 19, 2008 19:07:31 +0200:
> > On Tue, Aug 19, 2008 at 05:50:14PM +0200, Lea Wiemann wrote:
> > @@ -107,7 +107,7 @@ static void handle_from(const struct strbuf *from)
> >  	el = strcspn(at, " \n\t\r\v\f>");
> >  	strbuf_reset(&email);
> >  	strbuf_add(&email, at, el);
> > -	strbuf_remove(&f, at - f.buf, el + 1);
> > +	strbuf_remove(&f, at - f.buf, el + (at[el] ? 1 : 0));
> >  
> 
>  +	strbuf_remove(&f, at - f.buf, el + !!at[el]);
> 
> (Some people'll kill me for that :)

And why shouldn't they when:

	strbuf_remove(&f, at - f.buf, el + (at[el] != 0));

is infinitely better in every possible way? ;)
