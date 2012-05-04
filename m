From: Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>
Subject: [PATCH 4/4] reflog-walk: always make HEAD@{0} show indexed selectors
Date: Fri, 4 May 2012 01:27:25 -0400
Message-ID: <20120504052725.GD16107@sigill.intra.peff.net>
References: <20120504052106.GA15970@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yann Hodique <yann.hodique-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Andreas Schwab <schwab-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Eli Barzilay <eli-oSK4jVRJLyZg9hUCZPvPmw@public.gmane.org>
X-From: magit+bncCN2hpKqZChDA0Y39BBoEx_AewA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Fri May 04 07:27:30 2012
Return-path: <magit+bncCN2hpKqZChDA0Y39BBoEx_AewA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvgm-magit-3@m.gmane.org
Received: from mail-qa0-f55.google.com ([209.85.216.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <magit+bncCN2hpKqZChDA0Y39BBoEx_AewA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1SQB3B-0001eZ-Pa
	for gcvgm-magit-3@m.gmane.org; Fri, 04 May 2012 07:27:30 +0200
Received: by qabg40 with SMTP id g40sf1248274qab.10
        for <gcvgm-magit-3@m.gmane.org>; Thu, 03 May 2012 22:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=TyZ0VWUe1wTLwhhuAQP+8FmDNw0foKOhxou4mSWc/6g=;
        b=3QfXBPwQk4t36PguDafSN8XubEPXts2wVAKLP/5E02+UUg4cMM4raS/1BGGUBz7xU8
         ZGR6Hk0rbGYA4i2O6dN0+Ku24WgD2ll2YoQ0CdRXeJaHF83+LpU0muODmfV8mhTFsvrn
         2ML9lF5n+qhnaJ3AXy2Le1/BShXNrLJyHEbEI=
Received: by 10.50.179.72 with SMTP id de8mr305762igc.2.1336109248455;
        Thu, 03 May 2012 22:27:28 -0700 (PDT)
X-BeenThere: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.50.151.199 with SMTP id us7ls668512igb.1.canary; Thu, 03 May
 2012 22:27:28 -0700 (PDT)
Received: by 10.50.85.196 with SMTP id j4mr2937767igz.4.1336109248033;
        Thu, 03 May 2012 22:27:28 -0700 (PDT)
Received: by 10.50.85.196 with SMTP id j4mr2937765igz.4.1336109248021;
        Thu, 03 May 2012 22:27:28 -0700 (PDT)
Received: from peff.net (99-108-226-0.lightspeed.iplsin.sbcglobal.net. [99.108.226.0])
        by gmr-mx.google.com with ESMTPS id eo1si952542igc.0.2012.05.03.22.27.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 May 2012 22:27:28 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff-AdEPDUrAXsQ@public.gmane.org designates 99.108.226.0 as permitted sender) client-ip=99.108.226.0;
Received: (qmail 15191 invoked by uid 107); 4 May 2012 05:27:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 04 May 2012 01:27:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 May 2012 01:27:25 -0400
In-Reply-To: <20120504052106.GA15970-bBVMEuqLR+SYVEpFpFwlB0AkDMvbqDRI@public.gmane.org>
X-Original-Sender: peff-AdEPDUrAXsQ@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of peff-AdEPDUrAXsQ@public.gmane.org designates 99.108.226.0 as permitted sender) smtp.mail=peff-AdEPDUrAXsQ@public.gmane.org
Precedence: list
Mailing-list: list magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; contact magit+owners-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-ID: <magit.googlegroups.com>
X-Google-Group-Id: 752745291123
List-Post: <http://groups.google.com/group/magit/post?hl=en_US>, <mailto:magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:magit+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/magit?hl=en_US>
Sender: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/magit/subscribe?hl=en_US>, <mailto:magit+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/magit/subscribe?hl=en_US>, <mailto:googlegroups-manage+752745291123+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196992>

When we are showing reflog selectors during a walk, we infer
from context whether the user wanted to see the index in
each selector, or the reflog date. The current rules are:

  1. if the user asked for an explicit date format in the
     output, show the date

  2. if the user asked for ref@{now}, show the date

  3. if neither is true, show the index

However,  if we see "ref@{0}", that should be a strong clue
that the user wants to see the counted version. In fact, it
should be much stronger than the date format in (1). The
user may have been setting the date format to use in another
part of the output (e.g., in --format="%gd (%ad)", they may
have wanted to influence the author date).

This patch flips the rules to:

  1. if the user asked for ref@{0}, always show the index

  2. if the user asked for ref@{now}, always show the date

  3. otherwise, we have just "ref"; show them counted by
     default, but respect the presence of "--date" as a clue
     that the user wanted them date-based

Signed-off-by: Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>
---
 reflog-walk.c          | 3 ++-
 t/t1411-reflog-show.sh | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index 3549318..b974258 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -276,7 +276,8 @@ void get_reflog_selector(struct strbuf *sb,
 	}
 
 	strbuf_addf(sb, "%s@{", printed_ref);
-	if (commit_reflog->selector == SELECTOR_DATE || dmode) {
+	if (commit_reflog->selector == SELECTOR_DATE ||
+	    (commit_reflog->selector == SELECTOR_NONE && dmode)) {
 		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
 		strbuf_addstr(sb, show_date(info->timestamp, info->tz, dmode));
 	} else {
diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
index 88247f8..7d9b5e3 100755
--- a/t/t1411-reflog-show.sh
+++ b/t/t1411-reflog-show.sh
@@ -127,6 +127,14 @@ test_expect_success 'log.date does not invoke "--date" magic (format=%gd)' '
 	test_cmp expect actual
 '
 
+cat >expect <<'EOF'
+HEAD@{0}
+EOF
+test_expect_success '--date magic does not override explicit @{0} syntax' '
+	git log -g -1 --format=%gd --date=raw HEAD@{0} >actual &&
+	test_cmp expect actual
+'
+
 : >expect
 test_expect_success 'empty reflog file' '
 	git branch empty &&
-- 
1.7.10.1.10.ge534bc3
