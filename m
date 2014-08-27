From: Jeff King <peff@peff.net>
Subject: Re: [RFC] improving advice message from "git commit" during a merge
Date: Wed, 27 Aug 2014 15:18:58 -0400
Message-ID: <20140827191857.GB7561@peff.net>
References: <xmqq4mwxeqr7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 21:19:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMikK-00014F-Tp
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 21:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935501AbaH0TTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 15:19:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:60274 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S935243AbaH0TS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 15:18:59 -0400
Received: (qmail 17998 invoked by uid 102); 27 Aug 2014 19:18:59 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Aug 2014 14:18:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2014 15:18:58 -0400
Content-Disposition: inline
In-Reply-To: <xmqq4mwxeqr7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256025>

On Wed, Aug 27, 2014 at 11:23:08AM -0700, Junio C Hamano wrote:

> When there are unmerged paths, you would often get something like
> this:
> 
>     [git.git (pu|MERGING]$ git commit
>     U       copy.c
>     U       wrapper.c
>     error: commit is not possible because you have unmerged files.
>     hint: Fix them up in the work tree, and then use 'git add/rm <file>'
>     hint: as appropriate to mark resolution and make a commit, or use
>     hint: 'git commit -a'.
>     fatal: Exiting because of an unresolved conflict.
> 
> which is all good and correct, but I am wondering if we can be a bit
> more helpful by customizing the message in various ways.
> 
>  - When all the unmerged paths have their conflicts resolved in the
>    working tree, we do not have to say "Fix them up in the work
>    tree,".  We can instead say "You seem to have fixed them up in
>    the work tree already," or something.

How are you determining what has been resolved? By looking for "<<<<<<<"
markers? That feels a little flaky, but I guess it would probably work
well enough in practice.

If we started using that heuristic, it would probably make sense to
teach "git status" about it (and then maybe just have a failed "commit"
rely on wt_status to produce the output).

> I am not doing this myself soon, though.  Hint, hint...

Me either, though it all seems like a sensible direction to me.

-Peff
