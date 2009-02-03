From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin-remote: make rm operation safer in mirrored
	repository
Date: Tue, 3 Feb 2009 02:24:18 -0500
Message-ID: <20090203072418.GD21367@sigill.intra.peff.net>
References: <76718490902020536g6f4bcee2i76ee046a8dc7d46@mail.gmail.com> <1233600014-82346-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 08:25:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUFfI-0005k8-2t
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 08:25:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbZBCHYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 02:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752023AbZBCHYW
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 02:24:22 -0500
Received: from peff.net ([208.65.91.99]:49236 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966AbZBCHYV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 02:24:21 -0500
Received: (qmail 17471 invoked by uid 107); 3 Feb 2009 07:24:33 -0000
Received: from c-75-75-4-229.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (75.75.4.229)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 03 Feb 2009 02:24:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Feb 2009 02:24:18 -0500
Content-Disposition: inline
In-Reply-To: <1233600014-82346-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108160>

On Mon, Feb 02, 2009 at 01:40:14PM -0500, Jay Soffian wrote:

> This version adds a test case. I also noticed that the check I'd added to
> add_branch_for_removal() was generating spurious warnings because I'd added it
> in the wrong place; this version moves the check below the
> remote_find_tracking() checks.

This version looks fine to me, and I would be OK with it being applied.

However, I have one small nit. The output produces long lines with a lot
of repeated text (assuming you have multiple matched branches, which is
likely if you have a mirrored setup). So maybe it would be nicer to have
something like:

  warning: non-remote branches were not removed; you can delete them with:
          git branch -d master
          git branch -d next
          git branch -d topic

which is a little more obvious (to me, anyway), and allows you to cut
and paste if you really did want to delete them.

But this should be a pretty seldom seen message, so it might not matter
much.  I just thought I would throw it out there.

-Peff
