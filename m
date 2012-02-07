From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] tag: add --points-at list option
Date: Tue, 7 Feb 2012 14:36:33 -0500
Message-ID: <20120207193632.GC32367@sigill.intra.peff.net>
References: <20120206081119.GA3939@sigill.intra.peff.net>
 <1328598076-7773-2-git-send-email-tmgrennan@gmail.com>
 <20120207160527.GC14773@sigill.intra.peff.net>
 <20120207190228.GB6264@tgrennan-laptop>
 <20120207191202.GA496@sigill.intra.peff.net>
 <20120207192135.GC6264@tgrennan-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, jasampler@gmail.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 20:36:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuqqM-0003u9-9c
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 20:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756098Ab2BGTgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 14:36:36 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59383
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755976Ab2BGTgf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 14:36:35 -0500
Received: (qmail 10776 invoked by uid 107); 7 Feb 2012 19:43:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Feb 2012 14:43:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Feb 2012 14:36:33 -0500
Content-Disposition: inline
In-Reply-To: <20120207192135.GC6264@tgrennan-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190204>

On Tue, Feb 07, 2012 at 11:22:50AM -0800, Tom Grennan wrote:

> >> Thanks, but I now realize that I also need to save the pointed at
> >> refname to detect lightweight tags that have matching sha's but
> >> different names.
> >
> >I'm not sure I understand. Wouldn't you match lightweight tags by the
> >sha1 they point at? Something like:
> 
> I think the following would show the pointed at tag too.
>   $ git tag my-v1.7.9 v1.7.9
>   $ ./git-tag -l --points-at v1.7.9
>   my-v1.7.9
>   v1.7.9
> 
> vs.
> 
>   $ ./git-tag -l --points-at v1.7.9
>   my-v1.7.9
> 
> I found that I had to filter matching refnames.

Ah, so you are trying _not_ to show lightweight tags (I thought you
meant you also wanted to show them)? But I still don't see why the code
I posted before wouldn't work in that case. The "object" field of v1.7.9
is not the sha1 of the v1.7.9 tag object, but rather some commit, so it
would not match.

Maybe I don't understand what you mean.  Can you show a test case that
is buggy with the v2 version of the patch that you sent? I'm not sure in
the example above what is different between the two "git-tag"
invocations.

-Peff
