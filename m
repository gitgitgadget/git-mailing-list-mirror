From: David Lang <david.lang@digitalinsight.com>
Subject: Re: SHA1 hash safety
Date: Sat, 16 Apr 2005 15:33:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0504161531370.22652@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.62.0504160519330.21837@qynat.qvtvafvgr.pbz><20050416123155.GA19908@elte.hu><Pine.LNX.4.62.0504160542190.21837@qynat.qvtvafvgr.pbz>
 <4261132A.3090907@khandalf.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 00:30:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMvnX-0007X4-BG
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 00:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVDPWdi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 18:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVDPWdi
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 18:33:38 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:47560 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S261163AbVDPWde
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 18:33:34 -0400
Received: from wlvims01.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [12.107.209.244]) with SMTP; Sat, 16 Apr 2005 15:33:34 -0700
Received: by wlvexc02.diginsite.com with Internet Mail Service (5.5.2657.72)
	id <24ZZ1Z85>; Sat, 16 Apr 2005 15:33:14 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id 29YX1519; Sat, 16 Apr 2005 15:33:09 -0700
To: omb@bluewin.ch
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <4261132A.3090907@khandalf.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 16 Apr 2005, Brian O'Mahoney wrote:

> Three points:
> (1) I _have_ seen real-life collisions with MD5, in the context of
>    Document management systems containing ~10^6 ms-WORD documents.
> (2) The HMAC (ethernet-harware-address) of any interface _should_
>    help to make a unique Id.

you want a unique ID that can be computed directly from the file contents.

what file integrety programa (ala tripwire) do is to use multiple 
identification routines (aide uses MD4+MD5+filesize IIRC)

>
> David Lang wrote:
>> On Sat, 16 Apr 2005, Ingo Molnar wrote:
>>
>>> * David Lang <david.lang@digitalinsight.com> wrote:
>>>
>>>> this issue was raised a few days ago in the context of someone
>>>> tampering with the files and it was decided that the extra checks were
>>>> good enough to prevent this (at least for now), but what about
>>>> accidental collisions?
>>>>
>>>> if I am understanding things right the objects get saved in the
>>>> filesystem in filenames that are the SHA1 hash. of two legitimate
>>>> files have the same hash I don't see any way for both of them to
>>>> exist.
>>>>
>>>> yes the risk of any two files having the same has is low, but in the
>>>> earlier thread someone chimed in and said that they had two files on
>>>> their system that had the same hash..
>>>
>>>
>>> you can add -DCOLLISION_CHECK to Makefile:CFLAGS to turn on collision
>>> checking (disabled currently). If there indeed exist two files that have
>>> different content but the same hash, could someone send those two files?
>>
>>
>> remember that the flap over SHA1 being 'broken' a couple weeks ago was
>> not from researchers finding multiple files with the same hash, but
>> finding that it was more likly then expected that files would have the
>> same hash.
>>
>> there was qa discussion on LKML within the last year about useing MD5
>> hashes for identifying unique filesystem blocks (with the idea of being
>> able to merge identical blocks) and in that discussion it was pointed
>> out that collisions are a known real-life issue.
>>
>> so if collision detection is turned on in git, does that make it error
>> out if it runs into a second file with the same hash, or does it do
>> something else?
>>
>> David Lang
>>
>
> -- 
> Brian
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
