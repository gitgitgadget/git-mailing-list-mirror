From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Make cvsexportcommit work with filenames containing spaces.
Date: Sat, 23 Sep 2006 14:27:55 +0200
Message-ID: <200609231427.55721.robin.rosenberg@dewire.com>
References: <20060922223506.3377.34859.stgit@lathund.dewire.com> <7vvenfw727.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 14:28:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GR6bp-0005fr-1d
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 14:27:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWIWM1t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 23 Sep 2006 08:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWIWM1t
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 08:27:49 -0400
Received: from [83.140.172.130] ([83.140.172.130]:41797 "EHLO
	torino.dewire.com") by vger.kernel.org with ESMTP id S1750776AbWIWM1t convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Sep 2006 08:27:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id 24A12802884;
	Sat, 23 Sep 2006 14:25:03 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 12992-08; Sat, 23 Sep 2006 14:25:02 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by torino.dewire.com (Postfix) with ESMTP id B080080287A;
	Sat, 23 Sep 2006 14:25:00 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.4
In-Reply-To: <7vvenfw727.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27585>

l=F6rdag 23 september 2006 06:17 skrev Junio C Hamano:
> Robin Rosenberg <robin.rosenberg@dewire.com> writes:
> > Binary files are except to this so far.
>
> Funny.  This works on my home machine (CVS 1.12.13) while it
> does not pass test #2 "with spaces" on another machine that has
> CVS 1.11.22.
That must be something else. I've tried with various cvs versions here=20
(including plain 1.11.22) on Mandriva and SLES and it works on all with=
 the=20
lastest git on master (and 1.4.2.1).=20

Could you give me some more info, like the output from -v on the failin=
g=20
machine and your perl and patch version numbers and locale? I'm just gu=
essing=20
what could matter here. =20

Why patch? Well this patch works around (i.e. not perfect) a mismatch b=
etween=20
what patch eats and git submits. They are not totally, compatible, and =
I'm=20
not sure who to blame yet.  git emits diff's without timestamps, and wh=
at=20
matters to patch, without a TAB before the file timestamp. When patch s=
ees a=20
header like "+++ filename with spaces.txt" it patches "filename". When =
it=20
sees "+++ filename with spaces.txt<TAB>" if patches "filename with=20
spaces.txt". The real fix would ofcourse be in git diff or patch someti=
me in=20
the future.

> > +. ./test-lib.sh
> > +
> > +export CVSROOT=3D$(dirname $(pwd))/cvsroot
> > +export CVSWORK=3D$(dirname $(pwd))/cvswork
acknowledged

> You are creating t/{cvsroot,cvswork} directories.  Do not
> contaminate outside the test/trash directory your tests is
> started in.
>
> > +rm -rf $CVSROOT $CVSWORK
>
> People's $(pwd) can contain shell $IFS characters, especially on
> Cygwin.   Be careful and quote them when in doubt.

Considering this is a patch that should improve on whitespace handlung.=
=2E. ok.=20
I'll resubmit later.

-- robin
