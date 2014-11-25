From: Peter Wu <peter@lekensteyn.nl>
Subject: Re: [RFC] [PATCH] remote: add new --fetch option for set-url
Date: Tue, 25 Nov 2014 12:43:36 +0100
Message-ID: <2050939.TNKsWtkNmu@al>
References: <6997784.RuzRO1AFsK@al> <20141125050101.GA20805@peff.net> <CAPc5daWh4hnKsTMpaW-TvCmVDfU+rzCezrAHcLgXDG6RVvzXHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 12:44:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtEXq-0008NY-2A
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 12:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753724AbaKYLoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 06:44:32 -0500
Received: from lekensteyn.nl ([178.21.112.251]:37460 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753631AbaKYLnm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 06:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2014-q3;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From; bh=YUIfY6R0NhUxL9pq6f7r/2KgQscgFOiWw1yh5Sddp+U=;
	b=Uc/nw4dpcovHd/EtVglSICzC1aAoKzyE6x3X1SLR4jYXrYLtKuFPcfuuMorFzACybLF1znspw5gPlBatDbnfTQJCShNqbNqF61NT09UB1Z47eh2VqhD6My9rwRkb17hxf7UmTbCuwFFWRcYx215z+xdecjyJp3+PLplAlKRjg8MeJY5Lg1YWJ+7dglI/lPNLMV5JFAHdqaCm4BTCMkOn5NBJTE6AaC/f/Proy00E8pM8Xjgqi59KzXLZon9DPQMgOcJ7CyPTHVHVKvnEm/f7+sAug/y4ItifPgdDHba+V7Uje4N1thFlMSyh7fo0C1LZ0khfV4MTNNDZueNgN4g8Gg==;
Received: by lekensteyn.nl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <peter@lekensteyn.nl>)
	id 1XtEWv-0000C0-B8; Tue, 25 Nov 2014 12:43:37 +0100
User-Agent: KMail/4.14.3 (Linux/3.17.0-rc4-custom-00168-g7ec62d4; KDE/4.14.3; x86_64; ; )
In-Reply-To: <CAPc5daWh4hnKsTMpaW-TvCmVDfU+rzCezrAHcLgXDG6RVvzXHA@mail.gmail.com>
X-Spam-Score: -0.0 (/)
X-Spam-Status: No, hits=-0.0 required=5.0 tests=NO_RELAYS=-0.001 autolearn=no autolearn_force=no
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260212>

On Monday 24 November 2014 21:19:16 Junio C Hamano wrote:
> On Mon, Nov 24, 2014 at 9:01 PM, Jeff King <peff@peff.net> wrote:
> > We could also stop making push fall back to fetch. But I think people
> > would find that irritating.

The common case is probably having the same fetch and push URL, so I
think that this should not be changed.

> > I dunno. I think there has always been an implicit "subordinate"
> > relationship between fetch and push URLs, with fetch being the "main"
> > one. Maybe that is so ingrained in me at this point that I do not see a
> > problem with the asymmetry.
> 
> I actually do not have problem with asymmetry/subordinate
> relationship myself, but then why are we adding --fetch to
> complement --push in the first place?
> 
> Or perhaps I am misunderstanding the suggested semantics
> of --both. That "subordinate" relationship really means that
> remote.nick.URL is the one that is used for both directions
> when pushURL is not set.
> 
> I misunderstood that --both would add identical value to both
> remote.nick.URL and remote.nick.pushURL, but that would
> break the implicit subordinate relationship. Is the suggested
> semantics of "set-url --both" to first delete remote.nick.pushURL
> if exists and then to set remote.nick.URL?
> 
> If that is what is being proposed, then I think it makes sense.

Yes, your last understanding is correct. For this feature, try to think
as the user who does not know about the configuration implementation.
That is why the --fetch option was proposed, earlier it did not make
sense to me why a --push option exists, but a --fetch option is missing.

Option '--both' will drop the push URL and result in an implicit
fallback to the fetch URL. It becomes slightly more hairy in the
presence of URL sets (using --add and --delete), but I have also tried
to make that act sensibly).
-- 
Kind regards,
Peter
https://lekensteyn.nl
