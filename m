From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] builtin clone: support bundles
Date: Sun, 2 Mar 2008 11:48:13 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803021128510.19665@iabervon.org>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org> <200802260321.14038.johan@herland.net> <alpine.LNX.1.00.0802261128360.19024@iabervon.org> <alpine.LSU.1.00.0803020556380.22527@racer.site> <alpine.LSU.1.00.0803020622190.22527@racer.site>
 <alpine.LSU.1.00.0803020743170.22527@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 02 17:49:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVrN3-0007YB-7i
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 17:49:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204AbYCBQsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 11:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753333AbYCBQsR
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 11:48:17 -0500
Received: from iabervon.org ([66.92.72.58]:45893 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754202AbYCBQsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 11:48:16 -0500
Received: (qmail 15248 invoked by uid 1000); 2 Mar 2008 16:48:13 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Mar 2008 16:48:13 -0000
In-Reply-To: <alpine.LSU.1.00.0803020743170.22527@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75805>

On Sun, 2 Mar 2008, Johannes Schindelin wrote:

> +	for (i = 0; i < ARRAY_SIZE(bundle_suffix); i++) {
> +		const char *path;
> +		path = mkpath("%s%s", repo, bundle_suffix[i]);
> +		if (!stat(path, &st) && S_ISREG(st.st_mode)) {
> +			*is_bundle = 1;
> +			return xstrdup(make_absolute_path(path));

The problem I'm seeing in general is that origin/next's make_absolute_path 
doesn't work on a regular file in the current directory. How are you 
getting those tests to pass?

In any case, I've got my current version at

git://iabervon.org/~barkalow/git.git builtin-clone

The top patch is possibly the correct change for make_absolute_path(), and 
I've incorporated your changes (except that I'd reorganized a bunch of 
stuff already, making some of them unnecessary and doing some of them 
slightly differently). For example, I just make bundles not count as 
local, and let transport.c deal with them in the normal path.

	-Daniel
*This .sig left intentionally blank*
