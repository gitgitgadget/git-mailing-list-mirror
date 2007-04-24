From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Why SHA are 40 bytes? (aka looking for flames)
Date: Mon, 23 Apr 2007 22:30:35 -0400
Message-ID: <20070424023035.GK17480@spearce.org>
References: <e5bfff550704210635r4008c3c6tf5f55f970bf85e44@mail.gmail.com> <9e4733910704210837y3ac3654ekb60654ef6fc397fc@mail.gmail.com> <e5bfff550704211006t59cb49h179685d694a1d75a@mail.gmail.com> <alpine.LFD.0.98.0704220925420.28339@xanadu.home> <462D5370.8040905@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Marco Costalba <mcostalba@gmail.com>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 04:30:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgAnm-000359-Pr
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 04:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556AbXDXCan (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 22:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754560AbXDXCan
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 22:30:43 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55309 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754556AbXDXCam (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 22:30:42 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HgAnS-0006r2-9A; Mon, 23 Apr 2007 22:30:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B8ECC20FBAE; Mon, 23 Apr 2007 22:30:35 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <462D5370.8040905@zytor.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45406>

"H. Peter Anvin" <hpa@zytor.com> wrote:
> Nicolas Pitre wrote:
> >
> >Object names aren't 40 bytes.  They are 20 bytes.
> >It  is their hex representation that takes 40 bytes.
> >
> 
> Sure, but that's the way they're stored in *most* git objects, in 
> particular in commit objects.

But OBJ_TREE occurs more often, and its 20 bytes binary for a SHA-1
in those.  They are only ASCII hex in OBJ_COMMIT and OBJ_TAG.

If Nico and I ever get pack v4 done, all SHA-1s drop to 24 bytes
worst case, or 20 + (4 * n_references) best case.  Typically we
found that n_references was large enough, frequently enough, that
we shaved 5% or so off linux-2.6.git.  And I don't think that's
including the 20 * n_objects saved out of the .idx files...

-- 
Shawn.
