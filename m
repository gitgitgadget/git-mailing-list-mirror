From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] add NORETURN_PTR for function pointers
Date: Thu, 1 Oct 2009 04:17:10 -0400
Message-ID: <20091001081710.GC13436@coredump.intra.peff.net>
References: <1254333950-2440-1-git-send-email-kusmabite@gmail.com>
 <1254333950-2440-2-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	msysgit@googlegroups.com, gitster@pobox.com,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Oct 01 10:17:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtGqy-00084r-9s
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 10:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755842AbZJAIRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 04:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755855AbZJAIRP
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 04:17:15 -0400
Received: from peff.net ([208.65.91.99]:47789 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755832AbZJAIRO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 04:17:14 -0400
Received: (qmail 13999 invoked by uid 107); 1 Oct 2009 08:20:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 01 Oct 2009 04:20:42 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Oct 2009 04:17:10 -0400
Content-Disposition: inline
In-Reply-To: <1254333950-2440-2-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129383>

On Wed, Sep 30, 2009 at 06:05:50PM +0000, Erik Faye-Lund wrote:

> Some compilers (including at least MSVC and ARM RVDS) supports
> NORETURN on function declarations, but not on function pointers.
> 
> This patch makes it possible to define NORETURN for these compilers,
> by splitting the NORETURN macro into two - one for function
> declarations and one for function pointers.

Thanks, this version and (your 1/2) both look sane to me. The only thing
missing are some Makefile knobs to tweak this, but I will assume that
will come as part of a later MSVC-compatibility series.

Shawn, this can go straight to 'next', if not 'master'. The changes
should be a no-op for most platforms. The only danger would be if there
is some platform that doesn't like their NORETURN magic at the front of
the function declaration. But we only define it by default for __GNUC__,
so I suspect we're safe.

In my tree as ef/msvc-noreturn.

-Peff
