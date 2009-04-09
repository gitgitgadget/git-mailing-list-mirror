From: Mike Hommey <mh@glandium.org>
Subject: Re: bug: git-http-push fails to validate email address in LOCK
	request
Date: Thu, 9 Apr 2009 14:02:06 +0200
Message-ID: <20090409120205.GA29046@glandium.org>
References: <20090409111944.GA22297@kos.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Riku Voipio <riku.voipio@iki.fi>
X-From: git-owner@vger.kernel.org Thu Apr 09 14:03:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lrsz2-00086x-UE
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 14:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760254AbZDIMCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 08:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760192AbZDIMCQ
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 08:02:16 -0400
Received: from vuizook.err.no ([85.19.221.46]:39571 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759840AbZDIMCO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 08:02:14 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=vaio.glandium.org)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LrsxM-0004ya-Hm; Thu, 09 Apr 2009 14:02:11 +0200
Received: from mh by vaio.glandium.org with local (Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LrsxK-0000WL-L9; Thu, 09 Apr 2009 14:02:06 +0200
Content-Disposition: inline
In-Reply-To: <20090409111944.GA22297@kos.to>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116165>

On Thu, Apr 09, 2009 at 02:19:44PM +0300, Riku Voipio <riku.voipio@iki.fi> wrote:
> from http-push.c, we see that the lock request is:
> 
> #define LOCK_REQUEST "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n<D:lockinfo xmlns:D=\"DAV:\">\n<D:lockscope><D:exclusive/></D:lockscope>\n<D:locktype><D:write/></D:locktype>\n<D:owner>\n<D:href>mailto:%s</D:href>\n</D:owner>\n</D:lockinfo>"
> 
> So there is exactly one variable being set. Turns out the email
> address in .gitconfig was set to '<riku.voipio@iki.fi>'. Yes,
> a user error. This was copied from $EMAIL env variable, where
> using strings such as 'foo bar <foo.bar@corp.com>' have been
> a norm forever.

That's the problem with generating XML by concatenating strings without
checks :(

Mike
