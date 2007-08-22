From: "Josh England" <jjengla@sandia.gov>
Subject: Re: empty directories
Date: Wed, 22 Aug 2007 15:25:48 -0600
Message-ID: <1187817948.5986.159.camel@beauty>
References: <1187716461.5986.71.camel@beauty>
 <20070821134030.b763e9d3.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 23:25:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INxhP-00046x-NN
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 23:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbXHVVZI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 17:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760813AbXHVVZH
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 17:25:07 -0400
Received: from mm04snlnto.sandia.gov ([132.175.109.21]:4530 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932201AbXHVVZF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 17:25:05 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Wed, 22 Aug 2007 15:24:57 -0600
X-Server-Uuid: AA8306FD-23D1-4E5B-B133-B2D9F10C3631
Received: from [132.175.2.191] (beauty.son.sandia.gov [132.175.2.191])
 by mailgate.sandia.gov (8.14.0/8.14.0) with ESMTP id l7MLOuP6016802 for
 <git@vger.kernel.org>; Wed, 22 Aug 2007 15:24:56 -0600
In-Reply-To: <20070821134030.b763e9d3.seanlkml@sympatico.ca>
X-Mailer: Evolution 2.10.1
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.311128,
 Antispam-Data: 2007.8.22.135523
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='LEO_OBFU_SUBJ_RE
 0.1, __CP_MEDIA_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID
 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID
 0'
X-TMWD-Spam-Summary: TS=20070822212457; SEV=2.2.2; DFV=B2007082216;
 IFV=2.0.4,4.0-9; AIF=B2007082216; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230352E34364343413941392E303035373A53434A535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007082216_5.02.0125_4.0-9
X-WSS-ID: 6AD276233HO41545-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56422>

On Wed, 22 Aug 2007, Linus Torvalds wrote:
> On Wed, 22 Aug 2007, Salikh Zakirov wrote:
> > 
> > Linus Torvalds posted an untested patch in a recent discussion and requested
> > that anyone interested in this functionality continued development and testing.
> 
> That untested patch was seriously broken - it didn't do the sorting of 
> empty directories right. So it would need a lot of other work.
> 
> So I'm firmly back in the "just add a '.gitignore' file to the directory" 
> camp.

Woah.  I just spent much of the morning reading the history of this
thread. My eyes are still bleeding, but I think I'm sufficiently
informed enough to be dangerous.

Without actually sticking my head in the honey pot surrounded by giant
bears, I just want to relate a revision control scenario that I've been
wanting to solve for several years. I deploy/maintain many linux
clusters that each have a single system image to boot all nodes on the
machines. My desire is to shove an *entire* image into a git
repository, and simply have it do the right thing.  Doing so and using
clones/branches/merges to maintain these images would be extremely
useful.  I've attempted this concept with several SCMs using various
workarounds for each but have abandoned each attempt mainly due to
performance issues.  Git shows the best performance by far (to the
point of actually being usable) for this purpose.

Forget about special files as those are almost certainly a lost cause.
I'm willing to use .gitignore in empty directories until a better
solution presents itself.  The main need is for file
ownership/permission, which has been touched on before.  When I clone
an image, I really want an *identical* clone, in every way.  It seems
as though git had this functionality but scrapped it due to issues with
umask and merge type problems?  So the question is:  would there be any
way to bring this functionality back as a non-default configurable
option?  For those of us who need the functionality, we'd be more than
willing to live with some of the side-effects.

The alternatives (involving wrappers and strict policy) just haven't
been idiot-proof enough to be truly viable.  It almost has to be a
built-in capability.  It looks like Nax is doing something close to
this.  Is there anyone else using trying to use git in a similar way?

-JE

PS:  I know this falls outside of git's intended use, but its the
closest thing to something that could work.
