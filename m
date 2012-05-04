From: Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>
Subject: [PATCH 2/4] log: respect date_mode_explicit with --format:%gd
Date: Fri, 4 May 2012 01:25:18 -0400
Message-ID: <20120504052518.GB16107@sigill.intra.peff.net>
References: <20120504052106.GA15970@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yann Hodique <yann.hodique-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Andreas Schwab <schwab-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Eli Barzilay <eli-oSK4jVRJLyZg9hUCZPvPmw@public.gmane.org>
X-From: magit+bncCN2hpKqZChDB0I39BBoExDoz2Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Fri May 04 07:25:24 2012
Return-path: <magit+bncCN2hpKqZChDB0I39BBoExDoz2Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvgm-magit-3@m.gmane.org
Received: from mail-vc0-f186.google.com ([209.85.220.186] helo=mail-vx0-f186.google.com)
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <magit+bncCN2hpKqZChDB0I39BBoExDoz2Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1SQB18-00008i-VK
	for gcvgm-magit-3@m.gmane.org; Fri, 04 May 2012 07:25:23 +0200
Received: by vcbfo14 with SMTP id fo14sf2570687vcb.3
        for <gcvgm-magit-3@m.gmane.org>; Thu, 03 May 2012 22:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=DLEjDwQEP/+STQoKpWODpNTeR7mljCXSPFupaO8V0AE=;
        b=RJQCbkJfZOlUJYLKUTGvoRY6ElLg1gs1pqYUO+ulPh7KhzUUYAoVXatiQczDqPS09P
         pNJd1d8kOaUzuJpyjs5RInwIdOH1l6V0bxU6/vV5nx7pKLw1CnIjzSUcb5Dz7pkQ/E7k
         E3r43NoUk/33Gnemc1eQ8Vpf+ObW+Lhfe7fCM=
Received: by 10.50.179.72 with SMTP id de8mr305310igc.2.1336109121848;
        Thu, 03 May 2012 22:25:21 -0700 (PDT)
X-BeenThere: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.50.168.41 with SMTP id zt9ls666749igb.0.gmail; Thu, 03 May
 2012 22:25:21 -0700 (PDT)
Received: by 10.42.94.129 with SMTP id b1mr3545514icn.1.1336109121372;
        Thu, 03 May 2012 22:25:21 -0700 (PDT)
Received: by 10.42.94.129 with SMTP id b1mr3545513icn.1.1336109121361;
        Thu, 03 May 2012 22:25:21 -0700 (PDT)
Received: from peff.net (99-108-226-0.lightspeed.iplsin.sbcglobal.net. [99.108.226.0])
        by gmr-mx.google.com with ESMTPS id no9si918445igc.0.2012.05.03.22.25.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 May 2012 22:25:21 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff-AdEPDUrAXsQ@public.gmane.org designates 99.108.226.0 as permitted sender) client-ip=99.108.226.0;
Received: (qmail 15125 invoked by uid 107); 4 May 2012 05:25:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 04 May 2012 01:25:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 May 2012 01:25:18 -0400
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196990>

When we show a reflog selector (e.g., via "git log -g"), we
perform some DWIM magic: while we normally show the entry's
index (e.g., HEAD@{1}), if the user has given us a date
with "--date", then we show a date-based select (e.g.,
HEAD@{yesterday}).

However, we don't want to trigger this magic if the
alternate date format we got was from the "log.date"
configuration; that is not sufficiently strong context for
us to invoke this particular magic. To fix this, commit
f4ea32f (improve reflog date/number heuristic, 2009-09-24)
introduced a "date_mode_explicit" flag in rev_info. This
flag is set only when we see a "--date" option on the
command line, and we a vanilla date to the reflog code if
the date was not explicit.

Later, commit 8f8f547 (Introduce new pretty formats %g[sdD]
for reflog information, 2009-10-19) added another way to
show selectors, and it did not respect the date_mode_explicit
flag from f4ea32f.

This patch propagates the date_mode_explicit flag to the
pretty-print code, which can then use it to pass the
appropriate date field to the reflog code. This brings the
behavior of "%gd" in line with the other formats, and means
that its output is independent of any user configuration.

Signed-off-by: Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>
---
I'm not happy that users of pretty_print_context have to manually
remember to copy in the date_mode_explicit flag; it would be nice if it
just came with the date_mode field for free. But that would mean
changing the type of date_mode to hold the extra bit, and would disrupt
callers all over the code base.

 builtin/rev-list.c     | 1 +
 commit.h               | 1 +
 log-tree.c             | 1 +
 pretty.c               | 4 +++-
 t/t1411-reflog-show.sh | 2 +-
 5 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 4c4d404..ff5a383 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -109,6 +109,7 @@ static void show_commit(struct commit *commit, void *data)
 		struct pretty_print_context ctx = {0};
 		ctx.abbrev = revs->abbrev;
 		ctx.date_mode = revs->date_mode;
+		ctx.date_mode_explicit = revs->date_mode_explicit;
 		ctx.fmt = revs->commit_format;
 		pretty_print_commit(&ctx, commit, &buf);
 		if (revs->graph) {
diff --git a/commit.h b/commit.h
index ccaa20b..d617fa3 100644
--- a/commit.h
+++ b/commit.h
@@ -84,6 +84,7 @@ struct pretty_print_context {
 	const char *after_subject;
 	int preserve_subject;
 	enum date_mode date_mode;
+	unsigned date_mode_explicit:1;
 	int need_8bit_cte;
 	int show_notes;
 	struct reflog_walk_info *reflog_info;
diff --git a/log-tree.c b/log-tree.c
index 34c49e7..634f142 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -652,6 +652,7 @@ void show_log(struct rev_info *opt)
 	if (ctx.need_8bit_cte >= 0)
 		ctx.need_8bit_cte = has_non_ascii(opt->add_signoff);
 	ctx.date_mode = opt->date_mode;
+	ctx.date_mode_explicit = opt->date_mode_explicit;
 	ctx.abbrev = opt->diffopt.abbrev;
 	ctx.after_subject = extra_headers;
 	ctx.preserve_subject = opt->preserve_subject;
diff --git a/pretty.c b/pretty.c
index f2dee30..2bc64b3 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1009,7 +1009,9 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 			if (c->pretty_ctx->reflog_info)
 				get_reflog_selector(sb,
 						    c->pretty_ctx->reflog_info,
-						    c->pretty_ctx->date_mode,
+						    c->pretty_ctx->date_mode_explicit ?
+						      c->pretty_ctx->date_mode :
+						      DATE_NORMAL,
 						    (placeholder[1] == 'd'));
 			return 2;
 		case 's':	/* reflog message */
diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
index 4706f4c..88247f8 100755
--- a/t/t1411-reflog-show.sh
+++ b/t/t1411-reflog-show.sh
@@ -121,7 +121,7 @@ test_expect_success 'log.date does not invoke "--date" magic (oneline)' '
 cat >expect <<'EOF'
 HEAD@{0}
 EOF
-test_expect_failure 'log.date does not invoke "--date" magic (format=%gd)' '
+test_expect_success 'log.date does not invoke "--date" magic (format=%gd)' '
 	test_config log.date raw &&
 	git log -g -1 --format=%gd >actual &&
 	test_cmp expect actual
-- 
1.7.10.1.10.ge534bc3
