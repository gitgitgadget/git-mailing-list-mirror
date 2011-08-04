From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] cache patch ids on disk
Date: Thu, 4 Aug 2011 16:52:27 -0600
Message-ID: <20110804225227.GA28241@sigill.intra.peff.net>
References: <20110804224848.GA27545@sigill.intra.peff.net>
 <20110804224947.GB28215@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 05 00:52:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qp6mK-0001iw-Bj
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 00:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526Ab1HDWwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 18:52:32 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48166
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753288Ab1HDWwa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 18:52:30 -0400
Received: (qmail 23703 invoked by uid 107); 4 Aug 2011 22:53:04 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Aug 2011 18:53:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Aug 2011 16:52:27 -0600
Content-Disposition: inline
In-Reply-To: <20110804224947.GB28215@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178777>

On Thu, Aug 04, 2011 at 04:49:47PM -0600, Jeff King wrote:

> +struct sha1 {
> +	unsigned char v[20];
> +};
> +
> [...]
> +DECLARE_MAP(object_sha1, const struct object *, struct sha1)

I'm not altogether happy with this. But the generated code wants to
treat the value type as something that can be instantiated as "vtype
foo", so we need to wrap a struct around an array to make the compiler
happy.

We could do something a little fancier to avoid this, like separating
"this is what it looks like to declare a value" from "this is what a
passed value looks like". And then use "unsigned char v[20]" for the
former and "unsigned char *" for the latter.

-Peff
