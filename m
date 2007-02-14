From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Wed, 14 Feb 2007 21:24:09 +0100
Organization: Dewire
Message-ID: <200702142124.10996.robin.rosenberg.lists@dewire.com>
References: <45CFA30C.6030202@verizon.net> <200702141917.51341.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.64.0702141027380.3604@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Mark Levedahl <mlevedahl@verizon.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Levedahl <mdl123@verizon.net>,
	Junio C Hamano <junkio@cox.net>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 14 21:23:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHQfD-0001p3-PL
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 21:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbXBNUXL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 15:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbXBNUXK
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 15:23:10 -0500
Received: from [83.140.172.130] ([83.140.172.130]:19679 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932564AbXBNUXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 15:23:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 24CA8803393;
	Wed, 14 Feb 2007 21:18:15 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 01734-09; Wed, 14 Feb 2007 21:18:14 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id AC0A6800199;
	Wed, 14 Feb 2007 21:18:12 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <Pine.LNX.4.64.0702141027380.3604@woody.linux-foundation.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39738>

onsdag 14 februari 2007 19:31 skrev Linus Torvalds:
> 
> On Wed, 14 Feb 2007, Robin Rosenberg wrote:
> > 
> > That may be why an excellent piece of software, TortoiseCVS,  doesn't trust 
> > cvs or cvsnt to do the job. Here is how they do the binary detection (and 
> > some more):
> > 
> > http://tortoisecvs.cvs.sourceforge.net/tortoisecvs/TortoiseCVS/src/CVSGlue/CVSStatus.cpp?revision=1.172&view=markup
> 
> Well, it does seem to boil down to what Junio already got to:
> 
>  - 0-31 and 127 are never in text, except for BEL, BS, HT, LF, FF, CR and 
>    ESC.
>  - 128-255 can all be in either iso-8859 or extended ascii (or they 
>    explicitly add NEL but not 128+27 to "normal ASCII", which is strange)
>
> So they've effectively added BEL and ESC to the listof characters that 
Especially ESC used to be common in DOS/Windows and quite a few hang around in
older code.

> Junio has now. But they also make it an absolute error to have anything 
> else (no "1% rule").
Can this 1%-rule be motivated from real cases, rather that hypotetical ones? It makes 
it harder to understand  why the tools makes a particular decision.

> But they also do the filename tests, and I think that's more important in 
> many ways.

A unixy tool like git should maybe use magic too :).

Btw the filename (like .gitignore or similar) test in practice would give us 
 the binary flag. Just list a filename instead of a pattern.

-- robin
