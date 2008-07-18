From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Test that we can add a new file to a non-topmost patch with refresh -p
Date: Fri, 18 Jul 2008 20:01:09 +0200
Message-ID: <20080718180109.GA14825@diana.vm.bytemark.co.uk>
References: <20080718084127.GA7042@diana.vm.bytemark.co.uk> <20080718170225.10086.17504.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jon Smirl <jonsmirl@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 19:40:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJtw1-00059u-IJ
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 19:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbYGRRjB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2008 13:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbYGRRjB
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 13:39:01 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3078 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbYGRRjA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 13:39:00 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KJuGT-00047E-00; Fri, 18 Jul 2008 19:01:09 +0100
Content-Disposition: inline
In-Reply-To: <20080718170225.10086.17504.stgit@yoghurt>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89062>

On 2008-07-18 19:03:06 +0200, Karl Hasselstr=F6m wrote:

> We currently can't -- this is bug 12038, found by Jon Smirl. See
>
>   https://gna.org/bugs/index.php?12038

OK, the problem is that to pop the patches on top of the one we are to
refresh, we call pop_patch(keep =3D True). This in turn calls
git.switch(keep =3D True), which resets the index (but is careful to no=
t
touch the worktree).

I'm not quite sure how to fix this in a simple way -- the code simply
assumes that the index contains nothing of interest. And since I
already have a rewrite of refresh that handles this and a handful of
other cases that the old code does not, I'm kind of disinclined to
undertake a larger restructuring of the code.

Catalin, what do you think?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
