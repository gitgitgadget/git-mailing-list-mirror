From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] send-email uses contacts to propose recipients
Date: Fri, 16 Aug 2013 00:17:49 +0200
Message-ID: <1376605069-525-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: mst@kernel.org, felipe.contreras@gmail.com, bebarino@gmail.com,
	gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 16 00:17:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA5rX-00008V-LP
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 00:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561Ab3HOWRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 18:17:44 -0400
Received: from mail-ee0-f44.google.com ([74.125.83.44]:38019 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243Ab3HOWRn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 18:17:43 -0400
Received: by mail-ee0-f44.google.com with SMTP id b47so630980eek.17
        for <git@vger.kernel.org>; Thu, 15 Aug 2013 15:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=yKiUS62zZ2zQLaNXI0XeSyirLMkdRNiGOdLDFSNKtt4=;
        b=NVO7HR6At87zdzJdnzEYpOJ9gX3La4e5wY3c0unNsG5zhXdWHw5v/DPcEWDqvAvPf+
         ton9V4sn8oHrJO/TMDE+FRB15jPU2G0DTAHcDtv4mtsKc+Na2X7b4O9ulNlnpKR6/uI7
         zOCLoNjKVQdovCFbL8DVqNDx18MZNARBvLZlhG/OJGfsm90EyujcAVtdyCRAM3dGCx70
         pNDueLmUcP1z/56tnjdNcwbYxQr5bHRhvvmwxNHzoo/Tu1ySPq0P09ZHa/K5ESBBLDAm
         1izqak7+/d9lSLMA46jDG6ssWJ0+foOtmdDx25HOAkVmiTLMXjlewr4ppOOzRpqqoi47
         8rDQ==
X-Received: by 10.14.225.199 with SMTP id z47mr25680272eep.24.1376605062255;
        Thu, 15 Aug 2013 15:17:42 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id a1sm2270550eem.1.2013.08.15.15.17.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 Aug 2013 15:17:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc3.1.gc1ebd90
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232379>

I have got an idea regarding the send-email. If there are no recipients
given, it could propose recipients using the new 'git contacts'
This would help people new to projects to not forget people, who may have
the most knowledge reviewing that specific patch.

Unfortunately I cannot read/write perl, so I cannot solve it
myself in the near future, but I'd put it on my todo list for later.
---
 git-send-email.perl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 2162478..a34723d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -757,6 +757,12 @@ $sender = sanitize_address($sender);
 
 my $prompting = 0;
 if (!@initial_to && !defined $to_cmd) {
+	if (git contacts is available) {
+		proposed senders = git contacts on the same range or set of patches
+		print "Suggesting these receivers:\n"
+		print proposed senders
+	}
+
 	my $to = ask("Who should the emails be sent to (if any)? ",
 		     default => "",
 		     valid_re => qr/\@.*\./, confirm_only => 1);
-- 
1.8.4.rc3.1.gc1ebd90
