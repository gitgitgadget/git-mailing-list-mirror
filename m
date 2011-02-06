From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 00/31] refactor rebase
Date: Sun,  6 Feb 2011 13:43:29 -0500
Message-ID: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 19:45:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm9c5-0004PS-Ds
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468Ab1BFSp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 13:45:27 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48348 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428Ab1BFSp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:45:26 -0500
Received: by qyj19 with SMTP id 19so1045841qyj.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 10:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=1OMFRmE0/dyOAkdZw5bLygnZaXVaYAL3nJPZXgwb5+A=;
        b=e3VjaDZtYblAsbOxGFdo+AWTFrDPAqPj11G7MUx63yf55fuIdoPchjV1lKS7yEIH/x
         nnmzxE6NukvCtnVZ/oY992uxuQg2DPplgKQG5ohrTKHf1kqC4O4L6lscKltQAb5IXSMq
         0i9rQUo9MWfNrtl/qVeNRzlICm46OmHzuJdek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=M7wuukgZSfe1VKMB5VFkEBoHUEVoUzkTZRI3g6nytJ1COUJSdTqLWqkQFl2FO8LF0N
         iVzXNWA9YqFyXh95SUHoSKmXHiFw+Zs/mwIBc6m89Z36E5FrYtf8FP2CiuEJ/IpjcArP
         2UI/46ktRaXqn4Ti2i/wjUvc6sjyQmOUL6HsE=
Received: by 10.224.54.76 with SMTP id p12mr13302507qag.23.1297017925585;
        Sun, 06 Feb 2011 10:45:25 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm2174330qck.24.2011.02.06.10.45.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 10:45:24 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166161>

Changes since the first round:

As suggested by Johannes Sixt, source git-rebase--interactive.sh and
friends instead of executing them.

As suggested by Thomas Rast, downcase all variables for consitency.

Based on current master, including Jeff's two patches to rebase.

There are also a few other minor changes, but see the notes in each
patch for more information.


Martin von Zweigbergk (31):
  rebase: clearer names for directory variables
  rebase: refactor reading of state
  rebase: read state outside loop
  rebase: remove unused rebase state 'prev_head'
  rebase: improve detection of rebase in progress
  rebase: act on command line outside parsing loop
  rebase: stricter check of standalone sub command
  rebase: align variable names
  rebase: align variable content
  rebase: factor out command line option processing
  rebase -i: remove now unnecessary directory checks
  rebase: reorder validation steps
  rebase: factor out reference parsing
  rebase: factor out clean work tree check
  rebase: factor out call to pre-rebase hook
  rebase -i: support --stat
  rebase: remove $branch as synonym for $orig_head
  rebase: extract merge code to new source file
  rebase: extract am code to new source file
  rebase: show consistent conflict resolution hint
  rebase -i: align variable names
  rebase: make -v a tiny bit more verbose
  rebase: factor out sub command handling
  rebase: extract code for writing basic state
  rebase: remember verbose option
  rebase: remember strategy and strategy options
  rebase -m: remember allow_rerere_autoupdate option
  rebase -m: don't print exit code 2 when merge fails
  git-rebase--am: remove unnecessary --3way option
  rebase -i: don't read unused variable preserve_merges
  rebase -i: remove unnecessary state rebase-root

 .gitignore                 |    2 +
 Makefile                   |    2 +
 git-rebase--am.sh          |   30 ++
 git-rebase--interactive.sh |  751 +++++++++++++++----------------------------
 git-rebase--merge.sh       |  151 +++++++++
 git-rebase.sh              |  482 +++++++++++-----------------
 t/t3403-rebase-skip.sh     |    5 +
 t/t3407-rebase-abort.sh    |   10 +
 t/t3418-rebase-continue.sh |   55 ++++
 9 files changed, 707 insertions(+), 781 deletions(-)
 create mode 100644 git-rebase--am.sh
 create mode 100644 git-rebase--merge.sh

-- 
1.7.4.rc2.33.g8a14f
