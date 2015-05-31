From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 6/9] send-email: simplify sendmail aliases comment and blank line recognizer
Date: Sun, 31 May 2015 18:29:28 -0400
Message-ID: <1433111371-19573-7-git-send-email-sunshine@sunshineco.com>
References: <1433111371-19573-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 00:30:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzBkp-0005p2-ON
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 00:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758613AbbEaWag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 18:30:36 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:33242 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758524AbbEaWaY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 18:30:24 -0400
Received: by igbpi8 with SMTP id pi8so48789084igb.0
        for <git@vger.kernel.org>; Sun, 31 May 2015 15:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=49e/tOlaeXRobDG817SZ/VYCc2Gx5aFQAVQ42arrzr0=;
        b=u1SwH9wYPHs/Oj/+vxiW3PdSiK5zQ0vC0BspUnwYbsWl/6IqSG6UOi70qhTiqJaxcl
         l2+XSmbhIoK3nqaTUv8BOimZpJ5C+7dG9Rvhh7xcjQPABgr/MFwhsAMQ4bkVKPhTru6N
         SMxfE4aEO6bpRU7YP1cItqCS/s5CYwJFEP6e9vJDR9D9EEE9FWH8ed29HQ834R9ZJVNn
         vMEbEWq9RBwp7iXcj0FY7HJKhuOUTq8aKI1eDB0BTVGeOSZ3w37UOmzkoW0N7fOKr6sK
         rxglb4rL7ipSjBalOEN2toTi6JgDjd3n9cFgTHs25emFk2uQWQ3O2vpRMmVigdrfMHQn
         hf+g==
X-Received: by 10.107.134.153 with SMTP id q25mr22492179ioi.27.1433111423536;
        Sun, 31 May 2015 15:30:23 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id j20sm6571830igt.5.2015.05.31.15.30.22
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 May 2015 15:30:23 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.325.gb038f2f
In-Reply-To: <1433111371-19573-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270362>

Replace unnecessarily complex regular expression for recognizing comment
and blanks lines in sendmail aliases with idiomatic expressions which
can be easily understood at a glance.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 git-send-email.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 76bb499..e777bd3 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -505,7 +505,7 @@ sub parse_sendmail_alias {
 sub parse_sendmail_aliases {
 	my $fh = shift;
 	while (<$fh>) {
-		if (/^\s*(?:#.*)?$/) { next; }
+		next if /^\s*$/ || /^\s*#/;
 		parse_sendmail_alias($_);
 	}
 }
-- 
2.4.2.538.g5f4350e
