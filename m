From: david@lang.hm
Subject: Re: .gittattributes handling has deficiencies
Date: Sun, 21 Oct 2007 16:49:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0710211645210.12998@asgard.lang.hm>
References: <1192956535617-git-send-email-prohaska@zib.de>
 <Pine.LNX.4.64.0710210204580.4818@asgard> <B61AE1A9-E983-4ACE-BF71-8FDC113A4F34@zib.de>
 <Pine.LNX.4.64.0710211007430.4818@asgard> <1A07FEE6-88D8-4ED7-BEFD-F7F3B71310A5@zib.de>
 <Pine.LNX.4.64.0710211056580.4818@asgard> <C7F59DFB-D4E4-4F75-88F7-F1A90C7D41E8@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 01:43:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjkSG-0008Ue-ID
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 01:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbXJUXnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 19:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbXJUXnZ
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 19:43:25 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:53514
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbXJUXnY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 19:43:24 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l9LNhNHl001040;
	Sun, 21 Oct 2007 16:43:24 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <C7F59DFB-D4E4-4F75-88F7-F1A90C7D41E8@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61921>

On Sun, 21 Oct 2007, Steffen Prohaska wrote:

> On Oct 21, 2007, at 7:57 PM, david@lang.hm wrote:
>
>> On Sun, 21 Oct 2007, Steffen Prohaska wrote:
>> 
>>> On Oct 21, 2007, at 7:09 PM, david@lang.hm wrote:
>>> 
>>>> On Sun, 21 Oct 2007, Steffen Prohaska wrote:
>>>>> On Oct 21, 2007, at 11:19 AM, david@lang.hm wrote:
>>>>>>> But this is really hard to solve. We would need to compare
>>>>>>> attributes before and after for _all_ files that have attributes
>>>>>>> in one of the two commits and check if they changed. If so, we
>>>>>>> need to do a fresh checkout according to the new attributes.
>>>>>> if you know that you will get the new .gitattributes if it changes, 
>>>>>> setup a post-checkout hook to checkout everything if it has changed. 
>>>>>> it's far from ideal, but it should be a good, safe, first 
>>>>>> approximation.
>>>>> That's not good enough. I'll stop using .gitattributes. I
>>>>> need to teach >40 devs how to use git on Windows. I only use
>>>>> features that work flawlessly. .gitattributes doesn't. It bit
>>>>> me twice now.
>>>> why would checking everything out if .gitattributes has changed not work? 
>>>> I can see why _not_ doing so would cause problems, and I freely 
>>>> acknowledge that this approach imposes a performance hit by checking 
>>>> everything out twice, but I don't see how it would not be reliable.
>>> 
>>> What do you mean by "checking out everything"?
>>> Which command do you propose?
>> 
>> something like git checkout -f
>
> I suspected this. I see two problems:
>
> 1) it's too dangerous: I throws away _all_ changes, not only
> changes that are related to gitattributes.

this is true, the question of if this is 'too dangerous' depends on what 
workflow you teach as safe. if you teach that checking out a new version 
will loose any modifications you have made (which is useually the sane 
thing to do by default anyway) then this is just more of the same

> 2) it doesn't work reliably. git checkout -f will only update
> files that git detects as changed. But you could have files that
> should have crlf in the working copy but actually have only lf.
> Those would not be updated.

ok, you could do rm -r * before doing the checkout -f (or there's probably 
a option to git to tell it not to preserve changes to the working area, I 
am not a git guru.

> I'll not recommend this. Not using .gitattributes is the only
> sane solution.

it may be the best thing to do for you and your users, that's not the same 
thing as saying that it's the only sane solution.

David Lang
