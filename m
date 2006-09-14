From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [Monotone-devel] cvs import
Date: Wed, 13 Sep 2006 22:35:42 -0400
Message-ID: <20060914023541.GB31889@spearce.org>
References: <45084400.1090906@bluegap.ch> <20060913225200.GA10186@frances.vorpus.org> <1158190921.29313.175.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nathaniel Smith <njs@pobox.com>,
	Markus Schiltknecht <markus@bluegap.ch>, monotone-devel@nongnu.org,
	dev@cvs2svn.tigris.org, Git Mailing List <git@vger.kernel.org>
X-From: dev-return-1633-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Thu Sep 14 04:35:49 2006
Return-path: <dev-return-1633-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc51.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by ciao.gmane.org with smtp (Exim 4.43)
	id 1GNh4u-0006Ql-40
	for gcvscd-dev@gmane.org; Thu, 14 Sep 2006 04:35:48 +0200
Received: (qmail 8112 invoked by uid 5000); 14 Sep 2006 02:35:46 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Received: (qmail 8102 invoked from network); 14 Sep 2006 02:35:46 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AY8CAHJcCEWBTooeAgkOKg
X-IronPort-AV: i="4.09,161,1157353200"; 
   d="scan'208"; a="26762992:sNHT16844513"
X-IRONPORT: SCANNED
To: Keith Packard <keithp@keithp.com>
Content-Disposition: inline
In-Reply-To: <1158190921.29313.175.camel@neko.keithp.com>
Sender: spearce@spearce.org
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - cvs2svn.tigris.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26976>

Keith Packard <keithp@keithp.com> wrote:
> On Wed, 2006-09-13 at 15:52 -0700, Nathaniel Smith wrote:
> 
> > Regarding the basic dependency-based algorithm, the approach of
> > throwing everything into blobs and then trying to tease them apart
> > again seems backwards.  What I'm thinking is, first we go through and
> > build the history graph for each file.  Now, advance a frontier across
> > the all of these graphs simultaneously.  Your frontier is basically a
> > map <filename -> CVS revision>, that represents a tree snapshot. 
> 
> Parsecvs does this, except backwards from now into the past; I found it
> easier to identify merge points than branch points (Oh, look, these two
> branches are the same now, they must have merged).

Why not let Git do that?  If two branches are the same in CVS then
shouldn't they have the same tree SHA1 in Git?  Surely comparing
20 bytes of SHA1 is faster than almost any other comparsion...
 
> However, this means that parsecvs must hold the entire tree state in
> memory, which turned out to be its downfall with large repositories.
> Worked great for all of X.org, not so good with Mozilla.

Any chance that can be paged in on demand from some sort of work
file?  git-fast-import hangs onto a configurable number of tree
states (default of 5) but keeps them in an LRU chain and dumps the
ones that aren't current.

-- 
Shawn.
