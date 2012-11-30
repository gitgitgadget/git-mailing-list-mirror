From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 3/5] compat/terminal: separate input and
 output handles
Date: Fri, 30 Nov 2012 13:22:00 -0500
Message-ID: <20121130182200.GC7197@sigill.intra.peff.net>
References: <1352815447-8824-1-git-send-email-kusmabite@gmail.com>
 <1352815447-8824-4-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBDO2DJFKTEFBBSXS4OCQKGQEZPOCY7Y@googlegroups.com Fri Nov 30 19:22:27 2012
Return-path: <msysgit+bncBDO2DJFKTEFBBSXS4OCQKGQEZPOCY7Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yh0-f55.google.com ([209.85.213.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBSXS4OCQKGQEZPOCY7Y@googlegroups.com>)
	id 1TeVE7-0004Wu-Qk
	for gcvm-msysgit@m.gmane.org; Fri, 30 Nov 2012 19:22:15 +0100
Received: by mail-yh0-f55.google.com with SMTP id 10sf11811990yhl.10
        for <gcvm-msysgit@m.gmane.org>; Fri, 30 Nov 2012 10:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=jrJLNhOpViFrj3sGvvR4r5yQ1xMe1fWO0Y41bJTZm9s=;
        b=BNXeNoQFJQB254L6pelpYBQcwcOKoxZr38EqcFsH5Xh+08Wy8QIaQdRx6kvrZnmgZm
         UEDlUSaihIHywYQ8vfXQ8t/2Atzd52pk10vllJGI4qCTgEixYtyJv/1L2zZ5NdQg6hOG
         hl702lX1rScImI4LpTRYCYjEfqQTR8+Ey40wB02cuJku0xqQBbulNS0b03h6NGhtDiMS
         DS3N48gE7Wq1uAxkygnwufcg60ydwHTzU25BD46aMbgH0qKQRqC4x2u5E3Tal/RnOuiG
         mA/OsQ43TfafHkq9B3uYbY4lEl2sYx8xI+mFUHNvoR48/NrXRqKCt6y52EF0fp7qfXQe
       
Received: by 10.50.87.165 with SMTP id az5mr12646423igb.1.1354299723826;
        Fri, 30 Nov 2012 10:22:03 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.17.201 with SMTP id q9ls7653326igd.26.canary; Fri, 30 Nov
 2012 10:22:02 -0800 (PST)
Received: by 10.43.84.4 with SMTP id ai4mr1661699icc.22.1354299722350;
        Fri, 30 Nov 2012 10:22:02 -0800 (PST)
Received: by 10.43.84.4 with SMTP id ai4mr1661697icc.22.1354299722320;
        Fri, 30 Nov 2012 10:22:02 -0800 (PST)
Received: from peff.net (75-15-5-89.uvs.iplsin.sbcglobal.net. [75.15.5.89])
        by gmr-mx.google.com with ESMTPS id hw1si629424igc.3.2012.11.30.10.22.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Nov 2012 10:22:02 -0800 (PST)
Received-SPF: pass (google.com: domain of peff@peff.net designates 75.15.5.89 as permitted sender) client-ip=75.15.5.89;
Received: (qmail 5359 invoked by uid 107); 30 Nov 2012 18:22:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Nov 2012 13:22:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Nov 2012 13:22:00 -0500
In-Reply-To: <1352815447-8824-4-git-send-email-kusmabite@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210938>

On Tue, Nov 13, 2012 at 03:04:05PM +0100, Erik Faye-Lund wrote:

> On Windows, the terminal cannot be opened in read-write mode, so
> we need distinct pairs for reading and writing. Since this works
> fine on other platforms as well, always open them in pairs.

Looks OK. We're now opening /dev/tty three separate times in the no-echo
case, but it's not like this is in a performance critical loop.

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
