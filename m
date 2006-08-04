From: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
Subject: Re: [RFC] Introduce git-xxdiff to invoke xxdiff for manual conflict
 resolution
Date: Fri, 04 Aug 2006 12:16:47 +1200
Message-ID: <44D291EF.4020506@catalyst.net.nz>
References: <11546492331601-git-send-email-martin@catalyst.net.nz> <7v64h9pdx4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 04 02:16:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8nN1-0007Ez-4S
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 02:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWHDAQv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 20:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWHDAQv
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 20:16:51 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:25758 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S932316AbWHDAQu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Aug 2006 20:16:50 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[192.168.2.69])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1G8nMt-0001EZ-Fa; Fri, 04 Aug 2006 12:16:47 +1200
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64h9pdx4.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24761>

Junio C Hamano wrote:

>>diff --git a/git-xxdiff.sh b/git-xxdiff.sh
>>new file mode 100755
>>index 0000000..d562ab2
>>--- /dev/null
>>+++ b/git-xxdiff.sh
>>@@ -0,0 +1,38 @@
>>+#!/bin/sh
>>+
>>+USAGE='<path>'
>>+SUBDIRECTORY_OK=No
>>+. git-sh-setup
>>+
>>+FILE=$1
>>+MERGE_HEAD=`git rev-parse MERGE_HEAD`
>>+
>>+# Sanity checks
> 
> 
> We can have unmerged index without MERGE_HEAD (for example,
> think "rebase --merge" or "am -3"); drop check for that and
> instead check for stage 2 ("ours") for the path.
> 
> 	git cat-file blob :2:$FILE

(didn't know the :$stage: trick, neat)

I did think of using merge stages but I wasn't sure whether all the 
merge strategies followed the same convention. I'll fix up and re-post it.

> Can xxdiff take more than one file pairs?

Not that I can see.

>>+xxdiff -wbB --show-merged-pane --merged-filename $FILE~merged $FILE~HEAD $FILE~MERGE_HEAD
>>\ No newline at end of file
> 
> ;-).

Ouch, yes, I forgot the newline. Grumble.

I am also telling xxdiff to save the merged file as ~merged rather than 
overwriting the merge attempt that git has made. Better safe than sorry.

cheers,

m
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
OFFICE: +64(4)916-7224                              MOB: +64(21)364-017
       Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------
