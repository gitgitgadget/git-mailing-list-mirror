From: "Patwardhan, Rajesh" <rajesh.patwardhan@etrade.com>
Subject: RE:  Re: cvs2svn conversion directly to git ready for experimentation
Date: Fri, 3 Aug 2007 10:35:31 -0400
Message-ID: <0BB549C6E74E24409FB20B3B1D1B6644029461C0@ATL1EX11.corp.etradegrp.com>
References: <46B2E8F3.30301@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>, <git@vger.kernel.org>,
        <users@cvs2svn.tigris.org>
To: "Michael Haggerty" <mhagger@alum.mit.edu>,
        "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: users-return-1613-gcvscu-users=m.gmane.org@cvs2svn.tigris.org Fri Aug 03 16:35:49 2007
Return-path: <users-return-1613-gcvscu-users=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscu-users@gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1IGyFj-0004ZA-7r
	for gcvscu-users@gmane.org; Fri, 03 Aug 2007 16:35:43 +0200
Received: (qmail 28415 invoked by uid 5000); 3 Aug 2007 14:35:40 -0000
Mailing-List: contact users-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:users-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:users-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:users@cvs2svn.tigris.org>
Delivered-To: mailing list users@cvs2svn.tigris.org
Received: (qmail 28399 invoked from network); 3 Aug 2007 14:35:39 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAPPZskYMmeA3n2dsb2JhbACOEAICBwQGBwgY
X-IronPort-AV: i="4.19,217,1183359600"; 
   d="scan'208"; a="78929426:sNHT42197582"
X-IRONPORT: SCANNED
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <46B2E8F3.30301@alum.mit.edu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: cvs2svn conversion directly to git ready for experimentation
Thread-Index: AcfVqVo9QIgbhpBqQISi6eLwZwS4GAAMIMMA
X-OriginalArrivalTime: 03 Aug 2007 14:35:33.0186 (UTC) FILETIME=[8C4E8A20:01C7D5DB]
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54728>


Hello Michael,=20
I will explain a scenario (we are passing thru this right now)=20
1) you have 10 years worth of cvs data.
2) We want to move to svn.=20
3) The repository move should be in such a way that the development does
not get hampered for any 1 work day.  =20
4) We have atleast 4 major modules in cvs which takes about 30 - 40
hours each for conversion currently.
5) With increamental conversions we can do a few things ...=20
	A) Keep the downtime for hard cutoff minimal=20
	B) try out the svn move for other auxillary tools that are
needed by the SCM process.=20
	C) Do some meaningful testing and validation with simulated live
moves of changes from cvs to svn before the actual move on a day to day
basis.=20

Hopefuly this would substantiate the request \ need for increamental
moves. Or if someone out there has a better suggestion for such
scenario's please point me in the right direction.=20

Regards,
Rajesh=20

-----Original Message-----
From: Michael Haggerty [mailto:mhagger@alum.mit.edu]=20
Sent: Friday, August 03, 2007 1:36 AM
To: Martin Langhoff
Cc: Guilhem Bonnefille; git@vger.kernel.org; users@cvs2svn.tigris.org
Subject: Re: cvs2svn conversion directly to git ready for
experimentation

Martin Langhoff wrote:
> Is there any way we can run tweak cvs2svn to run incrementals, even if

> not as fast as cvsps/git-cvsimport? The "do it remotely" part can be=20
> worked around in most cases.

I don't see any fundamental reason why not, but I think it would be a
significant amount of work.  There are two main issues:

1. With CVS, it is possible to change things retroactively, such as
changing which version of a file is included in a tag, or adding a new
file to a tag, or changing whether a file is text vs. binary.  And many
people copy and/or rename files within the CVS repository itself (to get
around CVS's inability to rename a file).  This makes it look like the
file has *always* existed under the new name and *never* existed under
the old name.  An incremental conversion tool would have to look
carefully for such changes and either handle them properly or complain
loudly and abort.

2. cvs2svn uses a lot of repository-wide information to make decisions
about how to group CVSItems into changesets, and a lot of these
decisions are based on heuristics.  Incremental conversion would require
that the decisions made in one cvs2svn run are recorded and treated as
unalterable in subsequent runs.

This hasn't been a priority in the Subversion world, because, frankly,
what reason would a person have to stick with CVS instead of switching
to Subversion, given that (1) they are intentionally so similar in
workflow, an (2) there is no significant competition from other
centralized SCMs?  But of course until the distributed SCM playing field
has been thinned out a bit, people will probably be reluctant to commit
to one or the other.

I don't expect to have time to implement incremental conversions in
cvs2svn in the near future.  (I'd much rather work on output back ends
to other distributed SCMs.)  But if any volunteers step forward (hint,
hint) I would be happy to help them get started and answer their
questions.  I think that cvs2svn is quite hackable now, so the learning
curve is hopefully much less frightening than when I started on the
project :-)

Michael

---------------------------------------------------------------------
To unsubscribe, e-mail: users-unsubscribe@cvs2svn.tigris.org
For additional commands, e-mail: users-help@cvs2svn.tigris.org
