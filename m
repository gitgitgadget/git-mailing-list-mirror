From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] --amend Rename --pretty=changelog to --pretty=gnucl
Date: Sat, 3 Mar 2007 15:13:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703031511300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702271621120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0702280258200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <alpine.LRH.0.82.0702272147590.29426@xanadu.home>
 <Pine.LNX.4.63.0702281343200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vslcoghcd.fsf@assigned-by-dhcp.cox.net> <7v649icxis.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Simon Josefsson <simon@josefsson.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 03 15:13:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNUzG-0006Vb-P2
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 15:13:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbXCCONX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 09:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbXCCONX
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 09:13:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:43827 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030259AbXCCONX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 09:13:23 -0500
Received: (qmail invoked by alias); 03 Mar 2007 14:13:21 -0000
X-Provags-ID: V01U2FsdGVkX1/xGWMvFCnxydVzLAsRL2KN03mRD3V4RNKXbBcgOS
	0ZJ2pA0tW0Svll
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v649icxis.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41299>

Hi,

On Sat, 3 Mar 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Earlier, this code played dumb by outputting the file name and the comma
> > separately (to make it easier to determine when to output a colon
> > instead of the comma). This misguided code is fixed by this patch.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >
> > 	I know that this is a dead topic branch, but I did not want
> > 	to leave buggy code behind for future reference.
> 
> Huh?  How did you measure bugginess before and after the change?
> 
> $ ./git show -s --pretty=gnucl ':/convert object type h'
> 2007-02-26  Nicolas Pitre <nico@cam.org>
> 
> * archive-tar.c, archive-zip.c, blob.c, builtin-apply.c, 
>           uiltin-blame.c, builtin-cat-file.c, builtin-commit-tree.c, 
>           uiltin-for-each-ref.c, builtin-grep.c, builtin-log.c, 
>           uiltin-pack-objects.c, builtin-prune.c, builtin-reflog.c, 
>           uiltin-unpack-objects.c, cache.h, combine-diff.c, commit.c, 
>           onvert-objects.c, diff.c, entry.c, fast-import.c, http-push.c, 
>           ndex-pack.c, merge-file.c, merge-recursive.c, merge-tree.c, 
>           ktag.c, mktree.c, object.c, object.h, pack-check.c, read-cache.c,
>           sha1_file.c, tag.c, tree-diff.c, tree.c, unpack-file.c: convert
>           object type handling from a string to a number

For me, it is

$ ./git show -s --pretty=gnucl ':/convert object type h'
2007-02-26  Nicolas Pitre <nico@cam.org>

* archive-tar.c, archive-zip.c, blob.c, builtin-apply.c,
          builtin-blame.c, builtin-cat-file.c, builtin-commit-tree.c,
          builtin-for-each-ref.c, builtin-grep.c, builtin-log.c,
          builtin-pack-objects.c, builtin-prune.c, builtin-reflog.c,
          builtin-unpack-objects.c, cache.h, combine-diff.c, commit.c,
          convert-objects.c, diff.c, entry.c, fast-import.c, http-push.c,
          index-pack.c, merge-file.c, merge-recursive.c, merge-tree.c,
          mktag.c, mktree.c, object.c, object.h, pack-check.c,
          read-cache.c, sha1_file.c, tag.c, tree-diff.c, tree.c,
          unpack-file.c: convert object type handling from a string to a
          number

> Perhaps you would want something like this...
> 
> diff --git a/utf8.c b/utf8.c
> index ea23a6e..3a7b923 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -268,7 +268,9 @@ int print_wrapped_text(const char *text, int indent, int indent2, int width)
>  			}
>  			else {
>  				putchar('\n');
> -				text = bol = space + 1;
> +				if (isspace(*space))
> +					space++;
> +				text = bol = space;
>  				space = NULL;
>  				w = indent = indent2;
>  			}

... or something like in

$ git show ':/print_wrapped_text: fix output for negative indent'

?

Ciao,
Dscho
