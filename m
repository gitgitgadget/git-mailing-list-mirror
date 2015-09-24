From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] SQUASH for "fetch_populated_submodules: use new parallel job processing"
Date: Thu, 24 Sep 2015 14:13:06 -0700
Message-ID: <1443129187-18572-2-git-send-email-sbeller@google.com>
References: <xmqqzj0cv9v8.fsf@gitster.mtv.corp.google.com>
 <1443129187-18572-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, vlovich@gmail.com, ericsunshine@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 24 23:13:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDpd-00083d-9U
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753958AbbIXVNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:13:22 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35654 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870AbbIXVNR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:13:17 -0400
Received: by pacfv12 with SMTP id fv12so84819768pac.2
        for <git@vger.kernel.org>; Thu, 24 Sep 2015 14:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zUFqUXvwipatyi2vmhk1+ZJeM19zzaR6BUK9IeCfUFI=;
        b=oleq0rKUauTUFlmAHwyqpORs84GE10yTli8pmtI9vPbzy9xngLa/RHVU2nWBuWg77t
         qLvoFEJRskrgWQCSK4VpXSuStjAnn9FkPkmnZN9ZVrhAiCMau7z2p/Qk0FIOH6T0GJu+
         YfJXy4lqHKfCvAYWZf655Q25ALpmlTr0YZnABaSdX0dQn/1WqlFQfBQteLIBJbzOE3RZ
         geX/lcEg/R/zYrbctm4fxo55p6SdfWCkpMWbabAEVoXJLKm4m5rkPo0fBV2kKBfJ2LHa
         2TCgWb17uBgcdprGbc8QpUmMC60BAPbZd0j9nhh4iGhMNvPi7hRsAiAJRn+TuC5VCReD
         C3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zUFqUXvwipatyi2vmhk1+ZJeM19zzaR6BUK9IeCfUFI=;
        b=C9Os52Pb7RgitttPZLtuDvf18cFOE21l1cslWp0FZgWw6mJv7qSWAD0u7Qx0nfobsk
         AuGH7CD9tmU3lGBCScHUN5TlfsqkPmL3E3XfNhXGulJ9rRPmnAye7bjvSyeMvCUBrpNZ
         YJr0sGh0K3GvJrQc9UttmDb8Qfd/h/aXsWYlUo7gqKESCffwd21O+hU5i5NRLPUs1SS9
         y//SaH6Sa95q8TPmEb85VvSepRhr2QoDKu0pH3mcW7SgJot4pd/16Ngnj5GGzirm4SSk
         b4J0gXl3It54jaa4QH7mPNvZrgr/B6a+/U9m8A3mJv+dDfs/5+SbMEcWpD1ElYDlPLnD
         eJxQ==
X-Gm-Message-State: ALoCoQn/lXdJw3HoaLyKJr2Gc8/JE5L3gd2feSw8L37CaGxH018Qx5Ldiu/VWJxlI4OYK9SOGiDI
X-Received: by 10.68.95.3 with SMTP id dg3mr2196684pbb.35.1443129197252;
        Thu, 24 Sep 2015 14:13:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:85b5:1b05:2b7d:c74a])
        by smtp.gmail.com with ESMTPSA id su3sm128301pbc.83.2015.09.24.14.13.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 24 Sep 2015 14:13:16 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.273.g6fa2560.dirty
In-Reply-To: <1443129187-18572-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278630>

This fixes the function signature in the first user of the async run processor.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index d7c7a6e..2c4396b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -630,13 +630,15 @@ struct submodule_parallel_fetch {
 int get_next_submodule(void *data, struct child_process *cp,
 		       struct strbuf *err);
 
-void handle_submodule_fetch_start_err(void *data, struct child_process *cp, struct strbuf *err)
+void handle_submodule_fetch_start_err(void *data, struct child_process *cp,
+				      struct strbuf *err)
 {
 	struct submodule_parallel_fetch *spf = data;
 	spf->result = 1;
 }
 
-void handle_submodule_fetch_finish( void *data, struct child_process *cp, int retvalue)
+void handle_submodule_fetch_finish(void *data, struct child_process *cp,
+				   struct strbuf *err, int retvalue)
 {
 	struct submodule_parallel_fetch *spf = data;
 
-- 
2.5.0.273.g6fa2560.dirty
