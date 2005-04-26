From: David Roundy <droundy@abridgegame.org>
Subject: Re: Re: A darcs that can pull from git
Date: Tue, 26 Apr 2005 07:06:17 -0400
Message-ID: <20050426110613.GB20723@abridgegame.org>
References: <7ipswjbybx.fsf@lanthane.pps.jussieu.fr>
	<20050425133116.GG11667@abridgegame.org>
	<7i4qdusxdw.fsf@lanthane.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, darcs-devel@darcs.net
X-From: darcs-devel-bounces@darcs.net Tue Apr 26 13:08:01 2005
Return-path: <darcs-devel-bounces@darcs.net>
Received: from www.abridgegame.org ([66.179.181.159] helo=abridgegame.org)
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQNuC-0007fm-T4
	for gcvdd-darcs-devel@m.gmane.org; Tue, 26 Apr 2005 13:07:05 +0200
Received: from localhost ([127.0.0.1] helo=www.abridgegame.org)
	by abridgegame.org with esmtp (Exim 4.50)
	id 1DQNyp-0007ZP-13; Tue, 26 Apr 2005 07:11:51 -0400
Received: from user-10mt71s.cable.mindspring.com ([65.110.156.60]
	helo=localhost) by abridgegame.org with esmtp (Exim 4.50)
	id 1DQNym-0003R2-0O
	for darcs-devel@darcs.net; Tue, 26 Apr 2005 07:11:48 -0400
Received: from droundy by localhost with local (Exim 4.50)
	id 1DQNtR-0006r6-FM; Tue, 26 Apr 2005 07:06:17 -0400
To: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Mail-Followup-To: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>,
	darcs-devel@darcs.net, Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7i4qdusxdw.fsf@lanthane.pps.jussieu.fr>
User-Agent: Mutt/1.5.6+20040907i
X-BeenThere: darcs-devel@darcs.net
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: "List for darcs-related development discussion."
	<darcs-devel.darcs.net>
List-Unsubscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=unsubscribe>
List-Archive: <http://www.abridgegame.org/pipermail/darcs-devel>
List-Post: <mailto:darcs-devel@darcs.net>
List-Help: <mailto:darcs-devel-request@darcs.net?subject=help>
List-Subscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=subscribe>
Sender: darcs-devel-bounces@darcs.net
Errors-To: darcs-devel-bounces@darcs.net

On Mon, Apr 25, 2005 at 05:12:59PM +0200, Juliusz Chroboczek wrote:
> > Do you have any plans/ideas for allowing pulls directly from a
> > remote git repository?
> 
> I haven't thought about it yet.  Does anyone have any ideas about how
> to efficiently pull from git without a complete local copy?

I don't think so.  My best thought so far would be to have something like a
~/.gitcache/, which would store the sha1 objects themselves, so at least
we'd only end up with *one* local copy.  I'm actually curious what the true
git people do about this--it would be nice to share a cache.  For darcs'
purposes, we could prune the cache from time to time.  If we're running
with a darcs backend, we really only need the recent versions of files and
trees.

Do the git have any suggestions about how to avoid excess downloads or
excess copies of a git repository? It seems to me like it would make sense
to always download sha1s to ~/.gitcache/, and then hardlink them to the
current git repository, so you wouldn't end up ever downloading the same
sha1 twice.  Or we should use $GITCACHE/, to give the user some
flexibility.  But perhaps this is an already-solved problem, and I've just
not noticed...

As far as other details, currently we can just walk the tree to find out
what files are needed, right?
-- 
David Roundy
http://www.darcs.net
