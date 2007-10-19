From: cho <tobutaz@gmail.com>
Subject: Re: [BUG] git-svn not following svn moves
Date: Fri, 19 Oct 2007 07:51:56 +0000 (UTC)
Message-ID: <ff9nms$2eu$3@ger.gmane.org>
References: <ff7fhg$2eu$1@ger.gmane.org>
	<20071018121328.GA5358@xp.machine.xx> <ff7m2j$2eu$2@ger.gmane.org>
	<4717D85C.9050805@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 19 10:32:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IinH6-0000tc-BV
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 10:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759697AbXJSIbR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Oct 2007 04:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758922AbXJSIbO
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 04:31:14 -0400
Received: from main.gmane.org ([80.91.229.2]:39341 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756747AbXJSIbL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 04:31:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IimeM-0006kh-0P
	for git@vger.kernel.org; Fri, 19 Oct 2007 07:52:06 +0000
Received: from dhcp26-237.enst.fr ([137.194.26.237])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Oct 2007 07:52:06 +0000
Received: from tobutaz by dhcp26-237.enst.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Oct 2007 07:52:06 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dhcp26-237.enst.fr
User-Agent: Pan/0.129 (Benson & Hedges Moscow Gold)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61675>

Le Fri, 19 Oct 2007 11:04:12 +1300, Sam Vilain a =C3=A9crit=C2=A0:

> cho wrote:
>> I've surprised myself but yes, there is a simple testcase.
>>=20
svnadmin create repo
svn checkout file://$PWD/repo checkout cd checkout/
svn mkdir trunk tags branches
svn ci -m 'Standard svn layout.'
cd trunk/
svn mkdir doc
touch doc/README
svn add doc/README
svn ci -m 'Add README.'

# forgot this, sorry
svn up
cd ..
svn mv trunk/ branches/oldtrunk
svn ci -m 'Moved trunk.'
svn mkdir trunk
svn ci -m 'New trunk.'
cd trunk/
touch THIS_IS_THE_NEW_TRUNK
svn add THIS_IS_THE_NEW_TRUNK
svn ci -m 'Add marker.'
cd ../..
git svn clone file://$PWD/repo --stdlayout git-clone
cd git-clone/
tree

>>=20
>> So the testcase basically involves moving the trunk. git-svn gets ve=
ry
>> confused and keeps a mixture of the old and new trunk.
>=20
> Were you using --follow-parent or not?

It's the same whether I use --follow-parent or --no-follow-parent .
