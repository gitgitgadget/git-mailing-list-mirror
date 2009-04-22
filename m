From: Allan Caffee <allan.caffee@gmail.com>
Subject: [PATCH 2/3] graph API: fix extra space during pre_commit_line state
Date: Wed, 22 Apr 2009 15:52:13 -0400
Message-ID: <49ef7572.1e038e0a.2347.3896@mx.google.com>
References: <20090422193838.GA1841@linux.vnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Teemu Likonen <tlikonen@iki.fi>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 21:54:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwiW6-00015t-3m
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 21:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033AbZDVTwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 15:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753685AbZDVTwV
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 15:52:21 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:55331 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140AbZDVTwU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 15:52:20 -0400
Received: by wf-out-1314.google.com with SMTP id 26so131566wfd.4
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 12:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=9Wk6Dhu8G08sOQmQEen3eIornkrUc6s/1F/7iCKBTxI=;
        b=mk5vv3hjAfLNC4SH0w5tHHg7CWPlPu5uP4gYDiM8/CLuw7GIb5V/JV5coTGO+sHrxE
         l2u2xZYI15YrGfxaKO25EpEUIF0+MuMeJPfrNs4twOTBWBP+KAnwMeLlh7D52meGfu6O
         PKJF2yWMgqe0xKnSTa8xz49uQCoYhspDoIc1c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=NZFrBhENpA3cPrv/NZJM59THCm7NVNZT0Hy6Q2GyvzgII/ku6Xtvv2kxYDaFnn6O3G
         cVVOv+E5DdbJ2iIjG7JeX40oSlveBcZ/LZQ27q7z4yacAUb3zKrS9bO2++ZhpHMq3TDz
         IUDSCqKbco1+dBEGixcu21IHuZJuuq5ZCLskU=
Received: by 10.142.216.18 with SMTP id o18mr33651wfg.251.1240429939242;
        Wed, 22 Apr 2009 12:52:19 -0700 (PDT)
Received: from linux.vnet (n2-53-87.dhcp.drexel.edu [144.118.53.87])
        by mx.google.com with ESMTPS id 30sm181303wfc.24.2009.04.22.12.52.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Apr 2009 12:52:18 -0700 (PDT)
Mail-Followup-To: git@vger.kernel.org, Teemu Likonen <tlikonen@iki.fi>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20090422193838.GA1841@linux.vnet>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117243>

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
