From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v3 0/2] [PATCH v3 0/2] rev-parse: fix some options when executed from subpath of main tree
Date: Fri,  6 May 2016 09:35:18 -0400
Message-ID: <1462541720-79553-1-git-send-email-rappazzo@gmail.com>
Cc: gitster@pobox.com, pclouds@gmail.com, szeder@ira.uka.de,
	Michael Rappazzo <rappazzo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 15:35:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayfuZ-0004xq-HS
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 15:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758141AbcEFNfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 09:35:08 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:36196 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755750AbcEFNfH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 09:35:07 -0400
Received: by mail-qg0-f47.google.com with SMTP id w36so55915273qge.3
        for <git@vger.kernel.org>; Fri, 06 May 2016 06:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Wf0i26xmMcmvB85Dd4YAONv6il94DMK6hYerNHXWWss=;
        b=ENE9MpSo/sA//JraBzt4dzErPqXXAWmdhkIOkeRhpEqliR3bRvwElwAhQk5+jlGMea
         56EJtcNCejmISjd5Tw8FBAt/yV9vD9YJEsIaa2dkMIJNrjrAjL2SlAnPzVwCaAaY6L5T
         8I+W0nU3c1d8M0fFhLLwNxmDgaX934jDJhb9Jk2/Ot06tTHErxtlDBwedK1/1+1WV/qO
         bs0zYZyVyhT8Jo+zV/1JCIegv0qYW+msn48tNavMUplQQoamnji+9oZaoXr6oMpi+Gca
         9qWltRET3NtD/a97SfZLQhrdTOfqCknFBvVemcPV5Jl6BNKH7kq6ZC9tD8LR1hFzk3G0
         MR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Wf0i26xmMcmvB85Dd4YAONv6il94DMK6hYerNHXWWss=;
        b=lb/aO/Y9dyjm1CCiarbXebFM7A3SrxkMomqhRwlJR8TsoIHj9YShYw7w5Z72Ssm/cb
         kJjMGuz+pITeMZuGmhzPFOu6CXGtn1Go6Zjtw9WrvNpyD+BFeJYskxckpdO0WtE6p+/Q
         lKURmsiHfObImyn166FedVnUeKYpiqJAmFiAX7g7NodWguuQMdWH4DMxeTtlGtekg8rm
         +xzmgtUZGrFgdLKcagxst+R3dS6VzMVhlmYtaN3oZfjlCzztGY4BDY3XXY063pc66Zr3
         1el+7kKLia53s1LJ3hZWz0cE9V8GyZBCOz0JhUad5wBZUoTCqJLepW/YBT2mi5JrU9f+
         zNbA==
X-Gm-Message-State: AOPr4FVwEYhd2hthE4rKJ1ybWvF8mMp49EjsdKsRGcSUNFah+d4dmZXQtgvepnJR6/0DyQ==
X-Received: by 10.141.28.204 with SMTP id f195mr20691393qhe.59.1462541706672;
        Fri, 06 May 2016 06:35:06 -0700 (PDT)
Received: from mrappazzo-8.infor.com (rrcs-198-179-75-179.nyc.biz.rr.com. [198.179.75.179])
        by smtp.gmail.com with ESMTPSA id w17sm5702457qha.23.2016.05.06.06.35.05
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 May 2016 06:35:05 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293778>

Differenced from v2[1]:
 - Rewrote the commits to just two; one that introduces tests, and 
   one which fixes the problem.

[1] http://thread.gmane.org/gmane.comp.version-control.git/292272

Michael Rappazzo (2):
  rev-parse tests: add tests executed from a subdirectory
  rev-parse: fix some options when executed from subpath of main tree

 builtin/rev-parse.c      | 19 ++++++++++++++-----
 t/t1500-rev-parse.sh     | 38 ++++++++++++++++++++++++++++++++++++++
 t/t1700-split-index.sh   | 17 +++++++++++++++++
 t/t2027-worktree-list.sh | 10 +++++++++-
 4 files changed, 78 insertions(+), 6 deletions(-)

-- 
2.8.0
