From: Jeff King <peff@peff.net>
Subject: Re: backwards compatibility, was Re: [PATCH v1 1/3] Introduce
	config variable "diff.primer"
Date: Mon, 26 Jan 2009 13:48:30 -0500
Message-ID: <20090126184829.GA27543@coredump.intra.peff.net>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu> <1232904657-31831-2-git-send-email-keith@cs.ucla.edu> <7v1vurf7lq.fsf@gitster.siamese.dyndns.org> <alpine.GSO.2.00.0901251345240.12651@kiwi.cs.ucla.edu> <20090126031206.GB14277@sigill.intra.peff.net> <alpine.DEB.1.00.0901261154330.14855@racer> <20090126111605.GB19993@coredump.intra.peff.net> <76718490901260729m21ba140dke157d1d461aed2d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Keith Cascio <keith@cs.ucla.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 19:50:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRWX0-0007xa-Hv
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 19:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbZAZSsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 13:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbZAZSsd
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 13:48:33 -0500
Received: from peff.net ([208.65.91.99]:45299 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751470AbZAZSsc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 13:48:32 -0500
Received: (qmail 5304 invoked by uid 107); 26 Jan 2009 18:48:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 26 Jan 2009 13:48:40 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Jan 2009 13:48:30 -0500
Content-Disposition: inline
In-Reply-To: <76718490901260729m21ba140dke157d1d461aed2d5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107245>

On Mon, Jan 26, 2009 at 10:29:17AM -0500, Jay Soffian wrote:

> Aside, AIX has commands that are run both directly or via smit (a
> curses-based interface). When smit calls the commands, it passes a
> switch to let said commands know that they are being run from smit.
> e.g.:
> 
>        -J
>             This flag is used when the installp command is executed from the
>             System Management Interface Tool (SMIT) menus.
> 
> Perhaps adding such a concept to those git commands which can be used
> in both porcelain and plumbing contexts would be useful for git.

Sure, I think that is one of many possible ways that we could
differentiate between confusing plumbing and porcelain; another is
splitting functionality into two similar commands, one of which is
plumbing and one of which is porcelain.

The real problem with plans like that, though, is that there are
_already_ scripts in the wild that don't understand "-J" (or whatever).
My impression from your description above is that "-J" means "don't use
fancy features, because we're being called from the menus". And you
really want the opposite, which is that scripts opt _in_ to fancy
features, not _out_.

But then you have that problem that the _user_ is stuck specifying "OK,
turn on fancy features." And I don't relish the thought of typing "git
diff -J" every time. :)

-Peff
