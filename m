From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 0/3] DWIM with "git checkout -f -b"
Date: Mon, 21 Jun 2010 00:33:09 +0800
Message-ID: <1277051592-4552-1-git-send-email-rctay89@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 20 18:33:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQNSi-0006rx-9N
	for gcvg-git-2@lo.gmane.org; Sun, 20 Jun 2010 18:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889Ab0FTQda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jun 2010 12:33:30 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:51543 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018Ab0FTQd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jun 2010 12:33:29 -0400
Received: by pxi12 with SMTP id 12so1072157pxi.19
        for <git@vger.kernel.org>; Sun, 20 Jun 2010 09:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=ubP6SFECbD/YZm+LshLsRvDS60pHbayP+0LtE1656hk=;
        b=cDX0xA7kAK1fdXJsaUqXVJmI1Pwas1nGHJmje1+qnVjGZAWkNc+rqCCYNxg/aUGTFV
         slpsUjCKZqwRYDwgkPw8R7bWLFLFe+5zWFzIA2se2qrl1tQn/dEvKz5KWpEl+drl5djh
         Zm/qdbf8eXzflVGF8MhC9VYJcaRkjGp1LGm3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=F9OpuwrznLDn+l6Rb7NH9cogMdwLAzm30+F5THUVwmblElZcahUfn/7YglCiUC94IH
         6vSTmkhLKSLKqvpLNYSy9dD+W30NqgzbT+ktYAmxCwk6C4/N35lXixX3zFKMoX8Yb1Dp
         ZrwSMLoPFv1QsaUuKYr/Kknjh+YquEUwE7SAY=
Received: by 10.143.154.29 with SMTP id g29mr2586700wfo.94.1277051607632;
        Sun, 20 Jun 2010 09:33:27 -0700 (PDT)
Received: from localhost.localdomain (cm123.zeta152.maxonline.com.sg [116.87.152.123])
        by mx.google.com with ESMTPS id n29sm9634993wae.16.2010.06.20.09.33.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 20 Jun 2010 09:33:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.513.g06a69
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149397>

Right now, the -f/--force in git-checkout doesn't carry over to -b
operations - ie. you can't do git checkout -b branch on an existing
branch. This patch series changes this, so that one can do

  git checkout -f -b branch ref

which is equivalent to

  git branch -f branch ref && git checkout branch

Contents:
[PATCH 1/3] add tests for checkout -b
[PATCH 2/3] t2018-checkout-branch.sh: show that checkout -f -b doesn't DWIM
[PATCH 3/3] builtin/checkout: DWIM with -f -b

 Documentation/git-checkout.txt |    3 +
 builtin/checkout.c             |    4 +-
 t/t2018-checkout-branch.sh     |   86 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 2 deletions(-)
 create mode 100755 t/t2018-checkout-branch.sh
