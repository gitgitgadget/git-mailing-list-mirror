From: Jeff King <peff@peff.net>
Subject: Re: git remote update -> rejected
Date: Tue, 22 Apr 2008 06:34:58 -0400
Message-ID: <20080422103458.GA14751@sigio.intra.peff.net>
References: <1208857733.4695.37.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Mike Galbraith <efault@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 22 12:33:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoFod-0005rW-Qh
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 12:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759905AbYDVKcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 06:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759610AbYDVKcs
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 06:32:48 -0400
Received: from peff.net ([208.65.91.99]:4342 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759265AbYDVKcs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 06:32:48 -0400
Received: (qmail 9835 invoked by uid 111); 22 Apr 2008 10:32:47 -0000
Received: from sigio.intra.peff.net (HELO sigio.intra.peff.net) (10.0.0.10)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 22 Apr 2008 06:32:47 -0400
Received: by sigio.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Apr 2008 06:34:58 -0400
Content-Disposition: inline
In-Reply-To: <1208857733.4695.37.camel@marge.simson.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80096>

On Tue, Apr 22, 2008 at 11:48:53AM +0200, Mike Galbraith wrote:

> marge:..git/linux-2.6 # git remote update
> Updating origin
> Updating linux-next
> Updating stable
> Updating x86
> >From git://git.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-x86
>  ! [rejected]        latest     -> x86/latest  (non fast forward)
>  ! [rejected]        master     -> x86/master  (non fast forward)
>  ! [rejected]        testing    -> x86/testing  (non fast forward)

The x86 tree was presumably rewound or rebased, which means that
fetching their new position would overwrite your old. This is probably
OK, since it looks like you have x86/* as tracking branches, and only
they would get overwritten. So it is probably safe to put a '+' in front
of the 'fetch' line in your config file. E.g.,

  [remote "x86"]
    url = ...
    fetch = +refs/heads/*:refs/remotes/x86/*

See 'git help fetch' for details.

-Peff
