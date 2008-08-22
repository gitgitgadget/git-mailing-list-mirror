From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Linux 2.6.27-rc3: kernel BUG at mm/vmalloc.c - bisected
Date: Fri, 22 Aug 2008 23:36:18 +0200
Message-ID: <20080822213618.GC1598@atjola.homenet>
References: <48A36838.3050309@hp.com> <20080819124602.9e8e69f7.akpm@linux-foundation.org> <48AEDD3D.4060507@hp.com> <20080822092549.ddcb7e79.akpm@linux-foundation.org> <20080822171651.GP10544@machine.or.cz> <20080822105136.a8432875.akpm@linux-foundation.org> <7v7ia8ahgu.fsf@gitster.siamese.dyndns.org> <20080822141651.fe16ed99.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, pasky@suse.cz,
	Alan.Brunelle@hp.com, linux-kernel@vger.kernel.org,
	git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 23:37:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWeK0-00077Q-9k
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 23:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758285AbYHVVgY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Aug 2008 17:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758212AbYHVVgX
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 17:36:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:51931 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757874AbYHVVgW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 17:36:22 -0400
Received: (qmail invoked by alias); 22 Aug 2008 21:36:20 -0000
Received: from i577B8611.versanet.de (EHLO atjola.local) [87.123.134.17]
  by mail.gmx.net (mp042) with SMTP; 22 Aug 2008 23:36:20 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18fLXppQ7gfyXjBb4EuziUcyeByoSM8Hj3bHL7gam
	r1VY+07ea4yICH
Content-Disposition: inline
In-Reply-To: <20080822141651.fe16ed99.akpm@linux-foundation.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93377>

On 2008.08.22 14:16:51 -0700, Andrew Morton wrote:
> It's pretty simple.  If git-bisect tells us that the regression was
> introduced by a merge commit, we want to perform a bisection within
> that merge's individual commits.

bisect already did that. It asked for the left side and the right side,
both were good. What you can still do is creating a _new_ history where
the commits are not in parallel but linearized, like Jeff described. Bu=
t
that's (in general) not a trivial task as you need to reapply individua=
l
commit patches which can cause conflicts that were already solved in th=
e
existing merges to show up again. Or, it can even produce new conflicts=
,
for example when a commit on one side was reverted before the merge
happened. In that case, you get into a state with changes that were
never visible before.

Bj=F6rn
