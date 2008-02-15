From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 2/2] test mailinfo rfc3676 support
Date: Thu, 14 Feb 2008 21:21:17 -0500
Message-ID: <1203042077-11385-2-git-send-email-jaysoffian@gmail.com>
References: <1203042077-11385-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 15 03:21:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPqD9-0003db-0R
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 03:21:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759500AbYBOCV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 21:21:27 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759479AbYBOCV1
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 21:21:27 -0500
Received: from an-out-0708.google.com ([209.85.132.248]:63343 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759362AbYBOCVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 21:21:25 -0500
Received: by an-out-0708.google.com with SMTP id d31so109815and.103
        for <git@vger.kernel.org>; Thu, 14 Feb 2008 18:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NzXjsr6B/c/WEwcuT9Lw6mWBB9b+QKusri+EA3Qcaqo=;
        b=Jz3wcEubWDVNiLwRadvhrs2mzw5KU5wfsm5pT4QwjNdcr6Hin05b41D3r7H6qzL87ed/0s6uO73DInTNZogMYvSn1+G5y3ELB0stqXxacUSAUhLNFTIm23re5QRxj6iLlf5Tg/aAAPTAFRV6VtjIwE66th/X5ULcCCTsOpeQEuY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kT2unmEVE8hDdaPBo022HCMVti52XOheAnDMjqrZG89+j5oyLVyCbr00NjEiz75lciEq6FXD/83y3gzuS3UX+2G4GULrvPtLlxvl9gS9KEPz1wgOcLSQ5kQ6A+p9BXr+faUOAHGOi1fjxT4FMMStePFFHLCNMNvXv+i+cplWSUI=
Received: by 10.100.211.8 with SMTP id j8mr2351475ang.119.1203042084873;
        Thu, 14 Feb 2008 18:21:24 -0800 (PST)
Received: from localhost ( [75.189.159.45])
        by mx.google.com with ESMTPS id d19sm5506740and.6.2008.02.14.18.21.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Feb 2008 18:21:24 -0800 (PST)
X-Mailer: git-send-email 1.5.4.1.1281.g75df
In-Reply-To: <1203042077-11385-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73938>

Adds a format=3Dflowed message to the sample.mbox in order to test
mailinfo's rfc3676 support.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 t/t5100-mailinfo.sh |    2 +-
 t/t5100/info0009    |    5 ++
 t/t5100/msg0009     |    8 +++
 t/t5100/patch0009   |   98 ++++++++++++++++++++++++++++++++++++
 t/t5100/sample.mbox |  138 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
 5 files changed, 250 insertions(+), 1 deletions(-)
 create mode 100644 t/t5100/info0009
 create mode 100644 t/t5100/msg0009
 create mode 100644 t/t5100/patch0009

diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 9b1a745..d6c55c1 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -11,7 +11,7 @@ test_expect_success 'split sample box' \
 	'git mailsplit -o. ../t5100/sample.mbox >last &&
 	last=3D`cat last` &&
 	echo total is $last &&
-	test `cat last` =3D 8'
+	test `cat last` =3D 9'
=20
 for mail in `echo 00*`
 do
diff --git a/t/t5100/info0009 b/t/t5100/info0009
new file mode 100644
index 0000000..63369be
--- /dev/null
+++ b/t/t5100/info0009
@@ -0,0 +1,5 @@
+Author: A U Thor
+Email: a.u.thor@example.com
+Subject: mailinfo: support rfc3676 (format=3Dflowed) text/plain messag=
es
+Date: Thu, 14 Feb 2008 20:56:34 -0500
+
diff --git a/t/t5100/msg0009 b/t/t5100/msg0009
new file mode 100644
index 0000000..eb9c7f8
--- /dev/null
+++ b/t/t5100/msg0009
@@ -0,0 +1,8 @@
+RFC 3676 establishes two parameters (Format and DelSP) to be used with
+the Text/Plain media type. In the presence of these parameters, traili=
ng
+whitespace is used to indicate flowed lines and a canonical quote
+indicator is used to indicate quoted lines.
+
+mailinfo now unfolds, unquotes, and un-space-stuffs such messages.
+
+Signed-off-by: A U Thor <a.u.thor@example.com.com
diff --git a/t/t5100/patch0009 b/t/t5100/patch0009
new file mode 100644
index 0000000..a167e73
--- /dev/null
+++ b/t/t5100/patch0009
@@ -0,0 +1,98 @@
+---
+The next line will test space stuffing
+From A U Thor <a.u.thor@example.com.com>
+
+The next line will test space stuffing also, and force Mail.app to sen=
d this as quoted-printable. This line will be flowed.
+> M=C3=A4rchen
+
+A flowed quoted paragraph follows:
+Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusm=
od tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim=
 veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex e=
a commodo consequat. Duis aute irure dolor in reprehenderit in voluptat=
e velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occ=
aecat cupidatat non proident, sunt in culpa qui officia deserunt mollit=
 anim id est laborum.
+
+And again with deeper quoting depth:
+Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusm=
od tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim=
 veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex e=
a commodo consequat. Duis aute irure dolor in reprehenderit in voluptat=
e velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occ=
aecat cupidatat non proident, sunt in culpa qui officia deserunt mollit=
 anim id est laborum.
+
+
+builtin-mailinfo.c |   40 ++++++++++++++++++++++++++++++++++++++++
+1 files changed, 40 insertions(+), 0 deletions(-)
+
+diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
+index 2600847..deaf92b 100644
+--- a/builtin-mailinfo.c
++++ b/builtin-mailinfo.c
+@@ -20,6 +20,13 @@ static enum  {
+static enum  {
+	TYPE_TEXT, TYPE_OTHER,
+} message_type;
++/* RFC 3676 Text/Plain Format and DelSp Parameters */
++static enum {
++	FORMAT_NONE, FORMAT_FIXED, FORMAT_FLOWED,
++} tp_format;
++static enum {
++	DELSP_NONE, DELSP_YES, DELSP_NO,
++} tp_delsp;
+
+static char charset[256];
+static int patch_lines;
+@@ -193,6 +200,18 @@ static int handle_content_type(char *line)
+
+	if (strcasestr(line, "text/") =3D=3D NULL)
+		 message_type =3D TYPE_OTHER;
++	else if (strcasestr(line, "text/plain")) {
++		char attr[256];
++		if (slurp_attr(line, "format=3D", attr) && !strcasecmp(attr, "flowe=
d")) {
++			tp_format =3D FORMAT_FLOWED;
++			if (slurp_attr(line, "delsp=3D", attr) && !strcasecmp(attr, "yes")=
)
++				tp_delsp =3D DELSP_YES;
++			else
++				tp_delsp =3D DELSP_NO;
++		}
++		else
++			tp_format =3D FORMAT_FIXED;
++	}
+	if (slurp_attr(line, "boundary=3D", boundary + 2)) {
+		memcpy(boundary, "--", 2);
+		if (content_top++ >=3D &content[MAX_BOUNDARIES]) {
+@@ -681,6 +700,8 @@ again:
+	transfer_encoding =3D TE_DONTCARE;
+	charset[0] =3D 0;
+	message_type =3D TYPE_TEXT;
++	tp_format =3D FORMAT_NONE;
++	tp_delsp =3D DELSP_NONE;
+
+	/* slurp in this section's info */
+	while (read_one_header_line(line, sizeof(line), fin))
+@@ -770,6 +791,24 @@ static int handle_filter(char *line, unsigned lin=
esize)
+{
+	static int filter =3D 0;
+
++	if (tp_format =3D=3D FORMAT_FLOWED && !!strcmp(line, "-- \n")) {
++		char *cp =3D line;
++		while (*cp =3D=3D '>' && *cp !=3D 0)
++			cp++;
++		if (*cp =3D=3D ' ')
++			cp++;
++		line =3D cp;
++		if (!!strcmp(line, "-- \n")) {
++			while (*cp !=3D '\n' && *cp !=3D0)
++				cp++;
++			if (cp > line && *cp =3D=3D '\n' && *(cp-1) =3D=3D ' ') {
++				if (tp_delsp =3D=3D DELSP_YES)
++					*(cp-1) =3D '\0';
++				else
++					*cp =3D '\0';
++			}
++		}
++	}
+	/* filter tells us which part we left off on
+	 * a non-zero return indicates we hit a filter point
+	 */
+@@ -818,6 +857,7 @@ static void handle_body(void)
+
+		switch (transfer_encoding) {
+		case TE_BASE64:
++		case TE_QP:
+		{
+			char *op =3D line;
+
+--=20
+1.5.4.1.1281.g75df
diff --git a/t/t5100/sample.mbox b/t/t5100/sample.mbox
index 070c166..a1f9833 100644
--- a/t/t5100/sample.mbox
+++ b/t/t5100/sample.mbox
@@ -407,3 +407,141 @@ Subject: [PATCH] another patch
=20
 Hey you forgot the patch!
=20
+From nobody Thu Feb 14 21:02:08 2008
+Message-Id: <FCDFE42A-6A58-4F77-AEF2-E94C5373B14F@soffian.org>
+From: A U Thor <a.u.thor@example.com>
+To: A U Thor <a.u.thor@example.com>
+Content-Type: text/plain; charset=3DUTF-8; format=3Dflowed; delsp=3Dye=
s
+Content-Transfer-Encoding: quoted-printable
+Mime-Version: 1.0 (Apple Message framework v919.2)
+Subject: [PATCH] mailinfo: support rfc3676 (format=3Dflowed) text/plai=
n messages
+Date: Thu, 14 Feb 2008 20:56:34 -0500
+X-Mailer: Apple Mail (2.919.2)
+
+RFC 3676 establishes two parameters (Format and DelSP) to be used with
+the Text/Plain media type. In the presence of these parameters, traili=
ng
+whitespace is used to indicate flowed lines and a canonical quote
+indicator is used to indicate quoted lines.
+
+mailinfo now unfolds, unquotes, and un-space-stuffs such messages.
+
+Signed-off-by: A U Thor <a.u.thor@example.com.com
+---
+The next line will test space stuffing
+ =3D46rom A U Thor <a.u.thor@example.com.com>
+
+The next line will test space stuffing also, and force Mail.app to =3D=
20
+send this as quoted-printable. This line will be flowed.
+ > M=3DC3=3DA4rchen
+
+A flowed quoted paragraph follows:
+> Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do =3D=
20
+> eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim =
=3D20=3D
+
+> ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut =3D=
20
+> aliquip ex ea commodo consequat. Duis aute irure dolor in =3D20
+> reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla =
=3D20=3D
+
+> pariatur. Excepteur sint occaecat cupidatat non proident, sunt in =3D=
20
+> culpa qui officia deserunt mollit anim id est laborum.
+
+And again with deeper quoting depth:
+>>> Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do =3D=
20
+>>> eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut =3D=
20
+>>> enim ad minim veniam, quis nostrud exercitation ullamco laboris =3D=
20
+>>> nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in =
=3D20=3D
+
+>>> reprehenderit in voluptate velit esse cillum dolore eu fugiat =3D2=
0
+>>> nulla pariatur. Excepteur sint occaecat cupidatat non proident, =3D=
20
+>>> sunt in culpa qui officia deserunt mollit anim id est laborum.
+
+
+builtin-mailinfo.c |   40 ++++++++++++++++++++++++++++++++++++++++
+1 files changed, 40 insertions(+), 0 deletions(-)
+
+diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
+index 2600847..deaf92b 100644
+--- a/builtin-mailinfo.c
++++ b/builtin-mailinfo.c
+@@ -20,6 +20,13 @@ static enum  {
+static enum  {
+	TYPE_TEXT, TYPE_OTHER,
+} message_type;
++/* RFC 3676 Text/Plain Format and DelSp Parameters */
++static enum {
++	FORMAT_NONE, FORMAT_FIXED, FORMAT_FLOWED,
++} tp_format;
++static enum {
++	DELSP_NONE, DELSP_YES, DELSP_NO,
++} tp_delsp;
+
+static char charset[256];
+static int patch_lines;
+@@ -193,6 +200,18 @@ static int handle_content_type(char *line)
+
+	if (strcasestr(line, "text/") =3D3D=3D3D NULL)
+		 message_type =3D3D TYPE_OTHER;
++	else if (strcasestr(line, "text/plain")) {
++		char attr[256];
++		if (slurp_attr(line, "format=3D3D", attr) && =3D
+!strcasecmp(attr, =3D20
+"flowed")) {
++			tp_format =3D3D FORMAT_FLOWED;
++			if (slurp_attr(line, "delsp=3D3D", attr) && =3D
+!strcasecmp(attr, "yes"))
++				tp_delsp =3D3D DELSP_YES;
++			else
++				tp_delsp =3D3D DELSP_NO;
++		}
++		else
++			tp_format =3D3D FORMAT_FIXED;
++	}
+	if (slurp_attr(line, "boundary=3D3D", boundary + 2)) {
+		memcpy(boundary, "--", 2);
+		if (content_top++ >=3D3D &content[MAX_BOUNDARIES]) {
+@@ -681,6 +700,8 @@ again:
+	transfer_encoding =3D3D TE_DONTCARE;
+	charset[0] =3D3D 0;
+	message_type =3D3D TYPE_TEXT;
++	tp_format =3D3D FORMAT_NONE;
++	tp_delsp =3D3D DELSP_NONE;
+
+	/* slurp in this section's info */
+	while (read_one_header_line(line, sizeof(line), fin))
+@@ -770,6 +791,24 @@ static int handle_filter(char *line, unsigned =3D=
20
+linesize)
+{
+	static int filter =3D3D 0;
+
++	if (tp_format =3D3D=3D3D FORMAT_FLOWED && !!strcmp(line, "-- \n")) {
++		char *cp =3D3D line;
++		while (*cp =3D3D=3D3D '>' && *cp !=3D3D 0)
++			cp++;
++		if (*cp =3D3D=3D3D ' ')
++			cp++;
++		line =3D3D cp;
++		if (!!strcmp(line, "-- \n")) {
++			while (*cp !=3D3D '\n' && *cp !=3D3D0)
++				cp++;
++			if (cp > line && *cp =3D3D=3D3D '\n' && *(cp-1) =3D3D=3D3D=3D
+ ' ') {
++				if (tp_delsp =3D3D=3D3D DELSP_YES)
++					*(cp-1) =3D3D '\0';
++				else
++					*cp =3D3D '\0';
++			}
++		}
++	}
+	/* filter tells us which part we left off on
+	 * a non-zero return indicates we hit a filter point
+	 */
+@@ -818,6 +857,7 @@ static void handle_body(void)
+
+		switch (transfer_encoding) {
+		case TE_BASE64:
++		case TE_QP:
+		{
+			char *op =3D3D line;
+
+--=3D20
+1.5.4.1.1281.g75df
--=20
1.5.4.1.1281.g75df
