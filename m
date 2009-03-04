From: Jeff King <peff@peff.net>
Subject: Re: How does Git know which files no longer needed during upgrade?
Date: Wed, 4 Mar 2009 04:49:51 -0500
Message-ID: <20090304094951.GA32433@coredump.intra.peff.net>
References: <22318714.post@talk.nabble.com> <20090303233058.GE4371@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: dealmaker <vinkhc@gmail.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Mar 04 10:51:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LenlA-00087q-DS
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 10:51:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753938AbZCDJuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 04:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753878AbZCDJt7
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 04:49:59 -0500
Received: from peff.net ([208.65.91.99]:45259 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753840AbZCDJt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 04:49:59 -0500
Received: (qmail 23090 invoked by uid 107); 4 Mar 2009 09:49:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 04 Mar 2009 04:49:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Mar 2009 04:49:51 -0500
Content-Disposition: inline
In-Reply-To: <20090303233058.GE4371@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112193>

On Wed, Mar 04, 2009 at 12:30:58AM +0100, Miklos Vajna wrote:

> First, I think storing upstream code (that you will never touch) in
> version control is a horrible idea, but if you really do it, I would do
> something like:
> 
> cd /path/to/copy
> rm -rf *
> cp -a /path/to/new/version/* .
> git add -A
> git commit -m 'update foo to 2.0'

Nit: "rm -rf *" will miss files starting with '.'. So it is probably
simpler to say what you mean: delete all files managed by git:

  git ls-files -z | xargs -0 rm -f

-Peff
