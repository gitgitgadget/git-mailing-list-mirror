From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH 4/4] When debug==1, start fast-import with "--stats" instead of "--quiet".
Date: Wed, 11 Jul 2012 15:38:53 +0200
Message-ID: <1342013933-14381-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1342013933-14381-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1342013933-14381-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1342013933-14381-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1342013933-14381-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 15:40:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sox9I-0008Gl-Si
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 15:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757858Ab2GKNkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 09:40:06 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35780 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757696Ab2GKNkD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 09:40:03 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1074961bkw.19
        for <git@vger.kernel.org>; Wed, 11 Jul 2012 06:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=2HjI6bwfqbJ+nPKlDNuBmSiR7ygcPPDNYRkmKUnM/w8=;
        b=jaJTtMHxLKKlbNFCrDJpfkg4r16/14XqdYUBT1pqHPLHexdkXYa68AkfJsljE/1xk8
         TYWk9q/6F0kxOJr/KCenD7kePK/QD5diQ1yJjrtbWDkmoU2pq8yNepQJJIGRWsVsJWeA
         UC+3FQ9uWRDzIm6RaPeInJnbBb7qwXy5RKkIcS4JnK3kDrwV4kRi52x65xkjc0FnDedt
         WelJ5rM+gW6WqL1yj2080pcgxZgHXmS80qtIuxEUB1qWGzf8nU35NtshYvJ5I+b6Fvc8
         rlU5u5ZdGcl/YKy1sTCb0QmySCxCOmgZPW394QwidAdzoxjk4Z1zX/O/yBZqG6kYP72z
         beTg==
Received: by 10.205.122.147 with SMTP id gg19mr19983313bkc.73.1342014002273;
        Wed, 11 Jul 2012 06:40:02 -0700 (PDT)
Received: from flobuntu.lan (91-115-86-162.adsl.highway.telekom.at. [91.115.86.162])
        by mx.google.com with ESMTPS id fu8sm1207082bkc.5.2012.07.11.06.39.58
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Jul 2012 06:40:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1342013933-14381-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201297>

fast-import prints statistics that could be interesting to the
developer of remote helpers.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 transport-helper.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index 616db91..d6daad5 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -392,7 +392,7 @@ static int get_importer(struct transport *transport, struct child_process *fasti
 	memset(fastimport, 0, sizeof(*fastimport));
 	fastimport->in = helper->out;
 	argv_array_push(argv, "fast-import");
-	argv_array_push(argv, "--quiet");
+	argv_array_push(argv, debug ? "--stats" : "--quiet");
 	argv_array_pushf(argv, "--cat-blob-pipe=%s", data->report_fifo);
 	fastimport->argv = argv->argv;
 	fastimport->git_cmd = 1;
-- 
1.7.9.5
