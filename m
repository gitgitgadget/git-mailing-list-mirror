From: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>
Subject: Re: Bug: git add with absolute path fails if repo root dir is a
	symlink
Date: Mon, 27 Dec 2010 08:13:12 +0000
Message-ID: <20101227081312.GA12735@sajinet.com.pe>
References: <AANLkTi=Mj3AdinC87Ys35fv9DpZqefiZXhPbHMLdmyPh@mail.gmail.com> <AANLkTimPxhqwMebfTw9oHucuvABmSBynpZgG1zp6uwVz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Gladysh <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 27 09:24:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PX8N5-00031N-QA
	for gcvg-git-2@lo.gmane.org; Mon, 27 Dec 2010 09:24:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358Ab0L0IXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Dec 2010 03:23:54 -0500
Received: from sajino.sajinet.com.pe ([76.74.239.193]:52953 "EHLO
	sajino.sajinet.com.pe" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531Ab0L0IXy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Dec 2010 03:23:54 -0500
X-Greylist: delayed 641 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Dec 2010 03:23:54 EST
Received: by sajino.sajinet.com.pe (Postfix, from userid 1000)
	id B3FB2A580F1; Mon, 27 Dec 2010 08:13:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <AANLkTimPxhqwMebfTw9oHucuvABmSBynpZgG1zp6uwVz@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164215>

On Mon, Dec 27, 2010 at 10:23:12AM +0300, Alexander Gladysh wrote:
> 
> > I can't run git add with absolute path if the repository's root
> > directory is a symlink.
> 
> Note that this issue is also triggered if *any* of the directories in
> path above of my repo are symlinks.

When using absolute path names, git will compare the path given with the
git work tree and any name that is referred through a symlink in that
will trigger a mismatch.

> Is there a way to quickly workaround this somehow?

use relative paths (implemented below through an alias named "myadd") :

[alias]
        myadd = "!sh -c 'cd `dirname \"$1\"` && git add `basename \"$1\"`' -"

so in your workflow you would use "myadd" instead of "add" to convert your
absolute paths (with symlinks) into relative paths

Carlo
