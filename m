From: Jeff King <peff@peff.net>
Subject: [PATCH] t/lib-httpd: switch SANITY check for NOT_ROOT
Date: Thu, 15 Jan 2015 20:32:56 -0500
Message-ID: <20150116013256.GA25894@peff.net>
References: <54B68D99.2040906@web.de>
 <xmqqmw5l9pje.fsf@gitster.dls.corp.google.com>
 <54B6C897.5030405@web.de>
 <20150114211712.GE1155@peff.net>
 <064010B3-BC58-42F2-B5C0-DAADAA59B87D@gmail.com>
 <xmqqwq4n6b4c.fsf@gitster.dls.corp.google.com>
 <20150115222719.GA19021@peff.net>
 <xmqqa91j6537.fsf@gitster.dls.corp.google.com>
 <20150115235752.GB25120@peff.net>
 <xmqqh9vr4mlz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: msysgit@googlegroups.com, "Kyle J. McKay" <mackyle@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBDO2DJFKTEFBBTGU4GSQKGQEOAQKGAA@googlegroups.com Fri Jan 16 02:33:01 2015
Return-path: <msysgit+bncBDO2DJFKTEFBBTGU4GSQKGQEOAQKGAA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f192.google.com ([209.85.214.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBTGU4GSQKGQEOAQKGAA@googlegroups.com>)
	id 1YBvmX-0001TV-39
	for gcvm-msysgit@m.gmane.org; Fri, 16 Jan 2015 02:33:01 +0100
Received: by mail-ob0-f192.google.com with SMTP id va8sf1750110obc.9
        for <gcvm-msysgit@m.gmane.org>; Thu, 15 Jan 2015 17:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=q1ECLgbq+OGliY8flVQ+4OvJJKbs0i/5M9zdMQAFj94=;
        b=f0uMxeobNC+dhvWTbehmkEnbknq0HStCIUt8Yu7sUtz4G2wpRrvT/ErG4wzaB9qqhJ
         12PhyB5DYRXERwSJX8bX0Qn21m/SdW09B/wTpmwdQyj/80/Y4/3H+KBebZ+XiZFcuwbY
         QOMqXBA6HMP6404Zhvm8q9KuHCdW/Hz94ZOQocAsEdhRpvW+qV14DXSBlYqEueglibzk
         T9k1zKVyUWJMK1PHJQptWfI4g2jlrRzyWta9kyeBIBdOZItfIb2VocIEogBWIl02iMV3
         4wNJ1Kh+xVS0fQTMyYo3W74e2Tvi80MPgw2dKxyHQaEqHIe9OxeZrOwtu7su0FrqF5sw
         EYWA==
X-Received: by 10.140.22.48 with SMTP id 45mr243788qgm.5.1421371980388;
        Thu, 15 Jan 2015 17:33:00 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.100.183 with SMTP id s52ls1267523qge.25.gmail; Thu, 15 Jan
 2015 17:32:59 -0800 (PST)
X-Received: by 10.224.26.139 with SMTP id e11mr10170436qac.6.1421371979903;
        Thu, 15 Jan 2015 17:32:59 -0800 (PST)
Received: from cloud.peff.net (cloud.peff.net. [50.56.180.127])
        by gmr-mx.google.com with SMTP id u2si102992igh.0.2015.01.15.17.32.59
        for <msysgit@googlegroups.com>;
        Thu, 15 Jan 2015 17:32:59 -0800 (PST)
Received-SPF: pass (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted sender) client-ip=50.56.180.127;
Received: (qmail 13232 invoked by uid 102); 16 Jan 2015 01:32:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 19:32:59 -0600
Received: (qmail 19044 invoked by uid 107); 16 Jan 2015 01:33:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 20:33:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jan 2015 20:32:56 -0500
Content-Disposition: inline
In-Reply-To: <xmqqh9vr4mlz.fsf@gitster.dls.corp.google.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262535>

On Thu, Jan 15, 2015 at 04:04:24PM -0800, Junio C Hamano wrote:

> I wondered what 'perl -e 'print $>' would say in mingw, and if that
> is portable enough, though.

Good thinking. I guess the best way to find out is to convince somebody
from msysgit to try this patch. :)

We may simply find that nobody there even has apache installed on their
box, and they do not run the http tests at all.

-- >8 --
The SANITY prerequisite is really about whether the
filesystem will respect the permissions we set, and being
root is only one part of that. But the httpd tests really
just care about not being root, as they are trying to avoid
weirdness in apache (see a1a3011 for details).

Let's switch out SANITY for a new NOT_ROOT prerequisite,
which will let us tweak SANITY more freely.

We implement NOT_ROOT by checking perl's "$>" variable,
since we cannot rely on the "id" program being available
everywhere (and we would rather avoid writing a custom C
program to run geteuid if we can).

Note that we cannot just call this "ROOT" and ask for
"!ROOT". The possible outcomes are:

  1. we know we are root

  2. we know we are not root

  3. we could not tell, because perl was not installed or
     barfed showing us $>

We should conservatively treat (3) as "does not have the
prerequisite", which means that a naive negation would not
work.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-httpd.sh | 2 +-
 t/test-lib.sh  | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index fd53b57..d154d1e 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -37,7 +37,7 @@ then
 	test_done
 fi
 
-if ! test_have_prereq SANITY; then
+if ! test_have_prereq NOT_ROOT; then
 	test_skip_or_die $GIT_TEST_HTTPD \
 		"Cannot run httpd tests as root"
 fi
diff --git a/t/test-lib.sh b/t/test-lib.sh
index bb1402d..60020ca 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1040,3 +1040,8 @@ test_lazy_prereq UNZIP '
 	"$GIT_UNZIP" -v
 	test $? -ne 127
 '
+
+test_lazy_prereq NOT_ROOT '
+	uid=$(perl -e "print \$<") &&
+	test "$uid" != 0
+'
-- 
2.2.1.425.g441bb3c

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
