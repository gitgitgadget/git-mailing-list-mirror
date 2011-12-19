From: Nathan Gray <n8gray@n8gray.org>
Subject: Re: git-svn: multiple fetch lines
Date: Mon, 19 Dec 2011 13:40:50 -0800
Message-ID: <CA+7g9JzatFYViMk302uU-X=YQGF2wEsmASkLPm0tDfQvpL_-vQ@mail.gmail.com>
References: <CA+7g9Jxd3mhbra34f+MiJRt36Lb6gVHi1nOCP8Zo5y-G9jB3qA@mail.gmail.com>
	<20111217100521.GA12610@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 19 22:40:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rckx8-0004rv-GM
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 22:40:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600Ab1LSVky convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Dec 2011 16:40:54 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54188 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287Ab1LSVkx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Dec 2011 16:40:53 -0500
Received: by eaaj10 with SMTP id j10so5136533eaa.19
        for <git@vger.kernel.org>; Mon, 19 Dec 2011 13:40:52 -0800 (PST)
Received: by 10.205.131.13 with SMTP id ho13mr2170873bkc.41.1324330850962;
 Mon, 19 Dec 2011 13:40:50 -0800 (PST)
Received: by 10.204.228.204 with HTTP; Mon, 19 Dec 2011 13:40:50 -0800 (PST)
X-Originating-IP: [184.182.186.242]
In-Reply-To: <20111217100521.GA12610@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187476>

Hi,

On Sat, Dec 17, 2011 at 2:05 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Hi Nathan,
>
> Nathan Gray wrote:
>
>> I'm in a conversation with the support fellow of the very nice Tower
>> git interface for OS X and we need clarification on a point. =A0Does
>> git-svn explicitly support multiple "fetch =3D" lines in an svn-remo=
te
>> section or is it just an accident that it works? =A0My belief is tha=
t
>> such support is intended and his is that it is accidental.
>
> It's true that the documentation is not as clear about this as one
> might like. =A0Documentation/git-svn.txt leaves it to the reader to
> infer that this is supported by analogy with "fetch =3D" lines in nat=
ive
> git [remote] sections:

Thanks Jonathan, that's just what I suspected.

[snip]

> Perhaps such an example would be useful for the git-svn(1) manpage,
> too. =A0Any ideas for where to add such a note, and how it should be
> worded? =A0(Of course, if you can phrase such an idea in patch form,
> that would be the most convenient.)

The existing CONFIGURATION section of the man page seems like a
sensible place to mention multiple fetch entries.  I've also found the
documentation on creating branches in the presence of multiple branch
keys to be confusing and in need of an example, so maybe that could go
in as well.  How about something along these lines:

"""
In order to simplify working with messy subversion repositories you
can configure multiple fetch, branches, and tags keys.  For example:

[svn-remote "messy-repo"]
  url =3D http://server.org/svn
  fetch =3D trunk/project-a:refs/remotes/project-a/trunk
  fetch =3D branches/demos/june-project-a-demo:refs/remotes/project-a/d=
emos/june-demo
  branches =3D branches/server/*:refs/remotes/project-a/branches/*
  branches =3D branches/demos/2011/*:refs/remotes/project-a/2011-demos/=
*
  tags =3D tags/server/*:refs/remotes/project-a/tags/*

To create a branch in this configuration you need to specify the
location for the new branch using the -d or --destination flag.  For
example:

git svn branch -d wtf-goes-here-anyway?? release-2-3-0
"""

The thing about the -d option that confuses me is that I'm not sure if
I'm supposed to be supplying a full svn path, a partial svn path, the
glob from the config file, etc.  An example would make it obvious.
Personally, I always take the coward's way out and comment out the
extra branches keys, make the branch without -d, then restore them in
order to avoid any potential problems.  :^)

Thanks,
-Nathan

--=20
HexaLex: A New Angle on Crossword Games for iPhone and iPod Touch
http://hexalex.com
On The App Store: http://bit.ly/8Mj1CU
On Facebook: http://bit.ly/9MIJiV
On Twitter: http://twitter.com/hexalexgame
http://n8gray.org
