From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v3] completion: add new _GIT_complete helper
Date: Sun, 6 May 2012 12:30:06 +0200
Message-ID: <20120506103006.GI2164@goldbirke>
References: <1336231400-6878-1-git-send-email-felipe.contreras@gmail.com>
	<20120505155423.GA14684@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 12:30:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQyjJ-0000Lv-2T
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 12:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277Ab2EFKaL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 May 2012 06:30:11 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:56158 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973Ab2EFKaK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 06:30:10 -0400
Received: from localhost6.localdomain6 (p5B130CE2.dip0.t-ipconnect.de [91.19.12.226])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0Lr20J-1Rw1Yy25AZ-00e8Um; Sun, 06 May 2012 12:30:07 +0200
Content-Disposition: inline
In-Reply-To: <20120505155423.GA14684@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:SgA1N86C3AiPx03ynHXhHiZ8Efb9d8UhaOCBrEpKd6d
 5/shrbZzLzBkxO6KLQOnQFYp/UzNB93pvDlCQzrI6wJyAsPNfG
 Tdg4AKA1EjciesiQwWpfO1P4ysifaYIBYtMnIuzsZN0G3Te8iN
 jKuEweyw2gHbuagCsLMt4BldLTKWS9jDjinDXrxJ0nr4GtiCM1
 ssa8pY11UaGvz+/dhDnfzk8RV2p16i4RBhlq8w807sk+HL+j9K
 3AiA2glCPLjb082wQ6JwM0YnN+8dE8jXhf94pZJ3O4PvYLJOHe
 lX8jYWOIhioIM7IbaMT1T97qOYb0AFshsnDkxfJQfBwP54bGzH
 c8/asmuD/RC+C6oufJhs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197164>

On Sat, May 05, 2012 at 10:54:23AM -0500, Jonathan Nieder wrote:
> Felipe Contreras wrote:
>=20
> > Since v3:
> >
> >  * Rename to _GIT_complete to follow bash completion "guidelines"
> >  * Get rid of foo_wrap name
>=20
> Thanks.  G=E1bor, does the "all caps _GIT_ prefix for public API
> functions" convention look like one we should adopt?  If I understand
> correctly, previously contrib/completion/git-completion.bash used
> leading double underscores for everything except completion functions=
,
> so this is a change.

Dunno.  I have only three concerns:

- It doesn't contaminate "my" namespace, where my installed programs,
  aliases, and shell functions are, i.e. it begins with an underscore.
- Its name conveys that it's git-specific.
- It's not called _git_complete, so the completion script (in
  particular at the end of _git()) won't misrecognize it as a
  completion function for the 'git complete' command, just in case
  somebody ever happens to have such a command or alias.

I'm not sure about the capital letters, but it fulfills all three.


> I personally would be happier with a git_complete function provided
> by another script, like this:
>=20
> 	contrib/completion/git-completion.bash:
>=20
> 		__git_complete () {
> 			...
> 		}
>=20
> 	contrib/completion/bash-helpers.bash:
>=20
> 		git_complete () {
> 			__git_complete "$@"
> 		}
>=20
> One might object that if the user includes bash-helpers.bash (name is
> just a strawman) in .bashrc for interactive shells because he is
> defining some custom completion functions,
>=20
> 	git<TAB>
>=20
> would show the git_complete function.  I think that's fine.

It depends on what else will go into that bash-helpers.bash file.  If
I have to source it to use git completion or the git-specific bash
prompt, then I won't be very happy about it.

> Maybe
> the user would enjoy the reminder.

A reminder for what?

It's a configuration thing, so it will be used in .bashrc; I think
it's quite unlikely that it will be used interactively.


Best,
G=E1bor
