From: Michael Radziej <mir@noris.de>
Subject: Re: multiple-commit cherry-pick?
Date: Fri, 7 Nov 2008 11:46:30 +0100
Message-ID: <20081107104630.GB12424@noris.de>
References: <buoiqr18tdk.fsf@dhapc248.dev.necel.com> <20081106213711.GA4334@blimp.localdomain> <alpine.LFD.2.00.0811061925300.3451@nehalem.linux-foundation.org> <7vskq4gmf5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alex Riesen <raa.lkml@gmail.com>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 11:56:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyP0e-0001OC-KJ
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 11:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbYKGKyt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Nov 2008 05:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751796AbYKGKyt
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 05:54:49 -0500
Received: from mail05.noris.net ([62.128.1.225]:51433 "EHLO mail05.noris.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751481AbYKGKys convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Nov 2008 05:54:48 -0500
X-Greylist: delayed 485 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Nov 2008 05:54:48 EST
Received: from mail01.noris.net ([62.128.1.221])
	by mail05.noris.net with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <mir@noris.de>)
	id 1KyOs1-0007Jk-1D
	for git@vger.kernel.org; Fri, 07 Nov 2008 11:47:17 +0100
Received: from mail-intern.backup.noris.net ([10.1.0.25] helo=mail.office.noris.de)
	by mail01.noris.net with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <mir@noris.de>)
	id 1KyOrG-0007cP-Vw; Fri, 07 Nov 2008 11:46:31 +0100
Received: from mir.office.noris.de ([10.2.6.66])
	by mail.office.noris.de with esmtp (Exim 4.63)
	(envelope-from <mir@noris.de>)
	id 1KyOrG-0004X0-N4; Fri, 07 Nov 2008 11:46:30 +0100
Received: by mir.office.noris.de (Postfix, from userid 294)
	id 9DB96EBBE76; Fri,  7 Nov 2008 11:46:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vskq4gmf5.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Noris-IP: 10.1.0.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100301>

On Thu, Nov 06, Junio C Hamano wrote:
> Or "git show --pretty=3Demail $commit1 $commit2" ... piped to "am"?

Or make git show write shell commands.

I often have commits that later need to be cherry-picked into other
branches. For these, I use a commit message that starts with the name o=
f the
branch, like "implement-foo: make foo barfy". Later when I want to do t=
he
cherry-picking, I use this:

git log t/whatever..master --reverse --pretty=3Dtformat:'git cherry-pic=
k %h #
%s' | sed 's/^\([^:]*\) \([^:]*\):/git checkout \2 \&\& \1/'

giving me output like:

git checkout implement-foo && git cherry-pick 90ce727 # make foo barfy
git checkout ...

=2E.. and I'm ready for cut'n'paste.



Michael


--=20
noris network AG - Deutschherrnstra=DFe 15-19 - D-90429 N=FCrnberg -
Tel +49-911-9352-0 - Fax +49-911-9352-100
http://www.noris.de - The IT-Outsourcing Company
=20
Vorstand: Ingo Kraupa (Vorsitzender), Joachim Astel, Hansjochen Klenk -=
=20
Vorsitzender des Aufsichtsrats: Stefan Schnabel - AG N=FCrnberg HRB 176=
89
