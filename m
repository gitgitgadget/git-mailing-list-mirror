From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: [PATCH] git-bundle: assorted fixes
Date: Thu, 22 Feb 2007 22:37:53 -0500
Message-ID: <45DE6191.5030200@verizon.net>
References: <Pine.LNX.4.63.0702220157130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0702221913250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45DE4507.7090206@verizon.net>
 <Pine.LNX.4.63.0702230249340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45DE4D85.3000906@verizon.net>
 <Pine.LNX.4.63.0702230316570.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, junkio@cox.net, Nicolas Pitre <nico@cam.org>,
	Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 23 04:38:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKRG1-0001SU-2f
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 04:38:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbXBWDiB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 22:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbXBWDiB
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 22:38:01 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:58419 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbXBWDiA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 22:38:00 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDW007R0CR3GQJ9@vms046.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 22 Feb 2007 21:37:52 -0600 (CST)
In-reply-to: <Pine.LNX.4.63.0702230316570.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Newsgroups: gmane.comp.version-control.git
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40411>

Johannes Schindelin wrote:
> 
> On Thu, 22 Feb 2007, Mark Levedahl wrote:
> 
>> Johannes Schindelin wrote:
>>
>>> Mark wrote:
>>>
>>>> 2) git bundle verify reports only a single sha1 if prerequisites are 
>>>> not met.
>>> With the two follow-up patches I sent, this issue should be resolved, 
>>> no?
>>>
>>   I missed one of your patches, adding that, the problem is incompletely 
>> fixed: all missing commits are shown, but only as raw hashes (e.g., the 
>> 1-line commit message is not there to describe what is missing).
> 
> Okay, how about this on top:
> 
>

That works. I would change your error message slightly, perhaps...

diff --git a/builtin-bundle.c b/builtin-bundle.c
index d74afaa..e115feb 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -172,7 +172,7 @@ static int verify_bundle(struct bundle_header *header)
     struct object_array refs;
     struct commit *commit;
     int i, ret = 0, req_nr;
-   const char *message = "The bundle requires these lacking revs:";
+   const char *message = "Your repository lacks these prerequisite 
commits:";

     init_revisions(&revs, NULL);
     for (i = 0; i < p->nr; i++) {

Mark
