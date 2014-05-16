From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH/RFC] Always auto-gc after calling a fast-import transport
Date: Fri, 16 May 2014 08:08:09 -0500
Message-ID: <53760db99f8ae_6899d4d2f8c6@nysa.notmuch>
References: <20140515053722.GB12133@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>, 
 msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>, 
 GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBDBJVMGGZYNBBUVA3CNQKGQEWLARI2Q@googlegroups.com Fri May 16 15:19:18 2014
Return-path: <msysgit+bncBDBJVMGGZYNBBUVA3CNQKGQEWLARI2Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-oa0-f63.google.com ([209.85.219.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDBJVMGGZYNBBUVA3CNQKGQEWLARI2Q@googlegroups.com>)
	id 1WlI2e-0006FC-MW
	for gcvm-msysgit@m.gmane.org; Fri, 16 May 2014 15:19:16 +0200
Received: by mail-oa0-f63.google.com with SMTP id o6sf665440oag.8
        for <gcvm-msysgit@m.gmane.org>; Fri, 16 May 2014 06:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=jIO5SyEJNk2Fi01mPof9HSNwvs18GjaMmnlU7Zkty/Q=;
        b=vg23ndZYuBbyC+Iny/82NdLo9sBFXgo6Jvc8qHHD7m/CUU2wYWXhoqtFbwAbRERhlf
         WA4+6IspjVFitEFLAyB+nkqj4LdGIv/PAK5VwAS8F/4xmTVcv+YDDzeARP0yLM0gmDZb
         j4lLg27P8fAk2/XMMXyhtXUmM2o8JI2rCqxBnLKmEU0a5VLObl8ZQ9Ujzh8jtxK3vW/0
         TaD51MyVXNKX5Dc4i8d4jE0dD8q/OCGBh2VCU4b/AHTg0a4Rt49MJz7bQBuTBQ3TsgyL
         y6wwbmVK3D8x68cdzNG1tuNe7+aabs0j17HXcckT7iX9ptOqtsaXgspEoqXvmRRVIzc/
         /3+Q==
X-Received: by 10.140.23.113 with SMTP id 104mr3323qgo.31.1400246355538;
        Fri, 16 May 2014 06:19:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.93.131 with SMTP id d3ls710264qge.52.gmail; Fri, 16 May
 2014 06:19:13 -0700 (PDT)
X-Received: by 10.224.29.129 with SMTP id q1mr7378801qac.3.1400246353092;
        Fri, 16 May 2014 06:19:13 -0700 (PDT)
Received: from mail-oa0-x234.google.com (mail-oa0-x234.google.com [2607:f8b0:4003:c02::234])
        by gmr-mx.google.com with ESMTPS id iq7si144807igb.0.2014.05.16.06.19.13
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 May 2014 06:19:13 -0700 (PDT)
Received-SPF: pass (google.com: domain of felipe.contreras@gmail.com designates 2607:f8b0:4003:c02::234 as permitted sender) client-ip=2607:f8b0:4003:c02::234;
Received: by mail-oa0-f52.google.com with SMTP id eb12so2986676oac.11
        for <msysgit@googlegroups.com>; Fri, 16 May 2014 06:19:12 -0700 (PDT)
X-Received: by 10.60.33.199 with SMTP id t7mr3235097oei.73.1400246352416;
        Fri, 16 May 2014 06:19:12 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id pt8sm14833025obb.5.2014.05.16.06.19.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 May 2014 06:19:10 -0700 (PDT)
In-Reply-To: <20140515053722.GB12133@camelia.ucw.cz>
X-Original-Sender: felipe.contreras@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of felipe.contreras@gmail.com designates
 2607:f8b0:4003:c02::234 as permitted sender) smtp.mail=felipe.contreras@gmail.com;
       dkim=pass header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249303>

Stepan Kasal wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Mon, 9 Apr 2012 13:04:35 -0500
> 
> After importing anything with fast-import, we should always let the
> garbage collector do its job, since the objects are written to disk
> inefficiently.
> 
> This brings down an initial import of http://selenic.com/hg from about
> 230 megabytes to about 14.
> 
> In the future, we may want to make this configurable on a per-remote
> basis, or maybe teach fast-import about it in the first place.

Actually I tested this patch and it makes no difference. Before and
after the patch the repository size is exactly the same (and so is the
run-time).

That is because after the initial import there are no loose objects,
every thing is into one big pack, so `git gc --auto` does nothing.

> Could anyone on the list try to reproduce the performance problem
> that triggered this?

I'd say this patch is not doing anything in recent versions of Git.

-- 
Felipe Contreras

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
