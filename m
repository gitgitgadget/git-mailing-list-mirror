From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] Avoid crippled getpass function on Solaris
Date: Mon, 06 Aug 2012 18:39:55 -0400
Message-ID: <1344292395-sup-1921@pinkfloyd.chass.utoronto.ca>
References: <1344208672-20028-1-git-send-email-bwalton@artsci.utoronto.ca> <7vboio231n.fsf@alter.siamese.dyndns.org> <1344220427-sup-3468@pinkfloyd.chass.utoronto.ca> <20120806193958.GA10039@sigill.intra.peff.net> <1344287843-sup-6200@pinkfloyd.chass.utoronto.ca> <20120806213404.GA14320@sigill.intra.peff.net> <1344290892-sup-1108@pinkfloyd.chass.utoronto.ca> <20120806223113.GA16298@sigill.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 07 00:40:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyVy6-00082J-4A
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 00:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756460Ab2HFWkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 18:40:03 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:53662 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755922Ab2HFWkC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 18:40:02 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:54748 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SyVxr-00084c-MY; Mon, 06 Aug 2012 18:39:55 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SyVxr-0004pw-LU; Mon, 06 Aug 2012 18:39:55 -0400
In-reply-to: <20120806223113.GA16298@sigill.intra.peff.net>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202996>

Excerpts from Jeff King's message of Mon Aug 06 18:31:13 -0400 2012:

> Looking over the code, I recall now why I used stdio: strbuf_getline
> requires it. These days we have strbuf_getwholeline_fd. It's
> slightly less efficient (it has to read() a character at a time),
> but since we are talking about a few characters of keyboard input,
> it should be OK.

I noticed the same requirement.  I'm currently building/testing a
patch that switches from FILE -> fd and also to
strbuf_getwholeline_fd.  Personally, I like this approach more than
calling an open function multiple times.

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
