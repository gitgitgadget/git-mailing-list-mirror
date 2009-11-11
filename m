From: Jeff King <peff@peff.net>
Subject: Re: Consensus on "Git"
Date: Wed, 11 Nov 2009 04:36:56 -0500
Message-ID: <20091111093656.GB17422@sigill.intra.peff.net>
References: <ee77f5c20911110032r65a60653sfeef34e3de07d17e@mail.gmail.com>
 <7v8wedv3a3.fsf@alter.siamese.dyndns.org>
 <20091111092731.GA17422@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Symonds <dsymonds@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 10:37:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N89dQ-0000YJ-Ei
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 10:37:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755831AbZKKJgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 04:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753372AbZKKJgz
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 04:36:55 -0500
Received: from peff.net ([208.65.91.99]:45968 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753369AbZKKJgw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 04:36:52 -0500
Received: (qmail 11558 invoked by uid 107); 11 Nov 2009 09:40:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 11 Nov 2009 04:40:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Nov 2009 04:36:56 -0500
Content-Disposition: inline
In-Reply-To: <20091111092731.GA17422@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132633>

On Wed, Nov 11, 2009 at 04:27:31AM -0500, Jeff King wrote:

> For a fun (ab)use of blame, you can see who wrote each of David's
> suspect lines with:
> 
>    git grep -n "\bGIT\b" |
>    while IFS=: read file line junk; do
>      git blame -f -L $line,$line $file
>    done |
>    less
> 
> Many of them are variables (e.g., \b gets rid of "_", but we still have
> "-", so GIT-VERSION and such are still there). Many others are the title
> of the "GIT" section of the manpages. But there are some legitimate
> uses, too. Many of them blame to quite a long time ago, though (e.g.,
> Documentation/everyday.txt has two uses by you in 2005).

BTW, here is a much better grep (still a few false positives, but most
lines are meanginful):

   git grep -n -E "(^|[^A-Z_-])GIT($|[^A-Z_-])" |
   grep -v ':GIT$' |
   while IFS=: read file line junk; do
     git blame -f -L $line,$line $file
   done |
   less

You can really see that most of the uses of GIT are ancient. I wonder if
we should downcase the few that are in user-visible error messages. I
will let somebody else spend their time on such a conversion if they
want, though. I've already spent enough on this. :)

-Peff
