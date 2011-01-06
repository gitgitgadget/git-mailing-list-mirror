From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Resumable clone/Gittorrent (again) - stable packs?
Date: Thu, 06 Jan 2011 16:09:00 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101061552580.22191@xanadu.home>
References: <AANLkTikv+L5Da7A5VM7BAgnue=m0O_-nHmHchJzfGxJa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Zenaan Harkness <zen@freedbms.net>
X-From: git-owner@vger.kernel.org Thu Jan 06 22:09:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pax5H-0000Kf-UA
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 22:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753965Ab1AFVJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 16:09:09 -0500
Received: from relais.videotron.ca ([24.201.245.36]:46076 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753809Ab1AFVJH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 16:09:07 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz23.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LEM009OTDEHVQ20@vl-mo-mrz23.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 06 Jan 2011 16:08:42 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <AANLkTikv+L5Da7A5VM7BAgnue=m0O_-nHmHchJzfGxJa@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164674>

On Thu, 6 Jan 2011, Zenaan Harkness wrote:

> Bittorrent requires some stability around torrent files.
> 
> Can packs be generated deterministically?

They _could_, but we do _not_ want to do that.

The only thing which is stable in Git is the canonical representation of 
objects, and the objects they depend on, expressed by their SHA1 
signature.  Any BitTorrent-alike design for Git must be based on that 
property and not the packed representation of those objects which is not 
meant to be stable.

If you don't want to design anything and simply reuse current BitTorrent 
codebase then simply create a Git bundle from some release version and 
seed that bundle for a sufficiently long period to be worth it.  Then 
falling back to git fetch in order to bring the repo up to date with the 
very latest commits should be small and quick.  When that clone gets too 
big then it's time to start seeding another more up-to-date bundle.


Nicolas
