From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff-tree: do not show the sha1 of the given head with
 --quiet
Date: Thu, 23 Jul 2015 11:08:46 -0700
Message-ID: <20150723180846.GB18686@peff.net>
References: <0000014eb518dc87-a69705c4-31e7-4983-99a8-f780a743aeac-000000@eu-west-1.amazonses.com>
 <xmqqmvyoq6gh.fsf@gitster.dls.corp.google.com>
 <CAHGBnuM5TG6m7Rwd-EZTUXnaDNYomidthmCamCevNECTQCTnmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 20:08:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIKvO-0006Mv-QT
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 20:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128AbbGWSIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 14:08:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:34194 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752899AbbGWSIu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 14:08:50 -0400
Received: (qmail 25046 invoked by uid 102); 23 Jul 2015 18:08:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jul 2015 13:08:49 -0500
Received: (qmail 13867 invoked by uid 107); 23 Jul 2015 18:08:54 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jul 2015 14:08:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jul 2015 11:08:46 -0700
Content-Disposition: inline
In-Reply-To: <CAHGBnuM5TG6m7Rwd-EZTUXnaDNYomidthmCamCevNECTQCTnmA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274517>

On Thu, Jul 23, 2015 at 09:06:01AM +0200, Sebastian Schuberth wrote:

> My use-case (also see [1]) is that I wanted to checked whether some
> given commits change nothing but whitespace. So I did
> 
> if git diff-tree --quiet --ignore-space-change $commit; then
>     echo "$commit only changes whitespace."
> fi
> 
> just to see those SHA1s being printed to the console.
> 
> I probably could instead do
> 
> if git diff-tree --exit-code --ignore-space-change $commit > /dev/null
> 2>&1; then
>     echo "$commit only changes whitespace."
> fi
> 
> but that defeats the purpose of having "--quiet" in the first place.

I have not been following the thread closely, but I do not recall seeing
anyone mention that the reason for the sha1-output is handing
only a single commit-ish to diff-tree is what puts it into its log-like
mode. Actually asking for a two-endpoint tree diff:

  git diff-tree --quiet --ignore-space-change $commit^ $commit

will do what you want.

I know that does not necessarily help the greater issue of "what
diff-tree is doing is confusing", but perhaps that sheds some light at
least on why it is doing what it is doing. :)

-Peff
