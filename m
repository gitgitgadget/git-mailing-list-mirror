From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-fast-import
Date: Thu, 8 Feb 2007 22:34:17 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702082227170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070206023111.GB9222@spearce.org> <200702060928.54440.andyparkins@gmail.com>
 <Pine.LNX.4.64.0702060836180.8424@woody.linux-foundation.org>
 <20070206164441.GA4949@spearce.org> <200702070117.l171HGxr023213@laptop13.inf.utfsm.cl>
 <Pine.LNX.4.64.0702061832020.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 08 22:34:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFGuR-0002g0-KB
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 22:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423430AbXBHVeU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 16:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423433AbXBHVeU
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 16:34:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:37979 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423430AbXBHVeT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 16:34:19 -0500
Received: (qmail invoked by alias); 08 Feb 2007 21:34:18 -0000
X-Provags-ID: V01U2FsdGVkX18OdpEWgUIOakFt2tr2idd+r2wetU9YT194ix5+ku
	hhyA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702061832020.8424@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39098>

Hi,

On Tue, 6 Feb 2007, Linus Torvalds wrote:

> [Talks about timestamps being in UTC, even if augmented by a timezone]
>
> And yes, for all I know we might get this wrong inside git too. It's 
> easy to get confused, because they really do mean different things.

FWIW I just grepped git for tz, and looked at the results. The place I had 
to think a bit more about was in builtin-blame.c:format_time(). Probably a 
special date format is needed to stay compatible with cvsserver, otherwise 
show_date() or even show_rfc2822_date() could be used.

The code actually adds the timezone in minutes to the timestamp, and then 
calls gmtime() to be able to format the date with strftime() (something 
similar, without strftime() is done in show_[rfc2822_]date()). The result 
is correct AFAICT, although it would be cleaner IMHO to add yet another 
function to date.c which formats the time according to cvsserver's wishes.

Post 1.5.0.

Ciao,
Dscho
