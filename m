From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 0/2] make pull.ff=true override merge.ff
Date: Mon, 18 May 2015 21:45:40 +0800
Message-ID: <1431956742-25992-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 15:46:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuLMu-0006lK-Kj
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 15:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903AbbERNqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 09:46:01 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:33505 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbbERNp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 09:45:59 -0400
Received: by pdbqa5 with SMTP id qa5so150462505pdb.0
        for <git@vger.kernel.org>; Mon, 18 May 2015 06:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=QYDzgoqgDSBR+wWvDrhLM98plnj/rKJo9wGDBdA9jN8=;
        b=jk4tODrEYVJBwhvc76PUuus5GPLPgIu6HFRvq54rrgKNcIr6oOR23ov6WD/zDxGFFB
         FHL6rnLX9LgH1+q4eWBwsyeSUVU0mklGVx3UWoHDQXYF/gQcK0rEYU8UwBV4//QQu3uN
         n+w9kTPx4oxdUxADW+zEN3ryrpELYGKFoig4HRHkT+qIsVGQYwYpVp7kmuLTTw/NW1HV
         xJST6h7sGKr8WoXs9aQ5Krv9jUBdcQOdoU8lmmzPlUCj1FrLu0OXSPAEBCIwvcRvIsQb
         p3QYZfqex/wpk+qU8iQSQEW/JHwryCNzRPxgi/ySJlp15jRJVZJsqgU33hyUVwGEDkUW
         YFkw==
X-Received: by 10.68.87.5 with SMTP id t5mr43659111pbz.137.1431956759264;
        Mon, 18 May 2015 06:45:59 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id x4sm10175713pdl.55.2015.05.18.06.45.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 06:45:57 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269246>

This is a re-roll of [1], primarily to remove the use of "verbose".

Since b814da8 (pull: add pull.ff configuration, 2014-01-15), running
git-pull with the configuration pull.ff=false or pull.ff=only is
equivalent to passing --no-ff and --ff-only to git-merge. However, if
pull.ff=true, no switch is passed to git-merge. This leads to the
confusing behavior where pull.ff=false or pull.ff=only is able to
override merge.ff, while pull.ff=true is unable to.

This patch series adds a failing test to demonstrates the above, and fixes it.

The documentation is also tweaked to clarify that pull.ff is meant to override
merge.ff.

The last patch makes pull.ff consistent with merge.ff by supporting the config
aliases of true and false (on, off, 0, 1).

[1] http://thread.gmane.org/gmane.comp.version-control.git/268972

Paul Tan (2):
  pull: make pull.ff=true override merge.ff
  pull: parse pull.ff as a bool or string

 Documentation/config.txt     | 2 +-
 git-pull.sh                  | 5 ++++-
 t/t7601-merge-pull-config.sh | 8 ++++++++
 3 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.1.4
