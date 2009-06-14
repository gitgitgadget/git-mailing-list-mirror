From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv2 0/3] Teach shell scripts to be quiet
Date: Sun, 14 Jun 2009 16:16:11 -0700
Message-ID: <1245021374-8430-1-git-send-email-bebarino@gmail.com>
References: <1244924500-27391-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 15 01:16:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFyw5-0001GZ-Ay
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 01:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755996AbZFNXQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 19:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754771AbZFNXQQ
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 19:16:16 -0400
Received: from mail-px0-f187.google.com ([209.85.216.187]:59920 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753789AbZFNXQP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 19:16:15 -0400
Received: by pxi17 with SMTP id 17so1625730pxi.33
        for <git@vger.kernel.org>; Sun, 14 Jun 2009 16:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=wChB5ZICJPzhmXmfWR7PdfroOH7Myu5My5kg8hxmufE=;
        b=vWvWns0eUQfWcfc6tIeaMq9DDVA9IdRRb+S5Ts7RhQWSCUETYTPigU5YBNJ8V6GfPZ
         GOOlGNB8Gnsmd5phtCV7hIujqrK5B78krXC19S18knuJDdeOGjV3I+Qxaw0Sgg14J4p6
         PdkXSp6+3tLDWdZVhS7/EY9UCuL94mCVCLq8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FBKe+J76P+3sA8MwWRMvbdpzVSkoZeyhMNVDW34eyTn+WtGTFYbqUNfyJvF19yVfni
         ZX5q3gpYlST2rxaBFCMSjgvKBDXDxpIoWt6iWWx2B38VWnLb0Wb5Nk9ZOLgssYodHD6n
         E0dKzwR5/D5yi85JGwpMIL6NMUCxuJGm/259s=
Received: by 10.114.113.16 with SMTP id l16mr2751929wac.21.1245021377806;
        Sun, 14 Jun 2009 16:16:17 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id v25sm5178028wah.11.2009.06.14.16.16.15
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Jun 2009 16:16:17 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sun, 14 Jun 2009 16:16:14 -0700
X-Mailer: git-send-email 1.6.3.2.306.g4f4fa
In-Reply-To: <1244924500-27391-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121568>

The main goal of this is to teach git-am and git-rebase to be
quiet. To do that, I've implemented a generic say function in
git-sh-setup so that script writers can implement a quiet
option by setting GIT_QUIET and using say instead of echo.

git-stash is still left out, but hopefully this makes that easier
for someone else later.

Changes since v1:
    - introduction of say()
    - migration of submodule and repack

Stephen Boyd (3):
  git-sh-setup: introduce say() for quiet options
  submodule, repack: migrate to git-sh-setup's say()
  am, rebase: teach quiet option

 Documentation/git-am.txt     |    6 +++++-
 Documentation/git-rebase.txt |    4 ++++
 git-am.sh                    |   17 ++++++++++++-----
 git-rebase.sh                |   40 +++++++++++++++++++++++++++++-----------
 git-repack.sh                |   12 +++++-------
 git-sh-setup.sh              |    7 +++++++
 git-submodule.sh             |   24 ++++++------------------
 t/t3400-rebase.sh            |    7 +++++++
 t/t4150-am.sh                |    7 +++++++
 9 files changed, 82 insertions(+), 42 deletions(-)
