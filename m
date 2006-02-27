From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: bug?: stgit creates (unneccessary?) conflicts when pulling
Date: Mon, 27 Feb 2006 21:42:52 +0100
Message-ID: <20060227204252.GA31836@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@arm.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 21:42:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDpCm-0006rZ-2r
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 21:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWB0Umt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 27 Feb 2006 15:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbWB0Umt
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 15:42:49 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:54282 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1750848AbWB0Umt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 15:42:49 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1FDpCm-0008Uq-00; Mon, 27 Feb 2006 20:42:52 +0000
To: git@vger.kernel.org
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16882>

If I make a patch series where more than one patch touches the same
line, I get a lot of merge errors when upstream has accepted them and
I try to merge them back.

Suppose a line contained the string "0". Patch p1 changes that to "1",
patch p2 further changes that to "2". Upstream accept the patches, and
I later "stg pull" them. When reapplying p1 after the pull, stg
generates a merge conflict since upstream changed the "0" to "2" and
p1 changes the "0" to "1".

This situation arises for every line that's modified in more than one
patch, and for every such patch except the last one. And it's really
annoying, since it's intuitively obvious that there aren't actually
any conflicts, since upstream accepted my patches verbatim.

I suppose one way to fix it manually would be to first fetch, glance
at the new upstream commits and try to find any accepted patches, and
then "stg pull" the commit corresponding to the earliest patch in my
series; repeat for every patch in the series. The queston is, how can
we automate it?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
