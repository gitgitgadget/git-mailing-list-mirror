From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Re: Teach mailinfo to ignore everything before -- >8 --
 mark
Date: Mon, 24 Aug 2009 15:17:49 -0700
Message-ID: <7v3a7g501e.fsf@alter.siamese.dyndns.org>
References: <1250999285-10683-1-git-send-email-git@tbfowler.name>
 <1250999357-10827-3-git-send-email-git@tbfowler.name>
 <7vvdkfx8rl.fsf@alter.siamese.dyndns.org>
 <20090823171819.6117@nanako3.lavabit.com>
 <7v1vn2yklo.fsf@alter.siamese.dyndns.org>
 <20090824060708.6117@nanako3.lavabit.com>
 <alpine.DEB.2.00.0908231705200.29625@GWPortableVCS>
 <7v7hwurwmu.fsf@alter.siamese.dyndns.org> <20090824041608.GC3526@vidovic>
 <20090824141623.6117@nanako3.lavabit.com> <20090824071711.GE3526@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Thell Fowler <git@tbfowler.name>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Tue Aug 25 00:18:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfhrk-0003y7-Np
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 00:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495AbZHXWSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 18:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753476AbZHXWSF
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 18:18:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62038 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936AbZHXWSD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 18:18:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EB2D179DD;
	Mon, 24 Aug 2009 18:18:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=KGoPNC4kaoPOF4eoUAYwUPvXpLU=; b=IvaYfBjb+ROO2LSD798SBux
	PLTvfJK7uJZAhX7r1NOLXW64RVrhziCgCK7tMubmXySvTB/AkRJqqCMpVHMbvAHf
	1Nly8tEH6w0yx2WDicf9MN9mGhxeaF1ux8hWtcZLHcjKPty70TX/8q8q4XosdNW/
	/r0EmFikeLEXMy4x2NrE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=wBHEPBROM0xX4kyI7GYTS/7DJWEoy2c3irrRz1YimgMl7Jxbp
	bniCasos9ksrNZCDIPmf5hJbrCiJ95zgNGYT1NCNEDmQPtvaODg71eYcqF3gqPLq
	OgnhBz96fY5mWqmmnJxAyT9BCGYFS68umiC7QTDqjmQEudykXgZvmcOJDI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 507D5179DA;
	Mon, 24 Aug 2009 18:17:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 04199179D9; Mon, 24 Aug
 2009 18:17:50 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FB2E780A-90FB-11DE-A92C-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126976>

Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:

> ... But isn't the following mark a bit
> too much permissive?
>
> ->8

Yeah, I agree that we should require a bit longer perforation, and perhaps
we should tighten the rules a bit, while at the same time not limiting the
request to cut to the exact phrase "cut here".  As you pointed out, we do
not want to be too lenient to allow misidentification, but at the same
time it is nicer to be accomodating and treat something like this as a
scissors line:

    - - - >8 - - - remove everything above this line - - - >8 - - -

I think we have bikeshedded long enough, so I won't be touching this code
any further only to change the definition of what a scissors mark looks
like, but here is what I did during lunch break, with another comment
added later to hint what s_hdr_data[] stands for after reading response
from Don Zickus.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Teach mailinfo to ignore everything before -- >8 -- mark

This teaches mailinfo the scissors -- >8 -- mark; the command ignores
everything before it in the message body.

For lefties among us, we also support -- 8< -- ;-)

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-mailinfo.c  |   71 ++++++++++++++++++++++++++++++++++++++++-
 t/t5100-mailinfo.sh |    2 +-
 t/t5100/info0014    |    5 +++
 t/t5100/msg0014     |    4 ++
 t/t5100/patch0014   |   64 ++++++++++++++++++++++++++++++++++++
 t/t5100/sample.mbox |   89 +++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 233 insertions(+), 2 deletions(-)
 create mode 100644 t/t5100/info0014
 create mode 100644 t/t5100/msg0014
 create mode 100644 t/t5100/patch0014

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index b0b5d8f..7e09b51 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -712,6 +712,56 @@ static inline int patchbreak(const struct strbuf *line)
 	return 0;
 }
 
+static int is_scissors_line(const struct strbuf *line)
+{
+	size_t i, len = line->len;
+	int scissors = 0, gap = 0;
+	int first_nonblank = -1;
+	int last_nonblank = 0, visible, perforation, in_perforation = 0;
+	const char *buf = line->buf;
+
+	for (i = 0; i < len; i++) {
+		if (isspace(buf[i])) {
+			if (in_perforation) {
+				perforation++;
+				gap++;
+			}
+			continue;
+		}
+		last_nonblank = i;
+		if (first_nonblank < 0)
+			first_nonblank = i;
+		if (buf[i] == '-') {
+			in_perforation = 1;
+			perforation++;
+			continue;
+		}
+		if (i + 1 < len &&
+		    (!memcmp(buf + i, ">8", 2) || !memcmp(buf + i, "8<", 2))) {
+			in_perforation = 1;
+			perforation += 2;
+			scissors += 2;
+			i++;
+			continue;
+		}
+		in_perforation = 0;
+	}
+
+	/*
+	 * The mark must be at least 8 bytes long (e.g. "-- >8 --").
+	 * Even though there can be arbitrary cruft on the same line
+	 * (e.g. "cut here"), in order to avoid misidentification, the
+	 * perforation must occupy more than a third of the visible
+	 * width of the line, and dashes and scissors must occupy more
+	 * than half of the perforation.
+	 */
+
+	visible = last_nonblank - first_nonblank + 1;
+	return (scissors && 8 <= visible &&
+		visible < perforation * 3 &&
+		gap * 2 < perforation);
+}
+
 static int handle_commit_msg(struct strbuf *line)
 {
 	static int still_looking = 1;
@@ -723,7 +773,8 @@ static int handle_commit_msg(struct strbuf *line)
 		strbuf_ltrim(line);
 		if (!line->len)
 			return 0;
-		if ((still_looking = check_header(line, s_hdr_data, 0)) != 0)
+		still_looking = check_header(line, s_hdr_data, 0);
+		if (still_looking)
 			return 0;
 	}
 
@@ -731,6 +782,24 @@ static int handle_commit_msg(struct strbuf *line)
 	if (metainfo_charset)
 		convert_to_utf8(line, charset.buf);
 
+	if (is_scissors_line(line)) {
+		int i;
+		rewind(cmitmsg);
+		ftruncate(fileno(cmitmsg), 0);
+		still_looking = 1;
+
+		/*
+		 * We may have already read "secondary headers"; purge
+		 * them to give ourselves a clean restart.
+		 */
+		for (i = 0; header[i]; i++) {
+			if (s_hdr_data[i])
+				strbuf_release(s_hdr_data[i]);
+			s_hdr_data[i] = NULL;
+		}
+		return 0;
+	}
+
 	if (patchbreak(line)) {
 		fclose(cmitmsg);
 		cmitmsg = NULL;
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index e70ea94..e848556 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -11,7 +11,7 @@ test_expect_success 'split sample box' \
 	'git mailsplit -o. "$TEST_DIRECTORY"/t5100/sample.mbox >last &&
 	last=`cat last` &&
 	echo total is $last &&
-	test `cat last` = 13'
+	test `cat last` = 14'
 
 for mail in `echo 00*`
 do
diff --git a/t/t5100/info0014 b/t/t5100/info0014
new file mode 100644
index 0000000..ab9c8d0
--- /dev/null
+++ b/t/t5100/info0014
@@ -0,0 +1,5 @@
+Author: Junio C Hamano
+Email: gitster@pobox.com
+Subject: Teach mailinfo to ignore everything before -- >8 -- mark
+Date: Thu, 20 Aug 2009 17:18:22 -0700
+
diff --git a/t/t5100/msg0014 b/t/t5100/msg0014
new file mode 100644
index 0000000..259c6a4
--- /dev/null
+++ b/t/t5100/msg0014
@@ -0,0 +1,4 @@
+This teaches mailinfo the scissors -- >8 -- mark; the command ignores
+everything before it in the message body.
+
+Signed-off-by: Junio C Hamano <gitster@pobox.com>
diff --git a/t/t5100/patch0014 b/t/t5100/patch0014
new file mode 100644
index 0000000..124efd2
--- /dev/null
+++ b/t/t5100/patch0014
@@ -0,0 +1,64 @@
+---
+ builtin-mailinfo.c |   37 ++++++++++++++++++++++++++++++++++++-
+ 1 files changed, 36 insertions(+), 1 deletions(-)
+
+diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
+index b0b5d8f..461c47e 100644
+--- a/builtin-mailinfo.c
++++ b/builtin-mailinfo.c
+@@ -712,6 +712,34 @@ static inline int patchbreak(const struct strbuf *line)
+ 	return 0;
+ }
+ 
++static int scissors(const struct strbuf *line)
++{
++	size_t i, len = line->len;
++	int scissors_dashes_seen = 0;
++	const char *buf = line->buf;
++
++	for (i = 0; i < len; i++) {
++		if (isspace(buf[i]))
++			continue;
++		if (buf[i] == '-') {
++			scissors_dashes_seen |= 02;
++			continue;
++		}
++		if (i + 1 < len && !memcmp(buf + i, ">8", 2)) {
++			scissors_dashes_seen |= 01;
++			i++;
++			continue;
++		}
++		if (i + 7 < len && !memcmp(buf + i, "cut here", 8)) {
++			i += 7;
++			continue;
++		}
++		/* everything else --- not scissors */
++		break;
++	}
++	return scissors_dashes_seen == 03;
++}
++
+ static int handle_commit_msg(struct strbuf *line)
+ {
+ 	static int still_looking = 1;
+@@ -723,10 +751,17 @@ static int handle_commit_msg(struct strbuf *line)
+ 		strbuf_ltrim(line);
+ 		if (!line->len)
+ 			return 0;
+-		if ((still_looking = check_header(line, s_hdr_data, 0)) != 0)
++		still_looking = check_header(line, s_hdr_data, 0);
++		if (still_looking)
+ 			return 0;
+ 	}
+ 
++	if (scissors(line)) {
++		fseek(cmitmsg, 0L, SEEK_SET);
++		still_looking = 1;
++		return 0;
++	}
++
+ 	/* normalize the log message to UTF-8. */
+ 	if (metainfo_charset)
+ 		convert_to_utf8(line, charset.buf);
+-- 
+1.6.4.1
diff --git a/t/t5100/sample.mbox b/t/t5100/sample.mbox
index c3074ac..13fa4ae 100644
--- a/t/t5100/sample.mbox
+++ b/t/t5100/sample.mbox
@@ -561,3 +561,92 @@ From: <a.u.thor@example.com> (A U Thor)
 Date: Fri, 9 Jun 2006 00:44:16 -0700
 Subject: [PATCH] a patch
 
+From nobody Mon Sep 17 00:00:00 2001
+From: Junio Hamano <junkio@cox.net>
+Date: Thu, 20 Aug 2009 17:18:22 -0700
+Subject: Why doesn't git-am does not like >8 scissors mark?
+
+Subject: [PATCH] BLAH ONE
+
+In real life, we will see a discussion that inspired this patch
+discussing related and unrelated things around >8 scissors mark
+in this part of the message.
+
+Subject: [PATCH] BLAH TWO
+
+And then we will see the scissors.
+
+ This line is not a scissors mark -- >8 -- but talks about it.
+ - - >8 - - please remove everything above this line - - >8 - -
+
+Subject: [PATCH] Teach mailinfo to ignore everything before -- >8 -- mark
+From: Junio C Hamano <gitster@pobox.com>
+
+This teaches mailinfo the scissors -- >8 -- mark; the command ignores
+everything before it in the message body.
+
+Signed-off-by: Junio C Hamano <gitster@pobox.com>
+---
+ builtin-mailinfo.c |   37 ++++++++++++++++++++++++++++++++++++-
+ 1 files changed, 36 insertions(+), 1 deletions(-)
+
+diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
+index b0b5d8f..461c47e 100644
+--- a/builtin-mailinfo.c
++++ b/builtin-mailinfo.c
+@@ -712,6 +712,34 @@ static inline int patchbreak(const struct strbuf *line)
+ 	return 0;
+ }
+ 
++static int scissors(const struct strbuf *line)
++{
++	size_t i, len = line->len;
++	int scissors_dashes_seen = 0;
++	const char *buf = line->buf;
++
++	for (i = 0; i < len; i++) {
++		if (isspace(buf[i]))
++			continue;
++		if (buf[i] == '-') {
++			scissors_dashes_seen |= 02;
++			continue;
++		}
++		if (i + 1 < len && !memcmp(buf + i, ">8", 2)) {
++			scissors_dashes_seen |= 01;
++			i++;
++			continue;
++		}
++		if (i + 7 < len && !memcmp(buf + i, "cut here", 8)) {
++			i += 7;
++			continue;
++		}
++		/* everything else --- not scissors */
++		break;
++	}
++	return scissors_dashes_seen == 03;
++}
++
+ static int handle_commit_msg(struct strbuf *line)
+ {
+ 	static int still_looking = 1;
+@@ -723,10 +751,17 @@ static int handle_commit_msg(struct strbuf *line)
+ 		strbuf_ltrim(line);
+ 		if (!line->len)
+ 			return 0;
+-		if ((still_looking = check_header(line, s_hdr_data, 0)) != 0)
++		still_looking = check_header(line, s_hdr_data, 0);
++		if (still_looking)
+ 			return 0;
+ 	}
+ 
++	if (scissors(line)) {
++		fseek(cmitmsg, 0L, SEEK_SET);
++		still_looking = 1;
++		return 0;
++	}
++
+ 	/* normalize the log message to UTF-8. */
+ 	if (metainfo_charset)
+ 		convert_to_utf8(line, charset.buf);
+-- 
+1.6.4.1
-- 
1.6.4.1
