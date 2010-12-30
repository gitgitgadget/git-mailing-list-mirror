From: Alexandre Oliva <lxoliva@fsfla.org>
Subject: Re: rebase parents, or tracking upstream but removing non-distributable bits
Date: Thu, 30 Dec 2010 20:32:33 -0200
Organization: Free thinker, not speaking for FSF Latin America
Message-ID: <or4o9uc2ny.fsf@livre.localdomain>
References: <ord3ojb0yy.fsf@livre.localdomain>
	<20101230205847.GA29012@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 30 23:32:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYR3E-0005Un-0C
	for gcvg-git-2@lo.gmane.org; Thu, 30 Dec 2010 23:32:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939Ab0L3Wcr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Dec 2010 17:32:47 -0500
Received: from fsfla.org ([217.69.89.164]:34131 "EHLO fsfla.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744Ab0L3Wcq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Dec 2010 17:32:46 -0500
Received: from freie.oliva.athome.lsd.ic.unicamp.br (unknown [201.82.179.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by fsfla.org (Postfix) with ESMTPSA id 9F05867AF19;
	Thu, 30 Dec 2010 22:32:44 +0000 (UTC)
Received: from livre.localdomain (livre-to-gw.oliva.athome.lsd.ic.unicamp.br [172.31.160.19])
	by freie.oliva.athome.lsd.ic.unicamp.br (8.14.4/8.14.4) with ESMTP id oBUMWfnF032530;
	Thu, 30 Dec 2010 20:32:41 -0200
Received: from livre.localdomain (aoliva@localhost [127.0.0.1])
	by livre.localdomain (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id oBUMWZIQ023067;
	Thu, 30 Dec 2010 20:32:35 -0200
Received: (from aoliva@localhost)
	by livre.localdomain (8.14.3/8.14.3/Submit) id oBUMWX27023065;
	Thu, 30 Dec 2010 20:32:33 -0200
X-Authentication-Warning: livre.localdomain: aoliva set sender to lxoliva@fsfla.org using -f
In-Reply-To: <20101230205847.GA29012@burratino> (Jonathan Nieder's message of
	"Thu, 30 Dec 2010 14:58:47 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164370>

On Dec 30, 2010, Jonathan Nieder <jrnieder@gmail.com> wrote:

> Alexandre Oliva wrote:
>> Now, it looks like I might be able to pull from upstream if I mainta=
in
>> manually a graft file that named each upstream commit as an addition=
al
>> parent of the corresponding local rebase commit that brought it into=
 my
>> rewritten tree.  Workable, maybe, but this wouldn't help third parti=
es
>> that used my public repository.

> Have you looked into "git replace"?

As far as I could tell, it solves a complementary problem.  IIUC, it
would enable me to replace objects (say files, trees or commits) in my
local repository so as to remove objectionable stuff, but when I pushed
a branch out of it, it would go out with the very stuff I'm not suppose=
d
to publish.  This is because AFAICT replace objects are not sent over
the wire.

Even if they were, I still don't think it would be appropriate to use
them, for I'm speaking of really different trees.  Publishing a commit
replacement would, for anyone who had both my public repository and my
upstream, affect not just the branches I published, but also those in
upstream, which would be surprising and undesirable.

=46inally, it wouldn't be a complete solution.  Consider, for example, =
an
objectionable file or tree from an early commit, that I replaced with
something I can live with.  A later commit that changed that tree, or
any of those files, would AFAICT *silently* override my replacement,
requiring constant monitoring and new replacements for every such
change.

With the rewrite/rebase model I have in mind, changes to modified files
would conflict, prompting an immediate fix, without any risk of
publishing modified versions of unwanted files.  (Of course, in my
particular case I'd still have to monitor for newly-introduced
objectionable stuff, but that's to be expected.)


Did I make any mistakes in my analysis of the =E2=80=9Creplace=E2=80=9D=
 feature?  It
would be lovely if I could use it, but, in a way, it appears to be the
dual of what I need: I need to fix a problem in what I provide to
others, while replace would fix the problem in what I see myself.


Anyhow, thanks for the pointer, appreciated!

--=20
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
=46ree Software Evangelist      Red Hat Brazil Compiler Engineer
