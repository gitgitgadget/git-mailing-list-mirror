From: Jeff King <peff@peff.net>
Subject: Re: Getting a list of commits between 2 points without upstream
 changes
Date: Sun, 17 Jul 2011 20:17:49 -0400
Message-ID: <20110718001749.GA706@sigill.intra.peff.net>
References: <CAFOYHZC5hQ9JV8a5d20AaPR_eYFDViama+4148MPumvvJ-n6wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 02:22:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QibbV-0005gL-8k
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 02:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755987Ab1GRARx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jul 2011 20:17:53 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48433
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755477Ab1GRARw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2011 20:17:52 -0400
Received: (qmail 16185 invoked by uid 107); 18 Jul 2011 00:18:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Jul 2011 20:18:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Jul 2011 20:17:49 -0400
Content-Disposition: inline
In-Reply-To: <CAFOYHZC5hQ9JV8a5d20AaPR_eYFDViama+4148MPumvvJ-n6wQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177327>

On Mon, Jul 18, 2011 at 11:49:57AM +1200, Chris Packham wrote:

> I'm trying to send round an incremental changelog for my project which
> contains just my changes without changes that have been made upstream.
> The history look something like this.
> 
> ---o--o--o--o--o--o--o--o-- upstream
>     \          \        \
>      \-m--A--m--B--m--C--D-- topic
> 
> What I want is a changelog with just B, C and D in it (i.e. no merge
> commits and no commits already in upstream). I know if I wanted A,B,C
> and D I could just do 'git log --no-merges upstream..topic'. If I do
> 'git log --no-merges B..topic' I get the merged commits from upstream.
> In set-speak what I think want is the union of upstream..topic and
> B..topic.

I'm not clear on what makes "B" more special than "A" in the graph
above. But assuming you know A, don't you just want:

  git log --no-merges topic ^upstream ^A

? That is, "everything in topic, but not in upstream, nor in the parent
of A". Or if you know A and not B, you can use "^B^!" (which means "do
not include commits that are in any parent of B").

-Peff
