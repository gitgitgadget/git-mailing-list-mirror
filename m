From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Win32: nanosecond-precision file times
Date: Fri, 13 Feb 2015 11:28:17 -0800
Message-ID: <xmqq61b5obla.fsf@gitster.dls.corp.google.com>
References: <54DBEAA5.6000205@gmail.com>
	<xmqqbnkysygl.fsf@gitster.dls.corp.google.com>
	<54DD2FDA.7030604@gmail.com>
	<xmqqsieaog4a.fsf@gitster.dls.corp.google.com>
	<54DD5A89.5080502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>,  Johannes Schindelin <johannes.schindelin@gmx.de>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBU5A7GTAKGQEFGZPMZY@googlegroups.com Fri Feb 13 20:28:20 2015
Return-path: <msysgit+bncBCG77UMM3EJRBU5A7GTAKGQEFGZPMZY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ie0-f185.google.com ([209.85.223.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBU5A7GTAKGQEFGZPMZY@googlegroups.com>)
	id 1YMLuW-00079M-2I
	for gcvm-msysgit@m.gmane.org; Fri, 13 Feb 2015 20:28:20 +0100
Received: by iecrd18 with SMTP id rd18sf4698674iec.8
        for <gcvm-msysgit@m.gmane.org>; Fri, 13 Feb 2015 11:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=KNBcg+MSf04JHfh9WDE+Cp3CgeW6LLgcy64BiTWEHHU=;
        b=V0+O4GbeQ4QdkbAgeD02e6610NsRX+r8j3Z9KzGHrXWTQrucnPbaemI5sMyof/tpAY
         Mvu3WGJdbYcSPmTxiIq1w9499gdoCGno/AYFkSZKUpJdFVdWEbgCMM0EasLnG1LEAXfW
         SCAbJaWmPLioqjcndEygP1HQdjQFy/mcRx+P0kQJyGEjL7wWQyx99VlBghpROBAZbL9l
         J8MgZORTAnOQjjhXQb0JJhz4LMxJTkhyuwSh15DQZuhnXFQkLK4nQizXff1VgREV201T
         UwYSUNMtd5T1gP3RlQvti79OPAXaumIQymtJ3XAxxfMY9CjI3oYhdNGOcspH0Cp9BbSa
         9l9A==
X-Received: by 10.140.100.163 with SMTP id s32mr140965qge.41.1423855699344;
        Fri, 13 Feb 2015 11:28:19 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.31.139 with SMTP id f11ls1391498qgf.95.gmail; Fri, 13 Feb
 2015 11:28:18 -0800 (PST)
X-Received: by 10.140.232.84 with SMTP id d81mr2581814qhc.7.1423855698972;
        Fri, 13 Feb 2015 11:28:18 -0800 (PST)
Received: from sasl.smtp.pobox.com (pb-smtp1.int.icgroup.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id ba9si1616428qcb.0.2015.02.13.11.28.18
        for <msysgit@googlegroups.com>;
        Fri, 13 Feb 2015 11:28:18 -0800 (PST)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AEF8F238B9;
	Fri, 13 Feb 2015 14:28:18 -0500 (EST)
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A5207238B8;
	Fri, 13 Feb 2015 14:28:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 29A66238B2;
	Fri, 13 Feb 2015 14:28:18 -0500 (EST)
In-Reply-To: <54DD5A89.5080502@gmail.com> (Karsten Blees's message of "Fri, 13
	Feb 2015 02:59:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7685834E-B3B6-11E4-9AE4-A4119F42C9D4-77302942!pb-smtp1.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted
 sender) smtp.mail=junio@pobox.com;       dkim=pass header.i=@pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263823>

Karsten Blees <karsten.blees@gmail.com> writes:

> Am 13.02.2015 um 00:38 schrieb Junio C Hamano:
>> 
>> We do have sec/nsec fields in cache_time structure, so I have
>> nothing against updating the msysGit port to fill that value.

Having said that, we do not enable the NSEC stuff by default on Unix
for a reason.  I'd expect those who know Windows filesystems well to
pick the default there wisely ;-)

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
