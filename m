From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Fri, 12 Sep 2008 14:44:06 -0400
Message-ID: <20080912184406.GB5082@mit.edu>
References: <alpine.LFD.1.10.0809100841080.3384@nehalem.linux-foundation.org> <alpine.LFD.1.10.0809100844040.3384@nehalem.linux-foundation.org> <200809101823.22072.jnareb@gmail.com> <48C9A9A4.8090703@vilain.net> <alpine.LFD.1.10.0809111641110.3384@nehalem.linux-foundation.org> <20080912054739.GB22228@cuci.nl> <20080912145802.GV5082@mit.edu> <20080912155427.GB2915@cuci.nl> <20080912161911.GA12096@coredump.intra.peff.net> <20080912164348.GC2915@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Fri Sep 12 20:45:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeDeG-00088Y-KU
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 20:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482AbYILSod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 14:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753458AbYILSoc
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 14:44:32 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:42896 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753448AbYILSoc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Sep 2008 14:44:32 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8CIi7JN027797;
	Fri, 12 Sep 2008 14:44:07 -0400 (EDT)
Received: from closure.thunk.org (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8CIi6in012455
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 12 Sep 2008 14:44:06 -0400 (EDT)
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KeDck-0005AL-3V; Fri, 12 Sep 2008 14:44:06 -0400
Content-Disposition: inline
In-Reply-To: <20080912164348.GC2915@cuci.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95758>

On Fri, Sep 12, 2008 at 06:43:48PM +0200, Stephen R. van den Berg wrote:
> >> True.  But repopulating this cache after cloning means that you have to
> >> calculate the patch-id of *every* commit in the repository.  It sounds
> >> like something to avoid, but maybe I'm overly concerned, I have only a
> >> vague idea on how computationally intensive this is.
> 
> >For a rough estimate, try:
> 
> >  time git log -p | git patch-id >/dev/null
> 
> On my system that results in 2ms per commit on average.  Not huge, but
> not small either, I guess.  Running it results in real waiting time, it
> all depends on how patient the user is.

For a local clone, git could be taught to copy the cache file.  For a
network-based clone, the percentage of time needed to download is
roughly 2-3 times that (although that will obviously depend on your
network connectivity).  Building this cache can be done in the
background, though, or delayed until the first time the cache is
needed.

						- Ted
