From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Issue: repack semi-frequently fails on Windows
 (msysgit) - suspecting file descriptor issues
Date: Thu, 16 Apr 2015 15:07:46 +0200
Organization: gmx
Message-ID: <f046adea6791865f97f6d76b0dae01bc@www.dscho.org>
References: <20150416100359.GA19951@rhlx01.hs-esslingen.de>
 <552F98AC.5030603@virtuell-zuhause.de>
 <27f1120c2c5231d8c7add8bdac7e3b21@www.dscho.org>
 <20150416114235.GB30818@rhlx01.hs-esslingen.de>
 <20150416114846.GC30818@rhlx01.hs-esslingen.de>
 <20150416123552.GA825@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Braun <thomas.braun@virtuell-zuhause.de>, git@vger.kernel.org,
 msysGit <msysgit@googlegroups.com>, git-owner@vger.kernel.org
To: Andreas Mohr <andi@lisas.de>
X-From: msysgit+bncBCZPH74Q5YNRBJHIX2UQKGQEVDICR6A@googlegroups.com Thu Apr 16 15:07:52 2015
Return-path: <msysgit+bncBCZPH74Q5YNRBJHIX2UQKGQEVDICR6A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f55.google.com ([209.85.215.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBJHIX2UQKGQEVDICR6A@googlegroups.com>)
	id 1YijWH-0005xr-Jn
	for gcvm-msysgit@m.gmane.org; Thu, 16 Apr 2015 15:07:49 +0200
Received: by labgd6 with SMTP id gd6sf24058681lab.0
        for <gcvm-msysgit@m.gmane.org>; Thu, 16 Apr 2015 06:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:date:from:to:cc:subject:organization
         :in-reply-to:references:message-id:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=HdoSIF2ONLFLxDbZLXSjihNr0+sEywJ/xhdsAxcLBFc=;
        b=LJfsaiFzN8WcgrbVwNU1ZqXLTRJFvXaFSQMWDzcwURh8jjcBhQ1947FvSANsixxmCR
         XASOxXF8nwKo6GmlhZWbLnFNfhY25QwU8yiqwt6XNFd/l2r5ajwA8Ar/040+E2DFJoWu
         nMFmTyb6idItOIorOPRrShSSkDVCZM5Of2cbVhUJ1hsSd44eYOTcGbS0jN886aBkTMVY
         WCmUaXH6u9BeOmyENDfCBrlkd+YzCvz74mP/jhLiCwA185+9MSrKKDSC1gmcCxJpUyzh
         bb0RxaxK5qxnv9/MDLQ1vfnjcX2Y6KmD4rbo0kpf3n8o8o8kLyNSMkVrPvhCt46CuhPs
         Ohxw==
X-Received: by 10.152.206.12 with SMTP id lk12mr382793lac.21.1429189669297;
        Thu, 16 Apr 2015 06:07:49 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.9.38 with SMTP id w6ls329325laa.13.gmail; Thu, 16 Apr 2015
 06:07:48 -0700 (PDT)
X-Received: by 10.112.181.166 with SMTP id dx6mr7226205lbc.17.1429189668241;
        Thu, 16 Apr 2015 06:07:48 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.19])
        by gmr-mx.google.com with ESMTPS id eg1si518637wic.1.2015.04.16.06.07.48
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2015 06:07:48 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.19 as permitted sender) client-ip=212.227.15.19;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LiDrv-1ZCWMC0IxX-00nPcp; Thu, 16 Apr 2015 15:07:47
 +0200
In-Reply-To: <20150416123552.GA825@rhlx01.hs-esslingen.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:HAqy1kIlGfyf7lfxsq01GMTFGRgDVCJ+uoyibDeNNm1icl5zREj
 A7a0urYey8yFeVih79mnCEAEeBc/Ej7a93XQZoJmFh08zifV5rLXiKMp5c3WpYwpljnPMVa
 KAZIIZqVb7sJwemnUoYi6gO+rqBI9PnQssq8CK3Qx6p17WEybTl3xeNK3N4QFOuJ0iIpPZd
 QBJe+aTGJkDwfraiihg+Q==
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267286>

Hi Andreas,

On 2015-04-16 14:35, Andreas Mohr wrote:
> On Thu, Apr 16, 2015 at 01:48:46PM +0200, Andreas Mohr wrote:
>> OK, at this point in time it's my turn to actually verify
>> that indeed it's NOT the virus scanner:
>> - generate rebase-heavy activity
>> - update
>> - hit issue
>> - unload virus (~ scanner?? I'm unsure on exact terminology to be used ;-)
>> - update
>> - profit!?
> 
> Despite trying hard (generating a lot of activity, with different repo
> projects even)
> I cannot reproduce it in a timely manner,
> thus I'll have to wait until repo state has degraded in a sufficient manner
> for such a larger repack with that issue to occur again
> (probably a matter of weeks).
> Once it happens, I will:
> - ensure keeping a copy of the entire (problematic-state) repo, and
> verify reproducibility of its (copied/preserved) breakage
> - unload virus and do other tests
> - report back

I guess the best way to trigger it is by ensuring that a lot of loose objects are accumulated, e.g. by running

```sh
i=$(date +%s)
j=0
while test $j -lt 9999
do
    echo "test $(($i+$j))" git hash-object -w --stdin
    j=$(($j+1))
done
```

Ciao,
Johannes

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
