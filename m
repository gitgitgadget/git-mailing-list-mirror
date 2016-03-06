From: Jeff King <peff@peff.net>
Subject: Re: Fsck configurations and cloning.
Date: Sun, 6 Mar 2016 11:00:23 -0500
Message-ID: <20160306160022.GA20010@sigill.intra.peff.net>
References: <CAGbFckZNpy=2P8kpSsEpCeTFmgzE5MEK7fnS8xJzDSPJs3iJdQ@mail.gmail.com>
 <20160306115850.GA985@sigill.intra.peff.net>
 <CAGbFckYi1-b1NTaiQ8q1Ny_2+2rZFGMz+R-xgfRo1u5P-LKDwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git mailing list <git@vger.kernel.org>
To: Ryne Everett <ryneeverett@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 06 17:00:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acb6c-0004Gu-RH
	for gcvg-git-2@plane.gmane.org; Sun, 06 Mar 2016 17:00:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbcCFQA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 11:00:27 -0500
Received: from cloud.peff.net ([50.56.180.127]:55459 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751557AbcCFQA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 11:00:26 -0500
Received: (qmail 30893 invoked by uid 102); 6 Mar 2016 16:00:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 06 Mar 2016 11:00:25 -0500
Received: (qmail 19454 invoked by uid 107); 6 Mar 2016 16:00:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 06 Mar 2016 11:00:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Mar 2016 11:00:23 -0500
Content-Disposition: inline
In-Reply-To: <CAGbFckYi1-b1NTaiQ8q1Ny_2+2rZFGMz+R-xgfRo1u5P-LKDwg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288363>

On Sun, Mar 06, 2016 at 10:38:15AM -0500, Ryne Everett wrote:

> > I think there are two problems here.
> >
> > The first is that fsck.skiplist takes a filename that contains a list of
> > sha1s, not the sha1s themselves. So it would be more like:
> >
> >   echo 5e6ecdad9f69b1ff789a17733b8edc6fd7091bd8 >skiplist
> >   git -c fsck.skiplist="$(pwd)/skiplist" clone ...
> 
> I think I got this one right. Note the use of `cat` in my original post:
> 
>   $ cat $(git config --get fsck.skiplist)
>     5e6ecdad9f69b1ff789a17733b8edc6fd7091bd8

Oh, indeed, I missed that completely.

> > The second is is that only "fsck" and "receive-pack" seem to have
> > learned about skiplist and other per-error config. There is no matching
> > fetch.fsck.* config to cover fetches.
> 
> Ah, well that sounds like the answer -- my original assumption was wrong.

Yeah. I was kind of surprised to find this was the case, given that we
_do_ have fetch.fsckObjects.

-Peff
