From: Ittay Dror <ittayd@tikalk.com>
Subject: merge renamed files/directories? (was: Re: detecting rename->commit->modify->commit)
Date: Sat, 03 May 2008 20:56:18 +0300
Message-ID: <481CA742.4080909@tikalk.com>
References: <4819CF50.2020509@tikalk.com> <4819D98E.1040004@tikalk.com> <32541b130805010827r22169651s37c707071f3448f2@mail.gmail.com> <20080501153457.GB11469@sigill.intra.peff.net> <D0968007-2A38-44DB-B26F-3D273F20D428@midwinter.com> <20080501231427.GD21731@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 19:57:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsLz2-00086W-M0
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 19:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109AbYECR43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 13:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbYECR43
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 13:56:29 -0400
Received: from smtp104.biz.mail.re2.yahoo.com ([206.190.52.173]:28098 "HELO
	smtp104.biz.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751080AbYECR42 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 May 2008 13:56:28 -0400
Received: (qmail 81162 invoked from network); 3 May 2008 17:56:23 -0000
Received: from unknown (HELO ?192.168.1.9?) (ittayd@tikalk.com@84.108.89.36 with plain)
  by smtp104.biz.mail.re2.yahoo.com with SMTP; 3 May 2008 17:56:20 -0000
X-YMail-OSG: vmomoUoVM1n_iFUyvHkzB1xjHhlrehatYzOfp4YazYw_0yc7qerxZlVZu1cG46BXywO5BNsM3M3xE9lyoymisV76NAsYG5f6h7EA52kKDoom.wbHAmtzIpWIypWdglAV3FShueXvPoL4yalhRXWBsYIc
X-Yahoo-Newman-Property: ymail-3
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <20080501231427.GD21731@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81107>

Can someone comment whether supporting merges after renames will be on 
the Git roadmap?

As a Java developer, I can say that refactoring of class names and 
packages happens quite often. Having to remember I've made this change 
throughout the lifetime of a branch (or master, until pushed to a 
central repository), and needing to manually merge changes to files / 
packages (directories) I've refactored is something that I want my VCS 
to do.

Thank you,
Ittay

Jeff King wrote:
> On Thu, May 01, 2008 at 12:12:33PM -0700, Steven Grimm wrote:
>
>   
>> However, that leaves the question of which default will be wrong the  
>> least often.
>>
>> In my personal experience, I think a directory rename has almost always 
>> meant that I would want new files to appear in the new directory rather 
>>     
>
> I do agree that the rename is probably more often desired.
>
>   
>> Of course, the discussion is moot anyway until someone writes code to  
>> detect the situation; my impression is the current behavior is the way it 
>> is simply because it's what naturally happens in the absence of  
>> merge-time detection of a directory getting renamed.
>>     
>
> Yes, I think that is largely a correct impression (although I think
> Linus has spoken out against directory renaming in the past, so there is
> at least a little bit of conscious effort). I suspect the right sequence
> of steps to implement this would be:
>
>   1. write a proof-of-concept that shows directory renaming after the
>     fact (e.g., take a conflicted merge, scan the diff for directory
>     renames, and then fix up the files). That way it is available, but
>     doesn't impact git at all.
>
>   2. If people think it is useful, build it into the diff and merge
>      machinery so that it can happen automagically, but make it
>      optional. Thus git fully supports it, but the policy decision is
>      left up to the user.
>
>   3. Make it the default if it is the common choice.
>
> So we just need somebody to volunteer to work on 1. ;)
>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   

-- 
Ittay Dror <ittayd@tikalk.com>
Tikal <http://www.tikalk.com>
Tikal Project <http://tikal.sourceforge.net>
