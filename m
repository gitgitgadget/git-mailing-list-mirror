From: Christian Biesinger <cbiesinger@web.de>
Subject: Re: [PATCH] Don't send copies to the From: address
Date: Sat, 11 Feb 2006 13:31:13 +0100
Message-ID: <43EDD911.3030003@web.de>
References: <11396260373307-git-send-email-cbiesinger@web.de> <7vk6c2sg66.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>,
	Greg Kroah-Hartman <greg@kroah.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 13:31:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7tuc-0006As-4N
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 13:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWBKMbY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 07:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWBKMbY
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 07:31:24 -0500
Received: from smtp07.web.de ([217.72.192.225]:38023 "EHLO smtp07.web.de")
	by vger.kernel.org with ESMTP id S1751383AbWBKMbX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2006 07:31:23 -0500
Received: from [85.124.17.142] (helo=[192.168.1.4])
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.105 #340)
	id 1F7tuI-0005Lv-00; Sat, 11 Feb 2006 13:31:18 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9a1) Gecko/20060209 SeaMonkey/1.5a
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6c2sg66.fsf@assigned-by-dhcp.cox.net>
X-Sender: cbiesinger@web.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15939>

Junio C Hamano wrote:
> I cannot speak for Ryan or Greg, but I think the script
> deliberately does this to support this workflow:

Yeah, I suspected that this was the usecase. I don't think the patch 
breaks that, it just compares those addresses to $from, i.e. the address 
from which the email is sent.

> Me, personally I do not like CC: to people on the signed-off-by
> list, but dropping a note to From: person makes perfect sense to
> me, if it is to notify the progress of the patch.

I guess my description was a bit ambiguous, I didn't mean From: as in 
"author of the patch", but instead From: as in "the email header for the 
sender of the message", that is, the person who invokes git-send-email.

> What you are after _might_ be not CC'ing it if it was your own
> patch.  Maybe something like this would help, but even if that
> is the case I suspect many people want to CC herself so it needs
> to be an optional feature.

So a new --no-cc-self option?

> -	$cc = join(", ", unique_email_list(@cc));
> +	$cc = join(", ", unique_email_list(grep { $_ ne $from } @cc));

This seems to be basically the same as what my patch does, except that 
your way seems better :-)
