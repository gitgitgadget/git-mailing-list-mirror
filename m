From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH v4 3/3] add command performance tracing to
 debug scripted commands
Date: Fri, 23 May 2014 16:21:27 -0400
Message-ID: <20140523202127.GF19088@sigill.intra.peff.net>
References: <537BA806.50600@gmail.com>
 <537BA8DC.9070104@gmail.com>
 <20140521165508.GC2040@sigill.intra.peff.net>
 <537D4790.6030106@gmail.com>
 <20140522095920.GA15461@sigill.intra.peff.net>
 <537F5E9A.1030901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBDO2DJFKTEFBBSW372NQKGQE2AQPF6A@googlegroups.com Fri May 23 22:21:31 2014
Return-path: <msysgit+bncBDO2DJFKTEFBBSW372NQKGQE2AQPF6A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yh0-f58.google.com ([209.85.213.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBSW372NQKGQE2AQPF6A@googlegroups.com>)
	id 1Wnvy7-0004cx-Di
	for gcvm-msysgit@m.gmane.org; Fri, 23 May 2014 22:21:31 +0200
Received: by mail-yh0-f58.google.com with SMTP id a41sf1387666yho.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 23 May 2014 13:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=BeuqEW1eQP03iAyCd3WBeb9SAneSYjZ9rO2lL3ZCD+I=;
        b=KqEX6naFtyMyFUhZSHW5EX9JOqbD72YYiMNoFxN0hzJWtTHLXk38wES6cCt68Tz3Es
         JlzoPE3DwKLj5zJYTukYkeqJZW27o+F9aVu/EAmFtw3tpHkC1q+Ad5tZ/ahidq4s1vcQ
         fjGX3ADYsQLsfSQYXpWZgzRrrBMBS0dEGmRqj/zDdCctBbsfUAikhQ6NEDwQyddR+Mkt
         EGKod8lEZufVb7z+QmWdkvMREQtd4U2Edbh1ERjP83N95w5axWim9eLqytqfM78N8UsX
         oITcZP6nKTF2u+yMTKDJ6sM6t+CjY8Aew/PgwTPCHHIJRGsfKKD1naknOEQ7ga4JaDuW
         79xQ==
X-Received: by 10.140.95.141 with SMTP id i13mr132177qge.3.1400876490507;
        Fri, 23 May 2014 13:21:30 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.82.231 with SMTP id h94ls1936393qgd.49.gmail; Fri, 23 May
 2014 13:21:30 -0700 (PDT)
X-Received: by 10.52.113.226 with SMTP id jb2mr2737779vdb.6.1400876490081;
        Fri, 23 May 2014 13:21:30 -0700 (PDT)
Received: from peff.net (cloud.peff.net. [50.56.180.127])
        by gmr-mx.google.com with SMTP id h3si226760igq.3.2014.05.23.13.21.29
        for <msysgit@googlegroups.com>;
        Fri, 23 May 2014 13:21:29 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted sender) client-ip=50.56.180.127;
Received: (qmail 3342 invoked by uid 102); 23 May 2014 20:21:29 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 May 2014 15:21:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 May 2014 16:21:27 -0400
In-Reply-To: <537F5E9A.1030901@gmail.com>
X-Original-Sender: peff@peff.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted
 sender) smtp.mail=peff@peff.net
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250026>

On Fri, May 23, 2014 at 04:43:38PM +0200, Karsten Blees wrote:

> Alright then. I've queued vor v5:
> * add __FILE__ __LINE__ for all trace output, if the compiler supports variadic macros
> * add timestamp for all trace output
> * perhaps move trace declarations to new trace.h
> * improve commit messages of existing patches to clarify the issues discussed so far

Thanks, that all sounds reasonable.

> I'm on holiday next week , so please be patient...

No hurry. :)

-Peff

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
