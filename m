From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Fri, 12 Sep 2008 10:58:02 -0400
Message-ID: <20080912145802.GV5082@mit.edu>
References: <20080909132212.GA25476@cuci.nl> <alpine.LFD.1.10.0809100841080.3384@nehalem.linux-foundation.org> <alpine.LFD.1.10.0809100844040.3384@nehalem.linux-foundation.org> <200809101823.22072.jnareb@gmail.com> <48C9A9A4.8090703@vilain.net> <alpine.LFD.1.10.0809111641110.3384@nehalem.linux-foundation.org> <20080912054739.GB22228@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Sam Vilain <sam@vilain.net>, Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Fri Sep 12 17:04:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeAC6-0000ko-Ms
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 17:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064AbYILPDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 11:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752863AbYILPDK
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 11:03:10 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:55840 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752093AbYILPDJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Sep 2008 11:03:09 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8CF1pvN022885;
	Fri, 12 Sep 2008 11:01:55 -0400 (EDT)
Received: from closure.thunk.org (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8CEw2Nm006829
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 12 Sep 2008 10:58:04 -0400 (EDT)
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KeA5y-0004Sn-N3; Fri, 12 Sep 2008 10:58:02 -0400
Content-Disposition: inline
In-Reply-To: <20080912054739.GB22228@cuci.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95731>

On Fri, Sep 12, 2008 at 07:47:39AM +0200, Stephen R. van den Berg wrote:
> >You could add it as a 
> 
> >	Original-patch-id: <sha1>
> 
> That will probably work fine when operating locally on (short) temporary
> branches.
> 
> It would probably become computationally prohibitive to use it between
> long lived permanent branches.  In that case it would need to be
> augmented by the sha1 of the originating commit.

Nope, as Sam suggested in his original message (but which got clipped
by Linus when he was replying) all you have to do is to have a
separate local database which ties commits and patch-id's together as
a cache/index.

I know you seem to be resistent to caches, but caches are **good**
because they are local information, which by definition can be
implementation-dependent; you can always generate the cache from the
git repository if for some reason you need to extend it.  It also
means that if it turns out you need to index reationships a different
way, you can do that without having to make fundamental (incompatible)
changes in the git object.  

It's much like SQL databases; you have your database tables, where
making changes to the database schema is painful --- and indexes,
which can be added and dropped with much less effort.  Think of these
local caches are database indexes.  Just because you need an index in
a particular direction to optimize a query or loopup operation does
***not*** imply that you need to make a fundamental, globally visible,
database schema change or git object layout which breaks compatibility
for everybody.

						- Ted
