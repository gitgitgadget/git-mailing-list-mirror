From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v5 09/11] trace: add high resolution timer
 function to debug performance issues
Date: Wed, 11 Jun 2014 10:12:24 +0200
Message-ID: <53980F68.7050009@gmail.com>
References: <53980B83.9050409@gmail.com> <53980CBF.2060400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, 
 Jeff King <peff@peff.net>
X-From: msysgit+bncBCH3XYXLXQDBB2M64COAKGQEFJMGMKI@googlegroups.com Wed Jun 11 10:12:28 2014
Return-path: <msysgit+bncBCH3XYXLXQDBB2M64COAKGQEFJMGMKI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f62.google.com ([209.85.215.62])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBB2M64COAKGQEFJMGMKI@googlegroups.com>)
	id 1Wuddy-00023M-5u
	for gcvm-msysgit@m.gmane.org; Wed, 11 Jun 2014 10:12:26 +0200
Received: by mail-la0-f62.google.com with SMTP id pv20sf1012178lab.27
        for <gcvm-msysgit@m.gmane.org>; Wed, 11 Jun 2014 01:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=ikyfGGdZGlPT5LYqavAfnmb29+lC8naFV8Kk5P68eIw=;
        b=HuQssfEAcofFO40vFj7cVA4I4fXNDakWJrgWZLfnzVZSl1CWz1QaH/uFyRidaOprqi
         Ln+YKP2tTMsNA3PgTENK6uiHQUC3Ov0QYItzJIjlA5KAeR9OinnmjwIdUgm5K2VeBqlr
         RmZkJUWsFDCZHMWHw0dTy7qDojj0Vse8xPgiiEWBZWMeO1NYXjEyuH6FAqtRRV/sXYWE
         01PFtEgvKMu/hYg2/ftvkKMLKAe3HN0zl8wpBxbAb7PFlsb//J06ADyrIeUAVYamewhh
         bFUQvxKjUp2ioaoh05el998O20sLRKmuQ5gV/AWkJJYLPPMrot1B1Msx1CpjjKkrUnmD
         F55A==
X-Received: by 10.180.107.97 with SMTP id hb1mr64115wib.16.1402474345991;
        Wed, 11 Jun 2014 01:12:25 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.73.200 with SMTP id n8ls232078wiv.0.gmail; Wed, 11 Jun
 2014 01:12:25 -0700 (PDT)
X-Received: by 10.180.211.234 with SMTP id nf10mr4195329wic.1.1402474345171;
        Wed, 11 Jun 2014 01:12:25 -0700 (PDT)
Received: from mail-we0-x235.google.com (mail-we0-x235.google.com [2a00:1450:400c:c03::235])
        by gmr-mx.google.com with ESMTPS id x7si1270034wiw.1.2014.06.11.01.12.25
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Jun 2014 01:12:25 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::235 as permitted sender) client-ip=2a00:1450:400c:c03::235;
Received: by mail-we0-f181.google.com with SMTP id q59so3333606wes.40
        for <msysgit@googlegroups.com>; Wed, 11 Jun 2014 01:12:25 -0700 (PDT)
X-Received: by 10.194.77.39 with SMTP id p7mr2113606wjw.85.1402474345096;
        Wed, 11 Jun 2014 01:12:25 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id a1sm58007677eep.3.2014.06.11.01.12.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Jun 2014 01:12:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <53980CBF.2060400@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::235
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251343>

Am 11.06.2014 10:01, schrieb Karsten Blees:
> the epoch allows using the results (div 10e9) with other time-related APIs.

s/10e9/1e9/

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
