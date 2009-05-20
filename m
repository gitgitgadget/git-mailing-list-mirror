From: Jeff King <peff@peff.net>
Subject: Re: Reverting an uncommitted revert
Date: Wed, 20 May 2009 12:58:54 -0400
Message-ID: <20090520165854.GA23031@coredump.intra.peff.net>
References: <4A136C40.6020808@workspacewhiz.com> <alpine.LFD.2.00.0905192300070.3906@xanadu.home> <20090520032139.GB10212@coredump.intra.peff.net> <alpine.LFD.2.00.0905192328310.3906@xanadu.home> <025225A0-FACC-4A29-A747-40201A7FBA19@wincent.com> <alpine.LFD.2.00.0905200853010.3906@xanadu.home> <96BC1064-EEEF-48BC-B79A-9D15C517CF47@wincent.com> <alpine.LFD.2.00.0905201144040.3906@xanadu.home> <fabb9a1e0905200913u5252973aia9a20983b20243d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Wincent Colaiuta <win@wincent.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Nicolas Pitre <nico@cam.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 20 18:59:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6p8B-0008F8-QI
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 18:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754209AbZETQ64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 12:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754181AbZETQ6z
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 12:58:55 -0400
Received: from peff.net ([208.65.91.99]:36438 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753985AbZETQ6y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 12:58:54 -0400
Received: (qmail 9572 invoked by uid 107); 20 May 2009 16:59:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 20 May 2009 12:59:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 20 May 2009 12:58:54 -0400
Content-Disposition: inline
In-Reply-To: <fabb9a1e0905200913u5252973aia9a20983b20243d3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119621>

On Wed, May 20, 2009 at 06:13:55PM +0200, Sverre Rabbelier wrote:

> On that note, the usefulness of such a feature is dependant on the
> support we have for actually restoring an entry from this new reflog.
> The current reflog is so amazingly useful because git has
> awesome-cherry-pick-and-the-like-commit-handling powers that make it
> easy to restore the otherwise lost state. But as far as I know,
> there's no nice 'n easy support for restoring state to the information
> contained in this new reflog, is there?

I was envisioning a reflog of tree objects, so you could do:

  $ git reflog show TRASH ;# show the reflog message
  $ git show TRASH@{1} ;# show what's in the tree
  $ git show TRASH@{1}:path/to/file ;# see a file
  $ git checkout TRASH@{1} path/to/file ;# restore a file

which should all work as-is.

I suspect "git log -g" might need some tweaking to get a tree rather
than a commit (but in theory we should just show the "Reflog *:" headers
and not the commit headers).

-Peff
