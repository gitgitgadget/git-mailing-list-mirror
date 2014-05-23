From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [RFC/PATCH v4 3/3] add command performance tracing to
 debug scripted commands
Date: Fri, 23 May 2014 16:43:38 +0200
Message-ID: <537F5E9A.1030901@gmail.com>
References: <537BA806.50600@gmail.com> <537BA8DC.9070104@gmail.com> <20140521165508.GC2040@sigill.intra.peff.net> <537D4790.6030106@gmail.com> <20140522095920.GA15461@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBCH3XYXLXQDBBGF57WNQKGQEBCDXXOA@googlegroups.com Fri May 23 16:43:38 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBGF57WNQKGQEBCDXXOA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f188.google.com ([209.85.217.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBGF57WNQKGQEBCDXXOA@googlegroups.com>)
	id 1Wnqh8-0008Q9-1u
	for gcvm-msysgit@m.gmane.org; Fri, 23 May 2014 16:43:38 +0200
Received: by mail-lb0-f188.google.com with SMTP id q8sf345933lbi.15
        for <gcvm-msysgit@m.gmane.org>; Fri, 23 May 2014 07:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=IrfIO1Zm+R/1z6z/SjWC6MKIIHaSQR9XDccTAfxeB+M=;
        b=LU4Dtmria6poUR/Eu7EOAaxWMbmiGynI/xtSSp756aOiMT4UlL4a7uJtyNZWeTCmS1
         Uo4wY82YqNKdXVUZTqSoTno2QHdSPBgZx9U1c/GWhvSWycjqtM1yBjwGq9lfXk5eEf08
         3ampGMLx1g2Qo1ycYGFPDSvHeKFEEauBk1mxioKYcH/Q0Bp7agOFSjkhE1pQw+cprnU1
         ZYp5vn6b1I5jV8XzdTfrBIvLxrPAG7Ilmm0Fp2NAOL785Sslhac0691Jmi7hs+6eHnsZ
         oSJ+0RWHRZLF/35RIhMWZiFQvRiN9EqN2+Ql1ziUPZcoK0qIQKmvCwZP/7CqxEAHbbNI
         IGAg==
X-Received: by 10.180.80.226 with SMTP id u2mr12377wix.20.1400856217774;
        Fri, 23 May 2014 07:43:37 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.24.69 with SMTP id s5ls105695wif.52.gmail; Fri, 23 May
 2014 07:43:36 -0700 (PDT)
X-Received: by 10.180.82.98 with SMTP id h2mr393578wiy.0.1400856216304;
        Fri, 23 May 2014 07:43:36 -0700 (PDT)
Received: from mail-ee0-x232.google.com (mail-ee0-x232.google.com [2a00:1450:4013:c00::232])
        by gmr-mx.google.com with ESMTPS id g42si1304322eev.1.2014.05.23.07.43.36
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 23 May 2014 07:43:36 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:4013:c00::232 as permitted sender) client-ip=2a00:1450:4013:c00::232;
Received: by mail-ee0-f50.google.com with SMTP id e51so3730966eek.23
        for <msysgit@googlegroups.com>; Fri, 23 May 2014 07:43:36 -0700 (PDT)
X-Received: by 10.15.49.8 with SMTP id i8mr8649947eew.33.1400856216230;
        Fri, 23 May 2014 07:43:36 -0700 (PDT)
Received: from [10.1.116.56] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id b1sm8845032eef.15.2014.05.23.07.43.34
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 23 May 2014 07:43:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140522095920.GA15461@sigill.intra.peff.net>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:4013:c00::232
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249989>

Am 22.05.2014 11:59, schrieb Jeff King:
> On Thu, May 22, 2014 at 02:40:48AM +0200, Karsten Blees wrote:
> 
>> E.g. if I'm interested in a particular code section, I throw in 2
>> lines of code (before and after the code section). This gives very
>> accurate results, without significantly affecting overall performance.
>> I can then push the changes to my Linux/Windows box and get comparable
>> results there. No need to disable optimization. No worries that the
>> profiling tool isn't available on the other platform. No analyzing
>> megabytes of mostly irrelevant profiling data.
>>
>> Does that make sense?
> 
> Ah, I see. I misunderstood from your example above.
> 
> I do agree that automatically stamping with __FILE__ and __LINE__ is
> very helpful there. Could we maybe restrict that use of the variadic
> macros to a few known-good compilers (maybe #ifdef __GNUC__, which also
> hits clang, and something to catch MSVC)? On other systems it would
> become a compile-time noop, and they could live without the feature.
> 
> -Peff
> 

Alright then. I've queued vor v5:
* add __FILE__ __LINE__ for all trace output, if the compiler supports variadic macros
* add timestamp for all trace output
* perhaps move trace declarations to new trace.h
* improve commit messages of existing patches to clarify the issues discussed so far

I'm on holiday next week , so please be patient...

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
