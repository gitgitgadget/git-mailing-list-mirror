From: "Panagiotis Vossos" <pavossos@gmail.com>
Subject: Re: git-svn: regression with funny chars in svn repo url
Date: Wed, 9 Apr 2008 00:54:42 +0300
Message-ID: <d06901f0804081454r76a373e6h745f99a9dcbd6bc5@mail.gmail.com>
References: <d06901f0804011111o1da8a197ob6a9aaccb3e1e9a0@mail.gmail.com>
	 <20080407081108.GA28853@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Apr 08 23:55:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjLmz-0007vp-Oc
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 23:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137AbYDHVyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 17:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753990AbYDHVyx
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 17:54:53 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:34245 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753845AbYDHVyw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 17:54:52 -0400
Received: by yw-out-2324.google.com with SMTP id 5so426588ywb.1
        for <git@vger.kernel.org>; Tue, 08 Apr 2008 14:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=3OGnxYnByKLlzSk2UXSGTYZ7QdY6944cjPRCN+/8QSU=;
        b=ACw+XXWHM1hUCRIdaQd57T8JdtlBmxfFBWVmeL5p19YdFFUh0xfBuhL0iwbcFqLDxmFu54XQmzBjzFVc4fiWgzEPlGzOM37tmALs4rxnueH8h2LwMUoK1IyN/uBM+uGmscbYETL1S0QVV7Q26PHtScXFSzU3mc+guBWaJsn4APs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NDWKhNkAyah9nu2Xq4rZts493x8hdPFhDOO9N2wpEFM0T8kyMW5TTUqgnFFOfHr3GqgRbx1cecLmuTQLHjSC9RnF4oIoj8rWY2KXlbeTwkrkHxuvez5t3dLN6cLodTF+YX2NG0K5jlZ84aqwhzAupLm/Ns4VfFIylOR5Not/mzg=
Received: by 10.151.145.17 with SMTP id x17mr4292359ybn.182.1207691682620;
        Tue, 08 Apr 2008 14:54:42 -0700 (PDT)
Received: by 10.150.134.8 with HTTP; Tue, 8 Apr 2008 14:54:42 -0700 (PDT)
In-Reply-To: <20080407081108.GA28853@soma>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79035>

On Mon, Apr 7, 2008 at 11:11 AM, Eric Wong <normalperson@yhbt.net> wrote:

> Panagiotis Vossos <pavossos@gmail.com> wrote:
>  > I keep a copy of the gtk+ svn repository on my machine and I have
>  > noticed the following bug with git-svn:
>  >
>  > ~/gitproj/gtk+$ git-svn --version
>  > git-svn version 1.5.4.5 (svn 1.4.6)
>  >
>  > ~/gitproj/gtk+$ git-svn rebase
>  > Apache got a malformed URI: REPORT request failed on
>  > '/svn/gtk+/!svn/vcc/default': Unusable URI: it does not refer to this
>  > repository at /usr/local/bin/git-svn line 3821
>
>  I've known of this bug for a while but didn't track it down until
>  now.  Please let me know if this fixes things for you and if
>  there are any regressions; thanks.
>
>  From a9ebe54adf7ae2620fba1f638dee9566f8ccca82 Mon Sep 17 00:00:00 2001
>  From: Eric Wong <normalperson@yhbt.net>
>  Date: Mon, 7 Apr 2008 00:41:44 -0700
>  Subject: [PATCH] git-svn: fix cloning of HTTP URLs with '+' in their path
>
>  With this, git svn clone -s http://svn.gnome.org/svn/gtk+
>  is successful.

First of all, thanks for your reply.

I applied the patch, but now 'git-svn rebase' gives me
a different error.

first, some context (I am on a branch based on remote trunk):

~/gitproj/gtk+$ git log | head
commit e350328dee85f872db7689bf4ec7b577419333ee
Author: tvb <tvb@7eb1c76a-c725-0410-a3b5-a37faf6256f8>
Date:   Sun Apr 6 03:10:23 2008 +0000

        * gtk/gtkwidget.c: Clarified a g_warning message regarding
        parsing accelerators from builder files.

    git-svn-id: http://svn.gnome.org/svn/gtk+/trunk@19978
7eb1c76a-c725-0410-a3b5-a37faf6256f8


Trying with the latest git from the maint branch, with your patch applied:

~/gitproj/gtk+$ git-svn --version
git-svn version 1.5.4.5.dirty (svn 1.4.6)

~/gitproj/gtk+$ git-svn rebase
Index mismatch: d486332848849ca1e0555d4608df396946e20ad0 !=
ee3933caad632a093c1f7d98b813298ee806f333
rereading e350328dee85f872db7689bf4ec7b577419333ee
        M       Makefile.decl
        D       gtk/compose-parse.py
        D       gtk/gtkimcontextsimpleseqs.h
        D       gtk/gtkmountoperation.c
        D       gtk/gtkmountoperation.h
        M       gtk/gtkprogressbar.c
        M       gtk/gtkfilechooserentry.h
        M       gtk/gtktreeitem.c
        M       gtk/gtkfilechooserdialog.c
        M       gtk/gtkwidget.c
        M       gtk/gtktreemodelfilter.c
        M       gtk/gtkwidget.h
        M       gtk/gtkfixed.c
        M       gtk/gtkexpander.c
[lots and lots of lines snipped]
        M       gdk/gdkgc.h
        M       gdk/gdkcairo.h
        M       gdk/Makefile.am
        M       gdk/x11/gdkdisplay-x11.c
        M       gdk/x11/gdkkeys-x11.c
        M       gdk/x11/gdkscreen-x11.c
        M       gdk/x11/gdkprivate-x11.h
        M       gdk/x11/gdkgeometry-x11.c
        M       gdk/x11/gdkinput-x11.c
        M       gdk/x11/gdktestutils-x11.c
        M       gdk/x11/gdkwindow-x11.c
        M       gdk/x11/gdkcolor-x11.c
        M       gdk/x11/gdkmain-x11.c
        M       gdk/x11/gdkgc-x11.c
        M       Makefile.am
        M       examples/scribble-xinput/scribble-xinput.c
W: -empty_dir: trunk/modules/other/gail/tests
Last fetched revision of refs/remotes/trunk was r19978, but we are
about to fetch: r19234!


Trying with an old git version from my encap directory:

:~/gitproj/gtk+$ /usr/local/encap/git-1.5.3_20071207/bin/git-svn rebase
Index mismatch: d486332848849ca1e0555d4608df396946e20ad0 !=
ee3933caad632a093c1f7d98b813298ee806f333
rereading e350328dee85f872db7689bf4ec7b577419333ee
        M       gtk/gtkmenushell.c
        M       ChangeLog
r19981 = c8db7cf297fa5c309e8723b3eb0ee31be3413bf8 (trunk)
        M       gtk/gtkfilesystem.c
        M       ChangeLog
r19982 = f180aa33ce1d3b64305d4e7a7370f58027355767 (trunk)
        M       demos/gtk-demo/builder.c
        M       ChangeLog
r19985 = 36b09bfe222bd87c7463ac3042325c864fe5de7a (trunk)
First, rewinding head to replay your work on top of it...
HEAD is now at 36b09bf... 2008-04-08  Tor Lillqvist  <tml@novell.com>
Fast-forwarded my/trunk to refs/remotes/trunk.


Before reverting your patch, I tried with the glib repository, that one
has no special chars in svn url:

~/gitproj/glib$ git-svn rebase
        M       glib/gunicode.h
        M       ChangeLog
r6843 = b38a1500f212791de7b179cf358d2593d3afcc9d (trunk)
First, rewinding head to replay your work on top of it...
HEAD is now at b38a150... 2008-04-08  Behdad Esfahbod  <behdad@gnome.org>
Fast-forwarded my/trunk to refs/remotes/trunk.
~/gitproj/glib$

That one worked perfectly.  Now I reverted your patch, and tried
again on gtk+ repo with vanilla upstream git from maint branch:

~/gitproj/gtk+$ git-svn  rebase
Apache got a malformed URI: REPORT request failed on
'/svn/gtk+/!svn/vcc/default': Unusable URI: it does not refer to this
repository at /usr/local/bin/git-svn line 3821


regards,
panagiotis
