From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Question about --tree-filter
Date: Thu, 05 Feb 2009 14:57:03 +0100
Message-ID: <498AF02F.4020609@viscovery.net>
References: <loom.20090204T155824-858@post.gmane.org> <4989C437.4070401@viscovery.net> <4989FDC6.2080404@gmail.com> <498AA41D.3000609@viscovery.net> <loom.20090205T123832-998@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 14:58:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV4kk-0002Rm-R2
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 14:58:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755098AbZBEN5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 08:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754753AbZBEN5X
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 08:57:23 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:63168 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbZBEN5X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 08:57:23 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LV4j7-00060i-BD; Thu, 05 Feb 2009 14:57:17 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4658969F; Thu,  5 Feb 2009 14:57:04 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <loom.20090205T123832-998@post.gmane.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108563>

Sergio Callegari schrieb:
> Johannes Sixt <j.sixt <at> viscovery.net> writes:
>> [ Don't cull Cc list, please! ]

By this I actually meant that you should "Reply to All", not just the
mailing list.

> When you say "at the end it updates the index file" do you mean the effect of
> the -u switch?

I think so.

> And when you say "Some files have the same timestamp as the index file" do you
> mean that diff-index uses the stat info inside the index only if a file is "<"
> than the index otherwise it is directly assumed that the file is changed wrt the
> index content? If so, would it make sense to re-touch the index after the
> checkout -u so that after the checkout the index is always > than every file it
> contains and one always starts at a non-racy situation?

No. The "racy" situation is not something that is bad. It's merely a
situation where git cannot decide from stat information alone whether a
file was changed or not. So it plays safe, and looks also at the content.

But if you lie about the index's timestamp, then git will think that all
files are up-to-date.

> With this, one could
> only explicitly touch those files that need to get (re)filtered and gain in
> efficiency... or am I still missing something?

No, you cannot if you are on a "fast" machine, where the touch happens in
the same second that the index file was written. But you can wait one
second before you touch the files. Depending on the volume of your total
data, this might actually be faster as long as you touch only selected files.

-- Hannes
