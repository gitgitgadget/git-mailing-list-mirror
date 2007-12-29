From: Dan McGee <dpmcgee@gmail.com>
Subject: Re: generated HTML contains broken links
Date: Fri, 28 Dec 2007 21:01:17 -0600
Message-ID: <4775B87D.4010507@gmail.com>
References: <87sl1mqt10.fsf@offby1.atm01.sea.blarg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Hanchrow <offby1@blarg.net>
X-From: git-owner@vger.kernel.org Sat Dec 29 04:01:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8RxN-0007pj-NM
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 04:01:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753648AbXL2DBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2007 22:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753469AbXL2DBZ
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 22:01:25 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:43213 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169AbXL2DBY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2007 22:01:24 -0500
Received: by py-out-1112.google.com with SMTP id u52so8027542pyb.10
        for <git@vger.kernel.org>; Fri, 28 Dec 2007 19:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:followup-to:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=Te+pHpbYcq8D5R/gHLON4KSrQvmw6A1/oFMFL7DqZxE=;
        b=lKAdx2khO5+TSqNADXu1DVysirFxgo5sUNJUYlXIp4O+ejhjFYw+JHTbyAyaAo/Pp2Dmtby9u/57FLbSX65GJZlxq5cU7gms3fWh05W9DWrvUky4KgT60Sh39Pe8ph5ZjRcjEHTAUfJqSRqIbdnonEzmT71mcVXew147ZyipQzA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:followup-to:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Wy4qvm3SMxq1TlAYteixyDxw7xk5UZslSbg+tApFVghXHzq7zurhpaIL/2grjdVdIB8QdoFtqFVqoQaSIN1uIvMNx7h4VRBONnXN1NkvLATdSg9Xu2cQCaANVbCnoqJlH9Ql9rL7fvQ2Z/03tAixLHiqSbMJ2F+J5/iwpPoH1ss=
Received: by 10.35.49.4 with SMTP id b4mr11744543pyk.35.1198897281443;
        Fri, 28 Dec 2007 19:01:21 -0800 (PST)
Received: from ?192.168.1.100? ( [76.198.178.47])
        by mx.google.com with ESMTPS id f51sm16608695pyh.10.2007.12.28.19.01.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Dec 2007 19:01:20 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (X11/20071212)
Followup-To: gmane.comp.version-control.git
In-Reply-To: <87sl1mqt10.fsf@offby1.atm01.sea.blarg.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69307>

On 12/28/2007 05:49 PM, Eric Hanchrow wrote:
> I'm just starting to play with git, and have checked it out (with "git
> clone git://git.kernel.org/pub/scm/git/git.git"), and built the
> documentation (cd Documentation; make), on Cygwin.  I notice that the
> generated HTML docs are full of broken links -- for example, my file
> C:/cygwin/usr/local/src/git/Documentation/git.html includes this:
> 
>         git<a href="git-instaweb">1</a>
> 
> but there is no document named "git-instaweb" on my disk; instead,
> it's named "git-instaweb.html".
> 
> I'm using asciidoc version 8.2.4, if it matters.

We noticed this with the upgrade from Asciidoc 8.2.2 -> 8.2.3 on our project. It is broken in both the manpages and the HTML generated documentation. I've included an example below. So far, I haven't had luck tracking down the reason but I am looking into trying to fix this tonight. If anyone else is better with this stuff, it would be great if you could take a look.

Relevant email on the pacman-dev list [1]:

On Nov 9, 2007 4:05 PM, Andrew Fyfe <andrew@neptune-one.net> wrote:
> Did little digging, the breakage/change is in now asciidoc converts from asciidoc to xml (so it's 
> not docbook-xsl). In 8.2.2 manlink:pacman.conf[5] expands to
> 
> <citerefentry><refentrytitle>pacman.conf</refentrytitle><manvolnum>5</manvolnum></citerefentry>,
> 
> in 8.2.3 it expands to
> 
> man<ulink url="pacman.conf">5</ulink>,

Note that manlink is basically just a renamed gitlink, and can be found here:
<http://projects.archlinux.org/git/?p=pacman.git;a=blob;f=doc/asciidoc.conf>

-Dan

[1] <http://archlinux.org/pipermail/pacman-dev/2007-November/009937.html>



Generated man pages from Junio:
HOOKS
       This command can run commit-msg, pre-commit, and post-commit hooks. See
       [1]hooks for more information.

SEE ALSO
       git-add(1), git-rm(1), git-mv(1), git-merge(1), git-commit-tree(1)

AUTHOR
       Written by Linus Torvalds <torvalds@osdl.org> and Junio C Hamano
       <junkio@cox.net>

GIT
       Part of the git(7) suite

Man pages generated locally (with Asciidoc 8.2.3 or 8.2.5):
HOOKS
       This command can run commit-msg, pre-commit, and post-commit hooks. See
       hooks[5] for more information.

SEE ALSO
       git1[1], git1[2], git1[8], git1[6], git1[9]

AUTHOR
       Written by Linus Torvalds <torvalds@osdl.org> and Junio C Hamano
       <junkio@cox.net>

GIT
       Part of the git7[10] suite
