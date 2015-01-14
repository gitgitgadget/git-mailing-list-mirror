From: Jeff King <peff@peff.net>
Subject: Re: commit --amend --author   error
Date: Wed, 14 Jan 2015 07:09:43 -0500
Message-ID: <20150114120943.GA30383@peff.net>
References: <54B4D428.2050300@irisgermanica.com>
 <54B50062.3090209@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Gunnar Wagner <gunnar.wagner@irisgermanica.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jan 14 13:09:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBMlk-0008P7-QL
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 13:09:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbbANMJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 07:09:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:34285 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751706AbbANMJp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 07:09:45 -0500
Received: (qmail 23815 invoked by uid 102); 14 Jan 2015 12:09:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jan 2015 06:09:46 -0600
Received: (qmail 2411 invoked by uid 107); 14 Jan 2015 12:10:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jan 2015 07:10:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jan 2015 07:09:43 -0500
Content-Disposition: inline
In-Reply-To: <54B50062.3090209@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262376>

On Tue, Jan 13, 2015 at 12:24:18PM +0100, Michael J Gruber wrote:

> Gunnar Wagner schrieb am 13.01.2015 um 09:15:
> > I got APGL licensed code from someone else and want to post it on my 
> > github (without taking credit for the work)
> > 
> > tried   git commit --amend --author="Author name, www.website.com" but 
> > got an error message which said something like "original author not found"
> > Can it be that the --amen --author only work if the author is on github 
> > himself?
> > 
> 
> This has nothing to do with github.
> 
> The author has be in the form "authorname <authoremail>". The important
> parts for the format are the <>.

Yes, but the error message is a hint that there is something else going
on. When there are no angle brackets, some DWIM magic kicks in: git
tries to find a matching author by walking the project history from
HEAD. So you can do (in git.git):

  $ git commit --allow-empty -m foo --author=gruber
  [detached HEAD 73ef08b] foo
   Author: Michael J Gruber <git@drmicha.warpmail.net>

Of course that does not work if you do not already have commits from the
person in your repository:

  $ git commit --allow-empty -m foo --author=foobar
  fatal: No existing author found with 'foobar'

-Peff
