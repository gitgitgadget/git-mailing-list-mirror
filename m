From: Jeff King <peff@peff.net>
Subject: Re:
Date: Wed, 18 Mar 2015 17:28:52 -0400
Message-ID: <20150318212852.GA28860@peff.net>
References: <CANSxx61FaNp5SBXJ8Y+pWn0eDcunmibKR5g8rttnWGdGwEMHCA@mail.gmail.com>
 <CAPc5daWNTm5qtd1HJdgQ+-yqUpeMaMmK_UuUiyhxCF6gD3K9dQ@mail.gmail.com>
 <CAGZ79kZwmvZyye-3pHCbDgXhuQTQ8OsgtomK7BtR86qqU1koxQ@mail.gmail.com>
 <20150318211716.GC3376@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alessandro Zanardi <pensierinmusica@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 22:29:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYLWQ-0001HL-9x
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 22:29:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756975AbbCRV26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 17:28:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:34883 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756699AbbCRV2z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 17:28:55 -0400
Received: (qmail 1766 invoked by uid 102); 18 Mar 2015 21:28:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Mar 2015 16:28:54 -0500
Received: (qmail 7289 invoked by uid 107); 18 Mar 2015 21:29:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Mar 2015 17:29:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Mar 2015 17:28:52 -0400
Content-Disposition: inline
In-Reply-To: <20150318211716.GC3376@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265764>

On Wed, Mar 18, 2015 at 05:17:16PM -0400, Jeff King wrote:

> [1] The double-CR fix works because we strip a single CR from the end of
>     the line (as a convenience for CRLF systems), and then the remaining
>     CR is syntactically significant. But I am surprised that quoting
>     like:
> 
>       printf '"Icon\r"' >.gitignore
> 
>     does not seem to work.

Answering myself: we don't do quoting like this in .gitignore. We allow
backslashing to escape particular characters, like trailing whitespace.
So in theory:

  Icon\\r

(where "\r" is a literal CR) would work. But it doesn't, because the
CRLF chomping happens separately, and CR is therefore a special case. I
suspect you could not .gitignore a file with a literal LF in it at all
(and I equally suspect that nobody cares in practice).

-Peff
