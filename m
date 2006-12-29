From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: read-for-fill and caching in gitweb (Re: kernel.org mirroring)
Date: Fri, 29 Dec 2006 11:40:45 +0100
Message-ID: <200612291140.46909.jnareb@gmail.com>
References: <46a038f90612281245s52bdd868h8c421951c7abeb84@mail.gmail.com> <20061229032126.GE6558@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Jeff Garzik <jeff@garzik.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rogan Dawes <discard@dawes.za.net>,
	Kernel Org Admin <ftpadmin@kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 29 11:38:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H0F7c-0006Ap-2U
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 11:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWL2Khw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Dec 2006 05:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWL2Khw
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Dec 2006 05:37:52 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:17097 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbWL2Khv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Dec 2006 05:37:51 -0500
Received: by ug-out-1314.google.com with SMTP id 44so4350055uga
        for <git@vger.kernel.org>; Fri, 29 Dec 2006 02:37:50 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=UErWcupwcLdYmPwQDFBfHrtz2V2CSPZYcEVNTi2JMCQQ4cmI8rWZtrf10yWQFnPN2dDo+imKjN9RT0m5p45JJJHRXHD2Y5Rp1n3KuAmEQdW2N4KMeiaxGyspQe+KkGXqVJE9+bVhW0yQ4dxaev+g8nxVPuueRRQKP3kCnCDdxIA=
Received: by 10.67.19.17 with SMTP id w17mr22447446ugi.1167388669798;
        Fri, 29 Dec 2006 02:37:49 -0800 (PST)
Received: from host-81-190-24-56.torun.mm.pl ( [81.190.24.56])
        by mx.google.com with ESMTP id k1sm25866527ugf.2006.12.29.02.37.49;
        Fri, 29 Dec 2006 02:37:49 -0800 (PST)
To: Robert Fitzsimons <robfitz@273k.net>
User-Agent: KMail/1.9.3
In-Reply-To: <20061229032126.GE6558@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35587>

Robert Fitzsimons wrote:

> Here are the mean (and standard deviation) in milliseconds for those
> pages using a few different versions of gitweb.
> 
>                  project_list   summary  shortlog        log
> v267                  173 1.6  1141 8.8   795 5.0   919  1.9
> 1.4.4.3               220 2.3   397 2.4   930 4.2  1113 56.9
> 1.5.0.rc0.g4a4d       226 1.9   292 1.7   352 4.0   491  6.7
> 1.5.0.rc0.g4a4d        60 1.0   131 0.7   195 1.2   347  3.7
> (mod_perl)

> I'll look into the increase in time for the project_list in more recent
> versions of gitweb, tomorrow.

It is simply the case that new features cost more. Namely in earlier
versions of gitweb Last Change time was taken from HEAD (from current
branch), in newer we check all branches (using git-for-each-ref).
For published public repository it migh make sense to pack also heads
(make them packed refs).

I was thinking about making this a gitweb %feature, allowing gitweb
administrator to chose if Last Change is taken from all branches
(as it is now), from HEAD (as it was before), or from given branch
(for example master).

Another thing that might made small increase in time is checking
if project is to be visible to gitweb ($export_ok and $strict_export).

-- 
Jakub Narebski
Poland
