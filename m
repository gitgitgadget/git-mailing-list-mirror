From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH] grep -I: do not bother to read known-binary files
Date: Wed, 14 May 2014 17:44:19 +0200
Organization: <)><
Message-ID: <20140514154419.GA4517@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
        msysGit <msysgit@googlegroups.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBVM6Z2NQKGQEOVGE4XI@googlegroups.com Wed May 14 17:44:27 2014
Return-path: <msysgit+bncBCU63DXMWULRBVM6Z2NQKGQEOVGE4XI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f62.google.com ([74.125.82.62])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBVM6Z2NQKGQEOVGE4XI@googlegroups.com>)
	id 1WkbLy-00050T-Gv
	for gcvm-msysgit@m.gmane.org; Wed, 14 May 2014 17:44:22 +0200
Received: by mail-wg0-f62.google.com with SMTP id n12sf205041wgh.17
        for <gcvm-msysgit@m.gmane.org>; Wed, 14 May 2014 08:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:mime-version:organization
         :user-agent:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=TZqQg5RtY/Yx3hZfbv86pUXAqf1NZgZI68u52CkgF3k=;
        b=GcygPbZBHcnQXr59fzQorEiDjMt+YlN54/E8swK0u0wSwDp1LPwoNm+CkWM4f6CENg
         D1vwvlqc8jNkCLE9enTuS+N9X4JQ7MEmFUnkic7mrQAa5XFhze7mP3rxgrI4H4PuW7+j
         tGR6eF1/kKm3enMck44j2b5qKM6kQqZirZHL/aJ75rF/CK+AVE+vck5ItQ11ZXoTpPII
         Hr494uBf0lZ1ph6cRO4ZRxtSzjWnnQ8guRTfjLCYJECG9dpDq1zxau//IU0Ovz46a5kU
         xaY2X9yCYs7iCcvelcVFIclxweRBYSQCuCU4FIqmSlwyGt7gD56CrZy/rZ8UdcUoa2ft
         dhMg==
X-Received: by 10.152.43.202 with SMTP id y10mr14512lal.33.1400082262258;
        Wed, 14 May 2014 08:44:22 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.29.37 with SMTP id g5ls147669lah.3.gmail; Wed, 14 May 2014
 08:44:21 -0700 (PDT)
X-Received: by 10.112.85.197 with SMTP id j5mr273958lbz.20.1400082261055;
        Wed, 14 May 2014 08:44:21 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id r49si788420eep.0.2014.05.14.08.44.21
        for <msysgit@googlegroups.com>;
        Wed, 14 May 2014 08:44:21 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id B70401C00C4;
	Wed, 14 May 2014 17:44:20 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s4EFiKrW004536;
	Wed, 14 May 2014 17:44:20 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s4EFiJpH004535;
	Wed, 14 May 2014 17:44:19 +0200
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248921>

From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Mon, 8 Nov 2010 16:10:43 +0100

Incidentally, this makes grep -I respect the "binary" attribute (actually,
the "-text" attribute, but "binary" implies that).

Since the attributes are not thread-safe, we now need to switch off
threading if -I was passed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---

Hi,
this patch has been in msysgit for 3.5 years.
Stepan

 builtin/grep.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index 43af5b7..8073fbe 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -18,6 +18,7 @@
 #include "quote.h"
 #include "dir.h"
 #include "pathspec.h"
+#include "attr.h"
 
 static char const * const grep_usage[] = {
 	N_("git grep [options] [-e] <pattern> [<rev>...] [[--] <path>...]"),
@@ -163,6 +164,22 @@ static void work_done(struct work_item *w)
 	grep_unlock();
 }
 
+static int skip_binary(struct grep_opt *opt, const char *filename)
+{
+	if ((opt->binary & GREP_BINARY_NOMATCH)) {
+		static struct git_attr *attr_text;
+		struct git_attr_check check;
+
+		if (!attr_text)
+			attr_text = git_attr("text");
+		memset(&check, 0, sizeof(check));
+		check.attr = attr_text;
+		return !git_check_attr(filename, 1, &check) &&
+				ATTR_FALSE(check.value);
+	}
+	return 0;
+}
+
 static void *run(void *arg)
 {
 	int hit = 0;
@@ -173,6 +190,9 @@ static void *run(void *arg)
 		if (!w)
 			break;
 
+		if (skip_binary(opt, (const char *)w->source.identifier))
+			continue;
+
 		opt->output_priv = w;
 		hit |= grep_source(opt, &w->source);
 		grep_source_clear_data(&w->source);
@@ -379,6 +399,9 @@ static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec, int
 			continue;
 		if (!ce_path_match(ce, pathspec, NULL))
 			continue;
+		if (skip_binary(opt, ce->name))
+			continue;
+
 		/*
 		 * If CE_VALID is on, we assume worktree file and its cache entry
 		 * are identical, even if worktree file has been modified, so use
@@ -803,6 +826,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		string_list_append(&path_list, show_in_pager);
 		use_threads = 0;
 	}
+	if ((opt.binary & GREP_BINARY_NOMATCH))
+		use_threads = 0;
 
 	if (!opt.pattern_list)
 		die(_("no pattern given."));
-- 
1.9.2.msysgit.0.335.gd2a461f

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
