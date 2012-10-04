From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: git pull takes ~8 seconds on up-to-date Linux git tree
Date: Thu, 4 Oct 2012 21:26:21 +0200
Message-ID: <20121004192621.GA244@x4>
References: <20121004141454.GA246@x4>
 <20121004184314.GA15389@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:44:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtgP-00033L-7d
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756187Ab2JDT0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 15:26:24 -0400
Received: from ud10.udmedia.de ([194.117.254.50]:39011 "EHLO
	mail.ud10.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756105Ab2JDT0X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 15:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=mail.ud10.udmedia.de; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=beta; bh=XKcYF6IzRZM1+PRr1vs4cweNkW
	JY3J529jLy+HfM5i0=; b=cm6fCyq+IYb7H60uW7T9zMLwoKLf95td/vTWS8+31K
	rdiEifuFGNbkoddJcHp8QroSpJF+7U5UItWIr3zMtkgwZznB78TmN3+SKTZjaGTh
	oupq6SXRiRdDQQIgkHjedKJFqnO5wWOC4ZDFGih9M4lAcYwLXlFRmO1FiiDJU7RF
	E=
Received: (qmail 12804 invoked from network); 4 Oct 2012 21:26:21 +0200
Received: from unknown (HELO x4) (ud10?360p3@91.65.91.246)
  by mail.ud10.udmedia.de with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 4 Oct 2012 21:26:21 +0200
Content-Disposition: inline
In-Reply-To: <20121004184314.GA15389@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207022>

On 2012.10.04 at 14:43 -0400, Jeff King wrote:
> On Thu, Oct 04, 2012 at 04:14:54PM +0200, Markus Trippelsdorf wrote:
> 
> > with current trunk I get the following on an up-to-date Linux tree:
> > 
> > markus@x4 linux % time git pull
> > Already up-to-date.
> > git pull  7.84s user 0.26s system 92% cpu 8.743 total
> > 
> > git version 1.7.12 is much quicker:
> > 
> > markus@x4 linux % time git pull
> > Already up-to-date.
> > git pull  0.10s user 0.02s system 16% cpu 0.740 total
> 
> Yikes. I can easily reproduce here. Bisecting between master and
> v1.7.12 gives a curious result: the slowdown first occurs with the merge
> commit 34f5130 (Merge branch 'jc/merge-bases', 2012-09-11). But neither
> of its parents is slow. I don't see anything obviously suspect in the
> merge, though.

Actually commit f37d3c75 is responsible for this. When I revert it, the
problem goes away.

-- 
Markus
