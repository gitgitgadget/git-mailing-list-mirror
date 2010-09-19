From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: Find out on which branch a commit was originally made
Date: Sun, 19 Sep 2010 11:45:25 +0200
Message-ID: <1jp2d5s.1q4xl2w1f5ufljM%lists@haller-berlin.de>
References: <4C94EBBC.4080201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: avarab@gmail.com (=?ISO-8859-1?Q?=C6var_Arnfj=F6r=3F_Bjarmason?=),
	git@vger.kernel.org
To: art.08.09@gmail.com (Artur Skawina)
X-From: git-owner@vger.kernel.org Sun Sep 19 11:45:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxGSk-0008AQ-S9
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 11:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548Ab0ISJp3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Sep 2010 05:45:29 -0400
Received: from mail.ableton.net ([62.96.12.115]:55655 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790Ab0ISJp2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Sep 2010 05:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:From:Subject:In-Reply-To:Cc:To; bh=nXt1lhO0pZmnP3kuO3Xep7qbW4/bM9AVmPcOImqgKaY=;
	b=ZuW9wWrvPuQ/Ge8Kenr6cL/cGoJCzOAE1orPvg5lFhyoI6fyEZmlTcZwwwkenJnL102c6AG+hr1YKrVx2H5rFcrRqyajhRay2wX6AQ6Nffzz6k2M8GExegfNZpFo6HPP48qJnjAkU1dQ/a3uTqdIFuOFmX0WLGl319zrMlOsCXg=;
Received: from [10.1.15.236]
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1OxGS0-00057A-0R; Sun, 19 Sep 2010 11:44:48 +0200
In-Reply-To: <4C94EBBC.4080201@gmail.com>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.4 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156487>

Artur Skawina <art.08.09@gmail.com> wrote:

> On 09/18/10 17:26, Stefan Haller wrote:
> > =C6var Arnfj=F6r? Bjarmason <avarab@gmail.com> wrote:
> >>                      A---B---C topic
> >>                     /         \
> >>                D---E---F---G---H master
>=20
> > The question is the same though: if I hit commit B while blaming, h=
ow do
> > I know what topic it was a part of?  For that, I need to find commi=
t H
> > which will tell me, right?  How do I do that?
>=20
> git rev-list --ancestry-path --merges --reverse B..master --format=3D=
oneline

Thanks, this is helpful.  (However, my co-workers will probably laugh a=
t
me if I suggest they remember a command such as this for what they thin=
k
should be a very simple operation.)

There's a problem though for commits that are far back in history:

               A---B---C topic
              /         \
         D---E---F---G---H---I---J---K---L---M---N master
                                  \         /
                                   O---P---Q another-topic

Your command also shows M, which is not interesting at all in this
context.  Ideally it should stop at the first command that's common to
topic and master.  Is there an easy way to achieve that?

> IOW if you know you could still need the old branch info, make an ali=
as
> that doesn't actually delete the branch after merging, but moves the =
ref
> away, eg 'topic-name' -> "merged/topic-name" or just adds a
> "merged/topic-name" tag. Then simply checking from which "merged/*"
> branch/tag the offending commit is reachable would be enough.

Same problem here: this also shows all branches that were created and
merged after the original topic was merged.  (In the example above, it
will also list another-topic.)  This makes it pretty much impossible to
find the one I'm interested in.


--=20
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
