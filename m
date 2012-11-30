From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 5/5] mingw: get rid of getpass implementation
Date: Fri, 30 Nov 2012 13:27:48 -0500
Message-ID: <20121130182748.GE7197@sigill.intra.peff.net>
References: <1352815447-8824-1-git-send-email-kusmabite@gmail.com>
 <1352815447-8824-6-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBDO2DJFKTEFBBJXV4OCQKGQE7YJNEZQ@googlegroups.com Fri Nov 30 19:28:07 2012
Return-path: <msysgit+bncBDO2DJFKTEFBBJXV4OCQKGQE7YJNEZQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pb0-f58.google.com ([209.85.160.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBJXV4OCQKGQE7YJNEZQ@googlegroups.com>)
	id 1TeVJj-0007Ns-8c
	for gcvm-msysgit@m.gmane.org; Fri, 30 Nov 2012 19:28:03 +0100
Received: by mail-pb0-f58.google.com with SMTP id xa7sf817446pbc.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 30 Nov 2012 10:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=hl1IWhDiKwyGnDm04khZq+1Rl3QOHLHwKI9C8GksG/k=;
        b=N+mIYBc/L/mpJvbBsDDvDSNzCyarQ7xLSlAj9qwXUVscRtNXeBQwOB2bLfA7UHxOUz
         jGFSOpfc56BQnaPe9VPZDxDvmsjK3X1HYZuEkiJVaACd4CT3c4jOLRWzifv+uJGvcL44
         CR9AvY1e78iiVGU41qjmSkQCsID0WMh1GtPDV9wt+gleHouO50TLfNOw4V7CoVfrI51o
         UbtshIKBVSZQLut6X9fFl8WyI9l7AVb/KdCm0sbGxz8QepXDBVKOq5eJ6OwLLZ0yCEV7
         I/afzC/oCKSRNCxaZz7VK8au7fzWivX9DpTu6IK/87DER+FWCTxxyBo4LJRGbQYXcV3b
       
Received: by 10.50.45.226 with SMTP id q2mr12374906igm.0.1354300070882;
        Fri, 30 Nov 2012 10:27:50 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.40.227 with SMTP id a3ls816igl.20.canary; Fri, 30 Nov 2012
 10:27:50 -0800 (PST)
Received: by 10.50.33.180 with SMTP id s20mr24555910igi.5.1354300070149;
        Fri, 30 Nov 2012 10:27:50 -0800 (PST)
Received: by 10.50.33.180 with SMTP id s20mr24555909igi.5.1354300070140;
        Fri, 30 Nov 2012 10:27:50 -0800 (PST)
Received: from peff.net (75-15-5-89.uvs.iplsin.sbcglobal.net. [75.15.5.89])
        by gmr-mx.google.com with ESMTPS id hw1si630183igc.3.2012.11.30.10.27.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Nov 2012 10:27:50 -0800 (PST)
Received-SPF: pass (google.com: domain of peff@peff.net designates 75.15.5.89 as permitted sender) client-ip=75.15.5.89;
Received: (qmail 5437 invoked by uid 107); 30 Nov 2012 18:28:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Nov 2012 13:28:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Nov 2012 13:27:48 -0500
In-Reply-To: <1352815447-8824-6-git-send-email-kusmabite@gmail.com>
X-Original-Sender: peff@peff.net
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of peff@peff.net designates 75.15.5.89 as permitted sender) smtp.mail=peff@peff.net
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210940>

On Tue, Nov 13, 2012 at 03:04:07PM +0100, Erik Faye-Lund wrote:

> There's no remaining call-sites, and as pointed out in the
> previous commit message, it's not quite ideal. So let's just
> lose it.
> 
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
>  compat/mingw.c | 15 ---------------
>  compat/mingw.h |  2 --
>  2 files changed, 17 deletions(-)

Yay!

-Peff

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
