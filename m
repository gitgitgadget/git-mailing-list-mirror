From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: jgit and ignore
Date: Sun, 1 Mar 2009 09:47:29 -0800
Message-ID: <20090301174729.GC14365@spearce.org>
References: <9e4733910902280831j70448ce9h7239f14e13b92b76@mail.gmail.com> <20090228172622.GC26689@spearce.org> <49AA5F64.6070207@pelagic.nl> <9e4733910903010454u662eb5afob45f608321660500@mail.gmail.com> <49AA884D.1050806@pelagic.nl> <49AA8ECD.4090302@gmail.com> <49AA91F0.7050008@pelagic.nl> <49AAA2B3.40808@gmail.com> <20090301171648.GB14365@spearce.org> <49AAC959.70406@pelagic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tor Arne =?iso-8859-1?Q?Vestb=F8?= <torarnv@gmail.com>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Sun Mar 01 18:49:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ldpmx-0001v9-Lb
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 18:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756099AbZCARrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 12:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756078AbZCARrb
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 12:47:31 -0500
Received: from george.spearce.org ([209.20.77.23]:43793 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753634AbZCARrb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 12:47:31 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id BAFD938210; Sun,  1 Mar 2009 17:47:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49AAC959.70406@pelagic.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111861>

"Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl> wrote:
> > IMHO, we should honor ignores in EGit as:
> > 
> >   per-directory .gitignore
> >   per-repostiory GIT_DIR/info/exclude
> > 
> >   per-repository core.excludesfile (yes, really, it can be per
> >   repository, which overrides ~/.gitconfig setting of same)
> 
> wow. override? really?

Yes.  I'd have to go back and read the git-core code again, but in
general a config setting of foo.bar in GIT_DIR/config overrides a
foo.bar setting in ~/.gitconfig, *unless* you use the --all flag.

Most of the C code parses as though the last value seen is the
only value set, and GIT_DIR/config is parsed after ~/.gitconfig,
hence it overrides.
 
> >   Eclipse global team ignore patterns
> 
> so, should these then override, supplement, or something else?
> the per-repo files (.gitignore's and info/exclude supplement eachother.

They all supplement each other.  You union every entry in that list
into a single override set and then evaluate against that.  That list
changes with each directory, due to the per-directory .gitignore
possibly changing, but otherwise its fixed for any given repository.
 
-- 
Shawn.
