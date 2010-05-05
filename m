From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Set GIT_PATHNAME_PREFIX with aliases.
Date: Wed, 5 May 2010 03:01:31 -0400
Message-ID: <20100505070131.GA11265@coredump.intra.peff.net>
References: <1273019122.16093.6.camel@ubuntu.ubuntu-domain>
 <20100505005153.GC25390@coredump.intra.peff.net>
 <4BE115EF.8010306@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jared Hance <jaredhance@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed May 05 09:01:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9Yc0-0005lE-5a
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 09:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756751Ab0EEHBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 03:01:34 -0400
Received: from peff.net ([208.65.91.99]:45508 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752688Ab0EEHBe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 03:01:34 -0400
Received: (qmail 20327 invoked by uid 107); 5 May 2010 07:01:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 05 May 2010 03:01:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 05 May 2010 03:01:32 -0400
Content-Disposition: inline
In-Reply-To: <4BE115EF.8010306@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146379>

On Wed, May 05, 2010 at 08:53:35AM +0200, Johannes Sixt wrote:

> Am 5/5/2010 2:51, schrieb Jeff King:
> > On Tue, May 04, 2010 at 08:25:22PM -0400, Jared Hance wrote:
> > 
> >> The environment variable GIT_PATHNAME_PREFIX passes on the
> >> current working directory (where the git command was called from)
> >> to shell aliases (aliases that begin with "!"). This allows these
> >> shell aliases to know the directory that the git command was called
> >> from.
> > 
> > Seems like a reasonable goal, but...
> 
> Sorry, I disagree.
> [reasons why it sucks]

Yes, I agree it sucks. The problem is that this information is totally
lost now for shell aliases, so you can't even do these painful things.
Your alias simply doesn't have access to that information at all. I am
open to better interfaces (my "reasonable" above was not a ringing
endorsement, but rather "I can see why you might want to do this").

> The only way where this variable could be used in a useful manner is to
> write the alias as
> 
>    !cd "${GIT_PATHNAME_PREFIX:-.}" && { do stuff... ; }

Agreed that is the only sane thing to do with it, but...

> which is something that git should do before it invokes the alias.

Wouldn't we then be breaking existing aliases which do not expect this
new behavior?

-Peff
