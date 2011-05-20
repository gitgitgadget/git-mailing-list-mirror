From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] basic priority queue implementation
Date: Fri, 20 May 2011 03:38:21 -0400
Message-ID: <20110520073821.GA3663@sigill.intra.peff.net>
References: <20110519212349.GA28589@sigill.intra.peff.net>
 <20110519212448.GB29584@sigill.intra.peff.net>
 <BANLkTikLSwWanxUksf3Ezx7uhaTR4mMiWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 20 09:38:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNKI1-0001LV-5d
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 09:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489Ab1ETHiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 03:38:24 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55353
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932097Ab1ETHiX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 03:38:23 -0400
Received: (qmail 26276 invoked by uid 107); 20 May 2011 07:40:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 20 May 2011 03:40:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 May 2011 03:38:21 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikLSwWanxUksf3Ezx7uhaTR4mMiWw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174045>

On Thu, May 19, 2011 at 09:47:38PM -0300, Thiago Farina wrote:

> > +void queue_insert(struct queue *pq, void *item);
> I'd rename this to queue_append as we add |item| to the end of the
> array (like you did for sha1_array_append), opposed of inserting it at
> some position/index.

It's definitely not an append. The data structure is a priority queue,
so the element is inserted within the heap at the proper position
according to the comparison function (notice that we stick at the end,
but then heapify_up).

Speaking of naming, though, the real problem is that this data structure
should be called "pqueue" or something similar to indicate that it is
not a simple FIFO. Unfortunately, the short-and-sweet "pqueue" is taken
by openssl, which pollutes all over the global namespace.

-Peff

PS If you don't mind, please try to trim your quoted text a bit. Finding
your 3-line paragraph amid 200 lines of quoted text was a little
challenging. :)
