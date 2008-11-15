From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH 3/3] Add -k/--keep-going option to mergetool
Date: Sat, 15 Nov 2008 11:12:27 -0500
Message-ID: <20081115161227.GE22948@mit.edu>
References: <1226580075-29289-1-git-send-email-charles@hashpling.org> <1226580075-29289-2-git-send-email-charles@hashpling.org> <1226580075-29289-3-git-send-email-charles@hashpling.org> <1226580075-29289-4-git-send-email-charles@hashpling.org> <20081114064756.GB11907@coredump.intra.peff.net> <491D7C38.7070906@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Andreas Ericsson <ae@op5.se>,
	William Pursell <bill.pursell@gmail.com>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Sat Nov 15 17:13:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1NmQ-0002Hr-1a
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 17:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbYKOQMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 11:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbYKOQMe
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 11:12:34 -0500
Received: from www.church-of-our-saviour.org ([69.25.196.31]:49614 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751345AbYKOQMe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 11:12:34 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1L1Nl8-0005v8-3p; Sat, 15 Nov 2008 11:12:30 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1L1Nl5-0008UZ-Dt; Sat, 15 Nov 2008 11:12:27 -0500
Content-Disposition: inline
In-Reply-To: <491D7C38.7070906@hashpling.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101076>

On Fri, Nov 14, 2008 at 01:25:12PM +0000, Charles Bailey wrote:
> Previously, if you aborted a merge, you were left with the
> base/local/remote temporaries for the merge that you aborted.
> 
> To be honest, I found this a little irritating. The base, local and
> remote temporaries are inputs so are accessible from slots 1,2 and 3 of
> the index, and any intermediate output will be in the target file. You
> can git clean, but if you have other temporaries you need to keep, you
> end up having to manually clean them up in any case.

I agree.  On occasion it's useful, but more often than not, keeping
the temporaries is more annoying than anything else.  At the time when
I wrote mergetool, it was a pain for me to either do "git ls-files
--stage" and then cut and paste the SHA hash, or to type commands like
"git cat-file blob :1:long/pathname/from/the/top.c" to look one
various staged versions of the file.   

I'd suggest that this is probably worth turning into an option
(-k|--keep-files), and default the answer to deleting the temporaries
before mergetool exits.

						- Ted
