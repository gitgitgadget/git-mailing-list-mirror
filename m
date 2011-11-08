From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [fyi] patches used by git distributors
Date: Tue, 8 Nov 2011 03:02:51 -0600
Message-ID: <20111108090251.GB17954@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 10:03:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNhaE-0002vb-W8
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 10:03:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277Ab1KHJDB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Nov 2011 04:03:01 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56225 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710Ab1KHJC4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2011 04:02:56 -0500
Received: by ggnb2 with SMTP id b2so314892ggn.19
        for <git@vger.kernel.org>; Tue, 08 Nov 2011 01:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=ZIWkvhHak90kymUzWg9EwopRnMAfelMOXgcTaCkSACw=;
        b=COLzHZo3ZwIHGFNIRlEnFqalG9mKq6Cd6IhC1inn4G+BGtppnQss58iFK5EuGvXy8a
         aXftRUjNdq/EftLkOFspq2qvQ8Hc3hKoT2SagdCQ7OQy8Fbk7Kc+3ry8yG4HqWPz0EaN
         WtDba4KkkcgmHQfNWaCjZPC3K4lq5fMuZADqU=
Received: by 10.236.197.72 with SMTP id s48mr40807757yhn.81.1320742976135;
        Tue, 08 Nov 2011 01:02:56 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id k20sm2591808ann.15.2011.11.08.01.02.54
        (version=SSLv3 cipher=OTHER);
        Tue, 08 Nov 2011 01:02:55 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185079>

Hi,

In an ideal world, each patch applied by downstream distributors would
fall into one of two categories: (a) adapting the package to some
esoteric distro-specific requirement (i.e., special-interest patches)
or (b) in the process of being generalized and reviewed for eventual
application upstream, so everyone can benefit from it.  Unfortunately
that takes time.  I should do better --- sorry about that.

As an experiment, here's a quick summary of the patches being used
in Debian, for people curious about that and for people interested in
grabbing useful patches to polish and not knowing where to start.

(Links point to relevant discussion, not necessarily the patch used):

=46r=C3=A9d=C3=A9ric Bri=C3=A8re (1):
      gitk: Skip over AUTHOR/COMMIT_DATE when searching all fields [1]

Gerrit Pape (1):
      bug#506445: hooks/post-receive-email: set encoding to utf-8 [2]

Jonathan Nieder (12):
      remove shebang line from shell libraries [3]
      pre-rebase hook: capture documentation in a <<here document [4]
      gitk: use symbolic font names "sans" and "monospace"
      transport: expose git_tcp_connect and friends in new tcp.h [5]
      daemon: make host resolution into a separate function [5]
      daemon: move locate_host to tcp.c [5]
      tcp: unify ipv4 and ipv6 code paths [5]
      daemon: check for errors retrieving IP address [5]
      tcp: make dns_resolve return an error code [5]
      transport: optionally honor DNS SRV records [5]
      srv: make errors less quiet [5]
      Makefile: add a knob to turn off hardlinks within same directory =
[6]

The patches listed above are on the candidate+patches branch of [7].
Questions and improvements can go to git@packages.debian.org.

A few other packaging projects:

 - git://pkgs.fedoraproject.org/git.git master --- 3 patches (using
   SERVER_NAME for home link, reviving vc-git.el, compatibility with
   newer cvsps)
 - http://www.freebsd.org/cgi/cvsweb.cgi/ports/devel/git/files/ ---
   1 patch (capping individual reads and writes at INT_MAX chars)
 - https://build.opensuse.org/package/files?package=3Dgit&project=3Ddev=
el%3Atools%3Ascm
   --- 4 patches (a python build fix, making gitweb::prevent_xss
   default to true, turning off hardlinks for builtins at installation
   time, protecting COMP_WORDBREAKS from mangling in the completion
   script)
 - http://sources.gentoo.org/cgi-bin/viewvc.cgi/gentoo-x86/dev-vcs/git/=
files/
   --- 1 patch (a NO_CVS knob for the makefile).  Very nice.
 - http://cvsweb.netbsd.org/bsdweb.cgi/pkgsrc/devel/scmgit-base/patches=
/
   --- 3 patches (putting CFLAGS at the end of ALL_CFLAGS so it can
   override BASIC_CFLAGS, setting INSTALLDIRS=3Dvendor in perl makefile=
,
   improving tk support on Darwin 8)
 - http://www.openbsd.org/cgi-bin/cvsweb/ports/devel/git/patches/ ---
   8 patches (updating OpenBSD makefile defaults, using raw perlio in
   gitweb blob view, removing "set -e" in t9117, passing --text [well,
   -a] to grep in t9200, avoiding nonportable regex \+ in t9400)
 - ftp://ftp.cygwin.org/pub/cygwin/release/git/git-1.7.5.1-1-src.tar.bz=
2
   --- 3 patches (tcl 8.4.1 support, updating Cygwin makefile defaults,
   case-insensitive path comparison in makefile, special Windows-specif=
ic
   wish script preamble)

[1] http://thread.gmane.org/gmane.comp.version-control.git/142160
[2] http://thread.gmane.org/gmane.comp.version-control.git/181737
[3] http://bugs.debian.org/368792
[4] http://thread.gmane.org/gmane.comp.version-control.git/150737
[5] http://thread.gmane.org/gmane.comp.version-control.git/175106
[6] http://thread.gmane.org/gmane.comp.version-control.git/183361
[7] http://smarden.org/git/git.git
    gitweb: http://repo.or.cz/w/git/debian.org
