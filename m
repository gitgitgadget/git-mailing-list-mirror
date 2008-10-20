From: Jeff King <peff@peff.net>
Subject: Re: bug: git-stash save and symbolic links
Date: Mon, 20 Oct 2008 11:17:16 -0400
Message-ID: <20081020151715.GA13553@coredump.intra.peff.net>
References: <df1390cc0810200134x68a8eb1fyc7f24650c8c9c5d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Simon Strandgaard <neoneye@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 22:59:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrwWd-0001Qm-HF
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 17:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbYJTPRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 11:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbYJTPRS
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 11:17:18 -0400
Received: from peff.net ([208.65.91.99]:3172 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992AbYJTPRS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 11:17:18 -0400
Received: (qmail 13513 invoked by uid 111); 20 Oct 2008 15:17:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 20 Oct 2008 11:17:17 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Oct 2008 11:17:16 -0400
Content-Disposition: inline
In-Reply-To: <df1390cc0810200134x68a8eb1fyc7f24650c8c9c5d3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98706>

On Mon, Oct 20, 2008 at 10:34:53AM +0200, Simon Strandgaard wrote:

> git-stash cannot find the repository when the path is a symbolic link.
> solution for me was to cd to the absolute path and then do git-stash.

Sorry, I can't reproduce here, using this test:

    mkdir repo &&
    cd repo &&
      git init &&
      echo content >file &&
      git add file &&
      git commit -m one &&
    cd .. &&
      ln -s repo linked &&
    cd repo &&
      echo cruft >>file &&
      git stash &&
      echo non-linked directory stashed ok &&
    cd ../linked &&
      echo cruft >>file &&
      git stash &&
      echo linked directory stashed ok

What version of git are you running (though I tried a few different
ones, and all passed my test)?

-Peff
