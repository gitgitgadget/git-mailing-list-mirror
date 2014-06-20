From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v6 05/11] trace: add infrastructure to augment
 trace output with additional info
Date: Sat, 21 Jun 2014 01:32:13 +0200
Message-ID: <53A4C47D.609@gmail.com>
References: <53A4A195.1070502@gmail.com> <53A4A267.2060907@gmail.com> <xmqqmwd7citp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCH3XYXLXQDBB7EISOOQKGQEBBYHABI@googlegroups.com Sat Jun 21 01:32:13 2014
Return-path: <msysgit+bncBCH3XYXLXQDBB7EISOOQKGQEBBYHABI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f57.google.com ([74.125.82.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBB7EISOOQKGQEBBYHABI@googlegroups.com>)
	id 1Wy8I1-0006yG-7K
	for gcvm-msysgit@m.gmane.org; Sat, 21 Jun 2014 01:32:13 +0200
Received: by mail-wg0-f57.google.com with SMTP id b13sf472267wgh.22
        for <gcvm-msysgit@m.gmane.org>; Fri, 20 Jun 2014 16:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=fMp8nycBeIvqjaSiqxAoBrnhwgiBrsy8BT4YsrjGyJo=;
        b=pqLsCnT3rGLkCP4doI3MtZayZwTJG6fHmgmDKV5jI0MMhBgdaSM5TAdhSpZqSZC+kY
         yMocP2CX7Mbj4WIta4LmVFG5Ma+4YpMwW+Q4kotX6Jr2pcjZV3lMbNKhGEC8B+gA1Wqq
         mqwvgjyS4TJD4+pk9DHod7B/74yD7F58kzqvRu4cBZheXk97oSsmmpC7pZhH2Hw/sePG
         0/Jas7F9E56JIFNVLRbDHpspkFGz3xM2+tfRXr2pWJ+npyYzEWzWRcMIC5vh2Q+tmwDW
         IXtWa4HfEWK6jFEbdxlCJ4Oe7bkf3cUMl5Yuh66ASqUrRCaXnfBI/O9qgxP8KHOMOOxC
         iGqg==
X-Received: by 10.152.30.66 with SMTP id q2mr18222lah.2.1403307132892;
        Fri, 20 Jun 2014 16:32:12 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.36.39 with SMTP id n7ls209452laj.80.gmail; Fri, 20 Jun
 2014 16:32:11 -0700 (PDT)
X-Received: by 10.112.137.138 with SMTP id qi10mr594286lbb.4.1403307131432;
        Fri, 20 Jun 2014 16:32:11 -0700 (PDT)
Received: from mail-wg0-x234.google.com (mail-wg0-x234.google.com [2a00:1450:400c:c00::234])
        by gmr-mx.google.com with ESMTPS id r13si245412wib.0.2014.06.20.16.32.11
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Jun 2014 16:32:11 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::234 as permitted sender) client-ip=2a00:1450:400c:c00::234;
Received: by mail-wg0-f52.google.com with SMTP id b13so4268077wgh.11
        for <msysgit@googlegroups.com>; Fri, 20 Jun 2014 16:32:11 -0700 (PDT)
X-Received: by 10.180.198.226 with SMTP id jf2mr7416207wic.35.1403307131330;
        Fri, 20 Jun 2014 16:32:11 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id wp6sm8387104wjb.9.2014.06.20.16.32.10
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Jun 2014 16:32:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqmwd7citp.fsf@gitster.dls.corp.google.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::234
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252296>

Am 21.06.2014 00:33, schrieb Junio C Hamano:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>> To be able to add a common prefix or suffix to all trace output (e.g.
>> a timestamp or file:line of the caller), factor out common setup and
>> cleanup tasks of the trace* functions.
>>
>> Some unit-tests use trace output to verify internal state, and variable
>> output such as timestamps and line numbers are not useful there. Disable
>> additional trace output if GIT_TRACE_BARE is set.
> 
> Hmph, this makes me wonder if we are better off making these
> additional trace output optional, i.e. not disabling with
> GIT_TRACE_BARE like this, but show the new output only when
> explicitly asked for by setting GIT_TRACE_PERF or something.
> 

GIT_TRACE_VERBOSE perhaps? It affects all trace output, not just
GIT_TRACE_PERFORMANCE. The tests would still have to disable it
explicitly, though, in case someone sets it in their profile.

However, IIRC conclusion of v4 discussion was that this would be
useful for all trace output [1], so I think it should be the default.

[1] https://groups.google.com/forum/#!topic/msysgit/UMKTvmZX5aI

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
