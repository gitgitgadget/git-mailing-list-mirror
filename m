From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] send-pack.c: Allow to disable side-band-64k
Date: Mon, 19 May 2014 12:33:40 -0700
Message-ID: <20140519193340.GP12314@google.com>
References: <1400526434-3132-1-git-send-email-thomas.braun@byte-physics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Thomas Braun <thomas.braun@byte-physics.de>
X-From: msysgit+bncBD6LRKOE4AIRBF5Z5GNQKGQEN5PSYOQ@googlegroups.com Mon May 19 21:33:47 2014
Return-path: <msysgit+bncBD6LRKOE4AIRBF5Z5GNQKGQEN5PSYOQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f192.google.com ([209.85.214.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD6LRKOE4AIRBF5Z5GNQKGQEN5PSYOQ@googlegroups.com>)
	id 1WmTJg-00036T-Nu
	for gcvm-msysgit@m.gmane.org; Mon, 19 May 2014 21:33:45 +0200
Received: by mail-ob0-f192.google.com with SMTP id va2sf1849343obc.9
        for <gcvm-msysgit@m.gmane.org>; Mon, 19 May 2014 12:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=kTTuZbBPl8hi3DRmnocRya67ibXgW6r6LifGzmCmMkI=;
        b=uvSYu0v9zptpwYgFrinwK0sMdMOq6eAy21EvBlCnkA2a6HkUlEih8NAKchwo8gXRXM
         9RJDP9ihjpDMtrtRDuS1GLy7unGPEuUJ9qnwJn85rxj1FJFuRiv4UnaHexdWrSBUtd7h
         vadWlkEHFoNrJ5krhJ6ivh3TwGEbfq4U6ArHl7g7oYNvT+ohd75yHk+kRCsG1JxmP2at
         quZQ/cNfH8HAkErqjCFuHPJR8WkZz1oNrASKMn7ML+n9XGzdcOhaaH+q6VooyfFBUEmj
         VTqRKRa5wzd/vHiPIzGgD1w/c2bG8Cv/yppGxBErcUlHuvI5BIaaV1Nsgk3nkmg/jvVx
         ZtIw==
X-Received: by 10.50.114.161 with SMTP id jh1mr12481igb.3.1400528023869;
        Mon, 19 May 2014 12:33:43 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.73.132 with SMTP id l4ls1230122igv.9.gmail; Mon, 19 May
 2014 12:33:43 -0700 (PDT)
X-Received: by 10.42.29.138 with SMTP id r10mr15619723icc.11.1400528023420;
        Mon, 19 May 2014 12:33:43 -0700 (PDT)
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com [2607:f8b0:400e:c03::22d])
        by gmr-mx.google.com with ESMTPS id vc6si4084496pab.2.2014.05.19.12.33.43
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 19 May 2014 12:33:43 -0700 (PDT)
Received-SPF: pass (google.com: domain of jrnieder@gmail.com designates 2607:f8b0:400e:c03::22d as permitted sender) client-ip=2607:f8b0:400e:c03::22d;
Received: by mail-pa0-f45.google.com with SMTP id ey11so6180982pad.4
        for <msysgit@googlegroups.com>; Mon, 19 May 2014 12:33:43 -0700 (PDT)
X-Received: by 10.66.150.169 with SMTP id uj9mr44943740pab.148.1400528023324;
        Mon, 19 May 2014 12:33:43 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id tu3sm79381716pab.1.2014.05.19.12.33.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 May 2014 12:33:42 -0700 (PDT)
In-Reply-To: <1400526434-3132-1-git-send-email-thomas.braun@byte-physics.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Original-Sender: jrnieder@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of jrnieder@gmail.com designates 2607:f8b0:400e:c03::22d
 as permitted sender) smtp.mail=jrnieder@gmail.com;       dkim=pass
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249616>

Hi,

Thomas Braun wrote:

> pushing over the dump git protocol with a windows git client.

I've never heard of the dump git protocol.  Do you mean the git
protocol that's used with git:// URLs?

[...]
> Alternative approaches considered but deemed too invasive:
> - Rewrite read/write wrappers in mingw.c in order to distinguish between
>   a file descriptor which has a socket behind and a file descriptor
>   which has a file behind.

I assume here "too invasive" means "too much engineering effort"?

It sounds like a clean fix, not too invasive at all.  But I can
understand wanting a stopgap in the meantime.

> - Turning the capability side-band-64k off completely. This would remove a useful
>   feature for users of non-affected transport protocols.

Would it make sense to turn off sideband unconditionally on Windows
when using the relevant protocols?

I assume someone on the list wouldn't mind writing such a patch, so I
don't think the engineering effort would be a problem for that.

Thanks,
Jonathan

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
