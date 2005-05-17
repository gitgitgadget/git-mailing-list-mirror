From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] uml: remove elf.h
Date: Tue, 17 May 2005 23:34:47 +0200
Message-ID: <20050517213447.GN7136@pasky.ji.cz>
References: <200505171704.j4HH4Ne8002532@hera.kernel.org> <20050517142113.59097a3d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>,
	Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
X-From: git-owner@vger.kernel.org Tue May 17 23:36:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY9i9-0002va-RK
	for gcvg-git@gmane.org; Tue, 17 May 2005 23:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbVEQVfH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 17:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVEQVfH
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 17:35:07 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38884 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261953AbVEQVes (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2005 17:34:48 -0400
Received: (qmail 27380 invoked by uid 2001); 17 May 2005 21:34:47 -0000
To: Andrew Morton <akpm@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050517142113.59097a3d.akpm@osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, May 17, 2005 at 11:21:13PM CEST, I got a letter
where Andrew Morton <akpm@osdl.org> told me that...
> Linux Kernel Mailing List <linux-kernel@vger.kernel.org> wrote:
> >
> > tree a3d85d9f43f64bbd8437c973caf98f79d95b5f3e
> > parent a123edab03ac39e08c2f9cb4fc1af07e099c68bc
> > author Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it> Tue, 17 May 2005 11:53:14 -0700
> > committer Linus Torvalds <torvalds@ppc970.osdl.org> Tue, 17 May 2005 21:59:11 -0700
> > 
> > [PATCH] uml: remove elf.h
> > 
> > Actually remove elf.h in the tree.  The previous patch, due to a quilt
> > bug/misuse, left it in the tree as a 0-length file, preventing the build to
> > see it as missing and to generate a symlink in its place.
> > 
> > Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
> > Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> > 
> >  asm-um/elf.h |    0 
> >  1 files changed
> > 
> > Index: include/asm-um/elf.h
> 
> Hot damn, this zero-length file is hard to get rid of.  I pulled Linus's
> tree this morning with this bizarre concoction:
> 
> 	cd $GIT_TREE
> 	cg-pull origin
> 	tagsha1=$(cat .git/refs/tags/v$(kversion))
> 	t=$(cat-file tag $tagsha1 | head -n 1 | sed -e 's/object //')
> 	cg-diff -r $t -r $(cat .git/refs/heads/origin) > $PULL/linus.patch
> 
> and the resulting diff has:
> 
> Index: include/asm-ia64/ioctl32.h
> ===================================================================
> --- eed337ef5e9ae7d62caa84b7974a11fddc7f06e0/include/asm-ia64/ioctl32.h  (mode:100644 sha1:d0d227f45e05d23705ac849f4bd5c06a28288b58)
> +++ 6bb5a1cf91bbda8308ec7e6d900cb89071907dcd/include/asm-ia64/ioctl32.h  (mode:100644 sha1:e69de29bb2d1d6434b8b29ae775ad8c2e48c5391)
> @@ -1 +0,0 @@
> -#include <linux/ioctl32.h>
> Index: include/asm-um/elf.h
> ===================================================================
> Index: include/asm-x86_64/apicdef.h
> ===================================================================
> 
> which of course doesn't remove that file at all.
> 
> And I bet that when Linus releases patch-2.6.12-rc5.gz and patch-2.6.12.gz,
> they will have the same construct.  AFAICT, the patch-based people will
> need to download a full new tarball to get rid of this dang file.

Feeding
--- include/asm-um/elf.h
+++ /dev/null
patch to cg-patch would make Cogito kill it. No help for regular patch
though, I fear. Perhaps some artificial timestamp could help to the file
removal heuristic in GNU patch. Or passing it -E, but that will
obviously do the wrong thing to any other zero-sized files.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
