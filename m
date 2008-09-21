From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH (GIT-GUI,GITK) 0/8] Encoding support in GUI
Date: Sun, 21 Sep 2008 17:55:48 -0500
Message-ID: <18646.53492.20994.908025@cargo.ozlabs.ibm.com>
References: <1221685659-476-1-git-send-email-angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 00:58:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhXsD-0005Gu-VH
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 00:57:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636AbYIUW4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 18:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752533AbYIUW4K
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 18:56:10 -0400
Received: from ozlabs.org ([203.10.76.45]:51767 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752495AbYIUW4K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 18:56:10 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 70028DDED8; Mon, 22 Sep 2008 08:56:07 +1000 (EST)
In-Reply-To: <1221685659-476-1-git-send-email-angavrilov@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96444>

Alexander Gavrilov writes:

> File encoding can be specified in the following ways:
> 
> 1) It defaults to the current locale encoding.
> 2) It can be overridden by setting the gui.encoding option.

I'm happy with providing a way to say what the default encoding of
files in the repository is, but I wonder why it is seen as a property
of the GUI.  Is it just that there is an existing "gui" section that
is convenient to use, or does git-gui already use gui.encoding (before
this patch series), or is there some other reason?

> 3) It can be further set on per-file basis by specifying
>    the 'encoding' attribute in gitattributes.

I haven't used .gitattributes before, but I would expect that the
.gitattributes files would be stored in the repository along with
everything else.  If that's the case, then for gitk at least there is
the question of which version of a given .gitattributes file one
should use when viewing the tree for a commit which isn't the
currently checked-out commit - do you use the version from that tree,
or the version in the working directory?  We seem to be using the
latter at present, and caching the results.  Is there a philosophical
reason to do that, other than speed?  (Also it seems that we won't
notice if the user changes .gitattributes after we've looked at it, or
if they create one after we've looked for one and not found it.)

> Since git apparently cannot work with filenames in non-locale
> encodings anyway, I did not try to do anything about it apart
> from fixing some obvious bugs.

For Linux, filenames are sequences of non-null bytes, so using
binary encoding to read them in Tcl sounds about right.

> There are also some bugs in handling of commit encodings in gitk,
> but they are out of the scope of this series.

I'm interested to hear what they are.

Paul.
