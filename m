From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 0/2] git p4 - import/export of git/p4 tags and labels
Date: Wed, 11 Apr 2012 17:21:22 +0200
Message-ID: <1334157684-31402-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 17:21:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHzMg-0003YH-Te
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 17:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755162Ab2DKPVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 11:21:40 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33648 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550Ab2DKPVi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 11:21:38 -0400
Received: by bkcik5 with SMTP id ik5so773110bkc.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 08:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=ZFM2kMKBD1KIjtTJScQ2eOXuNa9AxKYeXuxg6t3BY6w=;
        b=c+w7qZgosVL5/EHXwFL3MCMQmmjul+amxm4kbP40/0nH41C3xNTx36YQ02xDY/YNeE
         YhOw4OUO5+uwzrLJbHTLSNCLftEjHQIlAjg9jehRhNhsgtp1Jr4Mf6LdHf72TNL62whW
         lbXE+3vaYYRHiMzmYewaV6YEG4ZTQmbQRez4AtofqO4THYydtroeKyUuoUaUWF2l1SVd
         b2JUKXBb+UgTxFzrJ7gh7mbAjw+k/d1QIKQnW9iMbAXsY/wPJ+jV34L2jNkZzJDH3Tyw
         HLXQeCeEUzN+6y9mfgrWrXGWPWkz3mIPcICNzs0jt9CXRAdIQL8iuPDMegnZf+0OpL4N
         M2/w==
Received: by 10.205.133.210 with SMTP id hz18mr5945443bkc.117.1334157696902;
        Wed, 11 Apr 2012 08:21:36 -0700 (PDT)
Received: from halilbut.cam.broadcom.com ([212.183.128.225])
        by mx.google.com with ESMTPS id gw19sm5547474bkc.8.2012.04.11.08.21.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 08:21:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc0.161.gdb6eba
X-Gm-Message-State: ALoCoQlkpPj8tRCoAm4Jdfuhw+Wr7meBcZgorKnkeaV5cWhuOOt1/2W6S2QqaRieprax7sVVBY0D
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195188>

This is an updated version of the previous patch for importing p4 labels
and exporting git tags.

Unlike the previous version, this one exports tags to p4 during 'submit'.
Because of the rebasing that goes on with git-p4, this is no worse
than doing it during the sync phase - to be exported a git tag has
to be on one of the commits that has come from p4.

I have also renamed the --export-tags option to --export-labels, as
it just seemed confusing (so now is export-labels, import-labels, etc).

This version is against Pete Wyckoff's patch series for making git-p4
a top-level program.

There is also a small fix to the t9800 test case to help it work
when P4EDITOR is defined.

Luke Diamand (2):
  Fixing script editor checks
  git p4: import/export of labels to/from p4

 Documentation/git-p4.txt       |   43 ++++++-
 git-p4.py                      |  263 ++++++++++++++++++++++++++++++++++------
 t/t9800-git-p4-basic.sh        |    4 +-
 t/t9811-git-p4-label-import.sh |  202 ++++++++++++++++++++++++++++++
 4 files changed, 471 insertions(+), 41 deletions(-)
 create mode 100755 t/t9811-git-p4-label-import.sh

-- 
1.7.10.rc0.161.gdb6eba
