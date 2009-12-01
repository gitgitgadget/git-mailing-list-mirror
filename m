From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC PATCH 6/8] Remove special casing of http, https and ftp
Date: Tue, 1 Dec 2009 14:15:17 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0912011351220.14365@iabervon.org>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi> <1259675838-14692-7-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Dec 01 20:15:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFYC6-0003D4-L2
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 20:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075AbZLATPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 14:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752231AbZLATPM
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 14:15:12 -0500
Received: from iabervon.org ([66.92.72.58]:49250 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751870AbZLATPL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 14:15:11 -0500
Received: (qmail 20310 invoked by uid 1000); 1 Dec 2009 19:15:17 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 Dec 2009 19:15:17 -0000
In-Reply-To: <1259675838-14692-7-git-send-email-ilari.liusvaara@elisanet.fi>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134249>

On Tue, 1 Dec 2009, Ilari Liusvaara wrote:

> HTTP, HTTPS and FTP are no longer special to transport code. Also
> add support for FTPS (curl supports it so it is easy).

We've been through this extensively, and settled on having a special case 
for URLs that specify a pure location. That is, the distinction between 
http and ftp is at the level of how you get to the content for that 
location, not what you do to interact with it. (Even with webdav or the 
git-specific smart server support, we use the same detection method on all 
locations, and ftp simply never has the possibility of having these 
features detected.)

It would be fine to add "ftps" to the list of URL schemes that indicate a 
pure location, except that it's plausible that ftps supports writing, but 
obviously not by webdav, which is what the push support via curl will 
attempt, so it's more likely to be confusing than helpful.

	-Daniel
*This .sig left intentionally blank*
