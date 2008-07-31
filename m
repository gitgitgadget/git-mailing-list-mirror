From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: q: git-fetch a tad slow?
Date: Thu, 31 Jul 2008 14:19:19 -0700
Message-ID: <20080731211919.GC24631@spearce.org>
References: <20080728160138.GA12777@elte.hu> <20080729055014.GE11947@spearce.org> <20080729090802.GA11373@elte.hu> <20080730044855.GA7225@spearce.org> <20080730190657.GC26389@elte.hu> <20080731044531.GB1860@spearce.org> <20080731210307.GF25138@elte.hu> <20080731211141.GA1159@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Thu Jul 31 23:20:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOfZO-0001A5-1L
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 23:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693AbYGaVTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 17:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753987AbYGaVTV
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 17:19:21 -0400
Received: from george.spearce.org ([209.20.77.23]:48807 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693AbYGaVTU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 17:19:20 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E72CE38419; Thu, 31 Jul 2008 21:19:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080731211141.GA1159@elte.hu>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90995>

Ingo Molnar <mingo@elte.hu> wrote:
> 
> on another box, with 1.5.4, i have:
> 
>  dione:~/tip> time git fetch origin
> 
>  real    0m0.481s
>  user    0m0.136s
>  sys     0m0.060s
> 
>  dione:~/tip> time ./tip-fetch
>  b714d1a257cca93ba6422ca3276ac80a2cde2b59
>  b714d1a257cca93ba6422ca3276ac80a2cde2b59
> 
>  real    0m0.273s
>  user    0m0.012s
>  sys     0m0.020s
> 
> that's a 2.66 GHz core2 quad, i.e. a pretty fast box too. As you can see 
> most time spent in the tip-fetch case was waiting for the network. So 
> there's about 200 msecs of extra CPU cost on the local side.

Yea.  My testing last night was suggesting about 1/2 of that 200
ms is on the client, and the other 200 ms is on the server side
of the connection.  That matches up somewhat with your test above,
where git-fetch used about 100 ms more user time on the client side
than your tip-fetch shell script.

I have no clue where the bottleneck is, I didn't get that far before
I realized you must have been running a shell script based git-fetch
to be seeing the performance you were.

Maybe 1.6.1 or .2 we can try to squeeze fetch to run faster.
Its far too late for 1.6.0.

> Sorry that i didnt notice that titan had 1.5.2 - i almost never notice 
> it when i switch between stable git versions. (you guys are doing a 
> really good job on compatibility)

Yea, its easy to not realize your git isn't giving you the latest
and greatest toys.  ;-)

-- 
Shawn.
