From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] quote_path: convert empty path to "./"
Date: Fri, 7 Dec 2007 15:49:37 -0500
Message-ID: <20071207204937.GA20111@coredump.intra.peff.net>
References: <20071207165703.GA8889@sigill.intra.peff.net> <Pine.LNX.4.64.0712071853500.27959@racer.site> <4759996B.2000300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Harning <harningt@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 21:50:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0k94-0001Ge-AH
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 21:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142AbXLGUtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 15:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754532AbXLGUtl
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 15:49:41 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4150 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753033AbXLGUtk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 15:49:40 -0500
Received: (qmail 12935 invoked by uid 111); 7 Dec 2007 20:49:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 07 Dec 2007 15:49:39 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Dec 2007 15:49:37 -0500
Content-Disposition: inline
In-Reply-To: <4759996B.2000300@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67456>

On Fri, Dec 07, 2007 at 02:05:15PM -0500, Thomas Harning wrote:

> I concur.  There is one case that this seems to dodge.  What about the case 
> where you are in:
>
> /test/test_2  where /test  is not tracked...
>
> This should probably show "./../"   not just "./"   , right?

It already says "../", which is correct:

  $ git init
  $ mkdir test && cd test
  $ touch file
  $ mkdir test2 && cd test2
  $ git status
  ...
  # Untracked files:
  #   (use "git add <file>..." to include in what will be committed)
  #
  #       ../

There's no point in ever saying "./" _except_ in the case where the
output would be totally blank, since there is no way to tell that it is
an output line.

Personally, I don't like either the "../" or the "./", but I actually
think the relative paths are less readable than the full paths in
general.

-Peff
