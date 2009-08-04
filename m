From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Adding files to a git-archive when it is generated, and whats
 the 	best way to find out what branch a commit is on?
Date: Tue, 04 Aug 2009 19:50:04 +0200
Message-ID: <4A7874CC.9050702@lsrfire.ath.cx>
References: <9b18b3110907290115v1f30eeat748631bb09f92517@mail.gmail.com>	 <adf1fd3d0907290141v24cf129eue3939bf1afd518d2@mail.gmail.com>	 <9b18b3110907290221o8afc72s157969ef7d707d4d@mail.gmail.com>	 <4A720393.6030607@lsrfire.ath.cx>	 <9b18b3110907310304w261ee30bw8c06c6a65e936e6e@mail.gmail.com>	 <4A759A21.7070806@lsrfire.ath.cx> <9b18b3110908020719h79cf4872p9f284346cd6a185b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>,
	Git <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 19:50:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYO9e-0000Ib-HY
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 19:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933020AbZHDRuU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Aug 2009 13:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932977AbZHDRuT
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 13:50:19 -0400
Received: from india601.server4you.de ([85.25.151.105]:50679 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932897AbZHDRuT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 13:50:19 -0400
Received: from [10.0.1.101] (p57B7C32D.dip.t-dialin.net [87.183.195.45])
	by india601.server4you.de (Postfix) with ESMTPSA id 9A1562F8055;
	Tue,  4 Aug 2009 19:50:18 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <9b18b3110908020719h79cf4872p9f284346cd6a185b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124800>

demerphq schrieb:
> One solution is to do the work in a process specific temporary
> directory with the correct name and then add it that way.
>=20
> A slightly nicer approach is create the file in a common working
> directory with a temporary name and then have it added to the archive
> with a different name. This is actually the approach I used by
> exploiting the the --transform option to tar. So while it might appea=
r
> my request is a YAGNI it is actually a IADNI (I Already Did Need It).
>=20
> Even nicer and cleaner of course would be support something like
> "--add-file -=3D.patch"  with the "-" meaning "read from STDIN", whic=
h
> then means temporary files can be avoided, assuming one only needs to
> add a single file to the archive. This is particularly nice if the
> content of  the file can be generated from the output of something
> like git-describe or git rev-parse or any generic tool.

This case (single file in archive, contents from stdin) could be handle=
d
by another option, e.g. named --add-stdin <name_in_archive>, without
resorting to multi-valued option parameters.

Also, if a file can be generated using a --pretty=3Dformat: string, the=
n
you can let git-archive expand a checked-in template by setting the
attribute export-subst.  This works for multiple files, but doesn't if
you need git-describe style output (yet).

> So IMO actually this functionality would be very useful, and isnt so
> weird when you think of it in context of generating snapshots for a
> "git aware" build process.

No doubt about it.  The question is: how to expose such functionality?
Perhaps all that is needed for your purposes is a format place-holder
for git-describe output?

(git itself needs more: in addition to the files "version" and
"git.spec", which could benefit from such a place-holder, it adds the
generated "configure" script and "git-gui/version" to the tarball.)

Ren=E9
