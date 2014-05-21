From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH v4 2/3] add trace_performance facility to
 debug performance issues
Date: Wed, 21 May 2014 12:58:06 -0400
Message-ID: <20140521165806.GD2040@sigill.intra.peff.net>
References: <537BA806.50600@gmail.com>
 <537BA8D7.4000007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBDO2DJFKTEFBBIFW6ONQKGQEUENBPIA@googlegroups.com Wed May 21 18:58:11 2014
Return-path: <msysgit+bncBDO2DJFKTEFBBIFW6ONQKGQEUENBPIA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pd0-f185.google.com ([209.85.192.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBIFW6ONQKGQEUENBPIA@googlegroups.com>)
	id 1Wn9qE-0005j9-Vc
	for gcvm-msysgit@m.gmane.org; Wed, 21 May 2014 18:58:11 +0200
Received: by mail-pd0-f185.google.com with SMTP id g10sf577418pdj.2
        for <gcvm-msysgit@m.gmane.org>; Wed, 21 May 2014 09:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=pz5CNfryKhqbKNsH3gxMb/VpyiweynsvE0lOJRJrdSk=;
        b=aWQdKSAaJ63UFZOkmnT9IR3ABK1z2ZEroSgUGS0+vejc/aVEDnivcxdeUdgDGDGaFa
         FoJW3Y0Fc81DTXtCrwmq0JPIuHJ2dalNbF0jrappxjsYovA6+2xnizE1BGa7llDCK9sg
         bPSmvsmpxe8Q190Rpo1P1h3r5Hd1OL8W43WFIkGZRAZ2U7nhA1Anz8k3rcCqiyLDSyfh
         7zYTQ/PBqnwx7of2Q6R950TG/eATWZ/9wbYCWQYbp4Dtq2UrGh+3nTJjgjoL2X1Hze3N
         miub//DgZ/Lh/vtqbjnlenQ/zyC9CxvgHzIgRjFQ0/y7wAblkT3WwJsu9E+iJkHKInfk
         JGpA==
X-Received: by 10.182.20.203 with SMTP id p11mr17379obe.35.1400691489541;
        Wed, 21 May 2014 09:58:09 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.74.227 with SMTP id x3ls271195obv.75.gmail; Wed, 21 May
 2014 09:58:08 -0700 (PDT)
X-Received: by 10.182.121.232 with SMTP id ln8mr23371942obb.11.1400691488751;
        Wed, 21 May 2014 09:58:08 -0700 (PDT)
Received: from peff.net (cloud.peff.net. [50.56.180.127])
        by gmr-mx.google.com with SMTP id aa2si228920igd.3.2014.05.21.09.58.08
        for <msysgit@googlegroups.com>;
        Wed, 21 May 2014 09:58:08 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted sender) client-ip=50.56.180.127;
Received: (qmail 21326 invoked by uid 102); 21 May 2014 16:58:08 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 May 2014 11:58:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 May 2014 12:58:06 -0400
In-Reply-To: <537BA8D7.4000007@gmail.com>
X-Original-Sender: peff@peff.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted
 sender) smtp.mail=peff@peff.net
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249809>

On Tue, May 20, 2014 at 09:11:19PM +0200, Karsten Blees wrote:

> Add trace_performance and trace_performance_since macros that print file
> name, line number, time and an optional printf-formatted text to the file
> specified in environment variable GIT_TRACE_PERFORMANCE.
> 
> Unless enabled via GIT_TRACE_PERFORMANCE, these macros have no noticeable
> impact on performance, so that test code may be shipped in release builds.
> 
> MSVC: variadic macros (__VA_ARGS__) require VC++ 2005 or newer.

I think we still have some Unix compilers that do not do variadic
macros, either. For a while, people were compiling with antique stuff
like SUNWspro and MIPSpro. I don't know if they still do, if they use
gcc on such systems now, or if those systems have finally been
decomissioned.

But either we need to change our stance on variadic macros, or this
feature needs to be able to be compiled conditionally.

-Peff

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
