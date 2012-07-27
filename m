From: Sascha Cunz <Sascha@babbelbox.org>
Subject: Re: [RFC/PATCH] Use work tree to determine if it supports symlinks
Date: Sat, 28 Jul 2012 00:40:37 +0200
Message-ID: <3068717.2K7be5iONg@mephista>
References: <17699041.7b2cBoDgE0@mephista> <7vobn0zx5m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 28 00:47:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SutJu-0001fO-H4
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 00:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234Ab2G0Wr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 18:47:28 -0400
Received: from babbelbox.org ([83.133.105.186]:57538 "EHLO mail.babbelbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751832Ab2G0Wr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 18:47:26 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Jul 2012 18:47:25 EDT
Received: (qmail 6986 invoked from network); 27 Jul 2012 22:40:57 -0000
Received: from unknown (HELO mephista.localnet) (Sascha@Babbelbox.org@89.204.130.192)
  by babbelbox.org with ESMTPA; 27 Jul 2012 22:40:57 -0000
User-Agent: KMail/4.8.4 (Linux/3.4.4-gentoo; KDE/4.8.4; x86_64; ; )
In-Reply-To: <7vobn0zx5m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202389>

On Friday, July 27, 2012 02:55:49 PM you wrote:
> Sascha Cunz <Sascha-ML@babbelbox.org> writes:
> > From 3f449e719b924929f1f8ca9b5eff83f17bc64c60 Mon Sep 17 00:00:00 2001
> > From: Sascha Cunz <Sascha@BabbelBox.org>
> > Date: Fri, 27 Jul 2012 22:54:56 +0200
> > Subject: [PATCH] Use work tree to determine if it supports symlinks
> > 
> > When creating a new repository, we check some capabilities of the
> > underlying file system(s). We check the file system for its case
> > sensitivity and the ability to create symbolic links.
> > 
> > Before this patch the .git-dir was used for this check, while the
> > comments in code clearly state to test on the work tree.
> 
> That is simply because a layout that has .git and its containing
> directory (i.e. the working tree) on a separate filesystem when we
> run "git init" is not supported,

But isn't enforced either. Are there known issues?

> and more importantly, we do not
> want to step outside ".git", which is the simplest and safest way to
> avoid touching the end-user data that sits in the working tree.

While I think that this is true, I don't see the connection.

> The code comment is about checking the filesystem that houses both
> the working tree and ".git"; if the user later wants to turn .git
> into a separate mount point, or if the user wants to use GIT_DIR and
> GIT_WORK_TREE to create a funny layout, the user should know how to
> muck with ".git/config" to adjust to the peculiarity.

Ok, so repository and working directory are simply not meant to be on 
different file systems. Thanks for the clarification.
