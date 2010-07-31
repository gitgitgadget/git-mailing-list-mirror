From: Walter Bright <boost@digitalmars.com>
Subject: Re: noob user, want checkins to all be forced to LF terminated lines
Date: Fri, 30 Jul 2010 22:14:40 -0700
Organization: Digital Mars
Message-ID: <i30bg7$50k$1@dough.gmane.org>
References: <i308gl$v6p$1@dough.gmane.org> <20100731044957.GA8920@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 31 07:15:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of4PY-0001Iq-I5
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 07:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642Ab0GaFO6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 01:14:58 -0400
Received: from lo.gmane.org ([80.91.229.12]:40991 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751161Ab0GaFO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 01:14:58 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Of4PQ-0001Gl-Dh
	for git@vger.kernel.org; Sat, 31 Jul 2010 07:14:56 +0200
Received: from c-24-16-56-60.hsd1.wa.comcast.net ([24.16.56.60])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 07:14:56 +0200
Received: from boost by c-24-16-56-60.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 07:14:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-16-56-60.hsd1.wa.comcast.net
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <20100731044957.GA8920@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152302>

Jonathan Nieder wrote:
> Walter Bright wrote:
>=20
>> I've just started with git.
>=20
> I thought I saw you here years ago. :)

I've been around, just not in git.


>> Exactly what do I put in $HOME/.gitconfig ?
>=20
> Well, naturally it depends on what you want to happen.
>=20
> If you just want to make sure any new files you commit are tracked
> with simple LF line endings, you can use
>=20
> 	[core]
> 		autocrlf =3D input
>=20
> With this setting, Git will not do any munging to files in the work
> tree in any way (unless there is a .gitattributes file requesting to
> do so).

git is installed under Ubuntu, but I'll be checking in files that I edi=
t on both=20
Windows and Ubuntu, so the line endings will vary depending on which pl=
atform I=20
last editted the file on. Hence, I want to force them all to be LF upon=
 checkin.

> That is an _altruistic_ setting to use.  It ensures you do not pollut=
e
> history with some alternative line-ending, but your own work tree may
> not necessarily match the cleaned up versions you are checking in; so
> if you try to "git add" and then "touch" a file with CRLF line ending=
s
> with this setting enabled, you may be surprised at the result!
> (Though a simple "git checkout file.c" afterwards should fix up the
> line endings in the work tree.)


> If you want to make sure text files in the work tree use LF line
> endings and you are using a recent version of Git, use the above
> setting or
>=20
> 	[core]
> 		eol =3D lf

So this changes the file in the repository to lf only, but not in the w=
orktree?=20
That's what I want.

> On Unix-y systems, you do not have to do that, since it is the
> default.  On Windows, the "[core] autocrlf" setting is set up
> by default in /etc/gitconfig so you would probably want to
> override that with
>=20
> 	[core]
> 		autocrlf =3D false
>=20
> if you are not setting it to input.
>=20
> Which files are text files? you may ask.  By default (unless
> autocrlf is enabled), Git treats files as raw data; to get it
> to futz with line endings, you have to declare your text files
> in a file named .gitattributes in the tracked tree.
>=20
> 	* crlf
> 	*.jpg -crlf
> 	*.png -crlf

In the tracked tree? The documentation:

http://www.kernel.org/pub/software/scm/git/docs/gitattributes.html#_che=
cking_out_and_checking_in

says it goes in:

  $GIT_DIR/info/attributes, .gitattributes

so I'm confused again. Does .gitattributes go in $GIT_DIR, or in $GIT_D=
IR/info ?=20
And what if both of those files are there, which one 'wins' ?



> The keyword crlf here means =E2=80=9Capply line-ending conversions=E2=
=80=9D and
> nothing more.  In particular, it does not represent the preferred
> line ending.
>=20
> If everyone for which you want these setting to take effect uses a
> recent version of git, you can write =E2=80=9Ctext=E2=80=9D instead o=
f =E2=80=9Ccrlf=E2=80=9D if
> you prefer.

git --version says I'm using 1.5.6.3

> Hope that helps,

Yes, it does, thank you!

A final question: where does the repository actually go (so I can back =
it up)?=20
This is a local thing, I'm not trying to set up a networked or remote=20
repository, so it'll be the default location.
