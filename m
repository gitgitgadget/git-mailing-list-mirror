From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Unresolved issues #3
Date: Fri, 18 Aug 2006 21:04:29 -0700
Message-ID: <44E68DCD.8010603@gmail.com>
References: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net> <44E546F2.7070902@gmail.com> <Pine.LNX.4.64.0608181041420.11359@localhost.localdomain> <44E5D522.8030407@gmail.com> <Pine.LNX.4.64.0608181119410.11359@localhost.localdomain>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 19 06:04:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEI4d-0006J2-MO
	for gcvg-git@gmane.org; Sat, 19 Aug 2006 06:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWHSEEd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Aug 2006 00:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWHSEEd
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Aug 2006 00:04:33 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:62820 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932313AbWHSEEd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Aug 2006 00:04:33 -0400
Received: by py-out-1112.google.com with SMTP id n25so1367909pyg
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 21:04:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=PCmokPeudNHkahdD1NHIpV0nXz9DI3qqqWZtX/TsN1rkTVVR+/BGvQyzZfUuTRZo92pMd79qmMzdcyNVcI9o2n6Ak1vIArXA0I2ZLUhXbNLJQhFTEuPVXtS5NXjqr9PJDsODV0c5AHbb4z1ZV4s34s2WxyN/o+ALa06sr2LHQ5I=
Received: by 10.65.114.11 with SMTP id r11mr3048107qbm;
        Fri, 18 Aug 2006 21:04:32 -0700 (PDT)
Received: from ?10.0.0.6? ( [68.234.172.127])
        by mx.gmail.com with ESMTP id 7sm1139608nzn.2006.08.18.21.04.30;
        Fri, 18 Aug 2006 21:04:31 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0608181119410.11359@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25707>

Nicolas Pitre wrote:
> On Fri, 18 Aug 2006, A Large Angry SCM wrote:
> 
>> Nicolas Pitre wrote:
>>> On Thu, 17 Aug 2006, A Large Angry SCM wrote:
>> ...
>>>> 1) I disagree with Nico's assessment that, other than his, there can not
>>>> exist any type 2 packs that have bit 6 set to mean copy from result.
>>> Care to explain why?
>>>
>>> Since this code is mine I can tell you that no official GIT version ever 
>>                                               ^^^^^^^^^^^^^^^^^^^^^^^
>>> produced such a pack.  The code to make use of that bit was quite 
>>> involving and the end result wasn't great at all so I never published 
>>> said code.  This is also why current GIT accepts both pack version 2 and 
>>> 3 without any distinction using the same code in patch-delta.c on the 
>>> basis that no version 2 packs ever used that bit.
>> That doesn't prove the non-existence of other code to do it.
> 
> So?  If the official and primary code for GIT doesn't support it, what 
> is the point?  I'm telling you that if such packs exist they will simply 
> barf with all official GIT releases later than v1.1.6 making your 
> argument pointless.
> 
> I don't mind you documenting that historic intent for a bit that was 
> never officially used, but at least let's document it right.

Historic fact. Between Thu May 19 08:56:22 2005 and Thu Feb  9 21:06:38
2006 bit 6 of the first byte of a delta hunk was interpreted to mean
that the source of the copy was the result buffer. From Thu May 19
08:56:22 2005 on, the code to decode delta hunks in type 2 packs was
available to everyone and anyone interested could make a pack encoder
that would create packs that the core Git code would correctly read. The
commit of Thu Feb  9 21:06:38 2006, d60fc, actually introduced a bug
that would treat valid type 2 packs as invalid.

Since there was not any documentation that declared the bit as reserved,
the code was the documentation and it specified that bit 6 of the first
byte of a delta hunk was to be interpreted as meaning the the copy
source in the result buffer. The code did not and does not document intent.
