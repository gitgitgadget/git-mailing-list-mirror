From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] git: fix memory leak in show-diff.c
Date: Thu, 14 Apr 2005 14:08:34 +0200
Message-ID: <20050414120834.GA14290@elte.hu>
References: <20050414112638.GA12593@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 14:06:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM368-00061k-DH
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 14:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVDNMIs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 08:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVDNMIs
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 08:08:48 -0400
Received: from mx2.elte.hu ([157.181.151.9]:12421 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261484AbVDNMIp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 08:08:45 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id 6CBF93197BD;
	Thu, 14 Apr 2005 14:07:49 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id D68B51FC2; Thu, 14 Apr 2005 14:08:37 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050414112638.GA12593@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


this patch fixes a memory leak in show-diff.c.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- show-diff.c.orig
+++ show-diff.c
@@ -53,6 +53,7 @@ static void show_diff_empty(struct cache
 			printf("\n");
 		fflush(stdout);
 	}
+	free(old);
 }
 
 int main(int argc, char **argv)
