From: Fedor Sergeev <Fedor.Sergeev@Sun.COM>
Subject: Re: overly smart rebase - bug or feature?
Date: Thu, 13 Nov 2008 00:39:21 +0300
Message-ID: <20081112213920.GB5018@sun.com>
References: <20081110212333.GU6799@sun.com>
 <7vod0n41i5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Roman.Shaposhnick@Sun.COM, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 22:41:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0NSW-0001dX-3h
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 22:41:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbYKLVju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 16:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbYKLVju
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 16:39:50 -0500
Received: from gmp-eb-inf-1.sun.com ([192.18.6.21]:45490 "EHLO
	gmp-eb-inf-1.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbYKLVjt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 16:39:49 -0500
Received: from fe-emea-09.sun.com (gmp-eb-lb-2-fe3.eu.sun.com [192.18.6.12])
	by gmp-eb-inf-1.sun.com (8.13.7+Sun/8.12.9) with ESMTP id mACLdjMc021348
	for <git@vger.kernel.org>; Wed, 12 Nov 2008 21:39:45 GMT
Received: from conversion-daemon.fe-emea-09.sun.com by fe-emea-09.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0KA800901PC4MJ00@fe-emea-09.sun.com>
 (original mail from Fedor.Sergeev@Sun.COM) for git@vger.kernel.org; Wed,
 12 Nov 2008 21:39:45 +0000 (GMT)
Received: from localhost ([129.159.126.120])
 by fe-emea-09.sun.com (Sun Java System Messaging Server 6.2-8.04 (built Feb 28
 2007)) with ESMTPSA id <0KA8007OSPI7FTA0@fe-emea-09.sun.com>; Wed,
 12 Nov 2008 21:39:44 +0000 (GMT)
In-reply-to: <7vod0n41i5.fsf@gitster.siamese.dyndns.org>
Mail-followup-to: Junio C Hamano <gitster@pobox.com>,
 Roman.Shaposhnick@Sun.COM, git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100816>

On Mon, Nov 10, 2008, Junio C Hamano wrote:
> Fedor Sergeev <Fedor.Sergeev@Sun.COM> writes:
> >> You might be able to work this around by forcing rebase not to use the
> >> simplified 3-way merge, by saying "rebase -m".
> >
> > Yeah, it worked.
> > ...
> > CONFLICT (delete/modify): Makefile deleted in master and modified in HEAD~0. Version HEAD~0 of Makefile left in tree.
> > ...
> >
> > Though it does make me wonder why *simplified* 3-way merge is smarter than git merge ;)))
> 
> Simplified one is not _smarter_.  It is merely _faster_, exactly because
> it only looks at the paths between A^..A and nothing else.

I seem to start getting grasp on it.
Please, correct me if I'm wrong:
  - by default rebase uses "simplified" merge, which (roughly speaking) 
    simply goes around patching parent with changes from either branches A and B

  - rebase -m applies 'recursive' merge (default merge strategy) which is 
    kind of smarter and determines a conflict in my case

  - literally the same happens when I do merge instead of rebase 

  - cherry-pick fails just because "patch B" can not apply to A and that is
    literally why rebase started falling out to *some* merge first hand

If the above is true then can you, please, answer the following questions:
  - is there any merge strategy that can do "simplified" merge just like that in rebase?
    (not that I need it, but just for educational purpose)

  - does rebase perform simplified merge only because of speed considerations?
    (e.g. are there any correctness/usability issues with using smarter merge algo on rebase) 

  - is there any .git/config variable that affects which merge to use upon rebase?

best regards,
  Fedor.
