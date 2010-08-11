From: Magnus =?iso-8859-1?Q?B=E4ck?= <magnus.back@sonyericsson.com>
Subject: Re: With feature branches, what is ever committed directly to master
Date: Wed, 11 Aug 2010 08:57:51 +0200
Message-ID: <20100811065751.GA8808@jpl.local>
References: <AANLkTin0VgH8CvnUn_tCJPTkhh7Ce-tYWo52qouoVvRN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bradley Wagner <bradley.wagner@hannonhill.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 08:58:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj5GC-00010y-Jb
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 08:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932632Ab0HKG5z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 02:57:55 -0400
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:35645 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932493Ab0HKG5z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 02:57:55 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-b12.telenor.se (Postfix) with ESMTP id 518F8E9EC5
	for <git@vger.kernel.org>; Wed, 11 Aug 2010 08:57:53 +0200 (CEST)
X-SMTPAUTH-B2: [b627879]
X-SENDER-IP: [83.227.167.132]
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: At0+AF/mYUxT46eEPGdsb2JhbACHZ5hLDAEBAQE1Lbt+hToE
X-IronPort-AV: E=Sophos;i="4.55,351,1278280800"; 
   d="scan'208";a="117911874"
Received: from ua-83-227-167-132.cust.bredbandsbolaget.se (HELO elwood.jpl.local) ([83.227.167.132])
  by ipb1.telenor.se with ESMTP; 11 Aug 2010 08:57:52 +0200
Received: by elwood.jpl.local (Postfix, from userid 1000)
	id 8D151422BF; Wed, 11 Aug 2010 08:57:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTin0VgH8CvnUn_tCJPTkhh7Ce-tYWo52qouoVvRN@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153192>

On Tuesday, August 10, 2010 at 21:02 CEST,
     Bradley Wagner <bradley.wagner@hannonhill.com> wrote:

> I realize there are a lot of different Git workflows but I'm wonderin=
g
> how others in this community do it.
>
> We're using our "master" branch from our central repo (Beanstalk) as =
a
> dev branch and we have stable branches for various release versions o=
f
> our software.
>
> We've not made as heavy use of feature branches yet as we should have=
=2E
> Once we do start using them more regularly, what kind of stuff is eve=
r
> committed directly to "master" or is master typically the place where
> things are merged into from other stable/features branches?

=46eature branches are useful when stuff needs to be developed in
isolation, e.g. code that will undergo significant changes (usually
leading to instability) or code whose release schedule isn't set in
stone. When you're ready to create a stable branch for a public
release you don't want to have half a dozen half-finished features
on master.

While isolation is useful it also brings problems. If you have
dependencies between features you may run into integration problems
far too late. People can merge between the feature branches to mitigate
this, but that also creates a mess. Isolation also means that the code
will be exercised less before released, i.e. less dog fooding. In some
cases it makes sense to fulfill the goal of isolation by keeping
changes on the master branch but use static or dynamic configuration
of the software to disable the code or maybe use branch by abstraction.

In the case of creating a feature branch for the sake of securing
the releasability of a branch one must also consider the conditions
surrounding the release. Is the feature currently being developed on
a feature branch a must-have for the release? If yes, one of the
strongest arguments for feature branches becomes moot.

=46inally, bugfixes and similar smaller changes that don't make up a
whole string of commits should probably not be developed on branches.

> Is "master" really even unstable at that point?

I guess that depends on your organization, your developers, and the
maturity, architecture and inherent quality of the software. And, of
course, how you define unstable. How bad can it be before it hurts?
How would *you* weigh the risk of branching against the risk of
developer slowdowns caused by frequent regressions?

--=20
Magnus B=E4ck                      Opinions are my own and do not neces=
sarily
SW Configuration Manager         represent the ones of my employer, etc=
=2E
Sony Ericsson
