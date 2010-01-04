From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/6] t0021: use $SHELL_PATH for the filter script
Date: Mon, 4 Jan 2010 11:03:17 -0500
Message-ID: <20100104160317.GB9136@coredump.intra.peff.net>
References: <20091230095634.GA16349@coredump.intra.peff.net>
 <20091230110335.GF22959@coredump.intra.peff.net>
 <4B3E73AE.6050003@kdbg.org>
 <20100103072408.GA23031@sigill.intra.peff.net>
 <4B420E4F.1040706@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Jan 04 17:03:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRpP3-0003S9-8W
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 17:03:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526Ab0ADQDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 11:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753473Ab0ADQDV
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 11:03:21 -0500
Received: from peff.net ([208.65.91.99]:35693 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753464Ab0ADQDU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 11:03:20 -0500
Received: (qmail 19520 invoked by uid 107); 4 Jan 2010 16:08:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 04 Jan 2010 11:08:05 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Jan 2010 11:03:17 -0500
Content-Disposition: inline
In-Reply-To: <4B420E4F.1040706@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136123>

On Mon, Jan 04, 2010 at 04:50:39PM +0100, Johannes Sixt wrote:

> >>On Windows, we need the shbang line to correctly invoke shell scripts via
> >>a POSIX shell, except when the script is invoked via 'sh -c' because
> >>sh (a bash) does "the right thing". Since nowadays the clean and smudge
> >>filters are not always invoked via 'sh -c' anymore, we have to mark the
> >>the one in t0021-conversion with #!$SHELL_PATH.
> >
> >Hrm. This does mean we might be breaking users who have helper scripts
> >in a similar state to those in the test suite...
> 
> Not helper scripts in general, but only clean and smudge filters,
> because these have been invoked with "sh -c" so far. Everything else,
> that was not run via "sh -c", but now is, is safe.

I converted more than that; see my 2/6. It is also the pager, the
imap-send tunnel helper, and external merge helpers. Not the editor,
since it already had the no-metacharacters optimization (though it, too,
could be affected if we implement your DWIM trick instead of the
metacharacter thing).

So I think we need to make a conscious decision that this is an
acceptable change of behavior (and I am totally fine with the change
happening -- I just want to be clear about the extent of what is being
changed).

-Peff
