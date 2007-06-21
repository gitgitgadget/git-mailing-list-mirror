From: Jeff King <peff@peff.net>
Subject: Re: Moving a directory with history from one repository to another while renaming
Date: Thu, 21 Jun 2007 09:01:38 -0400
Message-ID: <20070621130137.GB4487@coredump.intra.peff.net>
References: <200706211337.32978.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 15:01:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1MIA-0006ua-Ed
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 15:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754931AbXFUNBl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 09:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754905AbXFUNBk
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 09:01:40 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2514 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753530AbXFUNBk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 09:01:40 -0400
Received: (qmail 28790 invoked from network); 21 Jun 2007 13:01:56 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 21 Jun 2007 13:01:56 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Jun 2007 09:01:38 -0400
Content-Disposition: inline
In-Reply-To: <200706211337.32978.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50620>

On Thu, Jun 21, 2007 at 01:37:30PM +0100, Andy Parkins wrote:

>  git checkout directoryonly
>  git-filter-branch --tree-filter "mkdir -p sub/dir/repoB_directory; \
>     mv file1 file2 file3 sub/dir/repoB_directory" directorymoved

You can do this much more efficiently by just operating on the index.
Something like:

git-filter-branch --index-filter \
 'git-ls-files -s | sed -n 's/change/paths/p' | git-update-index --index-info' \
 directorymoved

-Peff
