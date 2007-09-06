From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] git.__remotes_from_dir() should only return lists
Date: Thu, 06 Sep 2007 08:38:26 -0400
Message-ID: <1189082306.3695.5.camel@gx>
References: <20070905165722.17744.56584.stgit@dv.roinet.com>
	 <20070906112645.GA31888@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Karl =?ISO-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 14:38:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITGd0-0006N1-6s
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 14:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755866AbXIFMia convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 6 Sep 2007 08:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755631AbXIFMia
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 08:38:30 -0400
Received: from c60.cesmail.net ([216.154.195.49]:64807 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755488AbXIFMi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 08:38:29 -0400
Received: from unknown (HELO relay.cesmail.net) ([192.168.1.81])
  by c60.cesmail.net with ESMTP; 06 Sep 2007 08:38:28 -0400
Received: from [192.168.15.107] (c-71-230-131-166.hsd1.pa.comcast.net [71.230.131.166])
	by relay.cesmail.net (Postfix) with ESMTP id 5D437618FE1;
	Thu,  6 Sep 2007 08:38:27 -0400 (EDT)
In-Reply-To: <20070906112645.GA31888@diana.vm.bytemark.co.uk>
X-Mailer: Evolution 2.10.3 (2.10.3-2.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57873>

On Thu, 2007-09-06 at 13:26 +0200, Karl Hasselstr=F6m wrote:
> On 2007-09-05 12:57:22 -0400, Pavel Roskin wrote:
>=20
> > If there are no remotes, return empty list, not None. The later
> > doesn't work with builtin set().
>=20
> Thanks. But I guess an even nicer fix would be to make this function
> return a set in the first place.

=46ine with me.  But it was returning a list or None, so the simplest f=
ix
was to return a list in all cases.

> > This fixes t1001-branch-rename.sh
>=20
> Hmm. I don't believe I saw t1001 break without this patch (I run the
> test suite before I push, but I might have made a mistake of course).
> Does the user's environment leak into the test sandbox?

I don't think it's the user environment, at least on my side.  I'm usin=
g
=46edora 7, which has python-2.5-12.fc7.  That's the error from the t10=
01
before my patch:

Traceback (most recent call last):
  File "/home/proski/src/stgit/t/../stg", line 43, in <module>
    main()
  File "/home/proski/src/stgit/stgit/main.py", line 284, in main
    command.func(parser, options, args)
  File "/home/proski/src/stgit/stgit/commands/branch.py", line 163, in =
func
    parentremote =3D git.identify_remote(parentbranch)
  File "/home/proski/src/stgit/stgit/git.py", line 994, in identify_rem=
ote
    for remote in remotes_list():
  File "/home/proski/src/stgit/stgit/git.py", line 963, in remotes_list
    | set(__remotes_from_dir('branches')))
TypeError: 'NoneType' object is not iterable

--=20
Regards,
Pavel Roskin
