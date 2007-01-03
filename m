From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Make shortlog use 'h' (head) parameter again
Date: Wed,  3 Jan 2007 21:30:04 +0100
Message-ID: <11678562042320-git-send-email-jnareb@gmail.com>
References: <459C0232.3090804@linuxtv.org>
Cc: Michael Krufky <mkrufky@linuxtv.org>, linux-kernel@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 03 21:27:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2Chg-0008VP-8T
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 21:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbXACU1E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 15:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbXACU1E
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 15:27:04 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:45353 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932082AbXACU06 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 15:26:58 -0500
Received: by ug-out-1314.google.com with SMTP id 44so5266985uga
        for <git@vger.kernel.org>; Wed, 03 Jan 2007 12:26:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oCmnBh5SJYw70eXqoIQ2Z0fWjPER1gNLXvew+7up62T7l+VsiWXr7J9R5AmWjhTH77H9ZhNcHkDLV1DIILzJGi4yLzUhf+Ox9ayIPcyEdWnnof9D9MYgaZ9mmUpS0badFOeEw4vvVT9z+DafKDqnu1t0UKRwI/X5RS1U6wXtJlQ=
Received: by 10.67.106.3 with SMTP id i3mr9894739ugm.1167856017336;
        Wed, 03 Jan 2007 12:26:57 -0800 (PST)
Received: from roke.D-201 ( [81.190.20.195])
        by mx.google.com with ESMTP id u1sm20608640uge.2007.01.03.12.26.56;
        Wed, 03 Jan 2007 12:26:57 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l03KU5AE017372;
	Wed, 3 Jan 2007 21:30:06 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l03KU4IA017371;
	Wed, 3 Jan 2007 21:30:04 +0100
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.3
In-Reply-To: <459C0232.3090804@linuxtv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35889>

This fixes typo in 190d7fdcf325bb444fa806f09ebbb403a4ae4ee6

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Michael Krufky wrote:

> Ever since gitweb on kernel.org was recently updated, I've been experiencing a
> nasty bug -- It seems that it is no longer possible to view a shortlog from any
> branch or head other than master.
[...]
> "log" and "tree" is working properly -- it seems that "shortlog" is the only
> feature affected by this bug.

This corrects this bug.  When introducing parse_commits to shortlog,
there was typo in parse_commits arguments: it was $head instead of $hash.

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2ead917..2179054 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4423,7 +4423,7 @@ sub git_shortlog {
 	}
 	my $refs = git_get_references();
 
-	my @commitlist = parse_commits($head, 101, (100 * $page));
+	my @commitlist = parse_commits($hash, 101, (100 * $page));
 
 	my $paging_nav = format_paging_nav('shortlog', $hash, $head, $page, (100 * ($page+1)));
 	my $next_link = '';
-- 
1.4.4.3
