From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t1308: do not get fooled by symbolic links to the source
 tree
Date: Fri, 3 Jun 2016 02:10:23 -0400
Message-ID: <20160603061023.GA7687@sigill.intra.peff.net>
References: <xmqqzir53mdc.fsf@gitster.mtv.corp.google.com>
 <712e0755-6008-21f5-0ee6-25ed9d97fd45@web.de>
 <xmqq1t4ftheu.fsf@gitster.mtv.corp.google.com>
 <xmqqwpm7s2ex.fsf@gitster.mtv.corp.google.com>
 <20160602213920.GA13356@sigill.intra.peff.net>
 <xmqqeg8fs0dw.fsf_-_@gitster.mtv.corp.google.com>
 <57511E44.1090708@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 08:10:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8iJX-0006QH-Eu
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 08:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbcFCGK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 02:10:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:48213 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751537AbcFCGK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 02:10:27 -0400
Received: (qmail 26964 invoked by uid 102); 3 Jun 2016 06:10:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jun 2016 02:10:26 -0400
Received: (qmail 17829 invoked by uid 107); 3 Jun 2016 06:10:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jun 2016 02:10:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Jun 2016 02:10:23 -0400
Content-Disposition: inline
In-Reply-To: <57511E44.1090708@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296268>

On Fri, Jun 03, 2016 at 08:05:56AM +0200, Johannes Sixt wrote:

> > -	name=$(pwd)/.gitconfig
> > +	name=$HOME/.gitconfig
> 
> I haven't tested this, yet, but my guess is that this breaks on Windows:
> test-config will produce C:/foo style path, but the updated test would
> expect /c/foo style path. Dscho, do you have an idea how to fix this?

Hmm. This should come directly from expand_user_path("~/.gitconfig")
which prepends the literal contents of the $HOME variable. It does go
through convert_slashes() afterwards, but I don't see any other
massaging (but I won't be surprised when you tell me there is some that
happens behind the scenes).

-Peff
