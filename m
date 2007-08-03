From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Fri, 03 Aug 2007 10:36:03 +0200
Message-ID: <46B2E8F3.30301@alum.mit.edu>
References: <46AFCF3E.5010805@alum.mit.edu>	 <8b65902a0708010438s24d16109k601b52c04cf9c066@mail.gmail.com>	 <46B1F96B.7050107@alum.mit.edu> <46a038f90708021608o21480074ybcfada767afc7b04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Guilhem Bonnefille <guilhem.bonnefille@gmail.com>, git@vger.kernel.org,
        users@cvs2svn.tigris.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: users-return-1612-gcvscu-users=m.gmane.org@cvs2svn.tigris.org Fri Aug 03 10:36:12 2007
Return-path: <users-return-1612-gcvscu-users=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscu-users@gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1IGsdn-0000st-Rx
	for gcvscu-users@gmane.org; Fri, 03 Aug 2007 10:36:12 +0200
Received: (qmail 9388 invoked by uid 5000); 3 Aug 2007 08:36:09 -0000
Mailing-List: contact users-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:users-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:users-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:users@cvs2svn.tigris.org>
Delivered-To: mailing list users@cvs2svn.tigris.org
Received: (qmail 9378 invoked from network); 3 Aug 2007 08:36:08 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAJaFskbAbSoIlGdsb2JhbACOEQEBAgcKBwg
X-IronPort-AV: i="4.19,216,1183359600"; 
   d="scan'208"; a="78902612:sNHT18955580"
X-IRONPORT: SCANNED
X-Envelope-From: mhagger@alum.mit.edu
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.12) Gecko/20070604 Thunderbird/1.5.0.12 Mnenhy/0.7.5.666
In-Reply-To: <46a038f90708021608o21480074ybcfada767afc7b04@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54690>

Martin Langhoff wrote:
> Is there any way we can run tweak cvs2svn to run incrementals, even if
> not as fast as cvsps/git-cvsimport? The "do it remotely" part can be
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
