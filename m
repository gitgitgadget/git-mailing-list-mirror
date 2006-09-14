From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: cvs import
Date: Thu, 14 Sep 2006 06:17:30 +0200
Message-ID: <4508D7DA.8000302@alum.mit.edu>
References: <45084400.1090906@bluegap.ch>	<9e4733910609131201q7f583029r72dac66cd0dd098f@mail.gmail.com>	<46a038f90609131341se42b2dcne73c017cf757d13a@mail.gmail.com>	<4508724D.2050701@bluegap.ch> <46a038f90609131416s1a53b53xd12c3661140fec7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Markus Schiltknecht <markus@bluegap.ch>, Jon Smirl <jonsmirl@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, monotone-devel@nongnu.org,
        dev@cvs2svn.tigris.org
X-From: dev-return-1637-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Thu Sep 14 06:17:44 2006
Return-path: <dev-return-1637-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc51.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by ciao.gmane.org with smtp (Exim 4.43)
	id 1GNifS-0003aO-Gi
	for gcvscd-dev@gmane.org; Thu, 14 Sep 2006 06:17:38 +0200
Received: (qmail 19021 invoked by uid 5000); 14 Sep 2006 04:17:36 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Received: (qmail 19008 invoked from network); 14 Sep 2006 04:17:36 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAABx0CEWLbAIJDg
X-IronPort-AV: i="4.09,161,1157353200"; 
   d="scan'208"; a="26767883:sNHT42324464"
X-IRONPORT: SCANNED
X-Envelope-From: mhagger@alum.mit.edu
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060728 Thunderbird/1.5.0.5 Mnenhy/0.7.4.666
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90609131416s1a53b53xd12c3661140fec7a@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26979>

Martin Langhoff wrote:
> On 9/14/06, Markus Schiltknecht <markus@bluegap.ch> wrote:
>> Martin Langhoff wrote:
>> > On 9/14/06, Jon Smirl <jonsmirl@gmail.com> wrote:
>> >> Let's copy the git list too and maybe we can come up with one importer
>> >> for everyone.
>> >
>> > It's a really good idea. cvsps has been for a while a (limited, buggy)
>> > attempt at that. One thing that bothers me in the cvs2svn algorithm is
>> > that is not stable in its decisions about where the branching point is
>> > -- run the import twice at different times and it may tell you that
>> > the branching point has moved.
>>
>> Huh? Really? Why is that? I don't see reasons for such a thing happening
>> when studying the algorithm.
>>
>> For sure the proposed dependency-resolving algorithm which does not rely
>> on timestamps does not have that problem.
> 
> IIRC, it places branch tags as late as possible. I haven't looked at
> it in detail, but an import immediately after the first commit against
> the branch may yield a different branchpoint from the same import done
> a bit later.

This is correct.  And IMO it makes sense from the standpoint of an
all-at-once conversion.

But I was under the impression that this wouldn't matter for
content-indexed-based SCMs.  The content of all possible branching
points is identical, and therefore from your point of view the topology
should be the same, no?

But aside from this point, I think an intrinsic part of implementing
incremental conversion is "convert the subsequent changes to the CVS
repository *subject to the constraints* imposed by decisions made in
earlier conversion runs.  And the real trick is that things can be done
in CVS (e.g., line-end changes, manual copying of files in the repo)
that (a) are unversioned and (b) have retroactive effects that go
arbitrarily far back in time.  This is the reason that I am pessimistic
that incremental conversion will ever work robustly.

Michael
