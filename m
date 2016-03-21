From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] git-compat-util: st_add4: work around gcc 4.2.x
 compiler crash
Date: Mon, 21 Mar 2016 00:43:35 -0400
Message-ID: <20160321044335.GA20519@sigill.intra.peff.net>
References: <1458534958-6956-1-git-send-email-sunshine@sunshineco.com>
 <1458534958-6956-2-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Renato Botelho <garga@freebsd.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 05:43:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahrgt-0007qa-M2
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 05:43:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbcCUEnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 00:43:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:35093 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750794AbcCUEni (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 00:43:38 -0400
Received: (qmail 27436 invoked by uid 102); 21 Mar 2016 04:43:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Mar 2016 00:43:38 -0400
Received: (qmail 2093 invoked by uid 107); 21 Mar 2016 04:43:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Mar 2016 00:43:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Mar 2016 00:43:35 -0400
Content-Disposition: inline
In-Reply-To: <1458534958-6956-2-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289400>

On Mon, Mar 21, 2016 at 12:35:57AM -0400, Eric Sunshine wrote:

> Although changes by 5b442c4 (tree-diff: catch integer overflow in
> combine_diff_path allocation, 2016-02-19) are perfectly valid, they
> unfortunately trigger an internal compiler error in gcc 4.2.x:
> 
>     combine-diff.c: In function 'diff_tree_combined':
>     combine-diff.c:1391: internal compiler error: Segmentation fault: 11
> 
> Experimentation reveals that changing st_add4()'s argument evaluation
> order is sufficient to sidestep this problem.
> 
> Although st_add3() does not trigger the compiler bug, for style
> consistency, change its argument evaluation order to match.
> 
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  git-compat-util.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks for digging into this, the result is a really pleasant solution.
I think it's worth doing.

-Peff
