From: Junio C Hamano <junkio@cox.net>
Subject: http-fetch troubles
Date: Fri, 02 Jun 2006 10:38:15 -0700
Message-ID: <7vac8vbgqg.fsf_-_@assigned-by-dhcp.cox.net>
References: <20060601232437.GD12261@reactrix.com>
	<7vhd34dptq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nick Hengeveld <nickh@reactrix.com>
X-From: git-owner@vger.kernel.org Fri Jun 02 19:39:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmDbd-0003ZP-Cu
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 19:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWFBRiT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 13:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWFBRiS
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 13:38:18 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:6063 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751352AbWFBRiR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jun 2006 13:38:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060602173816.HUSB554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 2 Jun 2006 13:38:16 -0400
To: git@vger.kernel.org, Becky Bruce <Becky.Bruce@freescale.com>
In-Reply-To: <7vhd34dptq.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 01 Jun 2006 23:38:57 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21171>

Junio C Hamano <junkio@cox.net> writes:

> Nick Hengeveld <nickh@reactrix.com> writes:
>
>> - "git push" seems to pass --thin by default to http-push, which
>>   subsequently barfs because that's not a valid http-push option.
>>   Should it be?  Should it be silently ignored?  Should git-push not
>>   default to --thin when pushing with HTTP transport?
>
> The way I understand http-push works is that it does not use
> packed transfer, so I presume even if we give --thin as a hint
> it cannot even take advantage of it.  Probably we should stop
> passing --thin to http transport (git native one uses it as a
> cue that it can generate baseless deltas in the resulting pack).
>
>> - when I clone, http-fetch outputs a whole bunch of 
>>   "error: Could not read ..." messages - is that expected?
>
> The clone over http seems to be severely broken in "next" right
> now.  The one in "master" seems to be OK.  bisecting suggests
> the breakage is coming from the tree parser rewrite.
>
> bisect points at 136f2e548a34f1f504b0f062f87ddf33e8d6e83b.

I've pushed out Nick's http-fetch fixes in "master" to see if it
fixes problems for people.  Right now the one in "next" branch
seems to be having unrelated problems coming from another topic
which I haven't started tracking down yet.
