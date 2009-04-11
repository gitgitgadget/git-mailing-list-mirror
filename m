From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] MinGW readdir reimplementation to support
 d_type
Date: Sat, 11 Apr 2009 23:44:58 +0200
Message-ID: <49E10F5A.9010400@kdbg.org>
References: <1239224507-5372-1-git-send-email-marius@trolltech.com> <49DE5BDE.9050709@kdbg.org> <49DEFA30.1000101@gmail.com>
Reply-To: j6t@kdbg.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: marius@trolltech.com, git@vger.kernel.org, msysgit@googlegroups.com
To: Marius Storm-Olsen <marius@storm-olsen.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sat Apr 11 23:46:45 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f203.google.com ([209.85.217.203])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsl2C-0002Ef-3v
	for gcvm-msysgit@m.gmane.org; Sat, 11 Apr 2009 23:46:44 +0200
Received: by gxk27 with SMTP id 27so1025572gxk.21
        for <gcvm-msysgit@m.gmane.org>; Sat, 11 Apr 2009 14:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :reply-to:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=1GSs6WMzYfmvGiyN9gLfO8ygIbT9p3QTcSMXatbByRo=;
        b=Ki+QLNDrO/Tt5E7RDDJZNDcs3Cwh9Qr1OL6Rpkiy2bi9LnclDGlbhyqCuqMwFrx17p
         3RgMBauGGNteQPqpq3lW1YzvUIFcjoaofoOineJSa3erIymylAnd+kG5fFUDc9BqB712
         Nc5j0TpNSx1jem0+FR7yqgcnb8fkdk98CMRkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :reply-to:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        b=RyJ7LINfE6MhuO40ETEcsyuvp7MuyAgzAXPhbhLm2uj5g33A1yZdpMYHMF5IZDuEL0
         44vRAV85bK5aZvIZUbjQB+rfiotQeoG+6DXuD6xURiwznc2WyNbVAOYHB8ClG7+RTT05
         iX8spFJfZerlSOmKG7J81qiItdNTrOfwXmoxw=
Received: by 10.100.167.3 with SMTP id p3mr147653ane.5.1239486307100;
        Sat, 11 Apr 2009 14:45:07 -0700 (PDT)
Received: by 10.230.16.95 with SMTP id n31gr4775vba.0;
	Sat, 11 Apr 2009 14:45:07 -0700 (PDT)
X-Sender: j6t@kdbg.org
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.136.15 with SMTP id j15mr72436ebd.1.1239486305530; Sat, 11 Apr 2009 14:45:05 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14]) by gmr-mx.google.com with ESMTP id 14si353962ewy.1.2009.04.11.14.45.05; Sat, 11 Apr 2009 14:45:05 -0700 (PDT)
Received-SPF: neutral (google.com: 213.33.87.14 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=213.33.87.14;
Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 213.33.87.14 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
Received: from [77.117.144.164] (77.117.144.164.wireless.dyn.drei.com [77.117.144.164]) by bsmtp.bon.at (Postfix) with ESMTP id BA156A7EB3; Sat, 11 Apr 2009 23:45:02 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <49DEFA30.1000101@gmail.com>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116352>


Marius Storm-Olsen schrieb:
> Johannes Sixt said the following on 09.04.2009 22:34:
>> Marius Storm-Olsen schrieb:
>>> +struct mingw_dirent
>>> +{
>>> +    long        d_ino;            /* Always zero. */
>>> +    union {
>>> +        unsigned short    d_reclen;    /* Always zero. */
>>> +        unsigned char   d_type;        /* Reimplementation adds this */
>>> +    };
>>
>> VERY sneaky! I was wondering why you could get away without replacing
>> opendir and closedir, and why you still defined a replacement
>> mingw_DIR that contains the replacement mingw_dirent, until I noticed
>> this unnamed union.
>>
>> Since we don't use d_reclen anywhere in the code, wouldn't you get
>> away with
>>
>> #define d_type d_reclen
>>
>> unless the type (short vs. char) makes a difference. Or would you say
>> that doing that would be even more sneaky?
> 
> I'm sure it could be done just with a define. However, given the 
> remaining unused variables, I was wondering about also packing in 
> permission bits and file modification time in there, to optimize the 
> status checking even further. That way, on Windows, we would only need 
> one 'readdir' pass to check the whole repository, with no lstats 
> whatsoever. So, this was patch was a 'primer' for that, hence the union 
> with a proper uchar for the d_type.
> 
> However, that would also mean a significant change in the status 
> checking code, as it first lstat's ever file in the index, then uses 
> read_directory + lstat's for others. I guess that'll be too big of a 
> change in core code, so the vision is moot?
> 
> I'd be ok to just use the define, provided that it compiles cleanly of 
> course, if the above seems too ambitious. :-) I kinda feel like the 
> current code is more clean though :)

With a comment in the commit message, it would have been clear, perhaps.

I'll carry this in my (private) tree for a while with the below squashed 
in to avoid a lot of warnings.

-- Hannes

diff --git a/compat/mingw.h b/compat/mingw.h
index 104b310..16ec76b 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -260,4 +260,5 @@ struct mingw_dirent
  };
  #define dirent mingw_dirent
  #define readdir(x) mingw_readdir(x)
+struct dirent *mingw_readdir(DIR *dir);
  #endif // !NO_MINGW_REPLACE_READDIR
