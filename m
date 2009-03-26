From: Jeff King <peff@peff.net>
Subject: Re: Question: Is it possible to host a writable git repo over both
	http and ssh?
Date: Wed, 25 Mar 2009 22:12:59 -0400
Message-ID: <20090326021259.GA5835@coredump.intra.peff.net>
References: <49CA6A17.6050903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mike Gaffney <mr.gaffo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 03:14:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmf7E-0005Mn-OS
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 03:14:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755872AbZCZCNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 22:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752074AbZCZCNM
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 22:13:12 -0400
Received: from peff.net ([208.65.91.99]:59287 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754754AbZCZCNL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 22:13:11 -0400
Received: (qmail 10266 invoked by uid 107); 26 Mar 2009 02:13:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 25 Mar 2009 22:13:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Mar 2009 22:12:59 -0400
Content-Disposition: inline
In-Reply-To: <49CA6A17.6050903@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114706>

On Wed, Mar 25, 2009 at 12:29:59PM -0500, Mike Gaffney wrote:

> I am trying to setup a git repo internally at my work. I would like to  
> make the repo accessable via https for both read and write so that we may 
> access it from customer locations which don't allow anything but https. I 
> would also like to host it via SSH because that protocol is much faster. I 
> know that when you push with http it runs 'git update-server-info', would 
> I have to make the ssh pushes do the same? Will this even work?

Yes, it should work just fine. All pushes, no matter how they arrive at
the repository, will need to run "git update-server-info", which is what
allows "dumb" protocols like http to read from the repository. The
default post-update hook does this; you just need to enable it by "cd
.git/hooks && mv post-update.sample post-update".

-Peff
