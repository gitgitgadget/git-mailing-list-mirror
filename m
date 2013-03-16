From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH/RFC] http_init: only initialize SSL for https
Date: Sat, 16 Mar 2013 23:58:55 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1303162355120.21738@tvnag.unkk.fr>
References: <1363269079-6124-1-git-send-email-kusmabite@gmail.com> <alpine.DEB.1.00.1303141621340.3794@s15462909.onlinehome-server.info> <CABPQNSZNdGea9Nn91emWhfRGAZjZXm755UKArNr3EUy9CrSKHg@mail.gmail.com> <7vmwu6x72q.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1303142333170.3794@s15462909.onlinehome-server.info> <7vk3p9wqh5.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1303151054130.32216@tvnag.unkk.fr> <7v4ngcwt4w.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1303151719170.32216@tvnag.unkk.fr>
 <20130316120300.GA2626@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>, kusmabite@gmail.com,
        git@vger.kernel.org, msysgit@googlegroups.com
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBCS5LIPSQMEBBPPSSOFAKGQE6FXMLFQ@googlegroups.com Sat Mar 16 23:59:35 2013
Return-path: <msysgit+bncBCS5LIPSQMEBBPPSSOFAKGQE6FXMLFQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f189.google.com ([209.85.212.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCS5LIPSQMEBBPPSSOFAKGQE6FXMLFQ@googlegroups.com>)
	id 1UH04a-0006Zt-8v
	for gcvm-msysgit@m.gmane.org; Sat, 16 Mar 2013 23:59:32 +0100
Received: by mail-wi0-f189.google.com with SMTP id hi8sf441808wib.26
        for <gcvm-msysgit@m.gmane.org>; Sat, 16 Mar 2013 15:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:received-spf
         :x-authentication-warning:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:x-fromdanielhimself
         :mime-version:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=/sR+piwQPcEE3b4pjyQs8TRcnxRAuShGa1gCufIztdg=;
        b=nUgEoMtkpwVg6isZwW0t+6Gi1Y3DjDrSxS6t8UDDnQobLvKddoHnVa8J3tQpstDJsA
         9Yim87UG9o/ZYPRat7Bx/wKvHbWdOvIfzFltc0WFUGvmmGysRljEh2QQlmrsY6Xv2n+g
         w15YbTFPaFI//5CbVfJIdB0CDKM+Tc5H8AwzzKHE104Dx55qgPk7g7ZaXRPuxpzh4zEX
         8bvQKM29mtqV0jerGlG5RV3QWA5ycOmfyyw6u5ndOrRCr9WhlzzKhatdIgRXQe0O 
X-Received: by 10.180.84.195 with SMTP id b3mr338475wiz.13.1363474749443;
        Sat, 16 Mar 2013 15:59:09 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.189.166 with SMTP id gj6ls263256wic.26.canary; Sat, 16 Mar
 2013 15:59:08 -0700 (PDT)
X-Received: by 10.205.24.134 with SMTP id re6mr1053601bkb.7.1363474748860;
        Sat, 16 Mar 2013 15:59:08 -0700 (PDT)
Received: from giant.haxx.se (www.haxx.se. [2a00:1a28:1200:9::2])
        by gmr-mx.google.com with ESMTPS id i9si942016bki.2.2013.03.16.15.59.05
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 16 Mar 2013 15:59:06 -0700 (PDT)
Received-SPF: pass (google.com: domain of daniel@haxx.se designates 2a00:1a28:1200:9::2 as permitted sender) client-ip=2a00:1a28:1200:9::2;
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id r2GMwwVt020723
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 16 Mar 2013 23:58:58 +0100
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id r2GMwtlh020709;
	Sat, 16 Mar 2013 23:58:56 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <20130316120300.GA2626@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
X-Original-Sender: daniel@haxx.se
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of daniel@haxx.se designates 2a00:1a28:1200:9::2 as
 permitted sender) smtp.mail=daniel@haxx.se
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218319>

On Sat, 16 Mar 2013, Jeff King wrote:

> But are we correct in assuming that curl will barf if it gets a redirect to 
> an ssl-enabled protocol? My testing seems to say yes:

Ah yes. If it switches over to an SSL-based protocol it will pretty much 
require that it had been initialized previously.

With redirects taken into account, I can't think of any really good way around 
avoiding this init...

-- 

  / daniel.haxx.se

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
For more options, visit https://groups.google.com/groups/opt_out.
