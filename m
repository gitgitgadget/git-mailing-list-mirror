From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 12/13] remote.c: refactor get_remote_ref_states()
Date: Mon, 23 Feb 2009 01:50:48 -0500
Message-ID: <20090223065048.GC24517@coredump.intra.peff.net>
References: <cover.1235368324.git.jaysoffian@gmail.com> <885507eaf920f6b60727db7e712da3560a7fd4c5.1235368324.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 07:53:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbUgq-0002SA-8S
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 07:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbZBWGuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 01:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbZBWGuv
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 01:50:51 -0500
Received: from peff.net ([208.65.91.99]:40996 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525AbZBWGuu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 01:50:50 -0500
Received: (qmail 21003 invoked by uid 107); 23 Feb 2009 06:51:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 23 Feb 2009 01:51:13 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Feb 2009 01:50:48 -0500
Content-Disposition: inline
In-Reply-To: <885507eaf920f6b60727db7e712da3560a7fd4c5.1235368324.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111106>

On Mon, Feb 23, 2009 at 01:29:00AM -0500, Jay Soffian wrote:

> get_remote_ref_states() has three callers, but each is interested in
> slightly different information. Give it a bit-field flag so that callers
> can specify which pieces of information they need.

Hmph. I think this is probably an indication that
get_remote_ref_states() should really be 3 functions:

  common_stuff();
  query_one();
  query_two();

and then callers can choose the subset they are interested in.

Which is really more or less equivalent; it just seems like extra
obfuscation to have a single function with a bit-field.

-Peff
