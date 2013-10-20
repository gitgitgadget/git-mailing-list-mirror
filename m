From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Prevent buffer overflows when path is too big
Date: Sun, 20 Oct 2013 17:33:47 +0700
Message-ID: <CACsJy8AXV=KJtTWxp6dpfa_Pr81h3YwW5EK=c_dV=F7tr7ChWQ@mail.gmail.com>
References: <CABPQNSaqjKPGAQ4EKBSk+bQP2WMksc6M0YQxSkB91UrnFF28xQ@mail.gmail.com>
 <1382179954-5169-1-git-send-email-apelisse@gmail.com> <52636E5A.1080909@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: Antoine Pelisse <apelisse@gmail.com>, Git Mailing List <git@vger.kernel.org>, 
	Wataru Noguchi <wnoguchi.0727@gmail.com>, Erik Faye-Lund <kusmabite@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	msysGit <msysgit@googlegroups.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: msysgit+bncBC2ZN5PHQUMBBK7DR2JQKGQEJSY7VXY@googlegroups.com Sun Oct 20 12:34:22 2013
Return-path: <msysgit+bncBC2ZN5PHQUMBBK7DR2JQKGQEJSY7VXY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pb0-f60.google.com ([209.85.160.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC2ZN5PHQUMBBK7DR2JQKGQEJSY7VXY@googlegroups.com>)
	id 1VXqKz-0002dT-8P
	for gcvm-msysgit@m.gmane.org; Sun, 20 Oct 2013 12:34:21 +0200
Received: by mail-pb0-f60.google.com with SMTP id rr4sf1080028pbb.25
        for <gcvm-msysgit@m.gmane.org>; Sun, 20 Oct 2013 03:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=7HqHXspEVpxxr669Ne8OJPqswBsK7mboC7g5imlU88Y=;
        b=oNwHuV8narDWuj563imvoZegbWGXifgVLD6DGFD4Ucha0YpSUzS+N0hGKBP4eGxOjH
         EJHM4J/RiB73B37E8CUQr+9DB0o54aSr3eBKf+qRCKpxKw+0OuHtS+mNbaCi6HsqV99w
         2NH0F2LnjUmUdLMBf+kdn3M07MxvN6ZN5WjALABjv50kj/BbSOKN2mVuwNjMJWPStQ2g
         s7+Ug8LsjUYQJOKH6Zmc3x0u7zZ7CB9hysd5sgxseabVKbyd9qf1pikU5mO6aBIiNqZN
         gREaCsvhZ7ZCBoPk30HtFsjLG2TESgt7BqlVqT9MsgS+rHJpEWWJUQ/A31YAm5PTxmIw
         Kfgg==
X-Received: by 10.50.73.132 with SMTP id l4mr136482igv.0.1382265259852;
        Sun, 20 Oct 2013 03:34:19 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.117.5 with SMTP id ka5ls1323147igb.26.gmail; Sun, 20 Oct
 2013 03:34:19 -0700 (PDT)
X-Received: by 10.50.126.69 with SMTP id mw5mr3135068igb.7.1382265259014;
        Sun, 20 Oct 2013 03:34:19 -0700 (PDT)
Received: from mail-qc0-x229.google.com (mail-qc0-x229.google.com [2607:f8b0:400d:c01::229])
        by gmr-mx.google.com with ESMTPS id bc1si2003921qcb.1.2013.10.20.03.34.18
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 20 Oct 2013 03:34:18 -0700 (PDT)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 2607:f8b0:400d:c01::229 as permitted sender) client-ip=2607:f8b0:400d:c01::229;
Received: by mail-qc0-f169.google.com with SMTP id x12so3869851qcv.28
        for <msysgit@googlegroups.com>; Sun, 20 Oct 2013 03:34:18 -0700 (PDT)
X-Received: by 10.224.151.202 with SMTP id d10mr559022qaw.115.1382265258881;
 Sun, 20 Oct 2013 03:34:18 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Sun, 20 Oct 2013 03:33:47 -0700 (PDT)
In-Reply-To: <52636E5A.1080909@web.de>
X-Original-Sender: pclouds@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of pclouds@gmail.com designates 2607:f8b0:400d:c01::229
 as permitted sender) smtp.mail=pclouds@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236418>

On Sun, Oct 20, 2013 at 12:47 PM, Torsten B=F6gershausen <tboegi@web.de> wr=
ote:
> I'm not sure how to handle overlong path in general, there are several wa=
ys:
> a) Silently overwrite memory (with help of memcpy() and/or strcpy()
> b) Silently shorten the path using strlcpy() instead of strcpy()
> c) Avoid the overwriting and call die().
> d) Prepare a longer buffer using xmalloc()

d+) Use strbuf
--=20
Duy

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
