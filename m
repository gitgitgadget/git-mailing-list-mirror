From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git grep -O -i: if the pager is 'less', pass
 the '-i' option
Date: Thu, 15 May 2014 10:53:44 -0700
Message-ID: <20140515175344.GM9218@google.com>
References: <20140514155010.GA4592@camelia.ucw.cz>
 <xmqq7g5okztp.fsf@gitster.dls.corp.google.com>
 <20140514182654.GA9218@google.com>
 <xmqqvbt8jjlg.fsf@gitster.dls.corp.google.com>
 <alpine.DEB.1.00.1405151943310.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Stepan Kasal <kasal@ucw.cz>,
	GIT Mailing-list <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBD6LRKOE4AIRBK762ONQKGQEICADEBQ@googlegroups.com Thu May 15 19:53:49 2014
Return-path: <msysgit+bncBD6LRKOE4AIRBK762ONQKGQEICADEBQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pb0-f57.google.com ([209.85.160.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD6LRKOE4AIRBK762ONQKGQEICADEBQ@googlegroups.com>)
	id 1Wkzqm-0006An-Sg
	for gcvm-msysgit@m.gmane.org; Thu, 15 May 2014 19:53:49 +0200
Received: by mail-pb0-f57.google.com with SMTP id md12sf398602pbc.2
        for <gcvm-msysgit@m.gmane.org>; Thu, 15 May 2014 10:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=1ECOIkhuIPQEW7os5MeGtOqhO5+mZKDW/r7/ZD0thc0=;
        b=PLQx5CKBPaknmOI+YzVRqEquGKgcvealsC4BYJ8PCm77y/+Go2KkicIUaIh09zA+Tc
         E7kSxMNhF25Ze0VaQ+lx9d/lFqwgns10QVbgEKSgAYY3RnvRNveFNojQaAlCgRCSk+nY
         ruCBChWGd3sLFwwhtuG5ZKteA8JxKY2Q03VWn1srJC2QzQRPDKQc/5vX70uCe9OdhoEZ
         r/qUg1QwIeUS42+7U/OQlvfWow2UeAfzKdIaCRCkhxTLwmE8bDTaD2uNQdkQssZKL2yb
         ZeYqRK104rhykffJmWYN40KY2ozXxI9bWIqGcFoypdnZpCOxnJFOPKUFT/cf13Fqe0dB
         gj6w==
X-Received: by 10.140.27.40 with SMTP id 37mr43936qgw.24.1400176427768;
        Thu, 15 May 2014 10:53:47 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.47.203 with SMTP id m69ls387895qga.84.gmail; Thu, 15 May
 2014 10:53:47 -0700 (PDT)
X-Received: by 10.52.165.36 with SMTP id yv4mr4392196vdb.1.1400176426975;
        Thu, 15 May 2014 10:53:46 -0700 (PDT)
Received: from mail-pb0-x22b.google.com (mail-pb0-x22b.google.com [2607:f8b0:400e:c01::22b])
        by gmr-mx.google.com with ESMTPS id jx10si1307843pbd.2.2014.05.15.10.53.46
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 May 2014 10:53:46 -0700 (PDT)
Received-SPF: pass (google.com: domain of jrnieder@gmail.com designates 2607:f8b0:400e:c01::22b as permitted sender) client-ip=2607:f8b0:400e:c01::22b;
Received: by mail-pb0-f43.google.com with SMTP id up15so1404318pbc.2
        for <msysgit@googlegroups.com>; Thu, 15 May 2014 10:53:46 -0700 (PDT)
X-Received: by 10.68.192.193 with SMTP id hi1mr14489549pbc.108.1400176426821;
        Thu, 15 May 2014 10:53:46 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id nx12sm23836661pab.6.2014.05.15.10.53.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 May 2014 10:53:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1405151943310.14982@s15462909.onlinehome-server.info>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Original-Sender: jrnieder@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of jrnieder@gmail.com designates 2607:f8b0:400e:c01::22b
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249171>

Hi,

Johannes Schindelin wrote:
> On Wed, 14 May 2014, Junio C Hamano wrote:

>> Spot on.  The change, especially with "-I", makes sense.
>
> Except that it was not tested with -I. If you change it that way and it
> stops working on Windows, it's useless to me.

Are you saying that less on Windows doesn't have an "-I" option?
version.c tells me it was added in v266 (1994-12-26).

If "-I' is in fact broken on Windows, that would be useful to know,
but it's not clear to me.  Or if I have misunderstood what

	git grep -i -Oless -eGit_

is supposed to do, that would help, too.

Puzzled,
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
