From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Wed, 17 Feb 2010 20:38:22 -0500
Message-ID: <20100218013822.GB15870@coredump.intra.peff.net>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <20100213121238.GA2559@progeny.tock>
 <20100213133951.GA14352@Knoppix>
 <201002131539.54142.trast@student.ethz.ch>
 <20100213162924.GA14623@Knoppix>
 <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
 <20100213223733.GP24809@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 02:38:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhvLq-00063l-GS
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 02:38:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756014Ab0BRBi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 20:38:28 -0500
Received: from peff.net ([208.65.91.99]:53867 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755971Ab0BRBiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 20:38:25 -0500
Received: (qmail 23792 invoked by uid 107); 18 Feb 2010 01:38:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 17 Feb 2010 20:38:35 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Feb 2010 20:38:22 -0500
Content-Disposition: inline
In-Reply-To: <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140279>

On Wed, Feb 17, 2010 at 05:16:23PM -0800, Junio C Hamano wrote:

> +	if (paranoid) {
> +		unsigned char stablebuf[262144];

Is 256K a bit big for allocating on the stack? Modern OS's seem to give
us at least a couple of megabytes (my Linux boxen all have 8M, and
even Solaris 8 seems to have that much). But PTHREAD_STACK_MIN is only
16K (I don't think it is possible to hit this code path in a thread
right now, but I'm not sure). And I have no idea what the situation is
on Windows.

I dunno if it is worth worrying about, but maybe somebody more clueful
than me can comment.

-Peff
