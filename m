From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 2/2] config: use chmod() instead of fchmod()
Date: Wed, 16 Jul 2014 12:53:36 +0200
Message-ID: <53C659B0.8040306@gmail.com>
References: <20140712075035.GA12400@ucw.cz>	<1405431797-20899-1-git-send-email-kasal@ucw.cz> <xmqq38e2wkkh.fsf@gitster.dls.corp.google.com> <53C5B0A1.4060502@gmail.com> <53C5B126.6020404@gmail.com> <53C60E9C.3020604@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>, 
 Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBCH3XYXLXQDBBMFTTGPAKGQESHRHRXI@googlegroups.com Wed Jul 16 12:53:38 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBMFTTGPAKGQESHRHRXI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f189.google.com ([209.85.212.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBMFTTGPAKGQESHRHRXI@googlegroups.com>)
	id 1X7MqA-00071X-7u
	for gcvm-msysgit@m.gmane.org; Wed, 16 Jul 2014 12:53:38 +0200
Received: by mail-wi0-f189.google.com with SMTP id d1sf119103wiv.16
        for <gcvm-msysgit@m.gmane.org>; Wed, 16 Jul 2014 03:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=hkQU4O1u2nMxDgfyGELlonfdnhvFF+KXAcFNTwn4Z2I=;
        b=obdXP9pqk04xeF4ZdCj1wMWo3Bqiaf95AmkdPZuBnYJSTkA1n6JQgV7d0s4MvkuJaR
         VqPKwSNnK4lkxbEvWGsLFI19paPsqPs5VKT0iEPl1WRkZDUQoA39pOz8EaaQTin4WLOY
         vXYATIDxNFl4WpbzxhZzFNNHE+nOoL12Uf36DqK7H0DnegbvOx9NDSRAgZlBq9rC8KWU
         96lg7uPNQyBs3dUXvG2oJosB3vy/hDx3wiwl76FcpdMpMmVZWVGkRKRmvmfJuQoNeESQ
         wzG6HQ3RNs0N9QZYeAC6xtELUKFfUcvahE8YnGqPUdR05r36M+o3NKSdCpHSegbBR3HL
         z0Fg==
X-Received: by 10.180.107.99 with SMTP id hb3mr51627wib.13.1405508017770;
        Wed, 16 Jul 2014 03:53:37 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.181.13.81 with SMTP id ew17ls743554wid.28.canary; Wed, 16 Jul
 2014 03:53:36 -0700 (PDT)
X-Received: by 10.180.212.18 with SMTP id ng18mr1000183wic.3.1405508016525;
        Wed, 16 Jul 2014 03:53:36 -0700 (PDT)
Received: from mail-wi0-x229.google.com (mail-wi0-x229.google.com [2a00:1450:400c:c05::229])
        by gmr-mx.google.com with ESMTPS id b9si97610wic.2.2014.07.16.03.53.36
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Jul 2014 03:53:36 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::229 as permitted sender) client-ip=2a00:1450:400c:c05::229;
Received: by mail-wi0-x229.google.com with SMTP id n3so5523930wiv.4
        for <msysgit@googlegroups.com>; Wed, 16 Jul 2014 03:53:36 -0700 (PDT)
X-Received: by 10.194.120.35 with SMTP id kz3mr35033089wjb.38.1405508016434;
        Wed, 16 Jul 2014 03:53:36 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id v17sm38964701wjr.33.2014.07.16.03.53.35
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Jul 2014 03:53:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53C60E9C.3020604@kdbg.org>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::229
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253661>

Am 16.07.2014 07:33, schrieb Johannes Sixt:
> Am 16.07.2014 00:54, schrieb Karsten Blees:
>> There is no fchmod() on native Windows platforms (MinGW and MSVC), and the
>> equivalent Win32 API (SetFileInformationByHandle) requires Windows Vista.
>>
>> Use chmod() instead.
>>
>> Signed-off-by: Karsten Blees <blees@dcon.de>
>> ---
>>  config.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/config.c b/config.c
>> index ba882a1..9767c4b 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -1636,8 +1636,8 @@ int git_config_set_multivar_in_file(const char *config_filename,
>>  			MAP_PRIVATE, in_fd, 0);
>>  		close(in_fd);
>>  
>> -		if (fchmod(fd, st.st_mode & 07777) < 0) {
>> -			error("fchmod on %s failed: %s",
>> +		if (chmod(lock->filename, st.st_mode & 07777) < 0) {
>> +			error("chmod on %s failed: %s",
>>  				lock->filename, strerror(errno));
>>  			ret = CONFIG_NO_WRITE;
>>  			goto out_free;
>> @@ -1815,8 +1815,8 @@ int git_config_rename_section_in_file(const char *config_filename,
>>  
>>  	fstat(fileno(config_file), &st);
>>  
>> -	if (fchmod(out_fd, st.st_mode & 07777) < 0) {
>> -		ret = error("fchmod on %s failed: %s",
>> +	if (chmod(lock->filename, st.st_mode & 07777) < 0) {
>> +		ret = error("chmod on %s failed: %s",
>>  				lock->filename, strerror(errno));
>>  		goto out;
>>  	}
>>
> 
> I assume you tested this patch on Windows. I am mildly surprised that
> (on Windows) chmod() works on a file that is still open.
> 
> -- Hannes
> 

Yes, file attributes can be set independently of open files. In fact, existing
code in git already does that in many places (via adjust_shared_perm(), which
is typically called while the file is open).

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
