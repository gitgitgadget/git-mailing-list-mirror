From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] clone: have progress report mention top level dir,
 not git dir
Date: Sun, 9 May 2010 07:02:21 -0400
Message-ID: <20100509110221.GA16639@coredump.intra.peff.net>
References: <4BE60E89.8010709@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Sun May 09 13:02:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OB4HG-0005Qm-Gp
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 13:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724Ab0EILCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 07:02:24 -0400
Received: from peff.net ([208.65.91.99]:33961 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751768Ab0EILCY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 07:02:24 -0400
Received: (qmail 20766 invoked by uid 107); 9 May 2010 11:02:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 09 May 2010 07:02:38 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 09 May 2010 07:02:21 -0400
Content-Disposition: inline
In-Reply-To: <4BE60E89.8010709@pcharlan.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146719>

On Sat, May 08, 2010 at 06:23:21PM -0700, Pete Harlan wrote:

> "git clone foo bar" currently reports "Cloning into
> /path/to/bar/.git".  Change this message to "Cloning into bar" to more
> closely match the user's expectation.

I am a little torn on this. For most users, it is just another
implementation detail that makes git's output more confusing. And it is
likely to be the very first git message seen by many people. But at the
same time, it is telling you where the repository actually is, which is
something that can help users learn about how git works.

I guess it comes down to how much detail we want to show.

> For a --bare clone the current message prints the top level dir
> (because that is the git dir), so one could argue in favor of the
> current message because it confirms for the user whether their
> checkout was bare or not.  But that's only if the user is aware of how
> it would appear in both cases; I doubt that the existing code intended
> to make that distinction clear, and in practice I expect most users
> (a) trust git to do what they asked and (b) wouldn't notice that
> "Cloning into /path/to/bar" meant that it was a bare checkout.

I do think there is some value to this distinction. But we can make it a
lot less ugly for new users with:

  $ git clone /tmp/foo
  Cloning into /tmp/foo...

  $ git clone --bare /tmp/foo
  Cloning into bare repository /tmp/foo...

or something like that.

-Peff
