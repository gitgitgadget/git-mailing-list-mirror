From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: svn to git, N-squared?
Date: Mon, 12 Jun 2006 11:55:13 -0400
Message-ID: <9e4733910606120855p1cec9acfy62dadb89c11756b4@mail.gmail.com>
References: <20060612043949.20992.qmail@science.horizon.com>
	 <9e4733910606120832xaf74e77pad7f70df864541fc@mail.gmail.com>
	 <Pine.LNX.4.64.0606120843340.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux@horizon.com" <linux@horizon.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 17:55:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fpol6-0001LQ-GH
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 17:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbWFLPzQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 11:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752091AbWFLPzP
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 11:55:15 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:31736 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1752071AbWFLPzO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 11:55:14 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1664692nze
        for <git@vger.kernel.org>; Mon, 12 Jun 2006 08:55:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rLhJwAGJf/4hbs2v/QsgnEblD4eNru6RHsJWU/FB9kmZubce6GD15WUt1w43FCnGcUrlUDvWo3YOSJ5aO9+Tez4tVysr8iJEI257/NViqF8U5V7WQ8kv9Mi0Bjg8N5+B//NEoopvRZs4Z5mhV9O/mwCfRu7c4E7ArsfdfBTbQ4Y=
Received: by 10.36.113.12 with SMTP id l12mr7799334nzc;
        Mon, 12 Jun 2006 08:55:13 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Mon, 12 Jun 2006 08:55:13 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606120843340.5498@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21708>

On 6/12/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Mon, 12 Jun 2006, Jon Smirl wrote:
> >
> > I've stablized like this. 1GB RAM with 2.8Ghz P4 hyperthread. Is there
> > anyway to tell what it is doing in the kernel for so much time?
>
> oprofile will tell you.
>
> I don't see why it would spend a lot of time in the kernel, unless it's
> the SVN part that does a ton of reads or something. git should have almost
> no kernel footprint apart from the individual objects creation/reading, so
> once it's repacked, I generally see very little system time.
>
> What does top say? (Ie can you see _which_ process spends time in the
> kernel?)

top - 11:54:32 up 4 days,  1:27,  5 users,  load average: 1.85, 1.74, 1.55
Tasks: 135 total,   2 running, 133 sleeping,   0 stopped,   0 zombie
Cpu(s): 14.7% us, 35.3% sy,  0.0% ni, 49.3% id,  0.0% wa,  0.2% hi,  0.5% si,  0
Mem:   1035740k total,  1020836k used,    14904k free,    18368k buffers
Swap: 118222276k total,   645124k used, 117577152k free,   183172k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
14525 jonsmirl  16   0  604m 391m 1904 S   24 38.7 916:53.39 git-svnimport
20947 jonsmirl  17   0     0    0    0 R    1  0.0   0:00.03 git-svnimport
20864 jonsmirl  16   0  2120 1024  788 R    1  0.1   0:00.08 top
 2436 root      15   0 71184  28m 6100 S    0  2.8 119:13.55 Xorg
    1 root      16   0  1992  340  312 S    0  0.0   0:00.79 init
    2 root      RT   0     0    0    0 S    0  0.0   0:00.00 migration/0
    3 root      34  19     0    0    0 S    0  0.0   0:01.42 ksoftirqd/0
    4 root      RT   0     0    0    0 S    0  0.0   0:00.00 watchdog/0


-- 
Jon Smirl
jonsmirl@gmail.com
