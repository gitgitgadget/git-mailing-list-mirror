From: Allan Caffee <allan.caffee@gmail.com>
Subject: [PATCH 2/3] graph API: fix extra space during pre_commit_line state
Date: Wed, 22 Apr 2009 17:27:28 -0400
Message-ID: <20090422212728.GA30484@linux.vnet>
References: <20090422193838.GA1841@linux.vnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Teemu Likonen <tlikonen@iki.fi>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 23:29:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwk0A-0002C9-Tl
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 23:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846AbZDVV1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 17:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753555AbZDVV1f
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 17:27:35 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:49602 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427AbZDVV1e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 17:27:34 -0400
Received: by wf-out-1314.google.com with SMTP id 26so162456wfd.4
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 14:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=9Wk6Dhu8G08sOQmQEen3eIornkrUc6s/1F/7iCKBTxI=;
        b=bwSk6KekBpwvQn3gwp0GI6H4tF0JcECjrkVgC1jMjxsBOtcNfUlZ5r+oH5eswn5L3K
         0nqxVwSFr9i5pDwHqj9LFIqq0dZvfIuxbCzpCvBnkY7Kcw1QLIAVwIRltbWopEJFYLL8
         0fS5icwDDSWxMH80+XbDNWiait6wZ/5bRgS3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=BFtDe1btlRjSN3T+1gWHU8cMxKup/GtkOTGj2TAyio6cmUdJ4w68uVtiFSqp/cGpHH
         jDkyI/hBEvFT41iq4LMC3ofYaVTbD1gO3IDQWs93EjWV2QIeOD1ot2KcLdcAboKTk0TP
         cCDAwgMs82a32Rd6CYK8QkBrMFYtrGgOZ8leI=
Received: by 10.142.125.11 with SMTP id x11mr60934wfc.93.1240435654224;
        Wed, 22 Apr 2009 14:27:34 -0700 (PDT)
Received: from linux.vnet (pool-71-185-49-127.phlapa.fios.verizon.net [71.185.49.127])
        by mx.google.com with ESMTPS id 30sm1066594wfd.1.2009.04.22.14.27.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Apr 2009 14:27:33 -0700 (PDT)
Mail-Followup-To: git@vger.kernel.org, Teemu Likonen <tlikonen@iki.fi>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20090422193838.GA1841@linux.vnet>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117268>

An extra space is being inserted between the "commit" column and all of
the successive edges.  Remove this space.  This regression was
introduced by 427fc5b.

Signed-off-by: Allan Caffee <allan.caffee@gmail.com>
---
 graph.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/graph.c b/graph.c
index d4571cf..31e09eb 100644
--- a/graph.c
+++ b/graph.c
@@ -727,8 +727,8 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 		if (col->commit == graph->commit) {
 			seen_this = 1;
 			strbuf_write_column(sb, col, '|');
-			strbuf_addf(sb, " %*s", graph->expansion_row, "");
-			chars_written += 2 + graph->expansion_row;
+			strbuf_addf(sb, "%*s", graph->expansion_row, "");
+			chars_written += 1 + graph->expansion_row;
 		} else if (seen_this && (graph->expansion_row == 0)) {
 			/*
 			 * This is the first line of the pre-commit output.
-- 
1.5.6.3
