From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 0/5] Suggested for PU: revision caching system to
	significantly speed up packing/walking
Date: Thu, 6 Aug 2009 13:32:23 -0700
Message-ID: <20090806203223.GK1033@spearce.org>
References: <op.ux8i6hrbtdk399@sirnot.private> <alpine.DEB.1.00.0908061645470.8306@pacific.mpi-cbg.de> <4A7AEFA8.5010001@drmicha.warpmail.net> <c77435a80908061039p30b83511qb7c378cfd68a6cf6@mail.gmail.com> <alpine.DEB.1.00.0908062030340.8306@pacific.mpi-cbg.de> <c77435a80908061301n5e855aeci16af392ed3128651@mail.gmail.com> <c77435a80908061330h2461012at8b877970cab4906b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Sam Vilain <sam@vilain.net>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 22:32:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ9dT-0002Mg-Uq
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 22:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756585AbZHFUcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 16:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756562AbZHFUcX
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 16:32:23 -0400
Received: from george.spearce.org ([209.20.77.23]:53892 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756185AbZHFUcW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 16:32:22 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 564CF381FD; Thu,  6 Aug 2009 20:32:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <c77435a80908061330h2461012at8b877970cab4906b@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125123>

Nick Edelen <sirnot@gmail.com> wrote:
> Hrmm, I just realized that it dosn't actually cache paths/names...
> This obviously has no bearing on its use in packing, but I should
> either add that in or restrict usage in non-packing-related walks.
> Weird how things like that escape you.
> 
> I think I may go ahead and add support for this tomorrow.  It should
> have no effect on performance and very little impact on cache slice
> size.

You may not need the path name, but instead the hash value that
pack-objects computes from the path name.  All that matters is
the hash, so pack-objects can schedule the objects into the right
buckets when its doing delta computation for objects which are not
yet delta compressed, or whose delta cannot be suitably reused.

-- 
Shawn.
