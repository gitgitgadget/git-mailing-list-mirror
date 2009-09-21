From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pre-commit.sample: don't use [...] around a tr range
Date: Mon, 21 Sep 2009 09:44:27 -0400
Message-ID: <20090921134427.GA20567@sigio.peff.net>
References: <871vm0k6jm.fsf@meyering.net> <81b0412b0909210243h58633509r7b427c69f62928fe@mail.gmail.com> <87ocp4imul.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Riesen <raa.lkml@gmail.com>, git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Mon Sep 21 15:42:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpjA1-0006Xx-Mb
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 15:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbZIUNmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 09:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbZIUNmA
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 09:42:00 -0400
Received: from [208.65.91.99] ([208.65.91.99]:53946 "EHLO peff.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751432AbZIUNmA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 09:42:00 -0400
Received: (qmail 20577 invoked by uid 1000); 21 Sep 2009 13:44:27 -0000
Content-Disposition: inline
In-Reply-To: <87ocp4imul.fsf@meyering.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128885>

On Mon, Sep 21, 2009 at 01:00:34PM +0200, Jim Meyering wrote:

> > We have (had?) people trying to support Git on HP-UX and SunOS.
> > Do these count?
> 
> I had my doubts, but have just confirmed that Solaris 10's
> /usr/bin/tr is still doing it the SYSV way:
> 
>     $ echo foo | LC_ALL=C /usr/bin/tr a-z A-Z
>     foo
> 
> There, you have to use /usr/xpg4/bin/tr to get the expected behavior:
> 
>     $ echo foo | LC_ALL=C /usr/xpg4/bin/tr a-z A-Z
>     FOO
> 
> So you're right.  Thanks!

See:

  http://article.gmane.org/gmane.comp.version-control.git/76991

> +	# Note that the use of brackets around a tr range is ok here, (it's
> +	# even required, for portability to Solaris 10's /usr/bin/tr), since
> +	# the square bracket bytes happen to fall in the designated range.
>  	test "$(git diff --cached --name-only --diff-filter=A -z |
>  	  LC_ALL=C tr -d '[ -~]\0')"

Does this work on non-bracket systems? I would think that enumerating
the sequence would be the most portable thing.

-Peff
