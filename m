From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [BUG] fatal error during merge
Date: Fri, 14 Nov 2008 08:16:36 +0100
Message-ID: <20081114071636.GA4013@blimp.localdomain>
References: <53328.bFoQE3daRhY=.1226568134.squirrel@webmail.hotelhot.dk> <2008-11-13-14-23-19+trackit+sam@rfc1149.net> <20081113140323.GA10267@neumann> <2008-11-13-15-26-33+trackit+sam@rfc1149.net> <20081113145325.GD29274@neumann> <57814.N1gUGH5fRhE=.1226596012.squirrel@webmail.hotelhot.dk> <20081113180931.GE29274@neumann> <20081113230932.GA8552@blimp.localdomain> <48332.N1gUGH5fRhE=.1226619243.squirrel@webmail.hotelhot.dk> <7vfxlvf8up.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anders Melchiorsen <mail@cup.kalibalik.dk>,
	SZEDER =?iso-8859-15?Q?G=E1bor?= <szeder@ira.uka.de>,
	Samuel Tardieu <sam@rfc1149.net>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 08:18:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0swG-0003VG-Ch
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 08:17:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbYKNHQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 02:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbYKNHQk
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 02:16:40 -0500
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:8604 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbYKNHQk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 02:16:40 -0500
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx9CU82p9Cj
Received: from tigra.home (Fa8e1.f.strato-dslnet.de [195.4.168.225])
	by post.strato.de (mrclete mo40) (RZmta 17.20)
	with ESMTP id L04374kAE6b7kB ; Fri, 14 Nov 2008 08:16:37 +0100 (MET)
Received: from blimp.localdomain (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 5E45E277C8;
	Fri, 14 Nov 2008 08:16:37 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id E5F8A36D27; Fri, 14 Nov 2008 08:16:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vfxlvf8up.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100956>

Junio C Hamano, Fri, Nov 14, 2008 01:29:34 +0100:
> "Anders Melchiorsen" <mail@cup.kalibalik.dk> writes:
> 
> > Your patch got rid of the errors and it commits the merged tree. But the
> > working tree is not updated correctly, so the moved file disappears.
> 
> Isn't this a long known breakage of D/F conflict check logic in
> merge-recursive backend?

Could be, but there is no conflicting entries in the merged branches.
All file names are different and the D/F transition happens completely
on one branch.

And the patch isn't enough: the file Anders noticed missing is in the
index (correctly) but somehow removed from worktree.  Which is maybe
because it _still_ was a rename: 99% similarity. Well, just
"yes | tail -nNN" usually producess very similar data :)

Still broken, of course...
