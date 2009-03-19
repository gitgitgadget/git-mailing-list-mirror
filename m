From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v3 0/2] cvsimport: add test illustrating a bug in cvsps
Date: Thu, 19 Mar 2009 11:41:42 +0100
Message-ID: <49C22166.3000807@drmicha.warpmail.net>
References: <49A2EFC6.5000104@hvoigt.net> <49A37ED1.5090506@alum.mit.edu> <49AC1E88.1010709@hvoigt.net> <49B4FCDA.4030106@hvoigt.net> <49B52F74.1090006@alum.mit.edu> <49C13062.4020400@hvoigt.net> <7vfxhag07g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <git-list@hvoigt.net>,
	Michael Haggerty <mhagger@alum.mit.edu>, ydirson@altern.org,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 11:43:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkFik-0005FR-Vg
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 11:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754500AbZCSKmC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 06:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754357AbZCSKmB
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 06:42:01 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:43986 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752271AbZCSKmA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 06:42:00 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 4E4702F377D;
	Thu, 19 Mar 2009 06:41:58 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 19 Mar 2009 06:41:58 -0400
X-Sasl-enc: iF8IYTp4gPmlr0ZFKHsH4WKX0UdggGXn6hjVjpzJFMSw 1237459317
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 520112CCFD;
	Thu, 19 Mar 2009 06:41:56 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090319 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <7vfxhag07g.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113753>

Junio C Hamano venit, vidit, dixit 18.03.2009 19:22:
> Heiko Voigt <git-list@hvoigt.net> writes:
> 
>> This is an updated version of the first patch and an addition to ensure
>> correct handling of branches in fixes. 
> 
> I've already merged the first one to 'next' so this needs to be turned
> into an incremental update if we were to continue building on top in the
> git project.
> 
> I however have a bigger issue with this, perhaps because I do not have the
> feeling that I fully understand where these patches are going.
> 
> Your approach seems to me to:
> 
>  - add tests to git test suite that expose issues the current cvsimport
>    that runs on an unpatched cvsps has;
> 
>  - diagnose and fix
> 
>    - the issues in cvsimport, if the problem is because cvsimport is
>      mishandling correct output from cvsps; or
> 
>    - the issues in cvsps (and adjust cvsimport to patched cvsps if
>      necessary), if the problem is because output from cvsps is incorrect.
> 
> That all feels sane, and having the tests to verify the end result would
> help the people who collaborate on these tasks.
> 
> But how much of the actual fix will be made to cvsps, and how much to
> cvsimport?  If the majority of the changes are to happen on cvsps (which
> is not unexpected, given that many people who tried and wrote various cvs
> importers put blame on the shortcomings of its output), I am afraid that
> it would not help majority of git users until the fixes to cvsps that come
> out of this effort hit their distros for me to keep these tests in the
> git.git repository.  I do not build and install custom cvsps (because I
> haven't had to work with complex history in CVS that your improvements to
> cvsps are need to deal with correctly), and I suspect many others are in
> the same boat.  In addition, if your tests are in the git.git repository,
> they need to say test_expect_success for people with patched cvsps and
> test_expect_failure for people without, and because I suspect that the
> majority of git developers do not run bleeding edge cvsps, it does not do
> anything but slowing down the test suite.
> 
> It feels as if you are scratching my feet through my shoes while I still
> am wearing them.  I wonder if it would be more direct and simpler approach
> to add tests to cvsps and handle these improvements as part of the cvsps
> maintenance/development effort, not as part of cvsimport fixes, at least
> initially.
> 
> I think it is great that you started actively working on identifying and
> fixing issues with cvsps, that many others have gave up and gone to
> different avenues, and I certainly do not mind keeping the new tests in
> 'pu' for wider exposure, in order to make it easier for other people who
> use cvsimport and want to collaborate with you improving it through
> improving cvsps.
> 
> But I am starting to think that it was a mistake on my part to have merged
> the initial set of tests to 'next'.
> 
> Thoughts?

I second this, especially now that we've even got cvsps patches coming
to the git list. cvsps development should procede wherever all cvsps
developers can participate. It's not a central component of git.

In fact, the way git cvsimport uses cvsps may even mask some of cvsps's
behaviour. So, exposing cvsps bugs really only makes sense in a pure
cvsps test suite.

If git cvsimport is supposed to work around cvsps shortcomings then that
is supposed to be tested for in the git suite.

Right now this really seems to be going in the direction of: Make
everyone feel uneasy about working with git on cvs repos at all (aka
guerilla git), because git cvsimport still seems to be "recommended" or
"the standard", we have all this talk about how bad it is, and no clear
alternative.

I wish we had something saying: "If your cvs repo fulfills these
conditions you can use cvsimport. If not watch out for the following
(cvsps related) caveats. If you don't need two-way sync you're better of
with..."

Unfortunately, I'm not cvs(ps)-competent enough to spell out those
recommendations in detail.

Michael
