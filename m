From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 08/21] remote: let guess_remote_head() optionally
	return all matches
Date: Thu, 26 Feb 2009 09:40:52 -0500
Message-ID: <20090226144052.GB9693@coredump.intra.peff.net>
References: <cover.1235546707.git.jaysoffian@gmail.com> <ad3c408c208c8a829b1e4a0c0818e808b19e1dfc.1235546708.git.jaysoffian@gmail.com> <20090226143729.GA9693@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 15:42:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LchRQ-0007Yd-Tj
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 15:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429AbZBZOk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 09:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754378AbZBZOk4
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 09:40:56 -0500
Received: from peff.net ([208.65.91.99]:41422 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754301AbZBZOkz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 09:40:55 -0500
Received: (qmail 5193 invoked by uid 107); 26 Feb 2009 14:41:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 26 Feb 2009 09:41:19 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Feb 2009 09:40:52 -0500
Content-Disposition: inline
In-Reply-To: <20090226143729.GA9693@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111565>

On Thu, Feb 26, 2009 at 09:37:29AM -0500, Jeff King wrote:

> Hmm. This should probably be:
> 
>   dst->peer_ref = src->peer_ref ? copy_ref(src->peer_ref) : NULL;
> 
> (or copy_ref should return NULL when given NULL). I also wonder if the
> copied ref's peer_ref should be explicitly NULL'd.

BTW, all of my "probably" and "I wonder" here are because I think the
"peer ref" pointer is a little vague as a concept. E.g., I think in most
cases src->peer_ref->peer_ref != src.

Rather than having ref structs with "next" and "peer" pointers, I think
a more natural data structure would be a list (or array) of "ref pairs".

But you didn't create that with this series, and I don't think it is
worth the major surgery to change it now.

-Peff
