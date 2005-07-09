From: Marc Singer <elf@buici.com>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Fri, 8 Jul 2005 18:11:19 -0700
Message-ID: <20050709011119.GA10981@buici.com>
References: <20050708230750.GA23847@buici.com> <7v4qb46dff.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jul 09 03:19:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dr3zS-0007J6-D2
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 03:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263061AbVGIBPH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 21:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263031AbVGIBNN
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 21:13:13 -0400
Received: from florence.buici.com ([206.124.142.26]:27114 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S263072AbVGIBLW
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 21:11:22 -0400
Received: (qmail 11251 invoked by uid 1000); 9 Jul 2005 01:11:19 -0000
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v4qb46dff.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>  $ git checkout -f v2.6.11 ;# fixed one
>  warning: v2.6.11 is not a commit -- not updating your HEAD
>  $ git commit ;# to have his own baseline at v2.6.11
>  $ git-apply --index --stat --summary --apply <../old-patch-file
>  $ : do the usual tests
>  $ git commit ;# create a commit based on the baseline v2.6.11

Interesting note.  I tried the git-apply command and found that it
complained and wouldn't succeed.

  elf@florence ~...embedded/linux-2.6 > git-apply --index --stat --summary --apply < ../ms16/ide.patch 
  error: patch failed: drivers/ide/ide-io.c:129
  error: drivers/ide/ide-io.c: patch does not apply

Yet, patch does apply.

  elf@florence ~...embedded/linux-2.6 > patch -p1 < ../ms16/ide.patch
  patching file drivers/ide/arm/ide_arm.c
  patching file drivers/ide/arm/ide-lpd7952x.c
  patching file drivers/ide/arm/ide-lpd7a40x.c
  patching file drivers/ide/arm/Makefile
  patching file drivers/ide/ide-disk.c
  Hunk #1 succeeded at 282 (offset 41 lines).
  Hunk #2 succeeded at 294 (offset 41 lines).
  patching file drivers/ide/ide-io.c
  Hunk #1 succeeded at 96 with fuzz 2 (offset -33 lines).
  Hunk #2 succeeded at 1227 (offset 189 lines).
  Hunk #3 succeeded at 1388 (offset 189 lines).
  Hunk #4 succeeded at 1689 (offset 187 lines).
  patching file drivers/ide/ide-iops.c
  patching file drivers/ide/ide-probe.c
  Hunk #1 succeeded at 422 (offset 51 lines).
  Hunk #2 succeeded at 784 (offset 59 lines).
  Hunk #3 succeeded at 847 (offset 59 lines).
  Hunk #4 succeeded at 1112 (offset 64 lines).
  Hunk #5 succeeded at 1172 (offset 64 lines).
  patching file drivers/ide/Kconfig
  Hunk #1 succeeded at 272 (offset -1 lines).
  Hunk #2 succeeded at 781 (offset 5 lines).
  patching file drivers/ide/legacy/ht6560b.c
  patching file drivers/ide/legacy/qd65xx.c
  patching file drivers/ide/pci/ns87415.c
  patching file drivers/ide/pci/sl82c105.c
  patching file drivers/ide/pci/trm290.c
  patching file drivers/ide/ppc/pmac.c
  Hunk #1 succeeded at 572 (offset 61 lines).
  Hunk #2 succeeded at 596 (offset 61 lines).
  patching file include/linux/ide.h
  Hunk #1 succeeded at 961 (offset 1 line).
  Hunk #2 succeeded at 1497 (offset -14 lines).

It should be obvious that a patch that doesn't apply cleanly,
i.e. without rejects, is still useful to apply so that I can fix the
places where it fails.

  o Why does patch work and git-apply fail?
  o Is there a way to force git to apply and safe the rejects?
