From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: git push bug?
Date: Sat, 20 Oct 2007 10:38:04 +0200
Message-ID: <1216340A-9A44-49AC-9FF6-B289E8736893@zib.de>
References: <1192719040.9433.5.camel@gentoo-jocke.transmode.se>  <0DAC53EF-021D-441C-9520-9795AAB6DE54@zib.de> <1192723269.9433.21.camel@gentoo-jocke.transmode.se> <Pine.LNX.4.64.0710181720010.25221@racer.site> <9EEDF284-22BE-44BF-A9B8-116407784BEB@zib.de> <Pine.LNX.4.64.0710182258000.25221@racer.site> <5513C211-DE33-411C-8EE6-2259B41DC3EA@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Lars Hjemli <hjemli@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 20 10:37:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij9pK-0007P5-GX
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 10:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754430AbXJTIgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 04:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754400AbXJTIgn
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 04:36:43 -0400
Received: from mailer.zib.de ([130.73.108.11]:62187 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752209AbXJTIgn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 04:36:43 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9K8aaIC000812;
	Sat, 20 Oct 2007 10:36:36 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db1a6f2.pool.einsundeins.de [77.177.166.242])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9K8aZXB004204
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 20 Oct 2007 10:36:35 +0200 (MEST)
In-Reply-To: <5513C211-DE33-411C-8EE6-2259B41DC3EA@zib.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61814>

Shawn,
sp/push-refspec definitely needs more work (see below).


On Oct 20, 2007, at 10:29 AM, Steffen Prohaska wrote:

>
> On Oct 18, 2007, at 11:58 PM, Johannes Schindelin wrote:
>
>>
>> On Thu, 18 Oct 2007, Steffen Prohaska wrote:
>>>
>>> But you need a full refspec starting with 'refs/heads/' if you  
>>> want to
>>> create a new branch on the remote side.
>>
>> No.  Not if the name is the same on the local side.
>
> You're right. The documentation of git-send-pack says what you're
> saying:
>
> [...]
>
> Until you corrected me, I believed that new branches will never
> be created on the remote side unless a full ref is used. That is
> I expected that only
>
>    git push origin refs/heads/work/topic
>
> would work.
>
> I thought this would be another safety net -- kind of a reminder
> not to push the wrong branch by accident.
>
> I still like the idea, but apparently git didn't ever support what
> I thought it would.

And I even fixed the behavior to match my expectation in a patch
which made it to spearce/pu:


d869233c62688742968663c4e8b5ff20a50a5011

     push, send-pack: fix test if remote branch exists for colon-less  
refspec

     A push must fail if the remote ref does not yet exist and the  
refspec
     does not start with refs/. Remote refs must explicitly be  
created with
     their full name.

     This commit adds some tests and fixes the existence check in  
send-pack.


sp/push-refspec definitely needs some more work.

	Steffen
