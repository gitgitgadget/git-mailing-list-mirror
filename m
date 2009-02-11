From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [PATCH 3/3] completion: Prevents GIT_PS1_DIRTYSTATE from breaking
 when CWD is .git
Date: Wed, 11 Feb 2009 11:53:32 -0500
Message-ID: <4993028C.4010204@tedpavlic.com>
References: <1234366634-17900-1-git-send-email-ted@tedpavlic.com> <1234366634-17900-2-git-send-email-ted@tedpavlic.com> <1234366634-17900-3-git-send-email-ted@tedpavlic.com> <1234366634-17900-4-git-send-email-ted@tedpavlic.com> <20090211162612.GG30949@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, gitster <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 11 17:55:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXIMf-0002I3-8a
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 17:55:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755608AbZBKQxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 11:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755059AbZBKQxm
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 11:53:42 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:36122 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754700AbZBKQxl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2009 11:53:41 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id E153580D8088;
	Wed, 11 Feb 2009 11:47:09 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EyXNIe8tMd7M; Wed, 11 Feb 2009 11:47:09 -0500 (EST)
Received: from tedbook.mshome.net (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id CB06B80D8087;
	Wed, 11 Feb 2009 11:47:09 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <20090211162612.GG30949@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109443>

>> This patch uses "git rev-parse --is-inside-work-tree" to determine
>> whether a "--work-tree=.." should be added to the "git diff".
>
> I think it makes more sense to just drop the work tree stuff from
> the prompt if we aren't inside the work tree anymore.  Meaning,
> we should behave as though bash.showDirtyState is false.

I see.

At first, it seemed like it would be useful to know if the working 
directory was dirty even when you're within .git. However, I guess 
that's problematic when your working tree is in some completely 
unpredictable location. It's probably a bad idea to assume that work-tree=..

So you're right... there's a logical problem with having showDirtyState 
turned on when within .git. It should be disabled there.

So I'll check for "git rev-parse --is-inside-git-dir" and disable 
showDirtyState appropriately.

--Ted

-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.
