From: Christian Jaeger <christian@pflanze.mine.nu>
Subject: Re: [gambit-list] Separating generated files?
Date: Thu, 16 Oct 2008 14:32:35 +0200
Message-ID: <48F73463.2050902@pflanze.mine.nu>
References: <E6D34628-783D-4597-8B00-C10F27F63BE2@iro.umontreal.ca>	 <48F5D86B.6040501@pflanze.mine.nu>	 <fcaeb9bf0810150754s613f2c44pd8341711d9d73f73@mail.gmail.com>	 <vpqiqrt3mgs.fsf@bauges.imag.fr>	 <48F61D77.3080100@drmicha.warpmail.net>	 <48F62834.9080102@pflanze.mine.nu> <48F72CED.6030508@pflanze.mine.nu> <adf1fd3d0810160512if056c3dt5eeec6a097e1a7a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Marc Feeley <feeley@iro.umontreal.ca>,
	Gambit List <Gambit-list@iro.umontreal.ca>
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Thu Oct 16 14:33:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqS35-0004ch-3i
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 14:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167AbYJPMcj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Oct 2008 08:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754005AbYJPMci
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 08:32:38 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:39615 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753825AbYJPMci (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 08:32:38 -0400
Received: (qmail 5385 invoked from network); 16 Oct 2008 12:32:36 -0000
Received: from unknown (HELO elvis-jaeger.mine.nu) (127.0.0.1)
  by localhost with SMTP; 16 Oct 2008 12:32:36 -0000
Received: (qmail 31204 invoked from network); 16 Oct 2008 12:32:35 -0000
Received: from unknown (HELO ?127.0.0.1?) (10.0.5.1)
  by elvis-jaeger.mine.nu with SMTP; 16 Oct 2008 12:32:35 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <adf1fd3d0810160512if056c3dt5eeec6a097e1a7a7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98376>

Santi B=E9jar wrote:
> It looks like the html and man branches of git.git.
>
> http://git.kernel.org/?p=3Dgit/git.git;a=3Dshortlog;h=3Dhtml
> http://git.kernel.org/?p=3Dgit/git.git;a=3Dshortlog;h=3Dman
>
> They are automatically generated when Junio pushes the branches to
> kernel.org. Afterwards you can do a "make quick-install-html" and
> install the preformated html pages from these branches. They are
> generated with the dodoc.sh script from the todo branch in git.git
> (look inside for instructions):
>
> http://git.kernel.org/?p=3Dgit/git.git;a=3Dblob_plain;f=3Ddodoc.sh;hb=
=3Dtodo

This script only generates the html / man branches, it doesn't help fin=
d=20
the right version for a given git version, right?

The differences are:

- the html / man branches have a strictly linear history and are=20
centrally maintained. This solves the distribution issue for end users.=
=20
But while developping the compiler, the developers may need to go back=20
in the history of their own development (e.g. when the current compiler=
=20
doesn't work anymore), and the suspected usefulness of being able to se=
e=20
and track differences in the generated code also isn't available for a=20
strictly central approach.

- the script above is only for creating and committing the derived=20
files, in a hook similar to the one I suggested in=20
build/.git/hooks/commit-msg; this is the "cd build; git commit -m=20
'generated files for source repository commit
 > `git rev-parse HEAD`'" part; the more interesting part comes from=20
automatically finding the right commit in the generated branches for a=20
given source commit. This is what I intend to solve with the=20
"intergit-find-matching-commit-in" script. Said in a simpler way: the=20
git html / man branches do not offer automatically resolvable linking.

Christian.
