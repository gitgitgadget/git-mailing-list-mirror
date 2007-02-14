From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Wed, 14 Feb 2007 09:01:41 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702140855080.3604@woody.linux-foundation.org>
References: <45CFA30C.6030202@verizon.net> <200702130932.51601.litvinov2004@gmail.com>
 <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702130919100.8424@woody.linux-foundation.org>
 <7v7iumx7hu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702131053110.8424@woody.linux-foundation.org>
 <7v8xf1uxme.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702132127330.3604@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702141208020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45D31C0E.2040206@verizon.net> <Pine.LNX.4.64.0702140745110.3604@woody.linux-foundation.org>
 <7v64a4snfo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Levedahl <mdl123@verizon.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 18:03:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHNW3-0000mC-QY
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 18:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbXBNRBz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 12:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbXBNRBz
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 12:01:55 -0500
Received: from smtp.osdl.org ([65.172.181.24]:35434 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932483AbXBNRBy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 12:01:54 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1EH1ghB008395
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Feb 2007 09:01:43 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1EH1fNx003321;
	Wed, 14 Feb 2007 09:01:41 -0800
In-Reply-To: <7v64a4snfo.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.408 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39685>



On Wed, 14 Feb 2007, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > Actually, my patch already had one that you didn't mention: 
> >  6) CR never shows up alone.
> 
> Older Macs ;-)?

Yeah, I think we can ignore them..

Let's see if anybody ever complains ;)

> I would agree.  0-31 except HT, CR, LF and ESC would be a good
> idea; that would not harm text in UTF-8, EUC based various
> locales nor ISO 2022.

You could possibly add 127 to the list too (it's ascii DEL, I don't know 
if you should ever see it in anything that has anything to do with text).

> -	if (stats->nul)
> +	if (stats->nonprintable)

But this is too harsh.

It's quite common to have the occasional FF character. Some things really 
do use it for page breaks. So saying that *any* nonprintable character is 
bad is not a good idea.

Same goes for BS (some programs use it to show bold and underlined text: 
man-pages, for example).

		Linus
