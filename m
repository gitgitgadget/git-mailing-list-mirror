From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 08/21] remote: let guess_remote_head() optionally
	return all matches
Date: Fri, 27 Feb 2009 06:43:08 -0500
Message-ID: <20090227114308.GA20776@coredump.intra.peff.net>
References: <cover.1235546707.git.jaysoffian@gmail.com> <ad3c408c208c8a829b1e4a0c0818e808b19e1dfc.1235546708.git.jaysoffian@gmail.com> <20090226143729.GA9693@coredump.intra.peff.net> <20090226144052.GB9693@coredump.intra.peff.net> <76718490902261047p6168e875wf29bcca780105d3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 12:44:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld18y-00017q-Gc
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 12:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754654AbZB0LnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 06:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753173AbZB0LnN
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 06:43:13 -0500
Received: from peff.net ([208.65.91.99]:50061 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752779AbZB0LnN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 06:43:13 -0500
Received: (qmail 12204 invoked by uid 107); 27 Feb 2009 11:43:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 27 Feb 2009 06:43:36 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Feb 2009 06:43:08 -0500
Content-Disposition: inline
In-Reply-To: <76718490902261047p6168e875wf29bcca780105d3e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111664>

On Thu, Feb 26, 2009 at 01:47:45PM -0500, Jay Soffian wrote:

> Well, if you wanted to be consistent about things (and I apologize if gmail
> mangles the lines), I'd probably do something like:
> [...]
> Then peer_ref is consistently a copy, so we can free it consistently, we don't
> need two separate copy functions, and copy_ref returns NULL upon receiving
> NULL like most of the other foo_ref functions.

Good point. That is much cleaner, IMHO, and probably worth doing as part
of this series. Though I hesitate to make you reroll _again_ for such a
small cleanup. Maybe it is worth just putting on top.

> > Rather than having ref structs with "next" and "peer" pointers, I think
> > a more natural data structure would be a list (or array) of "ref pairs".
> 
> Actually, we don't need most of the fields in the peer_ref, so we could
> probably just embed the extra fields that we need in a peer_struct inside the
> ref struct. I can add this to my git todo list.

Sure, that might turn out cleaner (though you may run into problems
where you want to pass a "struct ref" to a helper function but you have
only the fake "peer_struct").

But while that cleanup might be nice, I don't think it is probably worth
the pain, assuming you are done messing with remotes for a little while,
now.

-Peff
