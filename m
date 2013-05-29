From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/8] cherry-pick: improvements
Date: Tue, 28 May 2013 22:56:20 -0500
Message-ID: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 05:58:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhXWi-0002oX-EA
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 05:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932888Ab3E2D6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 23:58:10 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:33815 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759239Ab3E2D6J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 23:58:09 -0400
Received: by mail-oa0-f53.google.com with SMTP id g12so10820014oah.40
        for <git@vger.kernel.org>; Tue, 28 May 2013 20:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=G1Ib1Pb06LfUBRSRSJvvXgGbWGYOqbgGnt8Twx67Jlw=;
        b=CDb0tegnP12rbcvTJOcKF0R/qPx6xp4ywr+wODvlUJZr6AhN2D/f0e3GdaVE+E6UQc
         fiVw6pd+mxAhGqudgNUK3Od5TRCCbo3tBgAuP+bnyMFEDMlzKTunaab1MhxB77dU58wr
         cHd91B8HiSPL+zaTVWl5QwpX81QKvZYar4ZZ2EL/YsvWudjwzNKisMHD0bu82GYBljdj
         bTT3CwksEV/WMH1mJrCDASfmAS6OfvL12m7Pk5Q4Cydi0iB0luejKl2aa9nP9wnrz1iN
         vX+WhcpIwWtW5hkPwXWA21uGk9dMphWLJlLbCysRlOFD/Yp9CDNFV+203JXx4754WGKp
         yztw==
X-Received: by 10.182.204.105 with SMTP id kx9mr460135obc.81.1369799889001;
        Tue, 28 May 2013 20:58:09 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id sa2sm8911873oeb.1.2013.05.28.20.58.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 20:58:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225714>

Hi,

Here's a bunch of changes to make cherry-pick (and revert) more useful. In
particular; this makes it more friendly for 'git rebase.

Felipe Contreras (8):
  sequencer: remove useless indentation
  sequencer: trivial fix
  cherry-pick: add --skip-empty option
  cherry-pick: store rewritten commits
  sequencer: run post-rewrite hook
  cherry-pick: add support to copy notes
  revert/cherry-pick: add --quiet option
  revert/cherry-pick: add --skip option

 Documentation/git-cherry-pick.txt   |  10 +-
 Documentation/git-revert.txt        |   7 +-
 Documentation/sequencer.txt         |   3 +
 builtin/revert.c                    |  11 ++
 sequencer.c                         | 230 ++++++++++++++++++++++++++++++++++--
 sequencer.h                         |   7 +-
 t/t3500-cherry.sh                   |  32 +++++
 t/t3508-cherry-pick-many-commits.sh |  13 ++
 t/t3510-cherry-pick-sequence.sh     |  12 ++
 9 files changed, 310 insertions(+), 15 deletions(-)

-- 
1.8.3.rc3.312.g47657de
