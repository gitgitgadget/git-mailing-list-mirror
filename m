From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: [PATCH 13/14] git-compat-util.h: fix integer
 overflow on IL32P64 systems
Date: Thu, 9 Oct 2014 08:08:31 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1410090751270.990@s15462909.onlinehome-server.info>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org> <1412791267-13356-14-git-send-email-marat@slonopotamus.org> <xmqqioju9xiz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org, 
    msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCZPH74Q5YNRBZOM3CQQKGQENIFMFDQ@googlegroups.com Thu Oct 09 08:08:39 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBZOM3CQQKGQENIFMFDQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f192.google.com ([209.85.217.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBZOM3CQQKGQENIFMFDQ@googlegroups.com>)
	id 1Xc6tx-0007Ja-Mo
	for gcvm-msysgit@m.gmane.org; Thu, 09 Oct 2014 08:08:37 +0200
Received: by mail-lb0-f192.google.com with SMTP id n15sf42836lbi.19
        for <gcvm-msysgit@m.gmane.org>; Wed, 08 Oct 2014 23:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=ZWDKaNf2bRwPN4NhRCPnKWj9CUqAyYlMhTfsUNNtfHY=;
        b=tryVGlu+s0XPFufYQSTkL5KX68RmmhsAvocOiYslONEwm6nGdfSv64j2fPzLKN1Qyk
         oZEjj2Exv/GC2qVw3GlCLD9R428X0XhabLOj7IuDAvtLQJPKXEAnyWwOJ7OKeNIx6DvU
         lBOUJgH3XU+KC++C7S3H7Ec2yTbvOzlCnSGQA4vREt6V6ILJ8MWz0hXSRu5lwBB+161e
         hjCJRV16ZyyNM7mJVXMtVOL5+N8iEv03YsqDDiY41Be/tuKmSbYZnQyNibqAWndd+nb8
         P2U/YtZI0tY9weZe0v/YJ3usjOq28tjzAyDv36VcDB9S5RdK0nhN9e9pMPDd2aY6t24Z
         NvTQ==
X-Received: by 10.180.9.114 with SMTP id y18mr14096wia.21.1412834917509;
        Wed, 08 Oct 2014 23:08:37 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.20.116 with SMTP id m20ls206152wie.0.gmail; Wed, 08 Oct
 2014 23:08:36 -0700 (PDT)
X-Received: by 10.180.188.145 with SMTP id ga17mr370515wic.3.1412834916817;
        Wed, 08 Oct 2014 23:08:36 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.15])
        by gmr-mx.google.com with ESMTPS id us10si324513lbc.1.2014.10.08.23.08.36
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Oct 2014 23:08:36 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.15 as permitted sender) client-ip=212.227.15.15;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0LZhoi-1Y3iTk14uK-00lT3i;
 Thu, 09 Oct 2014 08:08:32 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqioju9xiz.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:+1rz9KM49r0lzr+cIcBT5EgQuBWpJJZVHfX/5xzvgU9nsKRmPoT
 kHOiRk+AOL13OxxiIWMb5NiNq8FWyhCBr8l3IKoAnx0Jsg3KUg8FqfGaVS5ixk2uG7LsUBF
 5LnuLoy1liqBQSXTWBIP0+92ZjLgSPqGLInN/tESzXUv88NSAde2U8g6vARKNldRcilx6i1
 zY+QkPcYyKRk+gb3pYECA==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.15 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
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

Hi Junio,

On Wed, 8 Oct 2014, Junio C Hamano wrote:

> Marat Radchenko <marat@slonopotamus.org> writes:
> 
> >  #define DEFAULT_PACKED_GIT_LIMIT \
> > -	((1024L * 1024L) * (sizeof(void*) >= 8 ? 8192 : 256))
> > +	((size_t)(1024L * 1024L) * (sizeof(void*) >= 8 ? 8192 : 256))
> 
> 1024 * 1024 * 8192 overflows 32-bit unsigned, but is size_t always
> large enough?  Just checking.

The diff is a bit misleading as to what it *actually* changes. It *just*
casts the result to size_t. The arithmetic is performed with longs (thanks
to the "l" in 1024l) and it only overflows 32 bit iff the sizeof() test
verifies that we're at least on 64 bit -- this arithmetic operation is the
same as before the patch. I was fooled by the diff myself (adding another
parenthesis just to add the cast would probably have helped, though).

IMHO this is a good demonstration how a commit message that goes slightly
beyond the necessary can help tons of time by avoiding to let every
reviewer/reader go through the exact same steps of puzzlement.

Ciao,
Dscho

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
