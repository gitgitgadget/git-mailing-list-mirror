From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/10] pack-revindex: radix-sort the revindex
Date: Wed, 10 Jul 2013 08:00:29 -0400
Message-ID: <20130710120029.GA20519@sigill.intra.peff.net>
References: <20130710113447.GA20113@sigill.intra.peff.net>
 <20130710115557.GJ21963@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 10 14:00:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwt4Y-00077i-8y
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 14:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069Ab3GJMAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 08:00:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:47954 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753256Ab3GJMAe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 08:00:34 -0400
Received: (qmail 26266 invoked by uid 102); 10 Jul 2013 12:01:50 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Jul 2013 07:01:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jul 2013 08:00:29 -0400
Content-Disposition: inline
In-Reply-To: <20130710115557.GJ21963@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230053>

On Wed, Jul 10, 2013 at 07:55:57AM -0400, Jeff King wrote:

>   5. We use memcpy instead of an open-coded loop to copy the whole array
>      at the end. The individual bucket-assignment is still done by
>      struct assignment. I haven't timed if memcpy would make a
>      difference there.

I just timed this, and I can't measure any difference. I think the
struct assignment is the more readable option, and I do not think any
compilers should have trouble with it. But if they do, we can switch it
for a memcpy.

-Peff
