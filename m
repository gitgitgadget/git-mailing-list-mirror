From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] http-push: add regression tests
Date: Sun, 24 Feb 2008 19:48:32 +0100
Organization: glandium.org
Message-ID: <20080224184832.GA24240@glandium.org>
References: <20080218130726.GA26854@localhost> <alpine.LSU.1.00.0802181339470.30505@racer.site> <20080218155546.GA8934@localhost> <alpine.LSU.1.00.0802181733400.30505@racer.site> <20080223212843.GA30054@localhost> <20080224085830.GD13416@glandium.org> <20080224180340.GA11515@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Feb 24 19:47:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTLsF-0008Ad-P9
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 19:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbYBXSpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 13:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752432AbYBXSpz
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 13:45:55 -0500
Received: from vuizook.err.no ([85.19.215.103]:41785 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752325AbYBXSpy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 13:45:54 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JTLr6-0001KL-1M; Sun, 24 Feb 2008 19:45:50 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JTLto-000735-2j; Sun, 24 Feb 2008 19:48:32 +0100
Content-Disposition: inline
In-Reply-To: <20080224180340.GA11515@localhost>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74953>

On Sun, Feb 24, 2008 at 07:03:40PM +0100, Clemens Buchacher wrote:
> http-push tests require a web server with WebDAV support.
> 
> This commit introduces a HTTPD test library, which can be configured using
> the following environment variables.
> 
> LIB_HTTPD_PATH	web server path
> LIB_HTTPD_PORT	listening port
> LIB_HTTPD_DAV	enable DAV
> LIB_HTTPD_SVN	enable SVN
> LIB_HTTPD_SSL	enable SSL

I'd add LIB_HTTPD_MODULE_PATH in here ;)

I took a quick but deeper look to your script, and I think it would be
better to have a httpd.conf with proper <IfDefine> directives, and
toggle the proper defines on the httpd command line.

Note the ServerRoot is used when paths are relative, so only the
ServerRoot need to be set, and it could be set with the -C argument to
httpd, avoiding the need of a .in file. If necessary, modules path could
be made relative to the ServerRoot by means of a symlink.

Avoiding to have logs, dav lock, ssl mutex, etc. in the document
root would be better, too, but that is nitpicking.

Mike
