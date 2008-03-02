From: "Steve French" <smfrench@gmail.com>
Subject: kernel.org git tree corrupt?
Date: Sun, 2 Mar 2008 09:49:44 -0600
Message-ID: <524f69650803020749o469f2e48l125a55267b0b5d13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: lkml <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 16:50:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVqSI-0004Xn-SQ
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 16:50:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752377AbYCBPtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 10:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752958AbYCBPtu
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 10:49:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:34712 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbYCBPtt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 10:49:49 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1447161ugc.16
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 07:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=3USkYWsimeydSn2vyn8R8oUMQIzSRzkRySGlsFVWXWQ=;
        b=VhlqxC2q5LLVaqx/huCceJJjAYXJte+HsbayaFxr3e39FeY8V0YwVtM4yjpaLUqtgZGu3D4eBoh9IqH884Wum1meihbkR4t9evCaJjxC4dWMjVsRKXcamaCkhgy/iUerj9SkVLh7rrpN2vE/kXI48A4FXlz84Uae4gZR1wbqkQw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gIzb3a5sHOFt19JmMw4/P0wYnx1Ohnmb3Zbb2sDvuVEDsGnUSVu2J54GgpB1hxuDL08Uc8XgV/rkPTfGWkgUq7EXxYL169USWulY30ybg3pUIlHFnx2qaAsk1Z+AExJFgBDP6Y5ZaufcbETPTntm+dK3RSOieaK74oi/RSJqF/I=
Received: by 10.78.77.9 with SMTP id z9mr14519313hua.45.1204472984946;
        Sun, 02 Mar 2008 07:49:44 -0800 (PST)
Received: by 10.78.172.19 with HTTP; Sun, 2 Mar 2008 07:49:44 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75793>

In preparation for a merge request I do
    cg-diff -m -r origin: | diffstat -p1
(git diff -m -r origin: shows the same problem) and
    cg-log -m -r origin:
from my kernel.org cifs-2.6.git tree against the linux-2.6.git which
should only show a small set of changes (typically only affecting one
directory in the kernel source), but instead now is showing thousands
of changesets with changed lines all over the tree.   The origin is
        /pub/scm/linux/kernel/git/torvalds/linux-2.6.git
and the only operation done on cifs-2.6.git is git pull (to merge in
changes from linux-2.6.git) and applying (patch and cg-commit) small
patches (to the fs/cifs directory typically).    Even after doing git
pull again (and also git-fsck) that did not seem to help as there are
still thousands of changesets showing up when there should be fewer
than 30.   Was the linux-2.6.git rebuilt in the last four weeks with
different changeset numbers? Something seems to have drastically
changed in the kernel.org tree in the last few weeks.

Any idea how to get around this ... short of going through all patches
to fs/cifs saving the uncommitted ones off one by one by hand,
recloning the tree and reapplying them one by one?
Doing "cg-log -m -r origin: fs/cifs" shows changesets that are already
in linux-2.6.git (e.g. the vfs-wide changes to add path_put
1d957f9bf87da74f420424d16ece005202bbebd3 and
4ac9137858e08a19f29feac4e1f4df7c268b0ba5 )

The oldest patch which affects fs/cifs which incorrectly shows up as
not in mainline (ie shows up with cg-diff but is actually merged into
both mainline and my tree, and submitted and merged by someone else)
is eebd2aa355692afaf9906f62118620f1a1c19dbb dated 2/4/2008 so I assume
that the problem started around then.

Ideas for another solution short of recloning and sorting through all
of the last month or two of patches that affect this directory by
hand?


-- 
Thanks,

Steve
