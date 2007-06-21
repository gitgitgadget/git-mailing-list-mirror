From: Jeff King <peff@peff.net>
Subject: Re: Basename matching during rename/copy detection
Date: Thu, 21 Jun 2007 09:10:47 -0400
Message-ID: <20070621131047.GC4487@coredump.intra.peff.net>
References: <20070621030622.GD8477@spearce.org> <200706211050.03519.andyparkins@gmail.com> <Pine.LNX.4.64.0706211252190.4059@racer.site> <200706211344.47560.andyparkins@gmail.com> <vpqodj9zcxf.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 21 15:10:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1MR1-0000ZK-Dx
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 15:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754880AbXFUNKu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 09:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754260AbXFUNKu
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 09:10:50 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4649 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754097AbXFUNKt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 09:10:49 -0400
Received: (qmail 28855 invoked from network); 21 Jun 2007 13:11:06 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 21 Jun 2007 13:11:06 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Jun 2007 09:10:47 -0400
Content-Disposition: inline
In-Reply-To: <vpqodj9zcxf.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50621>

On Thu, Jun 21, 2007 at 02:53:32PM +0200, Matthieu Moy wrote:

> Well, why look so far to find an example of people having identical
> files in their tree?
> 
> $ cd git
> $ git-ls-files -z | xargs -0 md5sum | cut -f 1 -d ' ' | wc -l              
> 973
> $ git-ls-files -z | xargs -0 md5sum | cut -f 1 -d ' ' | sort | uniq | wc -l
> 964

md5? What is this, CVS? How about:

git-ls-files -s | cut -d' ' -f2 | sort | uniq -d | wc -l

Your pipeline will also list files in the working directory, which can
inflate the number of duplicates (note that git-foo.sh and git-foo will
have the same content).

-Peff

PS Please don't take this to mean I think duplicate files are stupid; I
think they can be quite useful. I just wanted to nitpick your shell
command. :)
