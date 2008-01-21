From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 23:56:15 +0300
Message-ID: <20080121205615.GY14871@dpotapov.dyndns.org>
References: <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095!@ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <alpine.LFD.1.00.0801210934400.2957@woody.linux-foundation.org> <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 21:56:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH3hJ-000871-Fz
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 21:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbYAUU4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 15:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752459AbYAUU4U
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 15:56:20 -0500
Received: from smtp02.mtu.ru ([62.5.255.49]:65025 "EHLO smtp02.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbYAUU4T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 15:56:19 -0500
Received: from smtp02.mtu.ru (localhost [127.0.0.1])
	by smtp02.mtu.ru (Postfix) with ESMTP id 6E1F020099;
	Mon, 21 Jan 2008 23:56:09 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-188-102.pppoe.mtu-net.ru [85.141.188.102])
	by smtp02.mtu.ru (Postfix) with ESMTP id 3429032A84;
	Mon, 21 Jan 2008 23:56:07 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JH3gl-00083E-EQ; Mon, 21 Jan 2008 23:56:15 +0300
Content-Disposition: inline
In-Reply-To: <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp02.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71337>

On Mon, Jan 21, 2008 at 02:05:51PM -0500, Kevin Ballard wrote:
> >
> >But that is *entirely* a separate issue from "normalization".
> >
> >Kevin, you seem to think that normalization is somehow forced on you  
> >by
> >the "text-as-codepoints" decision, and that is SIMPLY NOT TRUE.
> >Normalization is a totally separate decision, and it's a STUPID one,
> >because it breaks so many of the _nice_ properties of using UTF-8.
> 
> I'm not saying it's forced on you, I'm saying when you treat filenames  
> as text,

to treat as text could mean different for different people. Some
may prefer to fi and fi_ligature to be treated as same in some
context.

> it DOESN'T MATTER if the string gets normalized. As long as  
> the string remains equivalent,

As matter of fact it does, otherwise characters would be the
same and we would not have this conversation at all. String
can be equivalent and not equivalent at the time, because there
are different equivalent relations. Finally, what HFS+ does
is even not normalization. In the technote, Apple explains
that they decompose some characters but not others for better
compatibility. So, you see, there is a PROBLEM here.

> YOU DON'T CARE about the underlying  
> byte stream.

It is not about byte stream. After all, if it were UTF-16 instead
of UTF-8, it would be one to one conversion for each character.
So, what gets corrupted by HFS+ are Unicode *characters*.

> 
> Alright, fine. I'm not saying HFS+ is right in storing the normalized  
> version, but I do believe the authors of HFS+ must have had a reason  
> to do that,

I don't say they do that without *any* reason, but I suppose all
Apple developers in the Copland project had some reasons for they
did, but the outcome was not very good...

> The only information you lose when doing canonical normalization is  
> what the original byte sequence was. 

Not true. You lose the original sequence of *characters*.

Dmitry
