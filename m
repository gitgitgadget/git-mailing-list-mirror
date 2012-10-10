From: skillzero@gmail.com
Subject: rebase fails mid way through due to locally modified file?
Date: Tue, 9 Oct 2012 17:31:19 -0700
Message-ID: <CANRUUDNoUNMy1qHkYt-_wwxGtWrRY9vi8-CjzY8WhJ2gur+zTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 10 02:31:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLkCx-0002Qs-KV
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 02:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755814Ab2JJAbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 20:31:21 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:52633 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755005Ab2JJAbU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 20:31:20 -0400
Received: by mail-vc0-f174.google.com with SMTP id fo13so7775662vcb.19
        for <git@vger.kernel.org>; Tue, 09 Oct 2012 17:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=wzp2s4+5GS5tcaxFEAn3GGkOlKPOqvdh5vmEZK4reD0=;
        b=uRssMNdPZz1t1xHt6F6+/FxPIEMOfanSdrK3L2jkOC7yaFgocl6nEZhLcL0hXlSlJg
         O6AIfatDylZGVBtKSbPNOv+eUlE/J4FIyTuzbPEy2Ebjx+B27PnL3dsJFmcCOUnzXFa0
         DA6u6HCDghKy3iQI0r3LY+oCrKaKsAdkEVHPn84aibYGYKepHmpqfSpYrYqfXH2wOjky
         FV4SGNHmlBck9IhWgDq2fh8T+ll6jQXpiSBWpAgdD/ccLxz74FKta+IRiN5gXNsM+8O1
         flmz31X9q8j1cf9mrEnly5W70cgwIcfH1RpLEeGECyEiyElJZgHjUfR4kwxog3uKiOSp
         vK0g==
Received: by 10.220.150.201 with SMTP id z9mr12613197vcv.70.1349829079521;
 Tue, 09 Oct 2012 17:31:19 -0700 (PDT)
Received: by 10.58.216.164 with HTTP; Tue, 9 Oct 2012 17:31:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207356>

I frequently see rebase fail after applying several commits because
git thinks there are local changes. Before the rebase started, there
were no local changes and after the rebase fails, doing a git status
doesn't show any locally modified files. I was seeing this on git
1.7.x and I also tried updating to git 1.8rc1 and it fails there too.
I see progress like this:

--
Applying: Commit X
Applying: Commit Y
Applying: Commit Z
Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
error: Your local changes to the following files would be overwritten by merge:
	MyFile.h
Please, commit your changes or stash them before you can merge.
Aborting
Failed to merge in the changes.
Patch failed at 0013 Commit A
The copy of the patch that failed is found in:
   /Source/.git/rebase-apply/patch

When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase --abort".
--

If I git rebase --abort then retry, it usually fails again, but
sometimes on a different file. Once in a while, retrying will succeed.

Is this a known issue? I can't make the source for my repo available,
but is there some way I can provide more info to help narrow this
down?
