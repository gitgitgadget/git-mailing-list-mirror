From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 09/13] refactor duplicated ref_newer() to remote.c
Date: Mon, 23 Feb 2009 01:45:10 -0500
Message-ID: <20090223064510.GA24517@coredump.intra.peff.net>
References: <cover.1235368324.git.jaysoffian@gmail.com> <7f19e98ccc330d4094ffbb55ea06c35b91da9e55.1235368324.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 07:46:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbUaR-0001Fk-9b
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 07:46:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbZBWGpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 01:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbZBWGpO
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 01:45:14 -0500
Received: from peff.net ([208.65.91.99]:59877 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525AbZBWGpN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 01:45:13 -0500
Received: (qmail 20952 invoked by uid 107); 23 Feb 2009 06:45:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 23 Feb 2009 01:45:36 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Feb 2009 01:45:10 -0500
Content-Disposition: inline
In-Reply-To: <7f19e98ccc330d4094ffbb55ea06c35b91da9e55.1235368324.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111104>

On Mon, Feb 23, 2009 at 01:28:57AM -0500, Jay Soffian wrote:

> ref_newer() appears to have been copied from builtin-send-pack.c to
> http-push.c via cut and paste. This patch moves the function and its
> helper unmark_and_free() to remote.c.
> 
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---
> Hmm, I just noticed that the version in builtin-send-pack.c uses 1
> whereas http-push.c uses TMP_MARK as the mark argument. I used the
> version from builtin-send-pack.c. I don't know if this is signfificant.

I think the TMP_MARK one is probably better. At the very least, the
send-pack one should be using SEEN instead of a bare '1'. But given that
it is not part of the usual revision machinery, it seems like that was
what TMP_MARK was designed for.

-Peff
