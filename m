From: Daniel Villeneuve <daniel2villeneuve@videotron.ca>
Subject: Re: How to stop sharing objects between repositories
Date: Sun, 16 Aug 2009 09:54:17 -0400
Message-ID: <4A880F89.3060702@videotron.ca>
References: <alpine.DEB.2.00.0908151756150.29215@nhtr.ovalna.fjrygre.arg>
 <alpine.DEB.1.00.0908161042210.8306@pacific.mpi-cbg.de>
 <20090816122842.GA942@sigill.intra.peff.net>
 <alpine.DEB.1.00.0908161429590.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Jon Jensen <jon@endpoint.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 16 15:54:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McgBk-0003zp-Nt
	for gcvg-git-2@gmane.org; Sun, 16 Aug 2009 15:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196AbZHPNyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 09:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752187AbZHPNyM
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 09:54:12 -0400
Received: from relais.videotron.ca ([24.201.245.36]:61447 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742AbZHPNyM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 09:54:12 -0400
Received: from [192.168.1.100] ([96.23.157.191]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOH007MB2MCCPD0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 16 Aug 2009 09:54:12 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
In-reply-to: <alpine.DEB.1.00.0908161429590.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126058>

Johannes Schindelin wrote:
> Hmm.  I really would like a documentation patch, then.
>
>   
As another way to do it, I've used something along the lines from
    http://article.gmane.org/gmane.comp.version-control.git/62062
namely:

<script>
gitdir=$(git rev-parse --git-dir)
[ -n "$gitdir" ] || die "cannot find Git directory"

cd "$gitdir"
a=objects/info/alternates
if [ -f $a ]; then
  git rev-parse --all HEAD | git pack-objects --revs objects/pack/pack
  rm $a
fi
</script>

I was not sure HEAD would be included via --all (e.g. HEAD pointing to a 
dangling commit), so I added it explicitly.

The reverse operation (enabling sharing for a standalone repository) is 
described here
    
http://git.or.cz/gitwiki/GitFaq#Howtoshareobjectsbetweenexistingrepositories.3F

--
Daniel
