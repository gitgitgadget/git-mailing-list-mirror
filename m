From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: Some git performance measurements..
Date: Fri, 7 Dec 2007 16:09:30 +0000
Message-ID: <e2b179460712070809r4127dc0br8dc20f55b1076501@mail.gmail.com>
References: <alpine.LFD.0.9999.0711281747450.8458@woody.linux-foundation.org>
	 <alpine.LFD.0.99999.0711282244190.9605@xanadu.home>
	 <alpine.LFD.0.9999.0711282022470.8458@woody.linux-foundation.org>
	 <alpine.LFD.0.99999.0711291208060.9605@xanadu.home>
	 <finmvm$da8$1@ger.gmane.org>
	 <alpine.LFD.0.9999.0711291812530.8458@woody.linux-foundation.org>
	 <alpine.LFD.0.99999.0711292131350.9605@xanadu.home>
	 <B161871F-E812-44B4-A699-44341B5783D3@zib.de>
	 <e2b179460712070535x2eb10710s75a581664139e0cf@mail.gmail.com>
	 <Pine.LNX.4.64.0712071348100.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Steffen Prohaska" <prohaska@zib.de>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Nicolas Pitre" <nico@cam.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Dec 07 17:10:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0flz-0002L0-KQ
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 17:09:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbXLGQJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 11:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbXLGQJd
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 11:09:33 -0500
Received: from wr-out-0506.google.com ([64.233.184.225]:23866 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbXLGQJc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 11:09:32 -0500
Received: by wr-out-0506.google.com with SMTP id c49so580048wra
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 08:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=YF2L5rmKSRkvY+rNJnWD7itxu3JGZxowahjXDm1mZSo=;
        b=M/3h72o3txsvubnHOPX2ypTJe57tuxgHYX9BVCJ0nat/0nPnUCm+o8vK8ffGL4qBUqG3g8qFQsvrPe/It41suUw+MZtzIg9H+YbljyPWo8ZadZSAXLkMJPlH508+1I0V8Iuidy+jlTnvi46RsYvV2AaTMJHPOkSE0NrqRSUXpGY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L6O/MakCyGOnmWdhvko7If/yS3TEhhXnXM3DPT/WULgiRZag7KCr3DYygyveq1gX0BqscwJnVyEQq0LqYKCeajq0nMc/Uxz/VR0o5QOI5b/GxlO0SWPtfv+Bp/NOM2QbYpv2drUnCOceW52k6sI4Vpv/v5jvcP7hJctud2eFuCw=
Received: by 10.70.18.11 with SMTP id 11mr1186711wxr.1197043770572;
        Fri, 07 Dec 2007 08:09:30 -0800 (PST)
Received: by 10.70.59.11 with HTTP; Fri, 7 Dec 2007 08:09:30 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0712071348100.27959@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67432>

On Dec 7, 2007 1:49 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Fri, 7 Dec 2007, Mike Ralphson wrote:
>
> > I benchmarked 3 alternative qsorts, qsortG [2] was the fastest on my
> > system but has funky licensing, the NetBSD qsort was middle-range and
> > the glibc one the slowest of the three (but that could be due to it
> > being tuned for a "Sun 4/260"). All of them show over 100x speed
> > improvements on a git-status of my main repo (104s -> ~0.7s)
>
> How is "You may use it in anything you like;" funky licensing?  It is
> effectively public domain.

I did ask what the git licensing policy was (GPL2 or GPL2-compatible)
but got no response. The author's wishes state:

 * This code may be reproduced freely provided
 *   - this file is retained unaltered apart from minor
 *     changes for portability and efficiency
 *   - no changes are made to this comment
 *   - any changes that *are* made are clearly flagged
 *   - the _ID string below is altered by inserting, after
 *     the date, the string " altered" followed at your option
 *     by other material. (Exceptions: you may change the name
 *     of the exported routine without changing the ID string.
 *     You may change the values of the macros TRUNC_* and
 *     PIVOT_THRESHOLD without changing the ID string, provided
 *     they remain constants with TRUNC_nonaligned, TRUNC_aligned
 *     and TRUNC_words/WORD_BYTES between 8 and 24, and
 *     PIVOT_THRESHOLD between 32 and 200.)

and they should be respected. "retained unaltered apart from" sounds a
little bit more restrictive than we might like. I haven't pinged him
about relicensing though. [Edit, I see Linus has just made those
points].

> BTW if you need a starting point (easing on your time constraints):
> http://repo.or.cz/w/git/mingw/4msysgit.git?a=commitdiff;h=bba554dd0114dc436cfdd3f17edc836bbaf3d95f

Many thanks, the gmane links I bookmarked are just complaining about
wefts producing no weaves or somesuch, so that's helpful. I'll try the
mergesort and report back.

Cheers, Mike
