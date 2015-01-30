From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] Makefile: Handle broken curl version number in version check
Date: Fri, 30 Jan 2015 07:41:58 -0800
Message-ID: <6D2AEDA6-C5EB-489D-9EC2-F2B7F075A0D1@gmail.com>
References: <54CA2E84.6090604@statsbiblioteket.dk> <1422611554-15393-1-git-send-email-tgc@statsbiblioteket.dk> <87wq44gw4y.fsf@igel.home>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Tom G. Christensen" <tgc@statsbiblioteket.dk>,
	<git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Jan 30 16:42:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHDhv-0001zS-JU
	for gcvg-git-2@plane.gmane.org; Fri, 30 Jan 2015 16:42:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759645AbbA3PmD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2015 10:42:03 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:61121 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758553AbbA3PmB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2015 10:42:01 -0500
Received: by mail-pa0-f49.google.com with SMTP id fa1so53706226pad.8
        for <git@vger.kernel.org>; Fri, 30 Jan 2015 07:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=DrT98x2sPXEK0mgaTX3Dajeg7iRjpvaxJbnlS1+a8EU=;
        b=fZP+bROVGxU5gEf47sZAZmLTYqFpAmAEbAxLxis/S+Gqbz9v9kRM0a+OjhXv6ib81K
         oYvNbm25jqSWZ9W+9SnjWtLNjkAtY/AkhZwdJkPpINb3iTg3bQNbntBXVJ2PTLpyODlb
         BPZsq7ofuY4kFCxw6J/m7dbzHyDbanlcDyvZ6PVNxVieWFqT0Axgi2WR4DqbJeVXC7iJ
         mFzoNbDX0fFX1z51x9xX/3MRVeUooq4PhCrxw6GL1w8taczE1ClIuVh563h29PomGDlp
         M3p8MjqgqDkXJg2PzbfHXhFt7o89kjDNRPfH00zmF0zilWRXaai+sZ73Dt/iq9GrTzvy
         Xssw==
X-Received: by 10.70.15.131 with SMTP id x3mr9563524pdc.128.1422632520763;
        Fri, 30 Jan 2015 07:42:00 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id qq6sm11163384pbb.20.2015.01.30.07.41.59
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 30 Jan 2015 07:42:00 -0800 (PST)
In-Reply-To: <87wq44gw4y.fsf@igel.home>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263180>

On Jan 30, 2015, at 06:50, Andreas Schwab wrote:

> "Tom G. Christensen" <tgc@statsbiblioteket.dk> writes:
>
>> diff --git a/Makefile b/Makefile
>> index c44eb3a..69a2ce3 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1035,13 +1035,13 @@ else
>> 	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
>> 	PROGRAM_OBJS += http-fetch.o
>> 	PROGRAMS += $(REMOTE_CURL_NAMES)
>> -	curl_check := $(shell (echo 070908; curl-config --vernum) 2>/dev/ 
>> null | sort -r | sed -ne 2p)
>> +	curl_check := $(shell (echo 070908; curl-config --vernum | sed -e  
>> '/^70[B-C]/ s/^7/07/') 2>/dev/null | sort -r | sed -ne 2p)
>
> How about 's/^.....$/0&/' ?

Much nicer.  But that '$' will have to be escaped from make so it will  
need to be 's/^.....$$/0&/'
