From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH/RFC] Always auto-gc after calling a fast-import transport
Date: Thu, 15 May 2014 01:56:35 -0500
Message-ID: <53746523545d0_27ec161d2fc14@nysa.notmuch>
References: <20140515053722.GB12133@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>, 
 msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>, 
 GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBDBJVMGGZYNBBNOP2GNQKGQE3HIWM7Q@googlegroups.com Thu May 15 09:07:36 2014
Return-path: <msysgit+bncBDBJVMGGZYNBBNOP2GNQKGQE3HIWM7Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ve0-f192.google.com ([209.85.128.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDBJVMGGZYNBBNOP2GNQKGQE3HIWM7Q@googlegroups.com>)
	id 1WkplO-00087Y-KC
	for gcvm-msysgit@m.gmane.org; Thu, 15 May 2014 09:07:34 +0200
Received: by mail-ve0-f192.google.com with SMTP id oz11sf175322veb.9
        for <gcvm-msysgit@m.gmane.org>; Thu, 15 May 2014 00:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=eyhKq4ToYY8HrfoOOyX66JmzVVtsdnTlx3skzuavXeA=;
        b=PU5/5KN9c55goajx+0w4l05s4MHtlWntvBNFFWc1bnDfW0P3y/tIpQayXqf6/HNHpu
         YbSmi69Qj1oTniIWNY9cRzG0cpvyggfV38YbQyYtSSizDYHNqVXq+iGSyCjpM/us5bwO
         ZpgHF6yIxPgylmjs8HqZ33TFpOPt4iAOq/+gAbwBCXW3ZjEaLDbxdKf0en7UB8lhYzuF
         mWHxv7Osx3r/Qkkm9AwK9eZWoXp3JirBTOoBsO6ZsJZ/3dxGy90eKwZRDC8YDSpn5r7U
         EZ0EljqylFI/6xYrhLpnJ/bAL2gQW2UYgjxWC9QiaoCiqAWFcuFfvGrNtSnC1noo5gvD
         nHaA==
X-Received: by 10.140.91.40 with SMTP id y37mr1023qgd.37.1400137653705;
        Thu, 15 May 2014 00:07:33 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.43.135 with SMTP id e7ls107949qga.70.gmail; Thu, 15 May
 2014 00:07:33 -0700 (PDT)
X-Received: by 10.58.198.3 with SMTP id iy3mr4076934vec.39.1400137653257;
        Thu, 15 May 2014 00:07:33 -0700 (PDT)
Received: from mail-ob0-x229.google.com (mail-ob0-x229.google.com [2607:f8b0:4003:c01::229])
        by gmr-mx.google.com with ESMTPS id iq7si1458616igb.0.2014.05.15.00.07.33
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 May 2014 00:07:33 -0700 (PDT)
Received-SPF: pass (google.com: domain of felipe.contreras@gmail.com designates 2607:f8b0:4003:c01::229 as permitted sender) client-ip=2607:f8b0:4003:c01::229;
Received: by mail-ob0-x229.google.com with SMTP id vb8so762938obc.0
        for <msysgit@googlegroups.com>; Thu, 15 May 2014 00:07:33 -0700 (PDT)
X-Received: by 10.60.37.99 with SMTP id x3mr8149025oej.65.1400137653128;
        Thu, 15 May 2014 00:07:33 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id jr2sm7647222obb.8.2014.05.15.00.07.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 May 2014 00:07:32 -0700 (PDT)
In-Reply-To: <20140515053722.GB12133@camelia.ucw.cz>
X-Original-Sender: felipe.contreras@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of felipe.contreras@gmail.com designates
 2607:f8b0:4003:c01::229 as permitted sender) smtp.mail=felipe.contreras@gmail.com;
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249063>

Stepan Kasal wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Mon, 9 Apr 2012 13:04:35 -0500
> 
> After importing anything with fast-import, we should always let the
> garbage collector do its job, since the objects are written to disk
> inefficiently.

I'm not sure how slow `git gc --auto` is with a totally unpacked
repository, but it guess it will be slow enough that some people might
not want to do the gc initially.

Not many people have complained about the size of the repoitory after
cloning, so I think it should be OK to let users call `git gc` when they
wish to.

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
