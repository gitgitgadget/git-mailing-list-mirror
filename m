From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: curl
Date: Tue, 28 Apr 2015 11:27:13 +0200
Message-ID: <1430213233.2098.13.camel@elego.de>
References: <CACnwZYc8VvQ4mh3pbVcd06uc6YZOXnrGOEpTu19qacBy8v_Y8A@mail.gmail.com>
	 <20150428045732.GD24580@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thiago Farina <tfransosi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 28 11:27:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yn1nY-0006K9-Bw
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 11:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965293AbbD1J1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 05:27:19 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:39174 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965201AbbD1J1S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 05:27:18 -0400
Received: from centaur.local (p57A9646C.dip0.t-ipconnect.de [87.169.100.108])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 97D67DE05B;
	Tue, 28 Apr 2015 11:27:14 +0200 (CEST)
In-Reply-To: <20150428045732.GD24580@peff.net>
X-Mailer: Evolution 3.12.9-1+b1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267918>

On Tue, 2015-04-28 at 00:57 -0400, Jeff King wrote:
> On Mon, Apr 27, 2015 at 11:49:51PM -0300, Thiago Farina wrote:
> 
> > Is it right that git uses libcurl to download while libgit2 does without it?
> 
> I'm not sure if you mean "right" as in "this statement is true" or as in
> "is this a good thing that it is the case".
> 
> For the former, yes, libgit2 does not use curl.  On Windows, it can use
> the native http calls (which do nice things like using the system proxy
> and auth systems). On Unix, I think it is a combination of hand-rolled
> code, openssl, and an imported http parser (from nginx).
> 
> Whether that is a good idea or not, I can't comment too much. From what
> I have seen discussed in libgit2 issues, the stock http transport is
> meant to be bare-bones (but with minimal dependencies). But it could
> co-exist with a curl transport (just as it does with the WinHTTP
> transport).  Maybe Carlos (cc'd) can say more.

This is accurate, though I'll add that the development version of
libgit2 now uses SecureTransport instead of OpenSSL on Mac OS X.

But this is just the default. You can replace what libgit2 will use as a
transport if you have special needs. Visual Studio use their own network
code, and the cargo package manager uses libcurl. Eventually libcurl
support will likely be added to mainline libgit2, when we find time.

   cmn
