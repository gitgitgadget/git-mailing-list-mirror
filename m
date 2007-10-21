From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: .gittattributes handling has deficiencies
Date: Sun, 21 Oct 2007 22:21:31 +0200
Message-ID: <C7F59DFB-D4E4-4F75-88F7-F1A90C7D41E8@zib.de>
References: <1192956535617-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0710210204580.4818@asgard> <B61AE1A9-E983-4ACE-BF71-8FDC113A4F34@zib.de> <Pine.LNX.4.64.0710211007430.4818@asgard> <1A07FEE6-88D8-4ED7-BEFD-F7F3B71310A5@zib.de> <Pine.LNX.4.64.0710211056580.4818@asgard>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sun Oct 21 22:20:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjhI0-00020O-6X
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 22:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbXJUUUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 16:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753711AbXJUUUK
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 16:20:10 -0400
Received: from mailer.zib.de ([130.73.108.11]:46301 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751635AbXJUUUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 16:20:09 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9LKK4oL005729;
	Sun, 21 Oct 2007 22:20:05 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db1b164.pool.einsundeins.de [77.177.177.100])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9LKK2V9019505
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 21 Oct 2007 22:20:03 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0710211056580.4818@asgard>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61909>


On Oct 21, 2007, at 7:57 PM, david@lang.hm wrote:

> On Sun, 21 Oct 2007, Steffen Prohaska wrote:
>
>> On Oct 21, 2007, at 7:09 PM, david@lang.hm wrote:
>>
>>> On Sun, 21 Oct 2007, Steffen Prohaska wrote:
>>>> On Oct 21, 2007, at 11:19 AM, david@lang.hm wrote:
>>>>>> But this is really hard to solve. We would need to compare
>>>>>> attributes before and after for _all_ files that have attributes
>>>>>> in one of the two commits and check if they changed. If so, we
>>>>>> need to do a fresh checkout according to the new attributes.
>>>>> if you know that you will get the new .gitattributes if it  
>>>>> changes, setup a post-checkout hook to checkout everything if  
>>>>> it has changed. it's far from ideal, but it should be a good,  
>>>>> safe, first approximation.
>>>> That's not good enough. I'll stop using .gitattributes. I
>>>> need to teach >40 devs how to use git on Windows. I only use
>>>> features that work flawlessly. .gitattributes doesn't. It bit
>>>> me twice now.
>>> why would checking everything out if .gitattributes has changed  
>>> not work? I can see why _not_ doing so would cause problems, and  
>>> I freely acknowledge that this approach imposes a performance hit  
>>> by checking everything out twice, but I don't see how it would  
>>> not be reliable.
>>
>> What do you mean by "checking out everything"?
>> Which command do you propose?
>
> something like git checkout -f

I suspected this. I see two problems:

1) it's too dangerous: I throws away _all_ changes, not only
changes that are related to gitattributes.

2) it doesn't work reliably. git checkout -f will only update
files that git detects as changed. But you could have files that
should have crlf in the working copy but actually have only lf.
Those would not be updated.

I'll not recommend this. Not using .gitattributes is the only
sane solution.

	Steffen
