From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: Re: [PATCH] combine-diff: use textconv for combined diff format
Date: Thu, 21 Apr 2011 18:08:05 +0200
Message-ID: <201104211808.06400.kumbayo84@arcor.de>
References: <20110414213006.GA7709@sigill.intra.peff.net> <36a715a966a22207135f60532e723f6d87dd1ffb.1302881295.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Apr 21 19:23:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCxb1-0000vY-Fy
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 19:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755191Ab1DURXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2011 13:23:09 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:46196 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755104Ab1DURXH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2011 13:23:07 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mx.arcor.de (Postfix) with ESMTP id 73E123034B;
	Thu, 21 Apr 2011 19:23:05 +0200 (CEST)
Received: from mail-in-14.arcor-online.net (mail-in-14.arcor-online.net [151.189.21.54])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id 5EA8FCE;
	Thu, 21 Apr 2011 19:23:05 +0200 (CEST)
Received: from soybean.localnet (178-190-20-49.adsl.highway.telekom.at [178.190.20.49])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-14.arcor-online.net (Postfix) with ESMTPSA id 3984C9C989;
	Thu, 21 Apr 2011 19:23:05 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-14.arcor-online.net 3984C9C989
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1303406585; bh=hB/1ed0qmL1UOpE+0omNj+Zb6OPhtcFPxyHC7xwmZ/Y=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id;
	b=DhEddbwgkUUcq0aYRBH6qEYd6BCGS1WAFbwoFJfj19UNFoBzxA1fQmWZTY4HOd1Nt
	 wcLBOdgRjpqulsGFBrgykC72G/sBQfx0PgrI3BJq07JteobzgxAy+5NGM1kcv0Ny89
	 3Ykxnfr4QXEMXstCrwj54PYJzyqsrQYMLY1/tApw=
User-Agent: KMail/1.13.5 (Linux/2.6.35-28-generic-pae; KDE/4.5.1; i686; ; )
In-Reply-To: <36a715a966a22207135f60532e723f6d87dd1ffb.1302881295.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171909>

On Freitag, 15. April 2011, Michael J Gruber wrote:
> Currently, we ignore textconv and binary status for the combined diff
> formats (-c, -cc) which was never intended.
> 
> Change this so that combined diff uses the same helpers.
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> So, just so that I don't get the vapor patch award, here's a WIP passing
> Jeff's test.
> 
> Before looking at free()ing what I've introduced and the binary issue I'll
> check whether the whole blob/file read hunk in show_patch_diff() can't be
> simply subsumed in the fill_textconv() call. It is almost a copy of
> diff_populate_filespec() but not quite.
> 
> Also, the situation with worktree is even worse than I thought:
> 
> git diff -m produces a combined diff!
> 
> Also, my patch does not cure "diff -c" against worktree so far, I'm not
> textconv'ing the worktree file yet. But then again, "diff -m" sucks here also.
> 
> I'll probably pick this up later today.

Hi,

thanks for working on this.
I tried this patch on my msysgit system and now gitk shows a nice diff
for my merged archives. :-)
For merges of other binary files without textconf filter (jar)
i still get binary output.
(but i expected this from the notes above/discussion)

thanks,
Greetings Peter
