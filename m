From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] pretty-print: de-tabify indented logs to make things line
 up properly
Date: Wed, 16 Mar 2016 09:29:35 -0700 (PDT)
Message-ID: <alpine.LFD.2.20.1603160926060.13030@i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 17:29:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agEKN-0007vx-Ik
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 17:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544AbcCPQ3j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2016 12:29:39 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36332 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbcCPQ3i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 12:29:38 -0400
Received: by mail-pf0-f170.google.com with SMTP id u190so81178210pfb.3
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 09:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=CmoZ+OgXGu01YjRMHAqacYXJEOb88U5njQmvHNK2WEk=;
        b=cSpAGsdaKKrlznMEZv1ywEUuWX026yJkGHDcwFYdrfnCJ3tQ1ovcr+6JWbepl80zrw
         ZNb/5GM7PTOxfmxvUEBnIiuaG8m5lp3PXpgp9sxRVqreORv8Izu/6unoX2QP1jkw0NU/
         sZ3GebhGV5QHgoDNuc3tNWHrfEJFKcANB2RQN3S9ELUgF/tmPfyBxDvLfnmJfMLQdZ1d
         jLmcsa3NZrILBO1WiQhidwBup+ryxXEf1w3GfSKF58RntARBVzQem8jf0yYMc+b0HKg8
         EtHMESiWqGhUh7ZsEbq89tFEK8Si0yMvei5sr35fdHWsSH23XxjZdfVnmDFOiUBw+UiR
         h9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=CmoZ+OgXGu01YjRMHAqacYXJEOb88U5njQmvHNK2WEk=;
        b=N6e+aZWhz8PdhucoorQJ9WHmGQU4LSZVa3Pbj3znUcDWU5zi7iTxI59kgqZ9aJAJDC
         Ms+QNzu80C3G8NFxOREtG2Hp4zqtxQymLMmr3o7F8ExKHBRKJyfZ2tSq/b3eumJlpl+j
         p871fOFpC4b4m4DmEbqsL2XfoBH9zSJQu7XVsve6pJx2buo3bSduf54ZJu6C4y/hC6hH
         A09X+oMNmq5Ut6ZYZ+EqgJn13c+XIUtInecG7JlbyV0dq5GZqdBgbszpNeXptdBdr8/W
         cDOeV8p+b5dFOLAN46GExXROO9HOgM7J9Pa/knEg8Ncr5patLBB8yRPcbbapXK6yj5Md
         Armg==
X-Gm-Message-State: AD7BkJKjYVq9URLnJVHW8Vk4zDvbZuWW+N8nPk7kNlxT528PCX5b3mMq5rPzFdGfDo3l+A==
X-Received: by 10.98.15.17 with SMTP id x17mr7525120pfi.52.1458145777241;
        Wed, 16 Mar 2016 09:29:37 -0700 (PDT)
Received: from i7 (c-67-168-201-187.hsd1.or.comcast.net. [67.168.201.187])
        by smtp.gmail.com with ESMTPSA id q2sm6807314pfq.88.2016.03.16.09.29.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Mar 2016 09:29:36 -0700 (PDT)
X-X-Sender: torvalds@i7
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288987>


=46rom: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 16 Mar 2016 09:15:53 -0700
Subject: [PATCH] pretty-print: de-tabify indented logs to make things l=
ine up properly

This should all line up:

  Column 1	Column 2
  --------	--------
  A		B
  ABCD		EFGH
  SPACES        Instead of Tabs

Even with multi-byte UTF8 characters:

  Column 1	Column 2
  --------	--------
  =C3=84		B
  =C3=A5=C3=A4=C3=B6		100
  A M=C3=B8=C3=B8se	once bit my sister..

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This seems to work for me, and while there is some cost, it's minimal.=20
Doing a "git log > /dev/null" of the current git tree is about 1% slowe=
r=20
because of the tab-finding. A tree with a lot of tabs in the commit=20
messages would be more noticeable, because then you actually end up=20
hitting the whole "how wide is this" issue.

(But if the tabs are all at the beginning of a line, you'd still be ok=20
and avoid the utf8 width calculations).

Comments?

 pretty.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++--
 1 file changed, 74 insertions(+), 2 deletions(-)

diff --git a/pretty.c b/pretty.c
index 92b2870a7eab..0b40457f99f0 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1629,6 +1629,76 @@ void pp_title_line(struct pretty_print_context *=
pp,
 	strbuf_release(&title);
 }
=20
+static int pp_utf8_width(const char *start, const char *end)
+{
+	int width =3D 0;
+	size_t remain =3D end - start;
+
+	while (remain) {
+		int n =3D utf8_width(&start, &remain);
+		if (n < 0 || !start)
+			return -1;
+		width +=3D n;
+	}
+	return width;
+}
+
+/*
+ * pp_handle_indent() prints out the intendation, and
+ * perhaps the whole line (without the final newline)
+ *
+ * Why "perhaps"? If there are tabs in the indented line
+ * it will print it out in order to de-tabify the line.
+ *
+ * But if there are no tabs, we just fall back on the
+ * normal "print the whole line".
+ */
+static int pp_handle_indent(struct strbuf *sb, int indent,
+			     const char *line, int linelen)
+{
+	const char *tab;
+
+	strbuf_addchars(sb, ' ', indent);
+
+	tab =3D memchr(line, '\t', linelen);
+	if (!tab)
+		return 0;
+
+	do {
+		int width =3D pp_utf8_width(line, tab);
+
+		/*
+		 * If it wasn't well-formed utf8, or it
+		 * had characters with badly defined
+		 * width (control characters etc), just
+		 * give up on trying to align things.
+		 */
+		if (width < 0)
+			break;
+
+		/* Output the data .. */
+		strbuf_add(sb, line, tab - line);
+
+		/* .. and the de-tabified tab */
+		strbuf_addchars(sb, ' ', 8-(width & 7));
+
+		/* Skip over the printed part .. */
+		linelen -=3D 1+tab-line;
+		line =3D tab + 1;
+
+		/* .. and look for the next tab */
+		tab =3D memchr(line, '\t', linelen);
+	} while (tab);
+
+	/*
+	 * Print out everything after the last tab without
+	 * worrying about width - there's nothing more to
+	 * align.
+	 */
+	strbuf_add(sb, line, linelen);
+	return 1;
+}
+
 void pp_remainder(struct pretty_print_context *pp,
 		  const char **msg_p,
 		  struct strbuf *sb,
@@ -1652,8 +1722,10 @@ void pp_remainder(struct pretty_print_context *p=
p,
 		first =3D 0;
=20
 		strbuf_grow(sb, linelen + indent + 20);
-		if (indent)
-			strbuf_addchars(sb, ' ', indent);
+		if (indent) {
+			if (pp_handle_indent(sb, indent, line, linelen))
+				linelen =3D 0;
+		}
 		strbuf_add(sb, line, linelen);
 		strbuf_addch(sb, '\n');
 	}
--=20
2.8.0.rc2
