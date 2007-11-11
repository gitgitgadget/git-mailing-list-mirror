From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 6/6] refactor fetch's ref matching to use ref_abbrev_matches_full_with_rules()
Date: Sun, 11 Nov 2007 15:55:05 +0100
Organization: At home
Message-ID: <fh7548$15u$1@ger.gmane.org>
References: <1194789708646-git-send-email-prohaska@zib.de> <11947897083381-git-send-email-prohaska@zib.de> <11947897081278-git-send-email-prohaska@zib.de> <11947897083159-git-send-email-prohaska@zib.de> <11947897083265-git-send-email-prohaska@zib.de> <1194789709671-git-send-email-prohaska@zib.de> <11947897092576-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:55:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrEDv-0008H0-EY
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 15:55:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023AbXKKOz2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2007 09:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754020AbXKKOz2
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 09:55:28 -0500
Received: from main.gmane.org ([80.91.229.2]:53378 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753932AbXKKOz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 09:55:27 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IrEDY-0007hs-Ay
	for git@vger.kernel.org; Sun, 11 Nov 2007 14:55:20 +0000
Received: from abtr2.neoplus.adsl.tpnet.pl ([83.8.163.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Nov 2007 14:55:20 +0000
Received: from jnareb by abtr2.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Nov 2007 14:55:20 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abtr2.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64468>

Steffen Prohaska wrote:

> The old rules used by fetch were coded as a series of ifs. =A0The old
> rules are:
> 1) match full refname if it starts with "refs/" or matches "HEAD"
> 2) verify that full refname starts with "refs/"
> 3) match abbreviated name in "refs/" if it starts with "heads/",
> =A0 =A0 "tags/", or "remotes/".
> 4) match abbreviated name in "refs/heads/"
>=20
> This is replaced by the new rules
> a) match full refname
> b) match abbreviated name prefixed with "refs/"
> c) match abbreviated name prefixed with "refs/heads/"
>=20
> The details of the new rules are different from the old rules. =A0We =
no
> longer verify that the full refname starts with "refs/". =A0The new r=
ule
> (a) matches any full string. =A0The old rules (1) and (2) were strict=
er.
> Now, the caller is responsible for using sensible full refnames. =A0T=
his
> should be the case for the current code. =A0The new rule (b) is less
> strict than old rule (3). =A0The new rule accepts abbreviated names t=
hat
> start with a non-standard prefix below "refs/".
>=20
> Despite this modifications the new rules should handle all cases as
> expected. =A0Two tests are added to verify that fetch does not resolv=
e
> short tags or HEAD in remotes.
>=20
> We may even think about loosening the rules a bit more and unify them
> with the rev-parse rules. =A0This would be done by replacing
> ref_ref_fetch_rules with ref_ref_parse_rules. =A0Note, the two new te=
st
> would break.

Does still "origin" matches "origin/HEAD" if we have emote "origin"?

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
