From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: regression with funny chars in svn repo url
Date: Sat, 10 May 2008 17:10:03 -0700
Message-ID: <20080511000953.GA3128@yp-box.dyndns.org>
References: <d06901f0804011111o1da8a197ob6a9aaccb3e1e9a0@mail.gmail.com> <20080407081108.GA28853@soma> <d06901f0804081454r76a373e6h745f99a9dcbd6bc5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Panagiotis Vossos <pavossos@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 02:11:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Juz9j-0000hF-Se
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 02:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbYEKAKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 20:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752660AbYEKAKN
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 20:10:13 -0400
Received: from hand.yhbt.net ([66.150.188.102]:52523 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752362AbYEKAKL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 20:10:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id B025C2DC08B;
	Sat, 10 May 2008 17:10:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <d06901f0804081454r76a373e6h745f99a9dcbd6bc5@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81717>

Hi again, sorry I've forgotten about this issue for a while :x

Panagiotis Vossos <pavossos@gmail.com> wrote:
> On Mon, Apr 7, 2008 at 11:11 AM, Eric Wong <normalperson@yhbt.net> wrote:
> 
> > Panagiotis Vossos <pavossos@gmail.com> wrote:
> >  > I keep a copy of the gtk+ svn repository on my machine and I have
> >  > noticed the following bug with git-svn:
> >  >
> >  > ~/gitproj/gtk+$ git-svn --version
> >  > git-svn version 1.5.4.5 (svn 1.4.6)
> >  >
> >  > ~/gitproj/gtk+$ git-svn rebase
> >  > Apache got a malformed URI: REPORT request failed on
> >  > '/svn/gtk+/!svn/vcc/default': Unusable URI: it does not refer to this
> >  > repository at /usr/local/bin/git-svn line 3821
> >
> >  I've known of this bug for a while but didn't track it down until
> >  now.  Please let me know if this fixes things for you and if
> >  there are any regressions; thanks.
> >
> >  From a9ebe54adf7ae2620fba1f638dee9566f8ccca82 Mon Sep 17 00:00:00 2001
> >  From: Eric Wong <normalperson@yhbt.net>
> >  Date: Mon, 7 Apr 2008 00:41:44 -0700
> >  Subject: [PATCH] git-svn: fix cloning of HTTP URLs with '+' in their path
> >
> >  With this, git svn clone -s http://svn.gnome.org/svn/gtk+
> >  is successful.
> 
> First of all, thanks for your reply.
> 
> I applied the patch, but now 'git-svn rebase' gives me
> a different error.
> 
> first, some context (I am on a branch based on remote trunk):
> 
> ~/gitproj/gtk+$ git log | head
> commit e350328dee85f872db7689bf4ec7b577419333ee
> Author: tvb <tvb@7eb1c76a-c725-0410-a3b5-a37faf6256f8>
> Date:   Sun Apr 6 03:10:23 2008 +0000
> 
>         * gtk/gtkwidget.c: Clarified a g_warning message regarding
>         parsing accelerators from builder files.
> 
>     git-svn-id: http://svn.gnome.org/svn/gtk+/trunk@19978
> 7eb1c76a-c725-0410-a3b5-a37faf6256f8
> 
> 
> Trying with the latest git from the maint branch, with your patch applied:
> 
> ~/gitproj/gtk+$ git-svn --version
> git-svn version 1.5.4.5.dirty (svn 1.4.6)
> 
> ~/gitproj/gtk+$ git-svn rebase
> Index mismatch: d486332848849ca1e0555d4608df396946e20ad0 !=
> ee3933caad632a093c1f7d98b813298ee806f333
> rereading e350328dee85f872db7689bf4ec7b577419333ee
>         M       Makefile.decl
>         D       gtk/compose-parse.py
>         D       gtk/gtkimcontextsimpleseqs.h
>         D       gtk/gtkmountoperation.c
>         D       gtk/gtkmountoperation.h
>         M       gtk/gtkprogressbar.c
>         M       gtk/gtkfilechooserentry.h
>         M       gtk/gtktreeitem.c
>         M       gtk/gtkfilechooserdialog.c
>         M       gtk/gtkwidget.c
>         M       gtk/gtktreemodelfilter.c
>         M       gtk/gtkwidget.h
>         M       gtk/gtkfixed.c
>         M       gtk/gtkexpander.c
> [lots and lots of lines snipped]
>         M       gdk/gdkgc.h
>         M       gdk/gdkcairo.h
>         M       gdk/Makefile.am
>         M       gdk/x11/gdkdisplay-x11.c
>         M       gdk/x11/gdkkeys-x11.c
>         M       gdk/x11/gdkscreen-x11.c
>         M       gdk/x11/gdkprivate-x11.h
>         M       gdk/x11/gdkgeometry-x11.c
>         M       gdk/x11/gdkinput-x11.c
>         M       gdk/x11/gdktestutils-x11.c
>         M       gdk/x11/gdkwindow-x11.c
>         M       gdk/x11/gdkcolor-x11.c
>         M       gdk/x11/gdkmain-x11.c
>         M       gdk/x11/gdkgc-x11.c
>         M       Makefile.am
>         M       examples/scribble-xinput/scribble-xinput.c
> W: -empty_dir: trunk/modules/other/gail/tests
> Last fetched revision of refs/remotes/trunk was r19978, but we are
> about to fetch: r19234!

Really weird.  This could be a rev_db => rev_map migration issues, but I
haven't been able to reproduce any of it.  However, for most users
(those not using noMetadata or useSvmProps options, just blowing away
rev_db is safe).

-- 
Eric Wong
