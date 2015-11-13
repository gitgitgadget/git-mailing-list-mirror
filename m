From: Jeff King <peff@peff.net>
Subject: Re: Re: git log --merges doesn't show commits as expected
Date: Fri, 13 Nov 2015 18:32:39 -0500
Message-ID: <20151113233239.GC16173@sigill.intra.peff.net>
References: <AMSPR02MB168F9B2126871F4702CBA5483110@AMSPR02MB168.eurprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Dominik Rauch <dominik.rauch@gmx.at>
X-From: git-owner@vger.kernel.org Sat Nov 14 00:33:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxNqD-0008FU-Qd
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 00:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbbKMXcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 18:32:42 -0500
Received: from cloud.peff.net ([50.56.180.127]:57328 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750813AbbKMXcl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 18:32:41 -0500
Received: (qmail 17439 invoked by uid 102); 13 Nov 2015 23:32:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 17:32:41 -0600
Received: (qmail 29804 invoked by uid 107); 13 Nov 2015 23:33:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 18:33:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Nov 2015 18:32:39 -0500
Content-Disposition: inline
In-Reply-To: <AMSPR02MB168F9B2126871F4702CBA5483110@AMSPR02MB168.eurprd02.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281273>

On Fri, Nov 13, 2015 at 11:10:44PM +0000, Dominik Rauch wrote:

> However, I don't think the default simplification algorithm is a good
> default when used in combination with "--merges". "git log --merges
> file" looks very natural if I want to answer the question "When has
> file been merged into my master/develop/whatsoever branch?" and it
> just doesn't work. Is there a simpler way to answer that question?

I would generally use --first-parent to just walk down the commits that
first-appeared on the master branch. You don't really need --merges
then; you see all direct changes on the branch, and if you have a topic
branch workflow, you'll essentially only see merges anyway.

> What is the primary use of "--merges" if not combined with
> "--full-history" or at least "--first-parent"?

Using "--merges" is orthogonal to --full-history. You might not even be
simplifying history at all (the reason we do simplification in your
example is because of the "foo" pathspec you provide).

I don't use --merges by itself very much (I use --no-merges much more
often).

> What do you think about implying "--full-history" when using "--merges"?

I haven't thought hard about it, but my first instinct is that we should
not. Even if they are _mostly_ used together, they are orthogonal
concepts, and we'd be breaking backwards compatibility.

-Peff
