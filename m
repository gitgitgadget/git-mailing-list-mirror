From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] git-tag -s must fail if gpg is broken and cannot sign tags
Date: Fri, 7 Sep 2007 00:58:33 -0400
Message-ID: <20070907045833.GZ18160@spearce.org>
References: <20070906042115.GA343@spearce.org> <20070906042653.GQ18160@spearce.org> <7vd4wwe2n5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 06:58:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITVvW-0003gi-Q9
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 06:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbXIGE6i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 00:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbXIGE6i
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 00:58:38 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58255 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbXIGE6h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 00:58:37 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1ITVvP-0001iR-I1; Fri, 07 Sep 2007 00:58:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F1DF420FBAE; Fri,  7 Sep 2007 00:58:33 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vd4wwe2n5.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57977>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > "Shawn O. Pearce" <spearce@spearce.org> wrote:
> >> If the user has misconfigured `user.signingkey` in their .git/config
> >> or just doesn't have any secret keys on their keyring and they ask
> >> for a signed tag with `git tag -s` we better make sure the resulting
> >> tag was actually signed by gpg.
> 
> This seems to fail the test depending on the order processes
> happen to be scheduled.  I haven't looked at it closely yet.

That's not good.  I noticed stepping through the code last night
that if gpg is misconfigured (e.g. set a bad user.signingkey in
.git/config) it will terminate and send SIGPIPE to git-tag, which
makes it terminate.

All my change did was implement proper error handling.  So if you
are seeing failures now then we probably have a problem with the
code without my patch too...

-- 
Shawn.
