From: Michal Vitecek <fuf@mageo.cz>
Subject: [PATCH] Use "" instead of "<unknown>" for placeholders [was Re:
	[PATCH] Added a new placeholder '%cm' for full commit message]
Date: Fri, 21 Sep 2007 16:05:00 +0200
Message-ID: <20070921140500.GB9072@mageo.cz>
References: <20070921101420.GD22869@mageo.cz> <Pine.LNX.4.64.0709211146090.28395@racer.site> <20070921110646.GA9072@mageo.cz> <Pine.LNX.4.64.0709211207070.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 21 16:06:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYj8c-0006rK-5y
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 16:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758316AbXIUOFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 10:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758265AbXIUOFF
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 10:05:05 -0400
Received: from interactive-1.com ([193.85.232.82]:48636 "EHLO
	interactive-1.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758027AbXIUOFE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 10:05:04 -0400
Received: from interactive-1.com (localhost.localdomain [127.0.0.1])
	by interactive-1.com (Postfix) with ESMTP id 30FDA23B30F
	for <git@vger.kernel.org>; Fri, 21 Sep 2007 16:05:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709211207070.28395@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58855>

Johannes Schindelin wrote:
>On Fri, 21 Sep 2007, Michal Vitecek wrote:
>> Johannes Schindelin wrote:
>> >On Fri, 21 Sep 2007, Michal Vitecek wrote:
>> >
>> >> I have added a new placeholder '%cm' for a full commit message.
>> >
>> >You mean the raw message, including the headers?  Why not use "%r" for 
>> >that?
>> 
>>  No, sorry for the incorrect term. I meant the whole commit message
>>  (subject + 2*\n + body).
>
>Ah, makes sense.  In that case, "%M" maybe?

 I think it's no longer needed if instead of "<undefined>" only "" will
 be substituted.

>> >> I made it because I want to use my own pretty format which currently 
>> >> only allows '%s' for subject and '%b' for body. But '%b' is 
>> >> substituted with <undefined> if the body is "missing" which I 
>> >> obviously don't like :)
>> >
>> >Then you should fix %b not to show "<undefined>".
>> 
>>  I'll do it if it is okay. Shall I do the same for the other
>>  placeholders as well?
>
>Yeah.  Don't know why I did it that way.

 Here comes the big patch :)


>From 2e4ba4e73bbcd19558039dd85fe45c7bbe7fd1c4 Mon Sep 17 00:00:00 2001
From: Michal Vitecek <fuf@mageo.cz>
Date: Fri, 21 Sep 2007 14:40:37 +0200
Subject: [PATCH] Use "" instead of "<unknown>" for placeholders

---
 commit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/commit.c b/commit.c
index 99f65ce..7e90bc1 100644
--- a/commit.c
+++ b/commit.c
@@ -919,7 +919,7 @@ long format_commit_message(const struct commit *commit, const void *format,
 		table[IBODY].value = xstrdup(msg + i);
 	for (i = 0; i < ARRAY_SIZE(table); i++)
 		if (!table[i].value)
-			interp_set_entry(table, i, "<unknown>");
+			interp_set_entry(table, i, "");
 
 	do {
 		char *buf = *buf_p;
-- 
1.5.3.1

-- 
		fuf		(fuf@mageo.cz)
