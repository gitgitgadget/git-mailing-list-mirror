From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Tue, 13 Feb 2007 20:42:52 -0500
Message-ID: <45D2691C.4090005@verizon.net>
References: <45CFA30C.6030202@verizon.net>
 <200702130932.51601.litvinov2004@gmail.com>
 <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
 <200702131816.27705.litvinov2004@gmail.com> <eqt40c$5ov$1@sea.gmane.org>
 <Pine.LNX.4.64.0702131225070.3604@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 14 02:43:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH9Av-0001IM-AD
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 02:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbXBNBmv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 20:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbXBNBmv
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 20:42:51 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:45630 "EHLO
	vms048pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbXBNBmu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 20:42:50 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms048.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDF00I7IJFCO2U0@vms048.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 13 Feb 2007 19:42:50 -0600 (CST)
In-reply-to: <Pine.LNX.4.64.0702131225070.3604@woody.linux-foundation.org>
Newsgroups: gmane.comp.version-control.git
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39609>

Linus Torvalds wrote:
> 
> On Tue, 13 Feb 2007, Mark Levedahl wrote:
>> A proper win32 port will accept any of \n, \r\n as valid line endings (add
>> \r to support Mac pre-OSX if anyone cares, I still occasionally see such
>> files), treat any of them as semantically equal, and enforce the user's
>> chosen style (\n or \r\n) on output.
> 
> The patch I sent out does that, except right now the "autocrlf" flag is 
> just a pure boolean.
> 
> I could easily make it take a ternary value:
>  - off (normal UNIX semantics - never change anything)
>  - on (turn CRLF->LF on input, turn LF->CRLF on output)
>  - input-only (turn CRLF->LF on input, leave LF alone on output)
> 
> 
> 			Linus

Wow, this is an incredible response: I expected I was going to be 
studying git internals for a while to get to this point. Thank you!

The ternary value is definitely useful. As noted elsewhere, most tools 
on windows are very happy with \n ending, few honor those line endings 
when files are modified, and fewer still allow the user to specify use 
of \n for new files. However, cygwin tools in particular are not 
tolerant of crlf, so for that environment it makes sense to banish crlf 
and the input-only option is most likely the best default setting there.

Mark
