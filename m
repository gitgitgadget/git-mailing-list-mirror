From: Dave Jones <davej@redhat.com>
Subject: Re: Why do we need [PATCH]?
Date: Fri, 16 Dec 2005 16:13:57 -0500
Message-ID: <20051216211357.GL2821@redhat.com>
References: <20051216210145.GA25311@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 22:15:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnMuA-0008LF-QR
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 22:14:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbVLPVOO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 16:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbVLPVOO
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 16:14:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22939 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932437AbVLPVOM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Dec 2005 16:14:12 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id jBGLDx98007767;
	Fri, 16 Dec 2005 16:13:59 -0500
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id jBGLDx124780;
	Fri, 16 Dec 2005 16:13:59 -0500
Received: from nwo.kernelslacker.org (vpn83-121.boston.redhat.com [172.16.83.121])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id jBGLDwu5010033;
	Fri, 16 Dec 2005 16:13:59 -0500
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.5/8.13.4) with ESMTP id jBGLDwVX020616;
	Fri, 16 Dec 2005 16:13:58 -0500
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.5/8.13.5/Submit) id jBGLDveo020615;
	Fri, 16 Dec 2005 16:13:57 -0500
X-Authentication-Warning: nwo.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: Sam Ravnborg <sam@ravnborg.org>
Content-Disposition: inline
In-Reply-To: <20051216210145.GA25311@mars.ravnborg.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13752>

On Fri, Dec 16, 2005 at 10:01:45PM +0100, Sam Ravnborg wrote:

 > I've just applied a patch to my git tree using git-applymbox.
 > It worked like a charm as it often do.
 > But then when I did a quick check with gitk it stuck me that
 > the subject was prefixed with [PATCH].
 > I am aware that the [PATCH] in subject tell me:
 > "patch is received from somewhere and applied by me to the .git tree".
 > This is in comparsion to patches received when I merge a git tree for
 > example.
 > 
 > But with common practice to use sign-off I wonder the value of this
 > patch marker.
 > When browsing the kernel shortlog I often focus on first word in subject
 > - cause this tells me what system/drivers is changed. But with the
 >   [PATCH] marker I have to read some non-sense to see actual subject.
 > 
 > The information is redundant since metadata already tell me who is the
 > author and who committed the change.
 > So could we have it removed or if people continue to find it usefull
 > then at least hide it behind some option. Using the [PATCH] prefix is
 > not the natural thing to do with git.
 > 
 > I looked at the source and found the -k option, but adding [PATCH]
 > should not be default behaviour so this is not the correct solution.

I'm still using Linus' original 'applypatch' script, on which I think
this stuff was based, and this behaviour annoyed me too.
So I changed it to do this..

if [ -f .treename ]; then
  TREENAME=`cat .treename`
else
  TREENAME='PATCH'
fi
(echo "[$TREENAME] $SUBJECT" ; if [ -s $MSGFILE ]; then echo ; cat $MSGFILE; fi ) > $final


and then I have a .treename in say the AGP tree, containing just 'AGPGART',
and the changelogs get the prefixes that actually mean something useful.
(And those markers are invaluable when searching through history for changes)

		Dave
