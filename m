From: Jeff King <peff@peff.net>
Subject: Re: Automatically identifying the "split" point of a merged branch.
Date: Sat, 30 Jul 2011 23:53:10 -0600
Message-ID: <20110731055310.GA14384@sigill.intra.peff.net>
References: <CAOTq_ptov+6ixvyVvK3iuDp4L-=9PtKES14O93kL9n6hUz0JHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Conrad Irwin <conrad.irwin@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 31 07:53:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnOxk-0001iT-5A
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 07:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259Ab1GaFxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 01:53:15 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59253
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751497Ab1GaFxO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 01:53:14 -0400
Received: (qmail 6091 invoked by uid 107); 31 Jul 2011 05:53:45 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 31 Jul 2011 01:53:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Jul 2011 23:53:10 -0600
Content-Disposition: inline
In-Reply-To: <CAOTq_ptov+6ixvyVvK3iuDp4L-=9PtKES14O93kL9n6hUz0JHA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178228>

On Sat, Jul 30, 2011 at 05:54:59PM -0700, Conrad Irwin wrote:

> I wanted to introduce this branch onto master to end up with:
> 
> A-o-o-o-o-o-o-o-o-o-E-----------N (master)
>  \                   \         /
>   \                   C'-o-o-D' (topic-rebased)
>    \
>     o-o-B-o-o-o-o-M-o-o(integration)
>          \       /
>           C-o-o-D (topic)
> 
> (ASCII art reproduced at http://dpaste.org/GUmM/ lest it be munged)
> 
> While it's easy to create comit N once I have commit D' (with git
> merge --no-ff), I found that it's not at all easy to work out where
> commit B is in order to do do a rebase --onto master B.

If you know M, then B is the merge-base of M^1 and M^2 (i.e., the
parents of M). If you don't know M, but do know D, you can find it by
walking backwards from "integration" until you find a merge commit with
D as its second parent (e.g., by grepping "rev-list --parents").

Make sense?

-Peff
