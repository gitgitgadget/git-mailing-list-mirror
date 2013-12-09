From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Publishing "filtered branch repositories" - workflow /
 recommendations?
Date: Mon, 9 Dec 2013 23:59:50 +0100
Message-ID: <20131209225950.GG9606@sandbox-ub>
References: <CACPiFCJPq0fqOQrJD-8CHH405Xw61ZDynqqfN+_aZb3ZBgV2VA@mail.gmail.com>
 <52A0D199.1010403@web.de>
 <CACPiFCKHprB_oO_eXMYkey_CGbT7WOn5VDDjBdHbLRzcDpHnZw@mail.gmail.com>
 <52A0D9F5.3030101@web.de>
 <CACPiFCJ3mkOj=E+siideBpPfgS1tSicVQ46KqPK+Tha0DbkZHw@mail.gmail.com>
 <52A18F69.70002@web.de>
 <CACPiFCJ5hCPvRHB1knvMocN0XdHfSMpbZnqjf7yHAT4mMOSfzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 10 00:00:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq9oM-0007yo-Nt
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 00:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754368Ab3LIW74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 17:59:56 -0500
Received: from smtprelay05.ispgateway.de ([80.67.31.99]:33549 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964Ab3LIW7y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 17:59:54 -0500
Received: from [77.21.76.49] (helo=sandbox-ub)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Vq9nr-0005KO-MZ; Mon, 09 Dec 2013 23:59:51 +0100
Content-Disposition: inline
In-Reply-To: <CACPiFCJ5hCPvRHB1knvMocN0XdHfSMpbZnqjf7yHAT4mMOSfzw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239117>

On Fri, Dec 06, 2013 at 02:40:15PM -0500, Martin Langhoff wrote:
> On Fri, Dec 6, 2013 at 3:48 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> > Right you are, we need tutorials for the most prominent use cases.
> 
> In the meantime, are there any hints? Emails on this list showing a
> current "smart" workflow? Blog posts? Notes on a wiki?

None that I know of mainly because we have not yet reached the goal we
are aiming at. Maybe we should write something, A few points from
$dayjob that come to my mind:

  * A submodule commit is only allowed to be merged into master in a
    superproject commit if it is merged into master (or a stable branch)
    in the submodule. That way you ensure that any submodules commits
    that are tracked in a superproject are contained in each other and
    can be cleanly merged. (no rewinds, one commit contains the other)

  * Submodule should be selfcontained (i.e. if its a library have tests
    that use the code you implement). That way changes in the submodule
    can be made independent from the superproject

  * If a submodule needs another submodule have them side by side
    instead of one inside another. See the next point for explanation.

  * Only one depth of recursion for submodules. Even though intuition
    tell you that if some submodule needs another it should contain the
    other its IMO not wise to do so. There will be times when some other
    submodule needs the same submodule that is contained in the other
    and then you end up with two copies of the same code. My suggestion:
    Let the superproject bundle all the dependencies between modules.

  * Submodules are a good solution for shared code where the dependency
    goes superproject needs submodule. If you divide code into
    submodules because of access control and the dependency is actually
    that the submodule needs the superproject it works but is less than
    optimal.

Thats what I can quickly suggest and probably far from complete.

Cheers Heiko
