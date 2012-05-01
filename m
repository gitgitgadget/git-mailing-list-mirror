From: Jeff King <peff@peff.net>
Subject: Re: 1.7.10 doesn't show file pushstatus
Date: Tue, 1 May 2012 02:58:33 -0400
Message-ID: <20120501065832.GA17777@sigill.intra.peff.net>
References: <20120501010609.GA14715@jupiter.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: dfowler <davidfowl@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, Paul Betts <paul@github.com>,
	David Ebbo <david.ebbo@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: msysgit+bncCN2hpKqZChCfk_78BBoE7_OfmQ@googlegroups.com Tue May 01 08:58:40 2012
Return-path: <msysgit+bncCN2hpKqZChCfk_78BBoE7_OfmQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vb0-f58.google.com ([209.85.212.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCN2hpKqZChCfk_78BBoE7_OfmQ@googlegroups.com>)
	id 1SP72m-0002Hw-Da
	for gcvm-msysgit@m.gmane.org; Tue, 01 May 2012 08:58:40 +0200
Received: by vbal1 with SMTP id l1sf3903501vba.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 30 Apr 2012 23:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=LtVwopKjjVnCm3o26v3bcXqyPvOkvaefeM4nbrYBGOE=;
        b=QbDt6l+sxhjHvXWohaNhqzgiFxO8qi1SKX2/VFbeDF5J1ylp7ImMvMMSmS1/ConKEa
         BxPVwtqDkvZrS3PiqJMIzSdBdH9B9o3fjKEs5kQJJOzcom2DyY5QZwZRjGnTbI78g9VB
         I8fkis07Tca2uqIW4fBTMCGLb6QCkBD9YoFtE=
Received: by 10.50.216.133 with SMTP id oq5mr112841igc.4.1335855519190;
        Mon, 30 Apr 2012 23:58:39 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.181.201 with SMTP id dy9ls2824859igc.1.gmail; Mon, 30 Apr
 2012 23:58:37 -0700 (PDT)
Received: by 10.50.214.102 with SMTP id nz6mr844115igc.4.1335855517691;
        Mon, 30 Apr 2012 23:58:37 -0700 (PDT)
Received: by 10.50.214.102 with SMTP id nz6mr844114igc.4.1335855517681;
        Mon, 30 Apr 2012 23:58:37 -0700 (PDT)
Received: from peff.net (99-108-226-0.lightspeed.iplsin.sbcglobal.net. [99.108.226.0])
        by gmr-mx.google.com with ESMTPS id ar8si7863589igc.2.2012.04.30.23.58.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 30 Apr 2012 23:58:37 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 99.108.226.0 as permitted sender) client-ip=99.108.226.0;
Received: (qmail 697 invoked by uid 107); 1 May 2012 06:58:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 May 2012 02:58:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 May 2012 02:58:33 -0400
In-Reply-To: <20120501010609.GA14715@jupiter.local>
X-Original-Sender: peff@peff.net
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of peff@peff.net designates 99.108.226.0 as permitted sender) smtp.mail=peff@peff.net
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196664>

> I just updated to msysGit 1.7.10 and I noticed I don't see any details
> while pushing (like file upload speed and % completion). Was this
> intentionally removed? If so why?

No, it's a regression. I can reproduce it easily, and it bisects to
Clemens' 01fdc21 (push/fetch/clone --no-progress suppresses progress
output) which went into v1.7.9.2 (and v1.7.10).

The problematic hunk is:

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 71f258e..9df341c 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -58,7 +58,7 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
                argv[i++] = "--thin";
        if (args->use_ofs_delta)
                argv[i++] = "--delta-base-offset";
-       if (args->quiet)
+       if (args->quiet || !args->progress)
                argv[i++] = "-q";
        if (args->progress)
                argv[i++] = "--progress";

which seems wrong to me. In send-pack, args->progress may be unset if we
didn't get a --progress flag on the command line. Shouldn't we be
falling back to isatty in that case (or leaving "-q" unset so that
pack-objects can do so)? Does it need to also be converted into a
tri-state of yes/no/unknown as the other places in that patch were?
Clemens?

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
