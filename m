From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] MinGW: fix compile error due to missing ELOOP
Date: Tue, 15 Jul 2014 16:42:57 -0700
Message-ID: <20140715234257.GM12427@google.com>
References: <20140712075035.GA12400@ucw.cz>
 <1405431797-20899-1-git-send-email-kasal@ucw.cz>
 <xmqq38e2wkkh.fsf@gitster.dls.corp.google.com>
 <53C5B0A1.4060502@gmail.com>
 <53C5B0E7.4050706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Stepan Kasal <kasal@ucw.cz>,
	Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBD6LRKOE4AIRBBHZS2PAKGQE2DTGKYY@googlegroups.com Wed Jul 16 01:43:05 2014
Return-path: <msysgit+bncBD6LRKOE4AIRBBHZS2PAKGQE2DTGKYY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f186.google.com ([209.85.220.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD6LRKOE4AIRBBHZS2PAKGQE2DTGKYY@googlegroups.com>)
	id 1X7CNB-0006GC-MF
	for gcvm-msysgit@m.gmane.org; Wed, 16 Jul 2014 01:43:01 +0200
Received: by mail-vc0-f186.google.com with SMTP id hu12sf26854vcb.23
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Jul 2014 16:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=/e87f1ZJFvW1Udx53nRCgtiHx+K9iyS/ht/3r5eW+as=;
        b=D88F7dRD95RyC0pEJcqzF1r7AixNLumJq/95Jr85olrsYI1qtRg+CczIBHaDVbqoJR
         1wghPJZ0Y1C65CSK7US1PR+Lvp2LnFw0J76VhL4R2YKEB0aDS4LMqixFFf7EE1Juuj5H
         Ycb72RUzrvQSe8IIZLcTS/Npfkg6q6/IkbI08IraD6bnUS7HOQiNmUXEK+BL9QmUyo5X
         fwIX8i3wfKmcy00avtUJdhWhqNiKFA1HjRfSSb99TcrrpOMG4KpLuDUIvKdQQvp1BQz7
         3ORSfz0anJyYZ0Fey8MaS737hpKS6OvRQ53bT4aW5341T8V3Nm8z7GWbe9UmeS4G5F2P
         qXRg==
X-Received: by 10.50.134.3 with SMTP id pg3mr197048igb.4.1405467780908;
        Tue, 15 Jul 2014 16:43:00 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.239.162 with SMTP id vt2ls703755igc.19.gmail; Tue, 15 Jul
 2014 16:43:00 -0700 (PDT)
X-Received: by 10.70.103.237 with SMTP id fz13mr12659494pdb.4.1405467780029;
        Tue, 15 Jul 2014 16:43:00 -0700 (PDT)
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com [2607:f8b0:400e:c03::229])
        by gmr-mx.google.com with ESMTPS id bb4si1988828pdb.1.2014.07.15.16.43.00
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Jul 2014 16:43:00 -0700 (PDT)
Received-SPF: pass (google.com: domain of jrnieder@gmail.com designates 2607:f8b0:400e:c03::229 as permitted sender) client-ip=2607:f8b0:400e:c03::229;
Received: by mail-pa0-f41.google.com with SMTP id fb1so173051pad.0
        for <msysgit@googlegroups.com>; Tue, 15 Jul 2014 16:43:00 -0700 (PDT)
X-Received: by 10.70.44.101 with SMTP id d5mr26096849pdm.82.1405467779937;
        Tue, 15 Jul 2014 16:42:59 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:888a:1e2f:d307:1d55])
        by mx.google.com with ESMTPSA id v9sm20168311pdp.88.2014.07.15.16.42.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 15 Jul 2014 16:42:59 -0700 (PDT)
In-Reply-To: <53C5B0E7.4050706@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Original-Sender: jrnieder@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of jrnieder@gmail.com designates 2607:f8b0:400e:c03::229
 as permitted sender) smtp.mail=jrnieder@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253649>

Karsten Blees wrote:

> MinGW and MSVC before 2010 don't define ELOOP, use EMLINK (aka "Too many
> links") instead.
[...]
> +#ifndef ELOOP
> +#define ELOOP EMLINK
> +#endif

This could use

	#define ELOOP WSAELOOP

as an alternative.  But it shouldn't matter since git doesn't look for
EMLINK anywhere (EMLINK = 31, WSAELOOP = wsabaseerr+62 = 10062).

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

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
