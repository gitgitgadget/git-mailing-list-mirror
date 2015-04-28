From: Luke Diamand <luke@diamand.org>
Subject: [PATCH] git-p4: add failing tests for case-folding in p4d
Date: Tue, 28 Apr 2015 10:08:00 +0100
Message-ID: <1430212081-16146-1-git-send-email-luke@diamand.org>
Cc: Lex Spoon <lex@lexspoon.org>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 28 11:08:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yn1VV-0000LT-Dw
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 11:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933190AbbD1JIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 05:08:40 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:32960 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933182AbbD1JIi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 05:08:38 -0400
Received: by wief7 with SMTP id f7so11998179wie.0
        for <git@vger.kernel.org>; Tue, 28 Apr 2015 02:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=W2iYldlvQUCNHYmeU2JTH/W9487yXHcDs3kX+uksV5Y=;
        b=Wcqjn3wHB7vDh9yg2kgAi0SjiuqBr9XqzFjqpHzwPZB9dTtyfzT2TEtTwu6FdfZTaQ
         jcQC1LSoUKt+S/rFKCgkyo/WZm6m6xA3BLsoSe5Xj5zcXml8YGIg0sVNk+n3PUIMVgz4
         UnP03tNNJDje7sfcYtPH0J3PuqaN+8Z7ej1GM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W2iYldlvQUCNHYmeU2JTH/W9487yXHcDs3kX+uksV5Y=;
        b=KB9PMUCZrH3bTjmHrmAhm8vE9c26PxRmku1j4NW99Zf5gLv4Qdgn1F3H4shKAjheHC
         945p8y9pRRjk62gXY1A8QIbGjvZdF00q35kv2BZX25k4YOfhP8Xa548re6XnCcoiS4Lx
         ze4ucjD75afnoiJVvDpu9T+aSfieg3bvkLPoiMmIrczD7glRcZTztN0KgOFIPECQX7eB
         UiPOZJ8zPR91z2+UJgHm7LW80ULwnVTE1NqpLBPtn1X3CS0gLeNBLbrVJqSuCB9x9mlz
         HrtsS5zdIuAsdRJ7YELPnw5B2ZNX4LsoEWwGrFEDSbE6XY+SpimBad4LKsLKCnbV16JR
         sPag==
X-Gm-Message-State: ALoCoQkYriy9/6J5SkoE6AQT6zs03M5+n/11MrtN4xI5gEve4yuq1sH58ShYGL6TMUOnuGFJsom0
X-Received: by 10.180.186.99 with SMTP id fj3mr28607853wic.10.1430212117465;
        Tue, 28 Apr 2015 02:08:37 -0700 (PDT)
Received: from ethel.cable.virginmedia.net (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id b10sm15382571wiz.9.2015.04.28.02.08.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2015 02:08:36 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc3.380.g8e2ddc7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267916>

Lex found out recently that when git-p4 is asked to clone a repo
and the case of the repo is incorrect (but otherwise correct) that
git-p4, instead of reporting an error, appears to work fine, but
actually produces an empty repo. This can be quite confusing.

This patch adds a couple of failing test cases that illustrate the
problem.

The next step is to figure out where it's going wrong, and how it
should actually behave.

Luke Diamand (1):
  git-p4: add failing tests for case-folding p4d

 t/lib-git-p4.sh                |  2 +-
 t/t9819-git-p4-case-folding.sh | 54 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)
 create mode 100755 t/t9819-git-p4-case-folding.sh

-- 
2.4.0.rc3.380.g8e2ddc7
