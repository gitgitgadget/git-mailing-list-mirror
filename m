From: Anatoly Borodin <anatoly.borodin@gmail.com>
Subject: Re: git show -m with a parent number
Date: Wed, 30 Mar 2016 12:31:16 +0000 (UTC)
Message-ID: <ndggug$c87$1@ger.gmane.org>
References: <nd9gq6$412$1@ger.gmane.org> <20160328191608.GA22602@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 14:33:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alFIc-00082I-0V
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 14:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413AbcC3Mce convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Mar 2016 08:32:34 -0400
Received: from plane.gmane.org ([80.91.229.3]:47324 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751905AbcC3Mcd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 08:32:33 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1alFI1-0007X2-QT
	for git@vger.kernel.org; Wed, 30 Mar 2016 14:32:02 +0200
Received: from fokus169218.fokus.fraunhofer.de ([194.95.169.218])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 14:32:01 +0200
Received: from anatoly.borodin by fokus169218.fokus.fraunhofer.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 14:32:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: fokus169218.fokus.fraunhofer.de
Cancel-Lock: sha1:GgIRaok8P9+8ozfcm3eWeaShB8U=
User-Agent: tin/2.3.1-20141224 ("Tallant") (UNIX) (Linux/4.2.0-34-generic (x86_64))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290304>

Hi!

Jeff King <peff@peff.net> wrote:
> For the first one, showing all diffs is what I want. For the second, =
it
> only makes sense to for the first parent case, as following other
> parents would zig-zag through history.

Lucky you! :) You probably don't need to inspect 9 month old ex-svn
branches with sync (i.e. 'trunk'->'feature') merges

*-...-*-...-*-...-*-.......-*---trunk
 \     \     \     \       /
  *-...-*-...-*-...-*-...-*---feature

(Not to forget some funny legacy inter-feature merges.)

It's not like `git diff X^2 X` is a big problem, but too much of a
copypaste.

The other thing that bugs me is that you can easily `git cherry-pick -m=
 2 X`,
but to see the diff that you are going to apply is not that trivial.

> But perhaps you have some other use case in mind. In cases like these=
, I
> think it is a good idea to implement the feature, and run with it for=
 a
> while, seeing how it can be used. And then if it proves useful, post =
the
> patch to the list describing your experiences.

I'll try. BTW, should it be like '-m[=3Dparent]' for consistency,
or '-m [parent]' is ok?

PS Another idea:

'-m parent' makes sence in a normal, 2-branch merge. But what to do in =
a
case of an octopus merge? In a normal case I can treat '-m 2' as 'the
diff regarding the second parent', but also as 'the changes contributed
by the first parent (plus "evil")'. But with 3 and more branches '-m 3'
means 'the changes from 1 and 2'. Would it be possible to get only the
contribution from the second or third parent in this case?

Yeah, I know, there is `git diff parent1...parent3` etc, but not all th=
e
changes from parent3 will always get to the merge commit.

--=20
Mit freundlichen Gr=C3=BC=C3=9Fen,
Anatoly Borodin
