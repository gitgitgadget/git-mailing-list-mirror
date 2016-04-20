From: larsxschneider@gmail.com
Subject: [PATCH v2 0/2] git-p4: fix Git LFS pointer parsing
Date: Wed, 20 Apr 2016 10:10:07 +0200
Message-ID: <1461139809-6573-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, sschuberth@gmail.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 10:10:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asnDR-0005kv-Tg
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 10:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbcDTIKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 04:10:19 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37068 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754548AbcDTIKO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 04:10:14 -0400
Received: by mail-wm0-f50.google.com with SMTP id n3so67872286wmn.0
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 01:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=SZ7SL2pNWwH2dyG+hqfco+JMNSy/7Ng1yxTymQuPyg4=;
        b=szPCnLjWozY9ycAe4zmIzJV3FUsd88NOZHAXag4URfeQBd1M37Nd4x4azK5l1vVwg9
         2w4YDn+wFnlEbVQ9MuaP73aHomyBC+J90kqUxISxWVoBVIy7CLqFpT9XZurNUqW0yWG5
         go5Ol+fiZY/Xcqkmkr66qo3sCJAley3xac0i3aD8edFMM5gEFp24IHLnKO92Z7mQdXuG
         ui4KGi9y3WerVrCmmbSm99eftZTUpYUOmAvjrPm0MWY+JvrGuP+NlIDcAfNvPqLeQvRT
         aDxqeV1hGTlsTLWVsLEyrpqq8/leUJnJ+xfClDI5d9S44hG2g5KY8hnSB/vElDPLuRdf
         VGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SZ7SL2pNWwH2dyG+hqfco+JMNSy/7Ng1yxTymQuPyg4=;
        b=e5JHWFKyFlBjpmoZM5vsYYgbgYb2cJEBtewqkW57LaiLjXJIB+VqVZrWUao6zEF3FR
         Ce7f992IPUqxFj//V7nrg+7HNbUKqTOGEUrUNo0fVFpxzfTimDF0XwUi1UTRD38CjC1k
         4m6KfS6J4qNCjfPXaFzQkcao1JZDJK606OuNTIYfDN/GsQfYRKs8XOx/ozfdS1pym8ZH
         tavrIaiOnrN9eKioc7DMv0rQMC2lUsZuIc9gGeJUulQAZdttmKzMZt2iB/7KZ5CtADYP
         5iPHFhvMdjtLH22NqDze+9sRIReflbxFY4qtXl/GUNRwD8PPzsdhHQRLBP6Dya3Kxvoj
         s4vQ==
X-Gm-Message-State: AOPr4FVopKH3UU2KNgcSqn7lnTJiXtDwM0ebwMJurmcPkXEa//aPpESmlRLQ6C8TUacP6w==
X-Received: by 10.194.88.201 with SMTP id bi9mr7139192wjb.147.1461139813068;
        Wed, 20 Apr 2016 01:10:13 -0700 (PDT)
Received: from slxBook3.fritz.box (p508BAD5D.dip0.t-ipconnect.de. [80.139.173.93])
        by smtp.gmail.com with ESMTPSA id r8sm1502008wme.14.2016.04.20.01.10.11
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 20 Apr 2016 01:10:12 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291991>

From: Lars Schneider <larsxschneider@gmail.com>

v1: http://thread.gmane.org/gmane.comp.version-control.git/291917/

diff to v1:
* make git-p4 LFS compatible with Git LFS versions prior to 1.2.0
  Thanks Junio for the little push ... I guess I was a bit lazy here :)
* improve the git-p4 LFS tests to detect invalid LFS pointer files

Thanks,
Lars

Lars Schneider (2):
  travis-ci: update Git-LFS and P4 to the latest version
  git-p4: fix Git LFS pointer parsing

 .travis.yml               |  4 ++--
 git-p4.py                 | 15 ++++++++++++---
 t/t9824-git-p4-git-lfs.sh |  4 ++++
 3 files changed, 18 insertions(+), 5 deletions(-)

--
2.5.1
