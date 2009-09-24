From: Jeff King <peff@peff.net>
Subject: Re: [RFC] 'git cat-file' needs a better design on its option
 interface
Date: Thu, 24 Sep 2009 12:48:35 -0400
Message-ID: <20090924164834.GB5655@coredump.intra.peff.net>
References: <3a3680030909240804w1399ed7fhd6367300544f34f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Li Hong <lihong.hi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 24 18:48:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqrUe-0006hU-VM
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 18:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871AbZIXQsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2009 12:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752753AbZIXQsX
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 12:48:23 -0400
Received: from peff.net ([208.65.91.99]:59876 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752747AbZIXQsX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 12:48:23 -0400
Received: (qmail 5325 invoked by uid 107); 24 Sep 2009 16:51:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 24 Sep 2009 12:51:48 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2009 12:48:35 -0400
Content-Disposition: inline
In-Reply-To: <3a3680030909240804w1399ed7fhd6367300544f34f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129049>

On Thu, Sep 24, 2009 at 11:04:31PM +0800, Li Hong wrote:

> When using 'git cat-file' recently, I find its option interface is somewhat
> inconvenient or mistakenly-designed.

Yes, the current interface has grown over time and kind of sucks. I
agree with all of your complaints.

That being said, the reason it has grown in that way is that as a
plumbing command, cat-file must retain backwards compatibility so as not
to break existing scripts which make use of it. And it is not enough to
look through git.git and fix all of our scripts; the interface to
cat-file is a public one, and we must take care not to break other
people's custom scripts.

I'm not quite sure where your complaints are coming from. Do you want:

  1. Something more sane to type in your terminal for everyday use? Then
     you probably want to use (or invent) some sort of user-facing
     porcelain that does a similar thing. This is mostly covered by "git
     show" these days, but if there is something lacking, proposals
     describing your use case would be welcome.

  2. To script around cat-file, but there is some action you want to do
     that is missing from the interface? In that case, can you describe
     your use case in more detail, and exactly what addition you want to
     make to the cat-file interface to accomodate it?

  3. To just clean up cruft from the interface for your scripts? I am
     somewhat sympathetic to wanting a nicer interface. But keep in
     mind that we have to keep the old interface around to support
     historical scripts. So while your new interface may be more
     flexible and less complex, you have to consider whether having
     _both_ interfaces will actually be less complex in the long run.

-Peff
