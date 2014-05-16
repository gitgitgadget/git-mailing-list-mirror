From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH] grep -I: do not bother to read known-binary files
Date: Fri, 16 May 2014 10:19:57 +0200
Organization: <)><
Message-ID: <20140516081957.GA19845@camelia.ucw.cz>
References: <20140514154419.GA4517@camelia.ucw.cz> <20140514194128.GC2715@sigill.intra.peff.net> <alpine.DEB.1.00.1405151940170.14982@s15462909.onlinehome-server.info> <20140515192226.GC29746@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>,
        msysGit <msysgit@googlegroups.com>
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBCU63DXMWULRBL4U26NQKGQEDLJ4G5A@googlegroups.com Fri May 16 10:20:01 2014
Return-path: <msysgit+bncBCU63DXMWULRBL4U26NQKGQEDLJ4G5A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f57.google.com ([209.85.215.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBL4U26NQKGQEDLJ4G5A@googlegroups.com>)
	id 1WlDN2-0000wE-Ej
	for gcvm-msysgit@m.gmane.org; Fri, 16 May 2014 10:20:00 +0200
Received: by mail-la0-f57.google.com with SMTP id hr17sf197801lab.12
        for <gcvm-msysgit@m.gmane.org>; Fri, 16 May 2014 01:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=SuryR7+//1o8EDcSbfH/Na1W2tcYsHNpPrcC4Kfe5HI=;
        b=H3uLyWI6TJf4axMw76rAvE2oyCRALYMJcd66nSDHJ8pVke5COpos5ZAeAAhMVLmuVz
         o/DY5dk7/bTWBaBE3ym4hN6Ol2DWcQcwNUwjEL3YNhSOhJRT24b7ZzgC7YEz7H/Sq9Nq
         HwHGLSLpgLT3Me8lp5zhpgAB/eiKtQqC+xpGuQUv0HTcFk0p6bBwLb9Q6Sh/8jQFKmxD
         zE3OZMlqPXa0YWlqdScYsdbtiNqACCGJZVXNNrViwl1TRdNCQX4w0VP/TyNXXuBpeasO
         KSwMLA1kGq5b+JE6w6EcHoiX641VuO9IRGEHCsvj9UEfzgDAHR/2V4WXACIqIWu83P41
         1MSw==
X-Received: by 10.152.18.134 with SMTP id w6mr196158lad.1.1400228400232;
        Fri, 16 May 2014 01:20:00 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.37.169 with SMTP id z9ls92322laj.66.gmail; Fri, 16 May
 2014 01:19:59 -0700 (PDT)
X-Received: by 10.112.59.136 with SMTP id z8mr1407723lbq.8.1400228399157;
        Fri, 16 May 2014 01:19:59 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id u49si2480877eeo.1.2014.05.16.01.19.59
        for <msysgit@googlegroups.com>;
        Fri, 16 May 2014 01:19:59 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id CD82A1C00FA;
	Fri, 16 May 2014 10:19:58 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s4G8JwKJ019880;
	Fri, 16 May 2014 10:19:58 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s4G8JvG5019879;
	Fri, 16 May 2014 10:19:57 +0200
In-Reply-To: <20140515192226.GC29746@sigill.intra.peff.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249275>

Hello,

On Thu, May 15, 2014 at 03:22:26PM -0400, Jeff King wrote:
> As the person who is proposing the patch for git.git, I would hope
> Stepan would follow up on such review and confirm whether or not it is
> still needed.

well, I try to.  (I verified that "less -I" works in msysGit before
submitting the fixup back there, fox example.)

But I think my role is to moderate the reconciliation.
In this case, having read the discussion, I decided to to ask Dscho
to drop the patch.

(It is always about balancing the risks and the expenses.)

Stepan

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
