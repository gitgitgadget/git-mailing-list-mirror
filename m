From: Jeff King <peff@peff.net>
Subject: Re: 'Minimal' diff-algorithm producing a different result than
 'myers', 'patience' and 'histogram' ones
Date: Sun, 24 May 2015 03:33:39 -0400
Message-ID: <20150524073338.GA7197@peff.net>
References: <CAAg4OeLuR9NY1NaEsjqd4hbuLqZuUo7j+BsVvQT37APY_QEYUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dmitry Malikov <malikov.d.y@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 24 09:34:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwQQf-0002qm-8p
	for gcvg-git-2@plane.gmane.org; Sun, 24 May 2015 09:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbbEXHdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2015 03:33:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:35322 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750772AbbEXHdl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2015 03:33:41 -0400
Received: (qmail 12084 invoked by uid 102); 24 May 2015 07:33:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 24 May 2015 02:33:41 -0500
Received: (qmail 31362 invoked by uid 107); 24 May 2015 07:33:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 24 May 2015 03:33:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 May 2015 03:33:39 -0400
Content-Disposition: inline
In-Reply-To: <CAAg4OeLuR9NY1NaEsjqd4hbuLqZuUo7j+BsVvQT37APY_QEYUQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269824>

On Tue, May 12, 2015 at 03:07:46PM +0200, Dmitry Malikov wrote:

> I'm trying to compare 4 different git-diff algorithms and the
> 'minimal' one is the most vague and non-obvious. The documentation
> says "Spend extra time to make sure the smallest possible diff is
> produced." - that's all.
> 
> By any chance, is there any example of diff when 'minimal' algorithm
> produces a different result than a 'myers', 'patience' and 'histogram'
> ones?

I don't know of a simple example offhand, but you can easily generate
all of the patches for a repository with each type by doing:

  for i in myers minimal patience histogram; do
    git log --diff-algorithm=$i -p >$i
  done

In git.git, the output for each type is distinct. You might also find
this thread interesting:

  http://thread.gmane.org/gmane.comp.version-control.git/143426

It mentions 717b83117 from git.git, whose minimal diff is over 300 lines
shorter than the non-minimal one. It's not exactly a simple example, but
I suspect you won't find a short case; "minimal" only matters in the
complicated ones.

-Peff
