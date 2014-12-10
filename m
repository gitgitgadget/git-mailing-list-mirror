From: "Ryan, Phil." <ryanp@ewheel.de>
Subject: git fetch --quiet inconsistently reports to STDERR
Date: Wed, 10 Dec 2014 11:46:41 +0100
Message-ID: <1db81a7b475f5b2918d605082bb93e0a@elasticwheelchair.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 10 11:53:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xyetj-0005du-Sf
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 11:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755484AbaLJKxc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Dec 2014 05:53:32 -0500
Received: from ewheel.de ([62.75.150.108]:37508 "EHLO ewheel.localdomain"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751607AbaLJKxb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 05:53:31 -0500
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Dec 2014 05:53:30 EST
Received: from mail.ewheel.de (localhost.localdomain [127.0.0.1])
	by ewheel.localdomain (Postfix) with ESMTPA id 649B2E40B02
	for <git@vger.kernel.org>; Wed, 10 Dec 2014 11:46:41 +0100 (CET)
X-Sender: ryanp@ewheel.de
User-Agent: Roundcube Webmail/1.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261209>

Hello,

I'm using git 2.0.4 and 1.7.10.4 and have discovered an issue with quie=
t=20
option on fetch.

Scenario:

I am fetching from one bare repo into another bare repo and fetching=20
from branch A to branch B.
In the case that the branches have deviated from one another, --quiet=20
surpresses all output, incl. output to STDERR.


     $ pwd
     /home/ryan_p/gitrepos/git01.git

     $ git fetch --quiet ../git02.git working_branch:master

     $ echo $?
     1

     $ git fetch ../git02.git working_branch:master
     Von ../git02
      ! [zur=C3=BCckgewiesen]  working_branch -> master  (kein Vorspule=
n)


However, if I pass a false remote name to "git fetch --quiet" I get the=
=20
following:


     $ git fetch --quiet ../git02false.git working_branch:master
     fatal: '../git02false.git' does not appear to be a git repository
     fatal: Could not read from remote repository.

     Please make sure you have the correct access rights
     and the repository exists.


So, I see inconsistent behaviour here.


=46urther, the "git push" behaviour with the "--quiet" option correspon=
ds=20
to what the user actually expects:


     "-q, --quiet
            Suppress all output, including the listing of updated refs,=
=20
unless an error occurs. Progress is not reported to the standard error=20
stream."


I perceive the --quiet option on git fetch as behaving incorrectly and=20
would like to file this as a bug.

Best Rgs,

Phil.
