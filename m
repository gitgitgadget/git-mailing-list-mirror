From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] format-patch: fix dashdash usage
Date: Thu, 26 Nov 2009 21:11:59 +0200
Message-ID: <1259262720-24077-2-git-send-email-felipe.contreras@gmail.com>
References: <1259262720-24077-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 26 20:12:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDjlW-0007dq-Hl
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 20:12:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190AbZKZTMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 14:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751841AbZKZTMI
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 14:12:08 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:58454 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbZKZTMH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 14:12:07 -0500
Received: by mail-bw0-f227.google.com with SMTP id 27so755484bwz.21
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 11:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Ic1erzAEwYBubHLqLbOLrRQ+5zefEBBKVv446q4fYXc=;
        b=alqPPo37NGIEFpCeNnUPu+Uq9QqkvjvqtU/GM04IJDHygLZSAGA2rWjQKvpme+s98l
         BV1/kl7ANCaQCZBQCNdMpA3V1FvTfWxynRmw94M4qrz0Khr53ltg/gA2LBcNQaQZuiRu
         TUmvbVhFeKY6PmXI3giTrVMC+KsiRqrY30Ku8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Uh6730yDdhok9Y11u26hDM6pybF/JReohRcUgnaOt2UVxGxdN+Q/m0ND/jrESCvJ8V
         ZkXmoBMNlHhLlhYYRa7sFDSeF1LrCzmavOWrjN3hsJs5XBqdd+FSf+hN01Eb+JOl2MxI
         h/o3bIlqfllqLyNa47aOZ2swYhdAmauLorGFg=
Received: by 10.204.21.4 with SMTP id h4mr138077bkb.58.1259262733085;
        Thu, 26 Nov 2009 11:12:13 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id 14sm245213bwz.1.2009.11.26.11.12.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Nov 2009 11:12:12 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc0.61.geeb75
In-Reply-To: <1259262720-24077-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133823>

Otherwise 'git format-patch <committish> -- <non-existent-path>' doesn't
work.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-log.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 33fa6ea..1766349 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -976,7 +976,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	 */
 	argc = parse_options(argc, argv, prefix, builtin_format_patch_options,
 			     builtin_format_patch_usage,
-			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN);
+			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
+			     PARSE_OPT_KEEP_DASHDASH);
 
 	if (do_signoff) {
 		const char *committer;
-- 
1.6.6.rc0.61.geeb75
