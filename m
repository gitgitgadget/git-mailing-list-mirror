From: Magnus =?iso-8859-1?Q?B=E4ck?= <magnus.back@sonyericsson.com>
Subject: Status of conflicted files resolved with rerere
Date: Thu, 12 Aug 2010 23:28:28 +0200
Message-ID: <20100812212828.GA17825@jpl.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 12 23:28:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjfKG-0007xn-Kr
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 23:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760691Ab0HLV2b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 17:28:31 -0400
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:54335 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882Ab0HLV2a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 17:28:30 -0400
Received: from ipb3.telenor.se (ipb3.telenor.se [195.54.127.166])
	by smtprelay-b12.telenor.se (Postfix) with ESMTP id 9EE37E94DA
	for <git@vger.kernel.org>; Thu, 12 Aug 2010 23:28:29 +0200 (CEST)
X-SMTPAUTH-B2: [b627879]
X-SENDER-IP: [83.227.167.132]
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ar86AHoEZExT46eEPGdsb2JhbACHZ4tHjQUMAQEBATUtvWmFOgQ
X-IronPort-AV: E=Sophos;i="4.55,360,1278280800"; 
   d="scan'208";a="560889701"
Received: from ua-83-227-167-132.cust.bredbandsbolaget.se (HELO elwood.jpl.local) ([83.227.167.132])
  by ipb3.telenor.se with ESMTP; 12 Aug 2010 23:28:29 +0200
Received: by elwood.jpl.local (Postfix, from userid 1000)
	id 6B987422BF; Thu, 12 Aug 2010 23:28:28 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153420>

I played around with git rerere today and was surprised by the results.
When a conflict has been resolved automatically by rerere, the file
isn't added to the index like other files are where Git just used one o=
f
the regular merge resolution algorithms. What's worse, if git mergetool
is invoked -- which is what I normally do when git merge needs help --
it has no idea that the file actually has been merged already, and
launches the merge tool with the three files involved in the merge. If
the user hasn't been paying attention to each line of the git merge
output (stating the files who were automatically resolved) it's easy to
trash rerere's work.

Would it make sense for git merge to add rerere'd files (where all hunk=
s
were recognized and resolved) to the index automatically? That would
make it possible for the user to run git mergetool without reading ever=
y
single line of output from previous commands just to figure out which
files should be added to the index straight off and which files require
merging.

=46or users resolving conflicts by editing the file and fiddling with t=
he
<<<<<<<<< marks etc such a change wouldn't make that big difference, bu=
t
for mergetool users it seems like a quite useful improvement. Or is
there something I'm failing to grasp here? This is on Git 1.7.0.3 by th=
e
way.

--=20
Magnus B=E4ck                      Opinions are my own and do not neces=
sarily
SW Configuration Manager         represent the ones of my employer, etc=
=2E
Sony Ericsson
