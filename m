From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v5 09/11] trace: add high resolution timer
 function to debug performance issues
Date: Wed, 18 Jun 2014 17:14:31 +0200
Message-ID: <53A1ACD7.1040504@gmail.com>
References: <53980B83.9050409@gmail.com> <53980CBF.2060400@gmail.com>	<53980F68.7050009@gmail.com> <xmqq4mzjo58t.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, 
 Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCH3XYXLXQDBBWGZQ2OQKGQE5HJ67MQ@googlegroups.com Wed Jun 18 17:14:39 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBWGZQ2OQKGQE5HJ67MQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f55.google.com ([74.125.82.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBWGZQ2OQKGQE5HJ67MQ@googlegroups.com>)
	id 1WxHZJ-0008NH-IR
	for gcvm-msysgit@m.gmane.org; Wed, 18 Jun 2014 17:14:33 +0200
Received: by mail-wg0-f55.google.com with SMTP id a1sf122139wgh.20
        for <gcvm-msysgit@m.gmane.org>; Wed, 18 Jun 2014 08:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=6qB/Qz9vtniin9u/qBhxwVAhi//C/K9CB2cOlyy+ci8=;
        b=x+X0zIEmYowWb8Mfvl0GGNi1o3bGFgVrB5GyTr5xipfCkikeWvaAGs1viWQFGS7vjO
         GnmM9CZMBA0DWWIEADv/rpAbKPW687gBQofAeCCKTHgbBJak4BmY8ix3002NNw0FGIh7
         7u6bMfrMyC0EM4NLCM+d8d186wnC2DMGO24lxwknBaXhhUV/L/JpCiK9EIaAbduU1jzV
         WAqgmdZxvGcbJgTWOAtrWV/0FhrKc6sbwMdg7D+SmbSnb5qqHiAJfRXWODKPoE1l82hj
         jp8CliGllUmCUzcXx/riaQLjfcTk277aIhlyK+bZpZi11OsqZUT8VnbQK65cuChmJTc7
         nHoA==
X-Received: by 10.181.12.36 with SMTP id en4mr19194wid.5.1403104473344;
        Wed, 18 Jun 2014 08:14:33 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.108.140 with SMTP id hk12ls66331wib.31.gmail; Wed, 18 Jun
 2014 08:14:32 -0700 (PDT)
X-Received: by 10.194.57.48 with SMTP id f16mr2224960wjq.2.1403104472125;
        Wed, 18 Jun 2014 08:14:32 -0700 (PDT)
Received: from mail-wi0-x22a.google.com (mail-wi0-x22a.google.com [2a00:1450:400c:c05::22a])
        by gmr-mx.google.com with ESMTPS id x7si190933wiw.1.2014.06.18.08.14.32
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Jun 2014 08:14:32 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22a as permitted sender) client-ip=2a00:1450:400c:c05::22a;
Received: by mail-wi0-f170.google.com with SMTP id cc10so8714625wib.1
        for <msysgit@googlegroups.com>; Wed, 18 Jun 2014 08:14:32 -0700 (PDT)
X-Received: by 10.194.62.140 with SMTP id y12mr48533995wjr.27.1403104472051;
        Wed, 18 Jun 2014 08:14:32 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id a1sm5837935eep.3.2014.06.18.08.14.30
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Jun 2014 08:14:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqq4mzjo58t.fsf@gitster.dls.corp.google.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22a
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251986>

Am 17.06.2014 18:44, schrieb Junio C Hamano:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>> Am 11.06.2014 10:01, schrieb Karsten Blees:
>>> the epoch allows using the results (div 10e9) with other time-related APIs.
>>
>> s/10e9/1e9/
> 
> That replacement is fine but the "(div 1e9)" still wants to be
> clarified.  What did you exactly mean by that?  If the result is
> divided by 10^9 then it yields the number of seconds?
> 
> Thanks.
> 

Div 10^9 yields a time_t. But as not all time-related APIs use time_t, perhaps its best to drop the "(div 1e9)" altogether. That the function returns nanoseconds should be clear enough. Will drop in the next round.

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
