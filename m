From: Mike McCormack <mike@codeweavers.com>
Subject: Re: PATCH: Allow format-patch to attach patches
Date: Tue, 07 Mar 2006 12:20:38 +0900
Organization: CodeWeavers
Message-ID: <440CFC06.9080901@codeweavers.com>
References: <440C352C.9070009@codeweavers.com> <7vpskz5aqh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 04:25:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGSom-0008Bc-5n
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 04:25:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644AbWCGDY5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 22:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932646AbWCGDY5
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 22:24:57 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:51845 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S932644AbWCGDY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Mar 2006 22:24:56 -0500
Received: from foghorn.codeweavers.com ([216.251.189.130] helo=[127.0.0.1])
	by mail.codeweavers.com with esmtp (Exim 4.50)
	id 1FGSog-0000Jf-96; Mon, 06 Mar 2006 21:24:56 -0600
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923
X-Accept-Language: en, en-us
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpskz5aqh.fsf@assigned-by-dhcp.cox.net>
X-SA-Exim-Connect-IP: 216.251.189.130
X-SA-Exim-Mail-From: mike@codeweavers.com
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on mail
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17318>


Junio C Hamano wrote:

> The only two and half minor issues I might have about this are:
> 
>  (1) is the type text/x-patch appropriate?

I'm no expert on MIME types, unfortunately.  Maybe text/x-diff makes 
more sense?   A few different projects require one of those two types 
for diffs sent as attachments.  My main concern is that mailers can 
recognize that the attachment is text, then displayed with the message 
so that people can see the patch without opening the attachment.

>  (2) is it possible to cheaply come up with a safe mime-magic,
>      instead of a hardcoded long string and hope it does not
>      clash?

I agree that using a hardcoded long string isn't that great.  Reading 
all of the "diff-tree -p" output seems a bit expensive.  How about using 
   some part of the patch's SHA1 combined with date/time?

> The remaining half issue is if would it make sense to sometimes
> optionally use non 8-bit CTE for the patch part.

Maybe allow something like:

git-format-patch --attach=quoted-printable

where the default would be 8bit.  This require adding a perl script for 
each Content-Transfer-Encoding that we support.

Mike
