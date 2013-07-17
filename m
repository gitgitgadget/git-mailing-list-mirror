From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/6] fix blame -L regression; add tests
Date: Wed, 17 Jul 2013 17:25:26 -0400
Message-ID: <1374096332-7891-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 17 23:26:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzZEc-0003m0-PN
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 23:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757324Ab3GQV0B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 17:26:01 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:34536 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756114Ab3GQV0A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 17:26:00 -0400
Received: by mail-ob0-f178.google.com with SMTP id fb19so2923403obc.9
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 14:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=3jDW7jw4kXMHxj+C4oLtKd5l3eqipCHELtmiL4k4tPE=;
        b=XmGyw9Y39JUZ0hqwon9Y8EOztHI8envSPCe2j+2kDu47FWKoiARrQg8tk1DB/UcIP3
         h2HIqHSmPsH7YQ+ly+0cVSqxyh6gLRvZd0tc08lxXII+uSGIjoqVQrbHfaVt/OCKZWAg
         J6qaAp6VaAqGcrLHXIWV1FNxHx4fe2kTPgQWtb4l/hulCCUdQ2rerVNOSVKrbTlqfrRF
         mh1LbVD0WYC+5Ezp5v8OmuIMTdmQ3U5OMl1CTvqBGa7piMzRvvkO6pQ4n0aTDd+FyxM5
         9rcWrVUdN4k8yDiSYn24AJG9t93WgsKJaJNWukcVtzLEK6qbPkjfUieynRQBUNDTX6y0
         bYTQ==
X-Received: by 10.60.56.82 with SMTP id y18mr10341038oep.86.1374096360270;
        Wed, 17 Jul 2013 14:26:00 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id ps5sm10308187oeb.8.2013.07.17.14.25.58
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 14:25:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.3.1016.g4f0baba
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230651>

This series fixes a regression in "blame -L X,-N", adds blame -L tests,
and makes minor documentation adjustments. The tests, in particular,
were motivated by the desire to revisit and continue working on [1]
which extends git-blame to accept multiple -L's. That topic will need to
extend blame -L tests, of which there were essentially none.

Patches [2/6] (modernize style) and [3/6] (add blame -L tests) are
intentionally independent of the "git log -L" topic (from earlier this
year) to which the other patches are related.  This independence should
allow these two patches to graduate at their own pace without being tied
to "git log -L".

[1]: http://thread.gmane.org/gmane.comp.version-control.git/229755/

Eric Sunshine (6):
  line-range: fix "blame -L X,-N" regression
  t8001/t8002 (blame): modernize style
  t8001/t8002 (blame): add blame -L tests
  t8001/t8002 (blame): add blame -L :funcname tests
  blame-options.txt: place each -L option variation on its own line
  blame-options.txt: explain that -L <start> and <end> are optional

 Documentation/blame-options.txt |  10 +-
 line-range.c                    |   7 +
 t/annotate-tests.sh             | 363 ++++++++++++++++++++++++++++------------
 t/t8001-annotate.sh             |   6 +-
 t/t8002-blame.sh                |  12 +-
 5 files changed, 283 insertions(+), 115 deletions(-)

-- 
1.8.3.3.1016.g4f0baba
