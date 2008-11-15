From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Any overview available on jgit codebase?
Date: Sat, 15 Nov 2008 15:15:37 -0800
Message-ID: <20081115231537.GD2932@spearce.org>
References: <200811132059.16616.robin.rosenberg.lists@dewire.com> <491C8DBE.9080105@wellfleetsoftware.com> <f73f7ab80811140638m4045cf83p311c593aff066002@mail.gmail.com> <491F2F5E.20206@wellfleetsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kyle Moffett <kyle@moffetthome.net>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: Farrukh Najmi <farrukh@wellfleetsoftware.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 00:16:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1UNp-0008P2-Lr
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 00:16:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516AbYKOXPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 18:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751859AbYKOXPi
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 18:15:38 -0500
Received: from george.spearce.org ([209.20.77.23]:52905 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815AbYKOXPi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 18:15:38 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7E8F9381FF; Sat, 15 Nov 2008 23:15:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <491F2F5E.20206@wellfleetsoftware.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101095>

Farrukh Najmi <farrukh@wellfleetsoftware.com> wrote:
>
> At minimum could anyone tell me what packages and classes to look at in  
> order to make changes to jgit so it uses a database instead of  
> filesystem to references.

See RefDatabase, created by Repository.  You would want to replace
RefDatabase with your own implementation, which means abstracting
that class to be an abstract base class or an interface.

RefUpdate and RefLogWriter are connected to RefDatabase, so you
would likely need to modify those too in order to make the change,
especially since RefUpdate is the "INSERT OR UPDATE OR DELETE"
logic.  :)

BTW, I want to do that RefDatabase abstraction anyway, because I'd
like to get an in-memory only version of RefDatabase, to make unit
testing easier.  So abstracting this code may be useful beyond just
your desire to back Git with a JDBC-style database.

-- 
Shawn.
