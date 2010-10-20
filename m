From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: bash completion broken on ubuntu 10.10?
Date: Thu, 21 Oct 2010 01:04:09 +0200
Message-ID: <20101020230409.GB1767@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 21 01:04:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8hhi-0003Tz-6n
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 01:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697Ab0JTXEM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Oct 2010 19:04:12 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:64572 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762Ab0JTXEM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 19:04:12 -0400
Received: from localhost6.localdomain6 (p5B130998.dip0.t-ipconnect.de [91.19.9.152])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MACkL-1OxP1P2byT-00B08D; Thu, 21 Oct 2010 01:04:10 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:HVZn0ByN4Fyel6DNi/UUHoxXbCKyMCCuaRkm2MCrkX5
 cCtBfoFcdcl6JdnOibfRkMPk5Iml94eCWk5XV9ULjKd8ELc+5+
 2gB0P4f1zSML3VzjXXj3RSptSvaywZ82sg/Ymjp8Us9yuyH9js
 bLpFwed2H52TVdAHyUzdnYjMrAjJMZr2BxzkUNKQ8d/uvyWloZ
 uSP1Qhf2KD9wZHyjWuzeA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159448>

Hi,

Git's bash completion script offers possible arguments to some
options, e.g. it lists pretty formats after 'git log --pretty=3D<TAB>',
merge tools after 'git mergetool --tool=3D<TAB>', refs after 'git commi=
t
--reuse-message=3D<TAB>', etc.

On a three day old ubuntu 10.10 install these don't work anymore; the
completion script offers the list of files in all those cases.

After a bit of investigation I found that when I press TAB after 'git
log --pretty=3D', then ${COMP_WORDS[COMP_CWORD-1]} contains '--pretty'
and ${COMP_WORDS[COMP_CWORD]} contains "=3D".  Weird.

Then I remembered that we had some COMP_WORDBREAKS issues in the past
(db8a9ff, bash completion: Resolve git show ref:path<tab> losing ref:
portion, 2008-07-15)).  So I looked at my $COMP_WORDBREAKS, but didn't
see anything suspicious (it contains "'><=3D;|&(: ).  Removing the '=3D=
'
makes the listing after 'git log --pretty=3D' work, but breaks many
other things badly.

I don't have any ideas what could possibly be wrong here (but it's too
late here for any bright ideas anyway...).  Could someone confirm or
deny this behaviour on ubuntu 10.10?


Thanks,
G=E1bor
