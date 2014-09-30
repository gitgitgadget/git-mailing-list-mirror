From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH v4] MinGW(-W64) compilation
Date: Tue, 30 Sep 2014 11:02:29 +0400
Message-ID: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRBIVLVGQQKGQEBXCHA4I@googlegroups.com Tue Sep 30 09:03:01 2014
Return-path: <msysgit+bncBCE7TAPITACRBIVLVGQQKGQEBXCHA4I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f64.google.com ([74.125.82.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBIVLVGQQKGQEBXCHA4I@googlegroups.com>)
	id 1XYrSe-0008Qq-8e
	for gcvm-msysgit@m.gmane.org; Tue, 30 Sep 2014 09:03:00 +0200
Received: by mail-wg0-f64.google.com with SMTP id l18sf1230609wgh.9
        for <gcvm-msysgit@m.gmane.org>; Tue, 30 Sep 2014 00:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=LPooCpgx7t6vaWGjjD3KWgQde2tWmxOy/YoaAi1DlzM=;
        b=NzRUlYsKBA8ZCQ3cVLu+q8p7rBHDRSgtU4CO7MIBJeKZctrdauCDYWsnhmAM76aXLB
         cc7OFmf7UKJOT379usjOceDi+DTPN8NI6FXzAonRIh8q4Tl6oDZVep3fWJBIncIdeA4g
         GbtC92G9r50kTP1+SCeTgngujfxndyeKx6zRhcBd/X0tU8ZKBx0xt+s/z14r9i0nGxmz
         k2eG/66j+j38vc/YexFl+uXjgmOHDjsyWGzB3hlcwROVjxtX1DE5HOf7ULT8fNvld1tb
         L23rSaY30d75x5r8VFVMNaEMjJD/8rtPils+55su/udUbGaUs6gs9dmmi88YdYzUc4EK
         4PAA==
X-Received: by 10.152.87.81 with SMTP id v17mr2444laz.27.1412060579954;
        Tue, 30 Sep 2014 00:02:59 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.5.201 with SMTP id u9ls232lau.107.gmail; Tue, 30 Sep 2014
 00:02:57 -0700 (PDT)
X-Received: by 10.112.52.165 with SMTP id u5mr246741lbo.12.1412060577825;
        Tue, 30 Sep 2014 00:02:57 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id ca20si728690wib.3.2014.09.30.00.02.57
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Sep 2014 00:02:57 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XYrSZ-0004X0-5K; Tue, 30 Sep 2014 11:02:55 +0400
X-Mailer: git-send-email 2.1.1
X-Original-Sender: marat@slonopotamus.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: marat@slonopotamus.org does not designate permitted sender
 hosts) smtp.mail=marat@slonopotamus.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257647>

This patch series fixes building on modern MinGW and MinGW-W64 (including x86_64!).

*Compilation* tested on:
 - MSVC
 - msysGit environment (twice)
 - Linux cross-toolchain i686-pc-mingw32
 - Linux cross-toolchain i686-w64-mingw32
 - Linux cross-toolchain x86_64-w64-mingw32

Attention: in order to build on MinGW-W64, you need to use 'v1.x', 'v2.x' or 'sf/v3.x'
branches from MinGW-W64 repo because MinGW-W64 releases do not yet have a fix
for https://sourceforge.net/p/mingw-w64/bugs/397

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
