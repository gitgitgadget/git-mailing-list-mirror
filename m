From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] git-daemon wrapper to wait until daemon is ready
Date: Sun, 15 Apr 2012 00:06:06 +0200
Message-ID: <20120414220606.GA18137@ecki>
References: <20120414182907.GA3915@ecki>
 <4F89D1C6.8090705@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org, gitster@pobox.com, Jeff King <peff@peff.net>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Apr 15 00:08:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJB8Y-00065V-PN
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 00:08:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756513Ab2DNWHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 18:07:51 -0400
Received: from smtpout13.highway.telekom.at ([195.3.96.75]:27174 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756450Ab2DNWH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 18:07:26 -0400
Received: (qmail 4117 invoked from network); 14 Apr 2012 22:07:20 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL507.highway.telekom.at
X-Spam-Level: ****
Received: from p5b22d2b0.dip.t-dialin.net (HELO [127.0.0.1]) (aon.912301525.1@aon.at@[91.34.210.176])
          (envelope-sender <drizzd@aon.at>)
          by smarthub82.res.a1.net (qmail-ldap-1.03) with AES128-SHA encrypted SMTP
          for <j6t@kdbg.org>; 14 Apr 2012 22:07:19 -0000
Content-Disposition: inline
In-Reply-To: <4F89D1C6.8090705@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195525>

On Sat, Apr 14, 2012 at 09:36:38PM +0200, Johannes Sixt wrote:
> Am 14.04.2012 20:29, schrieb Clemens Buchacher:
> > +	r = read_line(proc.err, buf, sizeof(buf));
> 
> We have strbuf_getwholeline_fd().

Thanks. Will fix.

> > +	memset(&cat, 0, sizeof(cat));
> > +	cat.argv = (const char **)cat_argv;
> > +	cat.in = proc.err;
> > +	cat.out = 2;
> 
> Useless use of cat?

I don't see how I could avoid cat here. I have to create a pipe first so
that I can read the first line. And then I have to terminate
test-git-daemon in order to start the tests. So I cannot continue
reading synchronously.
