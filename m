From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use time_t for timestamps returned by approxidate() 
 instead of unsigned
Date: Sat, 24 Jan 2009 18:32:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901241829210.13232@racer>
References: <1232665622-5110-1-git-send-email-tim.henigan@gmail.com>  <alpine.DEB.1.00.0901240726070.13232@racer>  <32c343770901240813k2eeb19b0q65b533f829cb44d4@mail.gmail.com>  <alpine.DEB.1.00.0901241757140.13232@racer>
 <32c343770901240914n3fc76fe0vbe844e50cbc0bbf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, pasky@suse.cz, gitster@pobox.com
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 18:33:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQmNg-0005ve-CW
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 18:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbZAXRbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 12:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbZAXRbr
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 12:31:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:38588 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750972AbZAXRbq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 12:31:46 -0500
Received: (qmail invoked by alias); 24 Jan 2009 17:31:44 -0000
Received: from pD9EB3F9A.dip0.t-ipconnect.de (EHLO noname) [217.235.63.154]
  by mail.gmx.net (mp059) with SMTP; 24 Jan 2009 18:31:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/SdItwXxLSeMK1nEexqM4zydyxNDWFWdEDVUmMKT
	vJA4w/PREKMsuQ
X-X-Sender: gene099@racer
In-Reply-To: <32c343770901240914n3fc76fe0vbe844e50cbc0bbf@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106979>

Hi,

On Sat, 24 Jan 2009, Tim Henigan wrote:

> On Sat, Jan 24, 2009 at 11:58 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> >> Should I update the GitWiki page to remove this Janitor task or do 
> >> you keep it as a test to see if people are properly searching the 
> >> mail archives?
> >
> > Yes, please!
> 
> I did some more digging and found this last comment on the subject by 
> Linus: https://kerneltrap.org/mailarchive/git/2008/11/6/4014344
> 
> Given this, should the janitor task simply be deleted (since using 
> unsigned longs are safe until year 2038 is considered) or should it be 
> updated to change all timestamps to 64-bit values?
> 
> Also, there are still ~37 references to time_t in the code (e.g. the 
> index_state struct in cache.h).  Should these be phased out in favor of 
> unsigned longs (or perhaps 64-bit types)?

Correct me if I am wrong: there are two different uses of times.  One to 
output dates (which is where we use unsigned long), and one where we 
compare dates in file stats (where we use time_t).

I haven't looked at the code, though, so this might be incorrect.

If it is correct, though, I think that we should stay with time_t for the 
cases where we have to compare to time_t anyway (as the stat() calls give 
us the time in that datatype).

BTW the Janitor task was added by Pasky, so he should say something.  
Pasky?

Ciao,
Dscho
