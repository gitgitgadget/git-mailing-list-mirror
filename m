From: "Brian O'Mahoney" <omb@khandalf.com>
Subject: Re: SHA1 hash safety
Date: Sat, 16 Apr 2005 15:29:14 +0200
Message-ID: <4261132A.3090907@khandalf.com>
References: <Pine.LNX.4.62.0504160519330.21837@qynat.qvtvafvgr.pbz>
    <20050416123155.GA19908@elte.hu>
    <Pine.LNX.4.62.0504160542190.21837@qynat.qvtvafvgr.pbz>
Reply-To: omb@bluewin.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 15:26:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMnJF-0004up-79
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 15:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262660AbVDPN3U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 09:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbVDPN3U
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 09:29:20 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:39558 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S262660AbVDPN3N (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 09:29:13 -0400
Received: from khandalf.com (80-218-57-125.dclient.hispeed.ch [80.218.57.125])
	(authenticated bits=0)
	by smtp.hispeed.ch (8.12.6/8.12.6/tornado-1.0) with ESMTP id j3GDTBbb019546
	for <git@vger.kernel.org.>; Sat, 16 Apr 2005 15:29:12 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by
    teraflex.teraflex-research.com (8.12.10/8.12.10/SuSE Linux 0.7) with ESMTP
    id j3GDTH2Q001342; Sat, 16 Apr 2005 15:29:19 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: David Lang <david.lang@digitalinsight.com>
In-Reply-To: <Pine.LNX.4.62.0504160542190.21837@qynat.qvtvafvgr.pbz>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
X-Md5-Body: 76fae0bc0f39a327816183be5a449d56
X-Transmit-Date: Saturday, 16 Apr 2005 15:29:46 +0200
X-Message-Uid: 0000b49cec9d5ae000000002000000004261134a000a307e000000010008ce34
Replyto: omb@bluewin.ch
X-Sender-Postmaster: Postmaster@80-218-57-125.dclient.hispeed.ch.
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on smtp-02.tornado.cablecom.ch
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Three points:
(1) I _have_ seen real-life collisions with MD5, in the context of
    Document management systems containing ~10^6 ms-WORD documents.
(2) The HMAC (ethernet-harware-address) of any interface _should_
    help to make a unique Id.
(3) While I havn't looked at the details of the plumbing, this is
    the time to make sure we can, easily, drop in SHA-160, SHA-256
    (or whatever comes from NIST) when needed.


David Lang wrote:
> On Sat, 16 Apr 2005, Ingo Molnar wrote:
> 
>> * David Lang <david.lang@digitalinsight.com> wrote:
>>
>>> this issue was raised a few days ago in the context of someone
>>> tampering with the files and it was decided that the extra checks were
>>> good enough to prevent this (at least for now), but what about
>>> accidental collisions?
>>>
>>> if I am understanding things right the objects get saved in the
>>> filesystem in filenames that are the SHA1 hash. of two legitimate
>>> files have the same hash I don't see any way for both of them to
>>> exist.
>>>
>>> yes the risk of any two files having the same has is low, but in the
>>> earlier thread someone chimed in and said that they had two files on
>>> their system that had the same hash..
>>
>>
>> you can add -DCOLLISION_CHECK to Makefile:CFLAGS to turn on collision
>> checking (disabled currently). If there indeed exist two files that have
>> different content but the same hash, could someone send those two files?
> 
> 
> remember that the flap over SHA1 being 'broken' a couple weeks ago was
> not from researchers finding multiple files with the same hash, but
> finding that it was more likly then expected that files would have the
> same hash.
> 
> there was qa discussion on LKML within the last year about useing MD5
> hashes for identifying unique filesystem blocks (with the idea of being
> able to merge identical blocks) and in that discussion it was pointed
> out that collisions are a known real-life issue.
> 
> so if collision detection is turned on in git, does that make it error
> out if it runs into a second file with the same hash, or does it do
> something else?
> 
> David Lang
> 

-- 
Brian
