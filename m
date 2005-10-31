From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Another problem with not existing directories
Date: Mon, 31 Oct 2005 09:35:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0510310929361.27915@g5.osdl.org>
References: <1130779234.5848.15.camel@blade>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 18:38:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWdZy-0002Uc-N5
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 18:36:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbVJaRgQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 12:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbVJaRgQ
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 12:36:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13037 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750836AbVJaRgP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2005 12:36:15 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9VHbdsC023532
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 31 Oct 2005 09:37:41 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9VHZuw7016841;
	Mon, 31 Oct 2005 09:35:59 -0800
To: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1130779234.5848.15.camel@blade>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10867>



On Mon, 31 Oct 2005, Marcel Holtmann wrote:
> 
> I think there exists another problem with git-unpack-objects if the
> sub-directory in "objects" doesn't exists.

Are you sure you just don't have an old version of git on the other end?

As far as I know, git-unpack-objects will use the bog-standard 
"write_sha1_file()" which already knows how to create missing 
subdirectories.

This _sounds_ like the other end has two different versions of git, and 
when you "push" to it, it executes an old version, but then you have a 
newer version somewhere that created the sparsely-populated object 
directory in the first place.

This happens (for example) if you have installed an older version of git 
through an rpm (say, the one that comes from Fedora Core: 0.99.8) and you 
have that in /usr/bin, but then you have a newer version that you've built 
and installed yourself in your ~/bin/ directory.

If you have your PATH being set in your .bashrc, it won't trigger with a
non-interactive login, so you'll use the /usr/bin/ version when pushing, 
but then when you log in interactively to a shell, you'll use the ~/bin 
one (or the other way around, I'm easily confused by the bash config file 
rules ;)

		Linus
