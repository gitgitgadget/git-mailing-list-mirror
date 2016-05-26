From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [RFC/PATCH 0/2] Introduce "log.showSignature" config variable
Date: Thu, 26 May 2016 18:36:45 +0530
Message-ID: <20160526130647.27001-1-mehul.jain2029@gmail.com>
Cc: Austin English <austinenglish@gmail.com>,
	Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 15:09:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5v1x-0006Vt-7X
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 15:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960AbcEZNIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 09:08:45 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32868 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753843AbcEZNIo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 09:08:44 -0400
Received: by mail-pf0-f196.google.com with SMTP id b124so8870294pfb.0
        for <git@vger.kernel.org>; Thu, 26 May 2016 06:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=r50hTVV/+yLDoqlEe7HsEyxRaMptw0X4+CQTNHFbZDE=;
        b=uBx2+dD9TLKdUePcU5+XmEav+8dcs0NI65RyURVYmJImux1vclF/a8e/b2PJC5tvU4
         rekMrZWuNQxaxnU1aThmUwlzpdR8EPmNGMTQDasjEHLvcYePVAOGib5P1Fzmu2cjtD1E
         EnUC24LQc2xC76aHFPXDcRF7xNPC6M7MjJyoIJdRCiu+9Npd1L8Xb81kVS/SuAZofQQm
         9ptsm+3OX7yiowBdl7YqbUvd0mGW9d1aaghwMttJaUhimEqFAvt5/OcgZirnAfc9ZRVV
         zwsTz9JFKA5dQ2gnA5QJOWwH/8iQXz/lshTNHW16wNtk+YACbKOl+6KYLzcVC4ZBOqro
         zSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r50hTVV/+yLDoqlEe7HsEyxRaMptw0X4+CQTNHFbZDE=;
        b=M5Igdo+Wghe2MS+IaIDc2nx7NliCsJOFAkQZtajBbd8uIYVe/Crt2xXOhwePgZTUQd
         8U+jr5jHTKZrTmMKVzkebpGXj7GIvcCMfNdv09LRkz1fDyZ4ItFiWJjMevJytT1Takxe
         eF2miDWbHCjVp3ilwLCE7T+RW+IowoDdG+19S0uEN01pCPeGPiGPDPMnCzBZ3VraUyiv
         +3TAwjmHDcuG66ko1gf7IAfqorGpFLyStkBckrzWTI9+twZ5KJB77DsnJZdih4dQE/Wj
         NbaKzSaH9Ny9OsTBREOUvYDa7mP3On67ZpDrlZf3sbkmO6Ky/P/hUidEwNShqZBEgy9H
         obQQ==
X-Gm-Message-State: ALyK8tJ3s1n3D1VL8cEu55Ei7wo5qP8xSVWx7T/Jm87W/cxbN4DJw82y5oYPerdXhr89kw==
X-Received: by 10.98.60.74 with SMTP id j71mr13875288pfa.62.1464268123190;
        Thu, 26 May 2016 06:08:43 -0700 (PDT)
Received: from localhost.localdomain ([223.176.135.41])
        by smtp.gmail.com with ESMTPSA id vi6sm20547504pab.21.2016.05.26.06.08.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 May 2016 06:08:42 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295649>

Add a new configuratation variable "log.showSignature" for git-log and
git-show. "log.showSignature=true" will enable user to see GPG signature
by default while using git-log and git-show.

[Patch 1/2] introduce the config variable along with some tests.
[Patch 2/2] tackles the problem: what if user wants to disable the
	    setting of "log.showSignature=true" using a command line
	    switch.

Previous discussion on this: http://thread.gmane.org/gmane.comp.version-control.git/295405

Mehul Jain (2):
  log: add "log.showsignature" configuration variable
  log: add "--no-show-signature" command line option

 Documentation/git-log.txt |  4 ++++
 builtin/log.c             |  6 ++++++
 revision.c                |  2 ++
 t/t4202-log.sh            | 26 ++++++++++++++++++++++++++
 t/t7510-signed-commit.sh  |  7 +++++++
 5 files changed, 45 insertions(+)

-- 
2.9.0.rc0.dirty
