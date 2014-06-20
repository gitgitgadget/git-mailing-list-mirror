From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v6 00/11] add performance tracing facility
Date: Fri, 20 Jun 2014 23:03:17 +0200
Message-ID: <53A4A195.1070502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
 msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBFGDSKOQKGQEY3ED7LI@googlegroups.com Fri Jun 20 23:03:17 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBFGDSKOQKGQEY3ED7LI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f183.google.com ([209.85.217.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBFGDSKOQKGQEY3ED7LI@googlegroups.com>)
	id 1Wy5xt-00026d-Hx
	for gcvm-msysgit@m.gmane.org; Fri, 20 Jun 2014 23:03:17 +0200
Received: by mail-lb0-f183.google.com with SMTP id l4sf450121lbv.20
        for <gcvm-msysgit@m.gmane.org>; Fri, 20 Jun 2014 14:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=LJhTJRit7XvcsTaT+WEeEOnDymnEehLn0VC87BYN4eQ=;
        b=cbbuP1b4vJebw2/VUXTAbcLNWIbWVWdEDiVlwLy2j2Wp+we5EVpJ8KIotH/JYj1I6j
         cr1czSBWJIZPp6WuXDvei5l5FMuC3nXwWpeD2QcS4qNWAxd3wd6MBQd+v0zb/V0h23nJ
         9nGQiJvTTaO2KWoPPNPv+kMrptukV384Yc4Q2CKBVLvOL1QYRcL7Dqj5QWUu3PEb0FE6
         Huk+IVD44QN4RfAYPijo1SlAa9aP3ISufpKOriGTg5Vvm44bITBi0kbU8D3+gh84TZAy
         A5xzy20kOne4yTHiQSazhyvxhFweIkw57QZtzDo2ahfM/XOMYO8zl69yRsuoVQo0bV2V
         xHig==
X-Received: by 10.152.8.199 with SMTP id t7mr23159laa.11.1403298197370;
        Fri, 20 Jun 2014 14:03:17 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.37.8 with SMTP id u8ls110448laj.11.gmail; Fri, 20 Jun 2014
 14:03:16 -0700 (PDT)
X-Received: by 10.112.188.229 with SMTP id gd5mr502590lbc.13.1403298196097;
        Fri, 20 Jun 2014 14:03:16 -0700 (PDT)
Received: from mail-wg0-x230.google.com (mail-wg0-x230.google.com [2a00:1450:400c:c00::230])
        by gmr-mx.google.com with ESMTPS id h4si220861wib.2.2014.06.20.14.03.16
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Jun 2014 14:03:16 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::230 as permitted sender) client-ip=2a00:1450:400c:c00::230;
Received: by mail-wg0-f48.google.com with SMTP id n12so4142032wgh.31
        for <msysgit@googlegroups.com>; Fri, 20 Jun 2014 14:03:16 -0700 (PDT)
X-Received: by 10.180.14.65 with SMTP id n1mr6863971wic.4.1403298195918;
        Fri, 20 Jun 2014 14:03:15 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id cj8sm17893748wjb.5.2014.06.20.14.03.14
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Jun 2014 14:03:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::230
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252279>

Changes since v5:
[05/11]: GIT_TRACE_BARE=1 disables 'timestamp file:line' output for
         unit tests that rely on trace output (t1510 and t5503)
[08/11]: Align original trace output at col 40
[09/11]: Dropped '(div 10e9)' from the commit message.
[10/11]: Dropped trace_performance[_since]() return value and the
         respective usage example. Renamed trace_performance_vfl to
         trace_performance_vprintf_fl.

The other patches are the versions from pu.

Karsten Blees (11):
  trace: move trace declarations from cache.h to new trace.h
  trace: consistently name the format parameter
  trace: remove redundant printf format attribute
  trace: factor out printing to the trace file
  trace: add infrastructure to augment trace output with additional info
  trace: add current timestamp to all trace output
  trace: move code around, in preparation to file:line output
  trace: add 'file:line' to all trace output
  trace: add high resolution timer function to debug performance issues
  trace: add trace_performance facility to debug performance issues
  git: add performance tracing for git's main() function to debug
    scripts

 Makefile              |   7 ++
 cache.h               |  13 +--
 config.mak.uname      |   1 +
 git-compat-util.h     |   4 +
 git.c                 |   2 +
 t/t1510-repo-setup.sh |   2 +-
 t/t5503-tagfollow.sh  |   8 +-
 trace.c               | 313 ++++++++++++++++++++++++++++++++++++++++++++------
 trace.h               |  90 +++++++++++++++
 9 files changed, 387 insertions(+), 53 deletions(-)
 create mode 100644 trace.h

-- 
2.0.0.402.g13b8b25

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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
