From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Heads up: major rebase -i -p rework coming up
Date: Mon, 26 Jan 2009 11:10:53 -0500
Message-ID: <497DE08D.2030306@xiplink.com>
References: <alpine.DEB.1.00.0901242056070.14855@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stephen Haberman <stephen@exigencecorp.com>,
	spearce@spearce.org, Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 26 17:47:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRUca-0007bs-1M
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 17:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbZAZQqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 11:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751544AbZAZQqJ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 11:46:09 -0500
Received: from smtp222.iad.emailsrvr.com ([207.97.245.222]:49638 "EHLO
	smtp222.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbZAZQqI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 11:46:08 -0500
Received: from relay12.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay12.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 66DDD20DAB9;
	Mon, 26 Jan 2009 11:11:07 -0500 (EST)
Received: by relay12.relay.iad.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id C9B1620DAB2;
	Mon, 26 Jan 2009 11:11:00 -0500 (EST)
User-Agent: Icedove 1.5.0.14eol (X11/20090105)
In-Reply-To: <alpine.DEB.1.00.0901242056070.14855@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107233>

Johannes Schindelin wrote:
> 
> - $sha1'
> 
> 	for merge and goto, if a $sha1 ends in a single quote, the 
> 	rewritten commit is substituted (if there is one)

I find this notation fairly unintuitive.  I'm more inclined to let users 
specify their own names for important parts of the rebase.

I guess that's what Junio's 'mark' command is for, but not having seen a 
proper explanation of 'mark', I suggest instead a more inline method: an 
'as' keyword.  Any command in a todo script can be followed (on the same 
line, before the SHA1 value) with 'as <name>' allowing <name> to appear 
later in the script to refer to the result of the earlier command.

So the script in the example becomes

	pick as start A
	pick C
	pick as bottom D
	goto start
	pick B
	merge bottom was E

I find that much easier to understand.  Especially when real SHA1 values 
are floating around everywhere, I think this notation will help users 
get things right.

This approach also allows a commit name "A" to consistently refer to the 
original commit, which I think also makes things easier for users.

		M.
