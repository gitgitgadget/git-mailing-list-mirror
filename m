From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Aug 2014, #01; Fri, 1)
Date: Wed, 6 Aug 2014 04:11:02 -0400
Message-ID: <20140806081102.GA1646@peff.net>
References: <xmqqy4v7uax0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 10:11:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEwJZ-0005zD-Mj
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 10:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755740AbaHFILL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 04:11:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:46867 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755737AbaHFILJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 04:11:09 -0400
Received: (qmail 8390 invoked by uid 102); 6 Aug 2014 08:11:09 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Aug 2014 03:11:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Aug 2014 04:11:02 -0400
Content-Disposition: inline
In-Reply-To: <xmqqy4v7uax0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254849>

On Fri, Aug 01, 2014 at 03:01:31PM -0700, Junio C Hamano wrote:

> * jk/stash-list-p (2014-07-30) 7 commits
>  - SQUASH??? future-proof, log --cc should imply -p without being told
>  - stash: show combined diff with "stash show"
>  - stash: default listing to "--cc --simplify-combined-diff"
>  - add --simplify-combined-diff option
>  - pretty: make empty userformats truly empty
>  - pretty: treat "--format=" as an empty userformat
>  - revision: drop useless string offset when parsing "--pretty"
> 
>  Teach "git stash list -p" to DWIM to "git stash list -p --cc", with
>  even nicer twist to collapse combined diff from identical two
>  parents into a regular diff.

What do you want to do with this topic?

I think we want to drop the "stash show" patch, based on the discussion
we had.  The first three patches are nominally prep for that final
patch, but actually are things I've often wanted over the years. I'd be
glad if they made it in separately, but there were some compatibility
questions.

As clever as I find the --simplify-combined-diff patch, I think we came
to the conclusion that "--first-parent" is probably the reasonable
choice. It matches "stash show", and it's simple and obvious. Do we just
want a patch to specify "--first-parent" to stash-log? That would make
"-p" just work. The only downside is that there isn't a good way to turn
it off. Is it enough to say "if you want to do something clever, use
git-log"?

Or do we want to scrap the whole thing and try to update the
documentation to make it more clear why "-p" by itself doesn't do
anything?

-Peff
