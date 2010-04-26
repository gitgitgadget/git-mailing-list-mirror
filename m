From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/4] pretty: Respect --abbrev option
Date: Mon, 26 Apr 2010 05:00:32 -0500
Message-ID: <20100426100032.GE31483@progeny.tock>
References: <1272232579-18895-1-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-2-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-3-git-send-email-wmpalmer@gmail.com>
 <20100426031012.GA29953@progeny.tock>
 <u2i5b9751661004260047n168ad87bx6083fc201bfb21d9@mail.gmail.com>
 <20100426095206.GA31483@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Thomas Rast <trast@student.ethz.ch>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 12:00:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6L6n-0006sQ-JA
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 12:00:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747Ab0DZJ7l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Apr 2010 05:59:41 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:55670 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753710Ab0DZJ7j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 05:59:39 -0400
Received: by pxi17 with SMTP id 17so1510223pxi.19
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 02:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=QURnmKQk+RZ6mXvjwDBJuXnJJm2xqFPxKZBDPsK8saE=;
        b=Q2/OAiu5RwVOlOW3XPK3A56kicsX57O0uFqFlISaiYxtsa4lMaJSQ7tGrdb8b0R6ix
         C6lBP5wOM1hJlLRUe6+6ta3RjxDsqbXqjmN90v3ueopppk18DBXrYzbaegBmzANEugmJ
         gmvS5ZQN7TfMHOw0IrFjCVtguj+SAiJrmE15A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=RxQyhOooSxOR3CqPC0q9TlvguoEpvVpKbvMalzqa/VM0ZEg2LE6rm/XB4UUTB/qW7T
         tAqXsS0ziQq9p3hRW2lFBuLCeJe39YsAlt1hnxikID8CiMH5vzsmGE9yQCUAUIYIka7X
         3Bm5bs+mt0iO5RVLRk3cD9ubhTl/UTqRmgaGE=
Received: by 10.142.207.11 with SMTP id e11mr1681108wfg.93.1272275979256;
        Mon, 26 Apr 2010 02:59:39 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm3020904iwn.11.2010.04.26.02.59.38
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Apr 2010 02:59:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100426095206.GA31483@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145805>

=46rom: Will Palmer <wmpalmer@gmail.com>

Prior to this, the output of git log -1 --format=3D%h was always 7
characters long, without regard to whether --abbrev had been passed.

Signed-off-by: Will Palmer <wmpalmer@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That=E2=80=99s the end of the series.  Thanks for reading.

 builtin/shortlog.c         |    3 ++-
 pretty.c                   |    7 ++++---
 shortlog.h                 |    1 +
 t/t4201-shortlog.sh        |    2 +-
 t/t6006-rev-list-format.sh |   19 +++++++++++++++++++
 5 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 06320f5..5089502 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -162,7 +162,7 @@ void shortlog_add_commit(struct shortlog *log, stru=
ct commit *commit)
 		    sha1_to_hex(commit->object.sha1));
 	if (log->user_format) {
 		struct pretty_print_context ctx =3D {0};
-		ctx.abbrev =3D DEFAULT_ABBREV;
+		ctx.abbrev =3D log->abbrev;
 		ctx.subject =3D "";
 		ctx.after_subject =3D "";
 		ctx.date_mode =3D DATE_NORMAL;
@@ -290,6 +290,7 @@ parse_done:
 	}
=20
 	log.user_format =3D rev.commit_format =3D=3D CMIT_FMT_USERFORMAT;
+	log.abbrev =3D rev.abbrev;
=20
 	/* assume HEAD if from a tty */
 	if (!nongit && !rev.pending.nr && isatty(0))
diff --git a/pretty.c b/pretty.c
index 7cb3a2a..1430616 100644
--- a/pretty.c
+++ b/pretty.c
@@ -716,7 +716,7 @@ static size_t format_commit_one(struct strbuf *sb, =
const char *placeholder,
 		if (add_again(sb, &c->abbrev_commit_hash))
 			return 1;
 		strbuf_addstr(sb, find_unique_abbrev(commit->object.sha1,
-		                                     DEFAULT_ABBREV));
+		                                     c->pretty_ctx->abbrev));
 		c->abbrev_commit_hash.len =3D sb->len - c->abbrev_commit_hash.off;
 		return 1;
 	case 'T':		/* tree hash */
@@ -726,7 +726,7 @@ static size_t format_commit_one(struct strbuf *sb, =
const char *placeholder,
 		if (add_again(sb, &c->abbrev_tree_hash))
 			return 1;
 		strbuf_addstr(sb, find_unique_abbrev(commit->tree->object.sha1,
-		                                     DEFAULT_ABBREV));
+		                                     c->pretty_ctx->abbrev));
 		c->abbrev_tree_hash.len =3D sb->len - c->abbrev_tree_hash.off;
 		return 1;
 	case 'P':		/* parent hashes */
@@ -743,7 +743,8 @@ static size_t format_commit_one(struct strbuf *sb, =
const char *placeholder,
 			if (p !=3D commit->parents)
 				strbuf_addch(sb, ' ');
 			strbuf_addstr(sb, find_unique_abbrev(
-					p->item->object.sha1, DEFAULT_ABBREV));
+					p->item->object.sha1,
+					c->pretty_ctx->abbrev));
 		}
 		c->abbrev_parent_hashes.len =3D sb->len -
 		                              c->abbrev_parent_hashes.off;
diff --git a/shortlog.h b/shortlog.h
index bc02cc2..de4f86f 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -12,6 +12,7 @@ struct shortlog {
 	int in1;
 	int in2;
 	int user_format;
+	int abbrev;
=20
 	char *common_repo_prefix;
 	int email;
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 899ddbe..c49ca98 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -79,7 +79,7 @@ test_expect_success 'pretty format' '
 	test_cmp expect log.predictable
 '
=20
-test_expect_failure '--abbrev' '
+test_expect_success '--abbrev' '
 	sed s/SUBJECT/OBJID/ expect.template >expect &&
 	git shortlog --format=3D"%h" --abbrev=3D5 >log &&
 	fuzz log >log.predictable &&
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index a49b7c5..dd9b3b9 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -191,6 +191,19 @@ test_expect_success 'add LF before non-empty (2)' =
'
 	grep "^$" actual
 '
=20
+test_expect_success '--abbrev' '
+	echo SHORT SHORT SHORT >expect2 &&
+	echo LONG LONG LONG >expect3 &&
+	git log -1 --format=3D"%h %h %h" HEAD >actual1 &&
+	git log -1 --abbrev=3D5 --format=3D"%h %h %h" HEAD >actual2 &&
+	git log -1 --abbrev=3D5 --format=3D"%H %H %H" HEAD >actual3 &&
+	sed -e "s/$_x40/LONG/g" -e "s/$_x05/SHORT/g" <actual2 >fuzzy2 &&
+	sed -e "s/$_x40/LONG/g" -e "s/$_x05/SHORT/g" <actual3 >fuzzy3 &&
+	test_cmp expect2 fuzzy2 &&
+	test_cmp expect3 fuzzy3 &&
+	! test_cmp actual1 actual2
+'
+
 test_expect_success '"%h %gD: %gs" is same as git-reflog' '
 	git reflog >expect &&
 	git log -g --format=3D"%h %gD: %gs" >actual &&
@@ -203,6 +216,12 @@ test_expect_success '"%h %gD: %gs" is same as git-=
reflog (with date)' '
 	test_cmp expect actual
 '
=20
+test_expect_success '"%h %gD: %gs" is same as git-reflog (with --abbre=
v)' '
+	git reflog --abbrev=3D13 --date=3Draw >expect &&
+	git log -g --abbrev=3D13 --format=3D"%h %gD: %gs" --date=3Draw >actua=
l &&
+	test_cmp expect actual
+'
+
 test_expect_success '%gd shortens ref name' '
 	echo "master@{0}" >expect.gd-short &&
 	git log -g -1 --format=3D%gd refs/heads/master >actual.gd-short &&
--=20
1.7.1.3.g5f1e.dirty
