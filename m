From: bdowning@lavos.net (Brian Downing)
Subject: Re: I don't want the .git directory next to my code.
Date: Wed, 16 Jan 2008 18:59:54 -0600
Message-ID: <20080117005954.GM18022@lavos.net>
References: <478D79BD.7060006@talkingspider.com> <m3bq7lncak.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike <fromlists@talkingspider.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 02:10:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFJGo-00074e-DE
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 02:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbYAQBJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 20:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbYAQBJq
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 20:09:46 -0500
Received: from mxsf00.insightbb.com ([74.128.0.70]:11128 "EHLO
	mxsf00.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbYAQBJo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 20:09:44 -0500
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jan 2008 20:09:43 EST
X-IronPort-AV: E=Sophos;i="4.24,298,1196658000"; 
   d="scan'208";a="184891310"
Received: from unknown (HELO asav01.insightbb.com) ([172.31.249.124])
  by mxsf00.insightbb.com with ESMTP; 16 Jan 2008 19:59:55 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aj0KAPE2jkdKhvkY/2dsb2JhbACBWJAQnC0
X-IronPort-AV: E=Sophos;i="4.24,298,1196658000"; 
   d="scan'208";a="109509781"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav01.insightbb.com with ESMTP; 16 Jan 2008 19:59:54 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 6E0C5309F21; Wed, 16 Jan 2008 18:59:54 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <m3bq7lncak.fsf@roke.D-201>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70798>

On Wed, Jan 16, 2008 at 05:13:47AM -0800, Jakub Narebski wrote:
> > 2. If I tar/gz my code and deliver it to a client, I don't want the
> > .git dir slipping into the tarball, allowing my client to be able to
> > peruse the history of what we did and when.
> 
> Use git-archive / git-tar-tree to tar.gz or zip code to send to client.
> This has the advantage of not packing generated code, backup files,
> etc., not only .git. Besides there is --exclude option to tar ;-)

I realize that this is not directly what's being talked about here, but
one advantage to using "full Git" for deployment rather than something
like "git archive" is that Git has already implemented an
optimized-to-within-an-inch-of-its-life incremental filesystem updater -
namely, "git checkout-index".  If you always deploy with "git archive",
it could take a very long time to update a large web site even if only a
tiny change has taken place.

Yes, you could use rsync or some other tool, but Git already has the
tools available, so why not take advantage of them?

(Now, maybe some custom scripting to call plumbing like "git
checkout-index" would be more appropriate that using a "normal" working
directory, but I think the advantages of using Git's optimized WD update
tools here should be obvious for large sites...)

-bcd
