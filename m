From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 3/3] Win32: implement nanosecond-precision file times
Date: Fri, 13 Feb 2015 00:44:32 +0100
Message-ID: <54DD3AE0.2050307@gmail.com>
References: <54DBEAA5.6000205@gmail.com> <54DBEB5C.5070804@gmail.com> <54DD340C.50204@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>, 
 Git List <git@vger.kernel.org>,
 msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBXXV6STAKGQEZ57MY2Y@googlegroups.com Fri Feb 13 00:44:36 2015
Return-path: <msysgit+bncBCH3XYXLXQDBBXXV6STAKGQEZ57MY2Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f55.google.com ([209.85.215.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBXXV6STAKGQEZ57MY2Y@googlegroups.com>)
	id 1YM3Qw-0002fV-1q
	for gcvm-msysgit@m.gmane.org; Fri, 13 Feb 2015 00:44:34 +0100
Received: by labpn19 with SMTP id pn19sf3255926lab.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 12 Feb 2015 15:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=jCAWKIl+rVpYvW/EZKtoYrDDrpRDeBlHKFEa/b4FWOc=;
        b=mOE1fKBsh6gRp211ar8VFI9uB/yBhTM0Evz5Qc9h0JSpK4fGX/bRO4Bi2Kbm3FFL1s
         sgiZ471Lsr6fRyn1TI5InkobO1VQXj256r5QKKKC7ZPffrAUFdUo2qctGCyCkdglu//L
         TeTviVd5JX8PduMUDh8isNEnGhz2rmo/Jh3VlXE/8R5Gh6D9aImZul5RuedIJKtlwB1T
         zDDxNMnvKuDFz/np15DvZ3O+aLCRB0LK2dDA07o+ad+LenOVRnNY6fwxbTqe1A0PO23r
         qYCpGLiBWqm/A2zT1bmCCbcgionmLI+uAB33sAiprO37CeIVPLVEDc9C44LfCSqDH4d7
         2mTQ==
X-Received: by 10.152.21.202 with SMTP id x10mr76633lae.36.1423784673609;
        Thu, 12 Feb 2015 15:44:33 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.246.11 with SMTP id xs11ls256826lac.54.gmail; Thu, 12 Feb
 2015 15:44:30 -0800 (PST)
X-Received: by 10.112.171.37 with SMTP id ar5mr956889lbc.16.1423784670169;
        Thu, 12 Feb 2015 15:44:30 -0800 (PST)
Received: from mail-wg0-x22b.google.com (mail-wg0-x22b.google.com. [2a00:1450:400c:c00::22b])
        by gmr-mx.google.com with ESMTPS id ev8si403804wib.3.2015.02.12.15.44.30
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Feb 2015 15:44:30 -0800 (PST)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22b as permitted sender) client-ip=2a00:1450:400c:c00::22b;
Received: by mail-wg0-x22b.google.com with SMTP id n12so13459032wgh.2
        for <msysgit@googlegroups.com>; Thu, 12 Feb 2015 15:44:30 -0800 (PST)
X-Received: by 10.194.122.233 with SMTP id lv9mr7315484wjb.95.1423784670067;
        Thu, 12 Feb 2015 15:44:30 -0800 (PST)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id hg7sm7606040wjb.44.2015.02.12.15.44.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Feb 2015 15:44:29 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <54DD340C.50204@virtuell-zuhause.de>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22b
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263790>

Am 13.02.2015 um 00:15 schrieb Thomas Braun:
> Am 12.02.2015 um 00:53 schrieb Karsten Blees:
>> diff --git a/config.mak.uname b/config.mak.uname
>> index b64b63c..a18a4cc 100644
>> --- a/config.mak.uname
>> +++ b/config.mak.uname
>> @@ -346,7 +346,7 @@ ifeq ($(uname_S),Windows)
>>  	NO_SVN_TESTS = YesPlease
>>  	RUNTIME_PREFIX = YesPlease
>>  	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
>> -	NO_NSEC = YesPlease
>> +	USE_NSEC = YesPlease
>>  	USE_WIN32_MMAP = YesPlease
>>  	# USE_NED_ALLOCATOR = YesPlease
>>  	UNRELIABLE_FSTAT = UnfortunatelyYes
>> @@ -498,7 +498,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>>  	NO_PERL_MAKEMAKER = YesPlease
>>  	RUNTIME_PREFIX = YesPlease
>>  	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
>> -	NO_NSEC = YesPlease
>> +	USE_NSEC = YesPlease
>>  	USE_WIN32_MMAP = YesPlease
>>  	USE_NED_ALLOCATOR = YesPlease
>>  	UNRELIABLE_FSTAT = UnfortunatelyYes
>>
> 
> Why not also enable it in our special msysgit section?
> 
> diff --git a/config.mak.uname b/config.mak.uname
> index b64b63c..6326794 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -535,6 +535,7 @@ ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
>         INTERNAL_QSORT = YesPlease
>         HAVE_LIBCHARSET_H = YesPlease
>         NO_GETTEXT = YesPlease
> +       USE_NSEC = YesPlease
>  else
>         NO_CURL = YesPlease
>  endif
> 

The msysgit section is within MINGW (i.e. already covered by the 2nd hunk), don't let the indentation fool you.

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
