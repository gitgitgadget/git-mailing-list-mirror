From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: Any tips for improving the performance of cloning large repositories?
Date: Fri, 16 Dec 2011 09:14:59 -0500
Message-ID: <201112161414.pBGEExLJ006769@no.baka.org>
References: <CAJ-05NPP7aCcr_SYxLYk8U1entDMv0aF2Me3cTGmOLjYqFKUOA@mail.gmail.com> <hbf.20111216yufz@bombur.uio.no>
        <hbf.20111216zcin@bombur.uio.no>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: Alex Bennee <kernel-hacker@bennee.com>, git@vger.kernel.org
To: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
X-From: git-owner@vger.kernel.org Fri Dec 16 15:15:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbYZe-0002Cu-C1
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 15:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759665Ab1LPOPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 09:15:24 -0500
Received: from tsutomu.baka.org ([66.114.72.182]:38451 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759756Ab1LPOPU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 09:15:20 -0500
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id pBGEExtk003197
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 16 Dec 2011 09:15:00 -0500
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id pBGEExLJ006769;
	Fri, 16 Dec 2011 09:14:59 -0500
In-reply-to: <hbf.20111216zcin@bombur.uio.no>
Comments: In reply to a message from "Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>" dated "Fri, 16 Dec 2011 14:39:05 +0100."
Bypass: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187279>


In message <hbf.20111216zcin@bombur.uio.no>, Hallvard Breien Furuseth writes:

    I wrote:
    > Do you often need to clone from a remote?  Instead of cloning from a
    > local (git clone --mirror) which gets auto-updated from the remote.

    Er, obviously not, since you tried that with rsync.  Create the mirror
    with 'git clone --mirror', then update it with 'git fetch' rather than
    rsync.

If you really need to perform a full clone from the buildbot with or
without a different working directory (for instance if you have
buildbots/checkout users running in parallel where multiple users need
a consistent HEAD for multiple sequential operations) then instead
consider cloning with --reference or --shared.  There are severe
restrictions on what you should do with aggressive sharing (man
git-clone), but if all you are doing is normal checkouts, tags,
commits, etc, then it would be just fine.  Of course remember to add a
remote for the real upstream if you are planning on pushing
changes/tags back.

					-Seth Robertson
