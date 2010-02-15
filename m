From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] Refactoring: remove duplicated code from
 transport.c and builtin-send-pack.c
Date: Mon, 15 Feb 2010 00:28:53 -0500
Message-ID: <20100215052853.GJ3336@coredump.intra.peff.net>
References: <1266182863-5048-1-git-send-email-michael.lukashov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Michael Lukashov <michael.lukashov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 06:28:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgtVv-00013A-Vl
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 06:28:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592Ab0BOF2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 00:28:49 -0500
Received: from peff.net ([208.65.91.99]:34663 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752506Ab0BOF2s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 00:28:48 -0500
Received: (qmail 14684 invoked by uid 107); 15 Feb 2010 05:28:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 15 Feb 2010 00:28:59 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2010 00:28:53 -0500
Content-Disposition: inline
In-Reply-To: <1266182863-5048-1-git-send-email-michael.lukashov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139980>

On Sun, Feb 14, 2010 at 09:27:40PM +0000, Michael Lukashov wrote:

> The following functions are duplicated:
> 
>   verify_remote_names
>   update_tracking_ref
>   print_ref_status
>   status_abbrev
>   print_ok_ref_status
>   print_one_push_status
>   refs_pushed
>   print_push_status
> 
> Signed-off-by: Michael Lukashov <michael.lukashov@gmail.com>
> ---
>  builtin-send-pack.c |   89 ++++++++++++++----------
>  send-pack.h         |   20 +++++
>  transport.c         |  196 ---------------------------------------------------

I think this is backwards. The versions in send-pack were there first,
and then were ported to transport.c so that other transports could
benefit from them. And that is where they should ultimately be.

I can't remember the exact details of why the originals were not
removed, though (I think I complained about it once before, and there
was some technical reason, but I don't recall now). Daniel (cc'd) might
remember more.

-Peff
