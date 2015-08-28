From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/9] fetch: fetch submodules in parallel
Date: Fri, 28 Aug 2015 11:50:50 -0700
Message-ID: <20150828185050.GF8165@google.com>
References: <1440724495-708-1-git-send-email-sbeller@google.com>
 <1440724495-708-8-git-send-email-sbeller@google.com>
 <CAGZ79kbTAVDVmw+MrXvky6tJWZcG97tT_KAxV7S-pKCiNqRp3g@mail.gmail.com>
 <20150828170141.GB8165@google.com>
 <xmqqfv332v84.fsf@gitster.mtv.corp.google.com>
 <20150828182008.GC8165@google.com>
 <xmqqpp271d6v.fsf@gitster.mtv.corp.google.com>
 <20150828183501.GA17222@sigill.intra.peff.net>
 <CAGZ79kZALSJ9oY+6ZwyQ9CPFiV-AAq7c-r9mxw3N+gvsDw8m4A@mail.gmail.com>
 <20150828184405.GA17721@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 28 20:51:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVOjq-0007GX-7d
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 20:50:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbbH1Suy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 14:50:54 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35991 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbbH1Sux (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 14:50:53 -0400
Received: by padhm10 with SMTP id hm10so15145458pad.3
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 11:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NB48bU8C3QQBUmOtdKBxeFD21VSDvILtV1IHi2IXx1E=;
        b=RlXGBVp//ZETR1iH7BlJN6UhFWSc7tbTt5RtEfIBAH+4wWQCk3y7AT7l8G+T4Hor2a
         SyLjGpsHlLt73Cwd/7ZzHODnIxIUQuLyAZd2RFQkf0/RhfVj9rOVkfP8vIOwU3/JCsMM
         g2rRQvLjfYhqX926TAAXjggRFKmbi4DESsHrzo3TVJ4Gx/4LwnTc61UPvFgJ0mazRaxO
         aBFZan/e2dsuj2mD8fzfJMhoZiDv9vHtx7GgY+hyecVJmf69cWfT0tM18SPhBXRPeOvo
         c1bXRYUEfiTSIf6RmWUgGXDFZkv2SZ4RNVGa39zQNs/cpdcGoM4lPks1s1HEpdBM43CI
         ifag==
X-Received: by 10.66.192.162 with SMTP id hh2mr17718899pac.71.1440787852917;
        Fri, 28 Aug 2015 11:50:52 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:d830:475:d6b6:5fa8])
        by smtp.gmail.com with ESMTPSA id fa1sm6499035pbb.35.2015.08.28.11.50.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 28 Aug 2015 11:50:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150828184405.GA17721@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276754>

Jeff King wrote:

> Right, clearly we can't rely on pipe buffers to be large enough here
> (though we _may_ want to rely on tempfiles if we aren't sure that the
> stdout is bounded in a reasonable way).
>
> But what I meant was: the child will only show progress if stderr is a
> tty, but here it is not.

For clone / fetch, we can pass --progress explicitly.

For some reason 'git checkout' doesn't support a --progress option.  I
suppose it should. ;-)

Thanks,
Jonathan
