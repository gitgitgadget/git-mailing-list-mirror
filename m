From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Bump core.deltaBaseCacheLimit to 128MiB
Date: Thu, 20 Mar 2014 19:48:59 -0400
Message-ID: <20140320234859.GD7774@sigill.intra.peff.net>
References: <1395232712-6412-1-git-send-email-dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 00:49:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQmhu-0006nz-Eo
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 00:49:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759673AbaCTXtB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 19:49:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:43631 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751671AbaCTXtB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 19:49:01 -0400
Received: (qmail 29561 invoked by uid 102); 20 Mar 2014 23:49:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Mar 2014 18:49:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Mar 2014 19:48:59 -0400
Content-Disposition: inline
In-Reply-To: <1395232712-6412-1-git-send-email-dak@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244620>

On Wed, Mar 19, 2014 at 01:38:32PM +0100, David Kastrup wrote:

> The default of 16MiB causes serious thrashing for large delta chains
> combined with large files.

Does it make much sense to bump this without also bumping
MAX_DELTA_CACHE in sha1_file.c? In my measurements of linux.git, bumping
the memory limit did not help much without also bumping the number of
slots.

I guess that just bumping the memory limit would help with repos which
have deltas on large-ish files (whereas the kernel just has a lot of
deltas on a lot of little directories), but I'd be curious how much.

If you have before-and-after numbers for just this patch on some
repository, that would be an interesting thing to put in the commit
message.

-Peff
