From: David Barr <davidbarr@google.com>
Subject: RE: [PATCH v2] am: ignore leading whitespace before patch
Date: Mon,  8 Aug 2011 15:10:42 +1000
Message-ID: <1312780242-91659-1-git-send-email-davidbarr@google.com>
References: <20110808024904.GF19551@elie.gateway.2wire.net>, <1312323646-93427-1-git-send-email-davidbarr@google.com>
Cc: David Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Simon Sasburg <simon.sasburg@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 07:11:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqI7s-0001Qe-8Z
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 07:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463Ab1HHFLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 01:11:40 -0400
Received: from smtp-out.google.com ([216.239.44.51]:27641 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080Ab1HHFLj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 01:11:39 -0400
Received: from kpbe12.cbf.corp.google.com (kpbe12.cbf.corp.google.com [172.25.105.76])
	by smtp-out.google.com with ESMTP id p785Bcgo012644
	for <git@vger.kernel.org>; Sun, 7 Aug 2011 22:11:38 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1312780298; bh=RXJMnC8yzyG29g2s4hTYGgbEJAE=;
	h=From:To:Cc:Subject:Date:Message-Id:References:In-Reply-To;
	b=pVavwDW06IEybcbJkjZ/iwFXvuG5atZFl9X0eHkP7AGU8cM/dmJRhX2AaGoqJXJXJ
	 ps7yGZH4N0LdcYUgansJQ==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=dkim-signature:from:to:cc:subject:date:message-id:x-mailer:
	references:in-reply-to:x-system-of-record;
	b=jyEJujfD6mcGR6A9cwEIYoBeqegE/gNYvUPShKijyQt7zbqj4B0jyYRVKTqnhZOxy
	z0Z82uFsKTD2hsqDAY6Xg==
Received: from gxk2 (gxk2.prod.google.com [10.202.11.2])
	by kpbe12.cbf.corp.google.com with ESMTP id p785BNPP026755
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Sun, 7 Aug 2011 22:11:37 -0700
Received: by gxk2 with SMTP id 2so2591329gxk.8
        for <git@vger.kernel.org>; Sun, 07 Aug 2011 22:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=from:to:cc:subject:date:message-id:x-mailer:references:in-reply-to;
        bh=eJcpMRLIUPzgFhaF1no8x7lb6WVZvZsbTzqHMbYwsQs=;
        b=h9XmzqlFuvN4tMdx7zhQLaamOOhIRsHKvZpiuOmRcZFNMBqCfp7k8U0zZ7QzCQai/Y
         Aplu65NKLqHBiV3wOmmA==
Received: by 10.236.197.101 with SMTP id s65mr1167919yhn.433.1312780296938;
        Sun, 07 Aug 2011 22:11:36 -0700 (PDT)
Received: by 10.236.197.101 with SMTP id s65mr1167909yhn.433.1312780296762;
        Sun, 07 Aug 2011 22:11:36 -0700 (PDT)
Received: from localhost.localdomain (davidbarr-macpro.syd.corp.google.com [172.23.124.75])
        by mx.google.com with ESMTPS id j3sm5107174yhl.80.2011.08.07.22.11.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 07 Aug 2011 22:11:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <20110808024904.GF19551@elie.gateway.2wire.net>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178941>

Add a test for GMail-style padded email files.

Signed-off-by: David Barr <davidbarr@google.com>
---
 t/t4150-am.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 151404e..40a5a3e 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -167,6 +167,17 @@ test_expect_success 'am applies patch e-mail not in a mbox with CRLF' '
 	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
 '
 
+test_expect_success 'am applies patch e-mail with preceding whitespace' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	printf "%256s\\n" "" >patch1-ws.eml &&
+	cat patch1.eml >>patch1-ws.eml &&
+	git am <patch1-ws.eml >output.out 2>&1 &&
+	! test -d .git/rebase-apply &&
+	git diff --exit-code second
+'
+
 test_expect_success 'setup: new author and committer' '
 	GIT_AUTHOR_NAME="Another Thor" &&
 	GIT_AUTHOR_EMAIL="a.thor@example.com" &&
-- 
1.7.6
