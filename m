From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Issue: repack semi-frequently fails on Windows
 (msysgit) - suspecting file descriptor issues
Date: Thu, 16 Apr 2015 17:48:42 +0200
Organization: gmx
Message-ID: <a710472d7bf37757b7341dd99f8c76f3@www.dscho.org>
References: <20150416100359.GA19951@rhlx01.hs-esslingen.de>
 <552F98AC.5030603@virtuell-zuhause.de>
 <20150416113505.GA30818@rhlx01.hs-esslingen.de>
 <20150416152849.GA30137@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andreas Mohr <andi@lisas.de>, Thomas Braun
 <thomas.braun@virtuell-zuhause.de>, git@vger.kernel.org, msysGit
 <msysgit@googlegroups.com>, git-owner@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBCZPH74Q5YNRBYNTX6UQKGQEYFF2VNA@googlegroups.com Thu Apr 16 17:48:50 2015
Return-path: <msysgit+bncBCZPH74Q5YNRBYNTX6UQKGQEYFF2VNA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f184.google.com ([209.85.212.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBYNTX6UQKGQEYFF2VNA@googlegroups.com>)
	id 1Yim25-0000IF-Px
	for gcvm-msysgit@m.gmane.org; Thu, 16 Apr 2015 17:48:49 +0200
Received: by wivr20 with SMTP id r20sf28648581wiv.1
        for <gcvm-msysgit@m.gmane.org>; Thu, 16 Apr 2015 08:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:date:from:to:cc:subject:organization
         :in-reply-to:references:message-id:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=jUrvVRW6M6pMam9f8p0LD+SdX2ohuQbfApw2ohV8D8M=;
        b=WaYKBS4ARV4tK4SjEuqX0Eyde9GDlqYzIAZ0MsX3JkD4vfZ2tbV9b60Jgqxje9CJ2r
         ccWkU1x+K4T/IGlTRsj9bxPpx39Mnvm7LbhJtkSOVg3nHhbCFzZGonyKM3YZnYHcnxxL
         Hl9xkgeyLEO0j2UMq2Qtj1BJGHu1aBu8WLtTwf1wlKv4lBel790MvXFh3Xe0QtBGmR1v
         ys+aCPDHp1cKVurCyRvGisZXPBXodpD2yJTKM7y5TLvjws9OojeMeMQ4lmL0ZjYoV0mE
         d46OrJ4WDsGjfbsocP3ecPfzQApV9R2q/GBfN1NOaR2+Jxthx5dxaodaPsAOIIdd3qIj
         x79Q==
X-Received: by 10.180.97.167 with SMTP id eb7mr50565wib.6.1429199329379;
        Thu, 16 Apr 2015 08:48:49 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.83.200 with SMTP id s8ls156297wiy.11.canary; Thu, 16 Apr
 2015 08:48:48 -0700 (PDT)
X-Received: by 10.180.7.138 with SMTP id j10mr2073447wia.2.1429199328805;
        Thu, 16 Apr 2015 08:48:48 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.19])
        by gmr-mx.google.com with ESMTPS id eg1si552446wic.1.2015.04.16.08.48.48
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2015 08:48:48 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.19 as permitted sender) client-ip=212.227.15.19;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Llm5o-1ZHpjY1FDc-00ZOJ8; Thu, 16 Apr 2015 17:48:44
 +0200
In-Reply-To: <20150416152849.GA30137@peff.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:dAoJJXPaqc0/jeB55PSPt2HKts3ptnlgF40JUdUxsBTVolWSoF+
 iwN84JGCJ1l/VEMFq8M5AJDRwHnTOVHCl5kDUpVqYwUYbneqGRe8gVH85L5Xar53h63q+BR
 McLW6gYJ37x7WQFtwIQ/D/8SZ1CNLruLg9ScrUlGPSlyEC//x4pcFwJGWqZ8ZGBO8r0fYY1
 trbZ2XLeyI9TqO5KthAiQ==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.19 as
 permitted sender) smtp.mail=johannes.schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267300>

Hi Peff,

On 2015-04-16 17:28, Jeff King wrote:
> On Thu, Apr 16, 2015 at 01:35:05PM +0200, Andreas Mohr wrote:
> 
>> I strongly suspect that git's repacking implementation
>> (probably unrelated to msysgit-specific deviations,
>> IOW, git *core* handling)
>> simply is buggy
>> in that it may keep certain file descriptors open
>> at least a certain time (depending on scope of implementation/objects!?)
>> beyond having finished its operation (rename?).
> 
> Hrm. [... detailed analysis, including a Minimal, Complete & Verifiable Example ...]

Thank you so much! I will definitely test this (at the moment, I have to recreate my build environment in a different VM than I used so far, that takes quite some time...)

Thanks!
Dscho

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
