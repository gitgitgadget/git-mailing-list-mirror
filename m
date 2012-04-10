From: Matt McClure <matthewlmcclure@gmail.com>
Subject: Re: [PATCH v2] contrib: added git-diffall
Date: Tue, 10 Apr 2012 23:06:43 +0000 (UTC)
Message-ID: <loom.20120411T010200-132@post.gmane.org>
References: <1329948749-5908-1-git-send-email-tim.henigan@gmail.com> <7vipiy8m5q.fsf@alter.siamese.dyndns.org> <CAFouetiSpsZGtLt2tG4ou-H18zigNx5xWQH4cy8GrL1eDxbjJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 01:07:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHk9S-0003Ig-8m
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 01:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755847Ab2DJXHA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Apr 2012 19:07:00 -0400
Received: from plane.gmane.org ([80.91.229.3]:52530 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755241Ab2DJXHA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 19:07:00 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SHk9H-0003Bx-Cp
	for git@vger.kernel.org; Wed, 11 Apr 2012 01:06:55 +0200
Received: from c-24-91-16-82.hsd1.ma.comcast.net ([24.91.16.82])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 01:06:55 +0200
Received: from matthewlmcclure by c-24-91-16-82.hsd1.ma.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 01:06:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.91.16.82 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_3) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.151 Safari/535.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195137>

Tim Henigan <tim.henigan <at> gmail.com> writes:

> >> + =C2=A0 =C2=A0 do
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cp "$file" "$git_top_d=
ir/${file#$tmp/$right_dir/}"
> >> + =C2=A0 =C2=A0 done
> >> +fi
> >
> > This will copy new files created in $right_dir. =C2=A0Is that inten=
ded?
>=20
> hmmm...that was not intended.  If would be odd for the user to create
> new files in this tmp directory, but if the diff tool automatically
> generates any files then this could result in unwanted files.

I think more generally, I would prefer if either side of the comparison=
 is the
working copy that the temp directory on that side be populated with sym=
links.

A particularly bad failure mode of the copy-back approach is:

git diffall --copy-back
# while my diffall tool is running, I edit the file somewhere else.
# quit my diffall tool
# --> my edits in the other tool are overwritten by diffall

Editing the files in place via symlinks would resolve that.

Matt
