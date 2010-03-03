From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: git-svn died of signal 11 (was "3 failures on test t9100 (svn)")
Date: Wed, 3 Mar 2010 10:22:13 +0100
Message-ID: <20100303092213.GA12909@vidovic.wsb>
References: <20100302194518.GA12942@vidovic> <20100302212806.GA21413@coredump.intra.peff.net> <20100303005804.GA17120@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Wed Mar 03 10:22:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nmkmm-0004Yf-87
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 10:22:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755101Ab0CCJW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 04:22:26 -0500
Received: from mail-ew0-f220.google.com ([209.85.219.220]:33222 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754254Ab0CCJWX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 04:22:23 -0500
Received: by ewy20 with SMTP id 20so789438ewy.21
        for <git@vger.kernel.org>; Wed, 03 Mar 2010 01:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=aLvD7QVUCOwhTQ2l4DKGosyiFzjDNOvqzHPW9AAEu6Q=;
        b=HRrr8C2Ejtemanwu/5PVfbjdnlGg/UHipjxXkPG6eD1K/hQZiyuPgz0GelQSKSgqki
         yqPBGP6eA88BxvkTGhIoXxJMUZOK5V1iqMbj2QNpAn6ACOYX1Z6i0vIxX/B4M8D6mlCw
         BNltEYGJRoNWphcncd45xDUHQOe2xkusM6ST4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FyqiIDMjePpL0AzSBZTGSBK4Wob1zUpREYM1FJwTfRWy2HwLABNzCxezdHA3jnkqmc
         18GI0ow7kf45pF8J2nBAuoiRK//JpcvOlxiN8M9O73L1SVpuUAXxtR3oASzd2b6EpwEq
         gU/fUm8fA2z6LCjS/cIhX2+hM+heUpQF3ii4M=
Received: by 10.213.67.205 with SMTP id s13mr1934933ebi.1.1267608140414;
        Wed, 03 Mar 2010 01:22:20 -0800 (PST)
Received: from vidovic.wsb (che33-3-82-226-242-200.fbx.proxad.net [82.226.242.200])
        by mx.google.com with ESMTPS id 16sm3619608ewy.15.2010.03.03.01.22.15
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 03 Mar 2010 01:22:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100303005804.GA17120@vidovic>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141441>

The 03/03/10, Nicolas Sebrecht wrote:

> That said, I did the svn tests because sometimes I have reproductible
> errors with 'git svn fetch' or 'git svn clone'. I'm not sure how both
> problems could be related... git-svn is a Perl script. The given message
> for this one is "error: died with signal 11" from what I remember (but
> I'm sure about the "signal 11" part).

Here we are:

  $ git svn fetch
  error: git-svn died of signal 11

This is reproductible in most of my repositories based on a remote
subversion server.

Examples:
#1

  $ cd okawix
  $ cat .git/config
  <...>
  [svn-remote "svn"]
    url = https://okawix.svn.sourceforge.net/svnroot/okawix
    fetch = :refs/remotes/git-svn

  $ git svn fetch
    A branches/liquid-okawix-experiment/okawix/components/owItemEnumerator.js
    A branches/liquid-okawix-experiment/okawix/components/owContentList.js
    M branches/liquid-okawix-experiment/okawix/components/owContentItem.js
    M branches/liquid-okawix-experiment/okawix/chrome/content/interfacewiki/js/corpus.js
    M branches/liquid-okawix-experiment/minitar/CMakeLists.txt
    M branches/liquid-okawix-experiment/public/owIContentItem.idl
    A branches/liquid-okawix-experiment/public/owIList.idl
    M branches/liquid-okawix-experiment/public/owIItem.idl
    A branches/liquid-okawix-experiment/public/owIItemListener.idl
    M branches/liquid-okawix-experiment/public/CMakeLists.txt
  r113 = 6beca3525de64c1883c610e505b801bffdacff9f (refs/remotes/git-svn)
    M branches/liquid-okawix-experiment/okawix/components/owContentItem.js
  r114 = 9dcffad45f421bcfb681b9427f8d8d2b52ac02c6 (refs/remotes/git-svn)
    M branches/liquid-okawix-experiment/okawix/components/owContentList.js
    M branches/liquid-okawix-experiment/okawix/chrome/content/interfacewiki/js/corpussidebar.js
    M branches/liquid-okawix-experiment/okawix/chrome/content/interfacewiki/js/corpus.js
    M branches/liquid-okawix-experiment/public/owIList.idl
    A branches/liquid-okawix-experiment/public/owIListListener.idl
    M branches/liquid-okawix-experiment/public/CMakeLists.txt
  r115 = 3bfa1336d8ea00d722fadbf15f0b2ba4a3818b70 (refs/remotes/git-svn)
  error: git-svn died of signal 11
  $

#2

  $ cd plume-cms
  $ cat .git/config
  <...>
  [svn-remote "svn"]
    url = https://pxsystem.svn.sourceforge.net/svnroot/pxsystem
    fetch = :refs/remotes/git-svn
  $ git svn fetch
  error: git-svn died of signal 11
  $


_But_ git-svn works as expected in the gccgo repository for example:

  $ cd gccgo
  $ cat .git/config
  <...>
  [svn-remote "svn"]
    url = svn://gcc.gnu.org/svn/gcc/branches/gccgo
    fetch = :refs/remotes/git-svn
  $ git svn fetch
  $

> I'll do more investigations at work tomorrow. I've already tried to add
> the "-d" flag in git-svn and it didn't help neither: git looked like in
> an infinite loop. Odd, odd, odd.

Adding the -d option to the shebang of git-svn doesn't help. I've
stopped the process after 24 minutes running.  I have no more
information with the -w option set.

For repositories where it works, the debug option works as expected too:

  $ cd gccgo
  $ git svn fetch
  Loading DB routines from perl5db.pl version 1.28
  Editor support available.
  Enter h or `h h' for help, or `man perldebug' for more help.
  
  main::(/home/nicolas/bin/libexec/git-core/git-svn:10):
  10: $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
    DB<1> c
  Debugged program terminated.  Use q to quit or R to restart,
  <...>
  $

What shall I do next?

-- 
Nicolas Sebrecht
