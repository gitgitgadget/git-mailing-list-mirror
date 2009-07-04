From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 0/2] git apply: cope with whitespace differences
Date: Sat,  4 Jul 2009 13:53:47 +0200
Message-ID: <1246708429-21823-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 04 13:54:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MN3ok-0004KU-DK
	for gcvg-git-2@gmane.org; Sat, 04 Jul 2009 13:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453AbZGDLxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jul 2009 07:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753414AbZGDLxx
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jul 2009 07:53:53 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:47822 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389AbZGDLxx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jul 2009 07:53:53 -0400
Received: by fxm18 with SMTP id 18so2634747fxm.37
        for <git@vger.kernel.org>; Sat, 04 Jul 2009 04:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=NYiOj2/XL94JaoQ04rV/9hS0KJ4+2MWkkejSMmVL2WA=;
        b=dqxTjuBZIfV2fJFI/TpgFG5V0857YT+Qk4kp8Z9ofI48CbDoXh+4OKZAmnGsv84Fn1
         3Uwn/to9TtUEaPCBXp/mQOi903rS98K6S+tdhNUPy4Fg/qDWJckwrTEYvoFLCOReIrIQ
         9ZBzq80B4e1aVq+L42co4MoJaxBuL5zjykrP0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=C8SvDTUFSiGnPRAt2mzE7RsNHmJUcb4AtLg3vsLdm4JKFjvr5NQXFmTYIlzgyHXTH3
         G19VAAExOJnkx2Zq2uNpgez5APm5FIrawBtqGQrbx8RQixoswdql0ZTiZYt69JkntZvc
         jQMOeLOkl+AnX1o+gKm0NhzpYca6N+5IiHoJo=
Received: by 10.103.168.12 with SMTP id v12mr1398542muo.45.1246708435048;
        Sat, 04 Jul 2009 04:53:55 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-32-98.clienti.tiscali.it [94.37.32.98])
        by mx.google.com with ESMTPS id y6sm22538356mug.40.2009.07.04.04.53.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Jul 2009 04:53:53 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.3.512.g4fff
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122717>

This second version includes significant cleanups and improvements to my
previous attempt at a --ignore-whitespace option for git-apply.

Following Junio's review, the patch now includes proper handling for
leading whitespace (specifically the case when one part has it and the
other one doesn't), and more test cases.

The second patch fixes the updating of the postimage when whitespace is
adjusted to match the target.

Giuseppe Bilotta (2):
  git apply: option to ignore whitespace differences
  git apply: preserve original whitespace with --ignore-whitespace

 builtin-apply.c                        |  108 +++++++++++++++++++++++++++++---
 contrib/completion/git-completion.bash |    2 +
 git-am.sh                              |    3 +-
 git-rebase.sh                          |    3 +
 t/t4107-apply-ignore-whitespace.sh     |  107 +++++++++++++++++++++++++++++++
 5 files changed, 214 insertions(+), 9 deletions(-)
 create mode 100755 t/t4107-apply-ignore-whitespace.sh
