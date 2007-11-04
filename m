From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Why is --pretty=format: so slow?
Date: Sun, 04 Nov 2007 11:31:10 +0100
Message-ID: <472D9F6E.8070609@lsrfire.ath.cx>
References: <18221.16318.785162.44769@cargo.ozlabs.ibm.com> <7vmytuvdvq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 11:32:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iocmc-0001v8-Gt
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 11:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759033AbXKDKbu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Nov 2007 05:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759110AbXKDKbt
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 05:31:49 -0500
Received: from main.gmane.org ([80.91.229.2]:34287 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758983AbXKDKbr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 05:31:47 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IoclR-000169-3u
	for git@vger.kernel.org; Sun, 04 Nov 2007 10:31:33 +0000
Received: from p57b7db16.dip.t-dialin.net ([87.183.219.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Nov 2007 10:31:33 +0000
Received: from rene.scharfe by p57b7db16.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Nov 2007 10:31:33 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p57b7db16.dip.t-dialin.net
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vmytuvdvq.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63377>

Junio C Hamano schrieb:
> Paul Mackerras <paulus@samba.org> writes:
>=20
>> Strace seems to indicate that git log is doing at least one sequence
>> of open, fstat64, fcntl64, getdents64 and close for each line of
>> output in the --pretty=3Dformat: cases, but not in the other cases.
>=20
> I bet that is coming from doing find_unique_abbrev() to fill
> fields %h, %t and %p, even when the output format does not ask
> for any of them.
>=20
> Dscho, can we stop calling find_unique_abbrev() unconditionally
> before being asked?

Incidentally, I'm finishing a patch series to add git-describe style
placeholders.  It needs such an optimization even more badly (and has
it).  Speeding up other slow placeholder expansions falls out quite
naturally.  Please wait just a few minutes..

Ren=E9
