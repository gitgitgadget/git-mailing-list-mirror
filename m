From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Thu, 02 Aug 2007 17:34:03 +0200
Message-ID: <46B1F96B.7050107@alum.mit.edu>
References: <46AFCF3E.5010805@alum.mit.edu> <8b65902a0708010438s24d16109k601b52c04cf9c066@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, users@cvs2svn.tigris.org
To: Guilhem Bonnefille <guilhem.bonnefille@gmail.com>
X-From: users-return-1602-gcvscu-users=m.gmane.org@cvs2svn.tigris.org Thu Aug 02 17:34:13 2007
Return-path: <users-return-1602-gcvscu-users=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscu-users@gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1IGcgl-0007FH-9B
	for gcvscu-users@gmane.org; Thu, 02 Aug 2007 17:34:11 +0200
Received: (qmail 30437 invoked by uid 5000); 2 Aug 2007 15:34:08 -0000
Mailing-List: contact users-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:users-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:users-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:users@cvs2svn.tigris.org>
Delivered-To: mailing list users@cvs2svn.tigris.org
Received: (qmail 30426 invoked from network); 2 Aug 2007 15:34:07 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAAqWsUbAbSoIh2dsb2JhbACOEwEBCQoH
X-IronPort-AV: i="4.19,213,1183359600"; 
   d="scan'208"; a="63456494:sNHT22960798"
X-IRONPORT: SCANNED
X-Envelope-From: mhagger@alum.mit.edu
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.12) Gecko/20070604 Thunderbird/1.5.0.12 Mnenhy/0.7.5.666
In-Reply-To: <8b65902a0708010438s24d16109k601b52c04cf9c066@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54564>

[I am CCing this response to the mailing lists.]

Guilhem Bonnefille wrote:
> On 8/1/07, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> I am the maintainer of cvs2svn[1], which is a program for one-time
>> conversions from CVS to Subversion.  cvs2svn is very robust against the
>> many peculiarities of CVS and can convert just about every CVS
>> repository we have ever seen.
> 
> What are the differences with cvsps ( http://www.cobite.com/cvsps/ )?

I'm not extremely familiar with cvsps, and I don't really want to get
into a "my-tool-is-better-than-your-tool" kind of argument.  Instead I
will mention that the goals of the two projects are somewhat different:

cvs2svn is meant for one-time conversions from CVS, and therefore aims
for maximum conversion accuracy, robustness even in the presence of some
kinds of CVS repository corruption, intelligent translation of CVS
idioms to the idioms of a modern SCM, and scalability to large
repositories (by using on-disk databases instead of RAM for intermediate
data).  Conversion speed is not a primary goal of cvs2svn, and
incremental conversions are not supported at all.  cvs2svn requires
filesystem access to the CVS repository (it parses the RCS files directly).

cvsps is not a conversion tool at all, though it is used by other
conversion tools to generate the changesets.  It appears (I hope I am
not misinterpreting things) to emphasize speed and incremental
operation, for example attempting to make changesets consistent from one
run to the next, even if the CVS repository has been changed prudently
between runs.  cvsps does not appear to attempt to create atomic branch
and tag creation commits or handle CVS's special vendorbranch behavior.
 cvsps operates via the CVS protocol; you don't need filesystem access
to the CVS repository.

I can also point you to a list of cvs2svn features, which includes a
list of some of the CVS quirks that it knows how to handle:

    http://cvs2svn.tigris.org/cvs2svn.html#features

cvs2svn includes a large suite of perverse CVS repositories that we use
for testing.  Many of them are derived from real-life CVS repositories
that people have had problems with.  It would be very interesting to see
how other conversion tools handle these repositories, but I don't expect
to have time to do so in the near future.

Michael
