From: Richard Holmes <rholmes777@gmail.com>
Subject: git-svn: simple user-level versions question, plus help request
Date: Thu, 16 Feb 2012 14:57:58 -0600
Message-ID: <CAJaBf=oFpNZ3gf=Oqj9415_WpMyAM=EYnW6R9cZCPteqSxnogQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 16 21:58:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ry8P6-0005Na-Gd
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 21:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755753Ab2BPU57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 15:57:59 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:63043 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089Ab2BPU57 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 15:57:59 -0500
Received: by vcge1 with SMTP id e1so1831489vcg.19
        for <git@vger.kernel.org>; Thu, 16 Feb 2012 12:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=prQOPs/uzlCBKB7kbX1HwcmQ0IoykX+qdOBf9lEold4=;
        b=rld6pvwp3xwGvHJbJ3eWV0HdFt5xIm0eTA6++RqzNzUUgpCE9gD+SWxR9E4i1cgwW8
         H1zR73kn4+U020xn21eXOESMZEwInsDaCW7iQIVjgsgETeRSlUzTAvEh1ANov0vFqp7t
         kH/6q1ZasV8LAf+d2Zs/oko0xCF+AyGlmc9hc=
Received: by 10.220.149.200 with SMTP id u8mr2178917vcv.35.1329425878293; Thu,
 16 Feb 2012 12:57:58 -0800 (PST)
Received: by 10.52.240.171 with HTTP; Thu, 16 Feb 2012 12:57:58 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190909>

Hi all,

I've enjoyed using git-svn in the past, and it's been great until I
had to update my local svn executable to support the server's adoption
of sslv3.  I updated and configured my svn client with ra_serf and
then I could use svn standalone again.

When I went back to a git-svn project, I found that I could no longer
interact with the svn server via git-svn.  I tried recreate the
git-svn tree by blowing away my working copy and starting over:
     git svn init --stdlayout https://<redacted>/svn/path/to/repo
and got the familiar ssl error:
    Initialized empty Git repository in /Volumes/foo/bar/.git/
    RA layer request failed: OPTIONS of
'https://<redacted>/svn/path/to/repo': SSL handshake failed: SSL
error: bad decompression (https://<redacted>) at
/usr/local/Cellar/git/1.7.8.2/libexec/git-core/git-svn line 2299

(Yes, I'm using MacOS Lion and Homebrew to install git).  So, it
appears that the svn with the ra_serf is not being used by git-svn.
Obvious questions:
    1) Can I force git to use "my" version of svn for git-svn?
    2) If so, how / where is this configured?
    3) If not, what else can I do to get git-svn to talk to my svn server?

After looking at the respective versions, it appears that git svn
shows svn version 1.6.16 and my svn (standalone) client shows svn
version 1.6.17 (and its associated RA modules):

    $ git svn --version
    git-svn version 1.7.8.2 (svn 1.6.16)
    $ svn --version
svn, version 1.6.17 (r1128011)
   compiled Aug 26 2011, 09:41:54

Copyright (C) 2000-2009 CollabNet.
Subversion is open source software, see http://subversion.apache.org/
This product includes software developed by CollabNet (http://www.Collab.Net/).

The following repository access (RA) modules are available:

* ra_neon : Module for accessing a repository via WebDAV protocol using Neon.
  - handles 'http' scheme
  - handles 'https' scheme
* ra_svn : Module for accessing a repository using the svn network protocol.
  - with Cyrus SASL authentication
  - handles 'svn' scheme
* ra_local : Module for accessing a repository on local disk.
  - handles 'file' scheme
* ra_serf : Module for accessing a repository via WebDAV protocol using serf.
  - handles 'http' scheme
  - handles 'https' scheme

$ which git
/usr/local/bin/git
$ which svn
/opt/subversion/bin/svn

Sorry for the long post, but any help would be appreciated.  Doesn't
seem to be a common problem (judging from lack of discussion on
google), so I'd appreciate any pointers, either to documentation about
git's svn path / configuration, problem tickets, or ways to determine
if I've done something wonky to my environment to seriously confuse
git / svn.

Thanks!

-Richard.
