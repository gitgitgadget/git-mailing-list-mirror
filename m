From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: why no "ignore" command on git
Date: Thu, 15 Oct 2009 11:29:57 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910151125240.4985@pacific.mpi-cbg.de>
References: <42efdea40910141535g23a50b87p9b6c4a0fde7e842e@mail.gmail.com> <200910142220.51725.wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ralf Thielow <ralf.thielow@googlemail.com>, git@vger.kernel.org
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Thu Oct 15 11:34:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyMio-0004ze-N9
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 11:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934171AbZJOJ2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 05:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933743AbZJOJ2E
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 05:28:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:47393 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933788AbZJOJ2D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 05:28:03 -0400
Received: (qmail invoked by alias); 15 Oct 2009 09:27:15 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp043) with SMTP; 15 Oct 2009 11:27:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18peqxArrkpnkFW3D4AKh4t2jpGprTdbivJ1MRXz/
	4pGyi9Yo+Waicz
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200910142220.51725.wjl@icecavern.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130383>

Hi,

On Wed, 14 Oct 2009, Wesley J. Landaker wrote:

> On Wednesday 14 October 2009 16:35:23 Ralf Thielow wrote:
> > why does git don't have an "ignore" command, to ignore some files or
> > directories all the time.
> [...]
> > I read on some pages by a google search that you can create
> > a ".gitignore" directory or something like that. But you had to do
> > this manually.
> >
> > why there is no "ignore" command on git?
> 
> You could always make your own git-ignore script, e.g.:
> 
> #!/bin/sh
> echo "$@" >> .gitignore

Probably it needs to be a little more sophisticated, because of Postel's 
law.

#!/bin/sh

git rev-parse > /dev/null || exit
for f
do
	case "$f" in
	*'[*?]'*)
		# patterns probably are meant to be recursive
		echo "$f"
		;;
	*)
		echo /"$f"
		;;
	esac >> .gitignore
done
git add .gitignore


Ciao,
Dscho
