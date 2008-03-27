From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] add--interactive: ignore mode change in 'p'atch
	command
Date: Thu, 27 Mar 2008 13:10:23 -0400
Message-ID: <20080327171022.GA27189@coredump.intra.peff.net>
References: <cover.1206602393.git.peff@peff.net> <20080327073043.GB22444@coredump.intra.peff.net> <7v7ifob0et.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	=?utf-8?B?SsO2cmc=?= Sommer <joerg@alea.gnuu.de>,
	Wincent Colaiuta <win@wincent.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 18:11:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jevd7-00036h-BU
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 18:11:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756918AbYC0RK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 13:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756335AbYC0RK1
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 13:10:27 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3187 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755503AbYC0RK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 13:10:26 -0400
Received: (qmail 20143 invoked by uid 111); 27 Mar 2008 17:10:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 27 Mar 2008 13:10:24 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Mar 2008 13:10:23 -0400
Content-Disposition: inline
In-Reply-To: <7v7ifob0et.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78356>

On Thu, Mar 27, 2008 at 09:24:10AM -0700, Junio C Hamano wrote:

>     similarity index 90%
>     rename from gostak
>     rename to doshes
>     Stage the name change [y/n/a/d/j/J/?]?

I hadn't thought about renames. But I wonder if it really makes sense in
the context of a single path. If I have content in "doshes", what does
it matter at this point that it came from "gostak"? IOW, what does
saying 'y' here really do? What is the workflow around it?

> By the way, why was it done as a new sub called from parse_diff() and not
> as a part of parse_diff() itself?

Code clarity.

The parsing code seemed less convoluted to me that way. parse_diff is
about linearly splitting the input into hunks. The first hunk just
happens to be "everything before the first patch hunk".

But splitting head versus mode requires non-linear parsing. Doing it in
parse_diff would require adding some state to the loop. It seemed
more readable to me to compose it from two simple loops rather than one
more complex loop.

I can do it the other way if you prefer.

-Peff
