From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] git status: refresh the index
Date: Fri, 2 Apr 2010 12:57:59 -0400
Message-ID: <20100402165759.GB18576@coredump.intra.peff.net>
References: <1270211241-10795-1-git-send-email-markus.heidelberg@web.de>
 <1270211241-10795-5-git-send-email-markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 02 18:58:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxkCH-0002XZ-8O
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 18:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754961Ab0DBQ6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 12:58:13 -0400
Received: from peff.net ([208.65.91.99]:41292 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754615Ab0DBQ6M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 12:58:12 -0400
Received: (qmail 16030 invoked by uid 107); 2 Apr 2010 16:58:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 02 Apr 2010 12:58:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Apr 2010 12:57:59 -0400
Content-Disposition: inline
In-Reply-To: <1270211241-10795-5-git-send-email-markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143827>

On Fri, Apr 02, 2010 at 02:27:21PM +0200, Markus Heidelberg wrote:

> +	fd = hold_locked_index(&index_lock, 1);
> +	if (write_cache(fd, active_cache, active_nr) ||
> +	    commit_locked_index(&index_lock))
> +		die("unable to write new_index file");

Does this mean we will fail to run in a read-only repository? I think
that status, like diff, should refresh the index on disk if it _can_,
but as that refresh is a side effect of the main purpose (which is to
output information), it should not be fatal if it cannot do so.

-Peff
