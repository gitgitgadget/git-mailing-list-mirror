From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-cvsexportcommit fails for huge commits
Date: Wed, 12 Dec 2007 08:02:35 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712120753120.25032@woody.linux-foundation.org>
References: <20071211200418.GA13815@mkl-desktop> <20071212083154.GB7676@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Markus Klinik <markus.klinik@gmx.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 12 17:03:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2U3B-0001O7-K7
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 17:03:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbXLLQCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 11:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752343AbXLLQCr
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 11:02:47 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33439 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752112AbXLLQCq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Dec 2007 11:02:46 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBCG2aOr018498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Dec 2007 08:02:37 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBCG2ZQL017823;
	Wed, 12 Dec 2007 08:02:36 -0800
In-Reply-To: <20071212083154.GB7676@coredump.intra.peff.net>
X-Spam-Status: No, hits=-2.715 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68060>



On Wed, 12 Dec 2007, Jeff King wrote:
>  
> +sub xargs_safe_pipe_capture {
> +	my $MAX_ARG_LENGTH = 1024;

Well, that's a bit extreme. Make it 16kB or something. Anything should be 
able to handle that.

Btw, on Linux, the argument length is realy only limited by the stack size 
limits these days (you have to have a fairly recent kernel, though). It's 
limited to stack limit / 4, to be exact, iirc. So if you see these kinds 
of problems, and are running a recent kernel, do something like

	ulimit -s 65536

to give yourself a big stack and you can continue without these kinds of 
changes..

		Linus
