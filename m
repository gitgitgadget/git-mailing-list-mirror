From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Thu, 12 May 2005 05:32:13 -0400 (EDT)
Message-ID: <1895.10.10.10.24.1115890333.squirrel@linux1>
References: <1115847510.22180.108.camel@tglx> <428291CD.7010701@zytor.com> 
    <1115854733.22180.202.camel@tglx> <428297DB.8030905@zytor.com> 
    <1115858022.22180.256.camel@tglx>
    <7vekcdmd16.fsf@assigned-by-dhcp.cox.net>
    <1115884637.22180.277.camel@tglx>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20050512053213_92889"
Cc: "Junio C Hamano" <junkio@cox.net>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 11:25:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW9w2-0003Aj-Ng
	for gcvg-git@gmane.org; Thu, 12 May 2005 11:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVELJc2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 05:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVELJc2
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 05:32:28 -0400
Received: from simmts12.bellnexxia.net ([206.47.199.141]:55992 "EHLO
	simmts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261368AbVELJcO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 05:32:14 -0400
Received: from linux1 ([69.156.111.46]) by simmts12-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050512093213.UZZD19200.simmts12-srv.bellnexxia.net@linux1>;
          Thu, 12 May 2005 05:32:13 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4C9WBVE010085;
	Thu, 12 May 2005 05:32:11 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Thu, 12 May 2005 05:32:13 -0400 (EDT)
In-Reply-To: <1115884637.22180.277.camel@tglx>
To: tglx@linutronix.de
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

------=_20050512053213_92889
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Thu, May 12, 2005 3:57 am, Thomas Gleixner said:
> On Wed, 2005-05-11 at 18:46 -0700, Junio C Hamano wrote:
>> >>>>> "TG" == Thomas Gleixner <tglx@linutronix.de> writes:
>> So I am having a hard time understanding what problem repo-id
>> solves.
>
> Rn   o
>      > \
> Rn-1 o  |
>      >  o Mn
>      >  o Mn-1
> Rn-2 o /
> Rn-3 o
>
[snip]

All you forgot was to explain how repo-id helps one iota.   And if you're
up to it, explain how it would help sort out the following, where Xn is a
fast forward head:

Rn   o
     > \
Rn-1 o  |
     >  o Mn
     >  o Mn-1
Rn-2 o /
Xn   o

And what about sorting out branches created by a single developer in a
single repository? doh!   Sounds like a solution that addresses all these
should be worked out instead of repoid.   You really are barking up the
wrong tree here.

Just because rev-tree may get it wrong, doesn't mean every other tool does.
Actually, I just ran your above scenario through git, and here is what
cg-log shows, which seems perfectly acceptable:

commit 19de0d5cd9269f0869fecb0b866efa12ef882a11
parent 490ae38bcbf70fe19bcc0c1a28d1fa301620a2d5
parent 71890fc6b9e3da470623dbbf3dc492b937757a37
    Merge with ../test2/.git
    Rn

commit 490ae38bcbf70fe19bcc0c1a28d1fa301620a2d5
parent b96d60d7b632a188f4550762f8a1a99f8b381c9b
    Rn-1

commit b96d60d7b632a188f4550762f8a1a99f8b381c9b
parent 0dbe9da9b565bb695d464532470734c6f4676951
    Rn-2

commit 71890fc6b9e3da470623dbbf3dc492b937757a37
parent 81dbf4bac14c3caeadfa084d57ad78544e69d6d8
    Mn

commit 81dbf4bac14c3caeadfa084d57ad78544e69d6d8
parent 0dbe9da9b565bb695d464532470734c6f4676951
    Mn-1

commit 0dbe9da9b565bb695d464532470734c6f4676951
parent 221a1474b35d700fd67895cb6206d04fc17b083a
    Rn-3

In fact, please see attached .png image that shows how the nice gitk tool
from Paul Mackerras displays it exactly as you request WITHOUT Repo-id.

* Please * explain what problem you are trying to solve and how repoid
will solve it.

Sean
------=_20050512053213_92889
Content-Type: image/png; name="what_problem.png"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="what_problem.png"

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
/H/6122cDwM/MQAAAABJRU5ErkJggg==
------=_20050512053213_92889--


