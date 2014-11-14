From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t1410: fix breakage on case-insensitive filesystems
Date: Fri, 14 Nov 2014 14:23:08 -0500
Message-ID: <20141114192308.GA10860@peff.net>
References: <CAO2U3QiFvwMiwVCdVju_vJKK_HVndpQf4VyrEaHeeVVN6rgYgA@mail.gmail.com>
 <20141109014354.GA23883@peff.net>
 <20141109015918.GA24736@peff.net>
 <5463C106.5090803@kdbg.org>
 <20141112215923.GB6801@peff.net>
 <546470D0.3080809@kdbg.org>
 <20141113090832.GA8329@peff.net>
 <546653D6.7040505@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Blume <blume.mike@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncBDO2DJFKTEFBBHVNTGRQKGQE2TQEVFA@googlegroups.com Fri Nov 14 20:23:12 2014
Return-path: <msysgit+bncBDO2DJFKTEFBBHVNTGRQKGQE2TQEVFA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f190.google.com ([209.85.216.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBHVNTGRQKGQE2TQEVFA@googlegroups.com>)
	id 1XpMSd-0006t7-Sh
	for gcvm-msysgit@m.gmane.org; Fri, 14 Nov 2014 20:23:12 +0100
Received: by mail-qc0-f190.google.com with SMTP id c9sf448140qcz.27
        for <gcvm-msysgit@m.gmane.org>; Fri, 14 Nov 2014 11:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=JxgncFIhA1pCKyLTGpmAcMB0sG5nPzIcBJfltXRg9Gk=;
        b=W7x7mYAE9YLBQJuw07EgPBAvzicGVZYtvv9eWtrbh1Wonyr+0XrDaEJacRqRTK3zOV
         V1H13DfNU1f4hgotj9LBIyGQmBSQPpDkCo0P5kquSa2CSd4qstIa1CLl/jtPlTUTAcTV
         Z+4wy2NCOA6G2ZKkGnYg9Ev5Bysu6q06cyattY/h+gD5uOlGj6fshXOWei0Sn3yNlHWR
         L9jktfl8Mat1jvykYYs+lL9Ek8wWBsO0DvrkEKP28acodzKOg6szkPGMsb+gSGMPJ1EN
         uB2QbK1MQ5yYdq/dPcgIQF/lWW9Oc12tH0HEUYyoY46rwVWNrAhODKj7wUU/4HvlYqmz
         512Q==
X-Received: by 10.50.18.50 with SMTP id t18mr116469igd.3.1415992991025;
        Fri, 14 Nov 2014 11:23:11 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.107.18.94 with SMTP id a91ls2801998ioj.63.gmail; Fri, 14 Nov
 2014 11:23:10 -0800 (PST)
X-Received: by 10.43.73.6 with SMTP id yq6mr54832298icb.14.1415992990681;
        Fri, 14 Nov 2014 11:23:10 -0800 (PST)
Received: from cloud.peff.net (cloud.peff.net. [50.56.180.127])
        by gmr-mx.google.com with SMTP id u15si294648igr.3.2014.11.14.11.23.10
        for <msysgit@googlegroups.com>;
        Fri, 14 Nov 2014 11:23:10 -0800 (PST)
Received-SPF: pass (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted sender) client-ip=50.56.180.127;
Received: (qmail 12099 invoked by uid 102); 14 Nov 2014 19:23:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Nov 2014 13:23:10 -0600
Received: (qmail 15578 invoked by uid 107); 14 Nov 2014 19:23:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Nov 2014 14:23:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Nov 2014 14:23:08 -0500
In-Reply-To: <546653D6.7040505@kdbg.org>
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
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Content-Disposition: inline

On Fri, Nov 14, 2014 at 08:11:18PM +0100, Johannes Sixt wrote:

> Not a comment, on this paragraph of yours, but while I was walking
> through the code with gdb, I was wondering why the reflog directory is
> being touched at all when core.logallrefupdates is off (in
> log_ref_setup via log_ref_write). With the patch below I now get the
> same unlink warning as on Linux.

It's because of the weird reflog rules: we will use a reflog file that
exists (no matter what core.logallrefupdates says), but only _create_ a
new one if the config tells us to. I think this dates back to the origin
of reflogs, where we weren't sure at first that you would always want
them on.

> --- 8< ---
> Subject: [PATCH] Windows: correct detection of EISDIR in mingw_open()
> 
> According to the Linux open(2) man page, open() returns EISDIR if a
> directory was attempted to be opened for writing. Our emulation in
> mingw_open() does not get this right: it checks only for O_CREAT. Fix
> it to check for one of the write flags.
> 
> This fixes a failure in reflog handling, which opens files with
> O_APPEND|O_WRONLY, but without O_CREAT, and expects EISDIR when the
> named file happens to be a directory.

Ah, so we do get EISDIR with O_CREAT. Which explains why the first test
passed and the second failed (we only pass O_CREAT when logallrefupdates
is on). The behavior you saw (and this fix) make perfect sense to me
then.

> Signed-off-by: Johannes Sixt <j6t@kdbg.org>

I am not sure if I get to Acked-by things in compat/mingw, but I am
pretty sure this is the right fix. :)

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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
