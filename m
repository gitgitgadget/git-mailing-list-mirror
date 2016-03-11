From: Jeff King <peff@peff.net>
Subject: Re: Possible bug: --ext-diff ignored with --cc in git log
Date: Fri, 11 Mar 2016 13:58:28 -0500
Message-ID: <20160311185828.GA31750@sigill.intra.peff.net>
References: <E1adi8q-0005NJ-4G@smtp.tt-solutions.com>
 <xmqqlh5qc698.fsf@gitster.mtv.corp.google.com>
 <E1aeCRp-0005Jn-C1@smtp.tt-solutions.com>
 <xmqqziu4anb9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vadim Zeitlin <vz-git@zeitlins.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 19:58:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeSGi-0000KN-SL
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 19:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbcCKS6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 13:58:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:58515 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750733AbcCKS6b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 13:58:31 -0500
Received: (qmail 11411 invoked by uid 102); 11 Mar 2016 18:58:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Mar 2016 13:58:31 -0500
Received: (qmail 5582 invoked by uid 107); 11 Mar 2016 18:58:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Mar 2016 13:58:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Mar 2016 13:58:28 -0500
Content-Disposition: inline
In-Reply-To: <xmqqziu4anb9.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288699>

On Fri, Mar 11, 2016 at 10:20:42AM -0800, Junio C Hamano wrote:

>     diff --cc foo.sln
>     index d7ff46e,6c9aaa1..b829410
>     --- a/foo.sln
>     +++ b/foo.sln
>     @@@ 1,1 @@@
>     - d7ff46ec4a016c6ab7d233b9d4a196ecde623528  - generated file
>      -6c9aaa1ae63a2255a215c1287e38e75fcc5fc5d3  - generated file
>     ++b829410f6da0afc14353b4621d2fdf874181a9f7  - generated file
> 
> which would at least tell you that there was a merge, and if the
> merge took the full contents of the file from one of the commits and
> recorded as the result of the merge, then you wouldn't see them in
> the "--cc" output.
> 
> It happens that the above is fairly easily doable with today's Git
> without any modification.  Here is how.
> [...]

I think an even easier way is:

  git log --cc --raw

I know that is somewhat beside the point you are making, which is how we
should handle "--cc" with ext-diff. But I would much rather have us
show nothing for that case, and let the user turn on "--raw", than to
invent a diff-looking format that does not actually represent the file
contents.

-Peff
