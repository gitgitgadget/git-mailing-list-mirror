From: Saurav Sachidanand <sauravsachidanand@gmail.com>
Subject: [PATCH] Change type of signed int flags to unsigned
Date: Thu, 25 Feb 2016 18:54:32 +0530
Message-ID: <1456406672-5661-1-git-send-email-sauravsachidanand@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Saurav Sachidanand <sauravsachidanand@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 25 14:25:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYvus-0000bY-3Y
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 14:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760404AbcBYNY6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2016 08:24:58 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33994 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760562AbcBYNYt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 08:24:49 -0500
Received: by mail-pf0-f170.google.com with SMTP id x65so32906198pfb.1
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 05:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=RT2UYaUVutXTyNhv+0HMXbrxPS2igPWPW9GnEe+EHcY=;
        b=tqE05/nj79cpNL+I2xF9tj214yZiukcNOwe78vGUqyIYMlgCFjfhH2Ico2CCdN2sUR
         LWP9R02LPeIyTTWzYdlCvxuYDTEuzF5GhoMOR2idNHhx69/amkjoLk8dC9+RQeNFZDvQ
         ZVxm9jqq05FSny51nRHO5w7PV1dDR02WKl7iR7njdnmSAOJLr8x4p5KBEuYX6YMR2+yL
         vjq9TcycdQ9emF5a3exttuBvVNv/AYo07/7dRBAmxBgl1qAat01+QvB8V9rabOHjQz5Y
         0A8Xy4OSgumii1UIkUn25CSsjUXoaecICycgN4moysg2hovBKU9gP7vZ6OgP176OaUUE
         mXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=RT2UYaUVutXTyNhv+0HMXbrxPS2igPWPW9GnEe+EHcY=;
        b=I1Gp0ndOBk5DbYhHY6z8bu8GsI9xS/bs0fG/xGQ+4UnYUqmphJGXcsVQDrTR1JcfUq
         DzMVbTJeaSY6iMqsYhjWa4jgvcuEpvw9PMhQQsqHbPcZ2lzz3he6D69e2sa77Y6sNkiS
         W5ry0MRJF8D/smTyywWTY1bD9SPwuQhHG+WP5H7rgzXxvQim5WUFwIu2UQaJ9YkfX3Tx
         DljzdYIouMEw4326vU1hEJr7M0CngIHnQiuVBjE73j7mE3u1/i9R5dgHwqtXXvjy0swQ
         c4nkaRdlVx9pQhcbTh21U0v8AD/tvvm84HeJstRT9OQBX3phgpWpgoa4kxGEJ8509fLf
         oBLw==
X-Gm-Message-State: AG10YOTzmmddNltL/8gal6uTGO5RZgrbC+1iRJjpPVwApv665FJcm2TLxxXuRFJymx6LGA==
X-Received: by 10.98.68.212 with SMTP id m81mr62587043pfi.135.1456406688709;
        Thu, 25 Feb 2016 05:24:48 -0800 (PST)
Received: from localhost.localdomain ([106.51.19.158])
        by smtp.googlemail.com with ESMTPSA id yj1sm12471163pac.16.2016.02.25.05.24.46
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 25 Feb 2016 05:24:48 -0800 (PST)
X-Mailer: git-send-email 2.7.1.339.g0233b80
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287387>

=E2=80=9Cpattern=E2=80=9D and =E2=80=9Cexclude=E2=80=9D are two structs=
 defined in attr.c and dir.h
respectively. Each contains a field named =E2=80=9Cflags=E2=80=9D of ty=
pe int, that
takes on values from the set of positive integers {1, 4, 8, 16}
enumerated through the macro EXC_FLAG_*.

That the most significant bit (used to store the sign) of these two
fields is not used in any special way, is observed from the fact
that, the flags fields (accessed within attr.c, dir.c, and
builtin/check-ignore.c) is either checked for it's value using the &
operator (e.g.: flags & EXC_FLAG_NODIR), or assigned a value of 0
first and then assigned any one of {1, 4, 8, 16} using the | operator
(e.g.: flags |=3D EXC_FLAG_NODIR). Hence, change the type of flags
to unsigned in both structs.

=46urthermore, flags is passed by reference to the function
parse_exclude_pattern defined in dir.c, which accepts an =E2=80=9Cint *=
=E2=80=9D type
for the flags argument. To avoid converting between pointers to
different types, change type of the flags argument to =E2=80=9Cunsigned=
 *=E2=80=9D.

While we=E2=80=99re at it, document the flags field of exclude to expli=
citly
state the values it=E2=80=99s supposed to take on.

Signed-off-by: Saurav Sachidanand <sauravsachidanand@gmail.com>
---
 attr.c | 2 +-
 dir.c  | 4 ++--
 dir.h  | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/attr.c b/attr.c
index 086c08d..679e13c 100644
--- a/attr.c
+++ b/attr.c
@@ -124,7 +124,7 @@ struct pattern {
 	const char *pattern;
 	int patternlen;
 	int nowildcardlen;
-	int flags;		/* EXC_FLAG_* */
+	unsigned flags;		/* EXC_FLAG_* */
 };

 /*
diff --git a/dir.c b/dir.c
index 552af23..d36fda7 100644
--- a/dir.c
+++ b/dir.c
@@ -459,7 +459,7 @@ int no_wildcard(const char *string)

 void parse_exclude_pattern(const char **pattern,
 			   int *patternlen,
-			   int *flags,
+			   unsigned *flags,
 			   int *nowildcardlen)
 {
 	const char *p =3D *pattern;
@@ -500,7 +500,7 @@ void add_exclude(const char *string, const char *ba=
se,
 {
 	struct exclude *x;
 	int patternlen;
-	int flags;
+	unsigned flags;
 	int nowildcardlen;

 	parse_exclude_pattern(&string, &patternlen, &flags, &nowildcardlen);
diff --git a/dir.h b/dir.h
index 3ec3fb0..e34df5e 100644
--- a/dir.h
+++ b/dir.h
@@ -28,7 +28,7 @@ struct exclude {
 	int nowildcardlen;
 	const char *base;
 	int baselen;
-	int flags;
+	unsigned flags;		/* EXC_FLAG_* */

 	/*
 	 * Counting starts from 1 for line numbers in ignore files,
@@ -244,7 +244,7 @@ extern struct exclude_list *add_exclude_list(struct=
 dir_struct *dir,
 extern int add_excludes_from_file_to_list(const char *fname, const cha=
r *base, int baselen,
 					  struct exclude_list *el, int check_index);
 extern void add_excludes_from_file(struct dir_struct *, const char *fn=
ame);
-extern void parse_exclude_pattern(const char **string, int *patternlen=
, int *flags, int *nowildcardlen);
+extern void parse_exclude_pattern(const char **string, int *patternlen=
, unsigned *flags, int *nowildcardlen);
 extern void add_exclude(const char *string, const char *base,
 			int baselen, struct exclude_list *el, int srcpos);
 extern void clear_exclude_list(struct exclude_list *el);
--
2.7.1.339.g0233b80

This patch is for the suggested microproject for GSoC 2016 titled
"Use unsigned integral type for collection of bits."
