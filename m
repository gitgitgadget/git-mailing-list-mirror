From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] gitignore.txt: suggestions how to get literal # or ! at the beginning
Date: Sat,  6 Oct 2012 20:51:24 +0700
Message-ID: <1349531484-5938-1-git-send-email-pclouds@gmail.com>
References: <20121006132127.GC11712@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Philip Oakley <philipoakley@iee.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 06 15:58:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKUtu-0007wk-1i
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 15:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821Ab2JFN6c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Oct 2012 09:58:32 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39191 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719Ab2JFN6a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 09:58:30 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2775571pbb.19
        for <git@vger.kernel.org>; Sat, 06 Oct 2012 06:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=pT8vzTQAO71IhhS1mL+aelJXt8wc6hxVLVfQqI8S2Wk=;
        b=cfNknqDQZvqZcYfuIXRdDpFt/wjmr6RjaWTPcBK7VSLWCbqAfDQleKMZQjOSfovtCF
         4RBOEH0KoHYQzcWnWCY0XK7Dzd9UUkrH5+5dkY0IYGWWKlqQHjOxkmvo7vtdyOkaKJWh
         A4WFo4pnGAiIhC2B0jTBPtnNlDwiiScZCrIWjIEaBE2OSDeyYIF7DgMVRUS2IEqZr5Tm
         TTVKCSy2jwkOINzXZAbRDd6osvIUjLUQXMhC0oc8gyWLrzNqTUrT25TAj9WHU/M1R336
         yyLEP42ue/Q1nX3xHsebbUk+MHqTonO9yKg6E7BFROynNvY8D04MFq0HCFqw0bjPC/0z
         iySQ==
Received: by 10.68.213.138 with SMTP id ns10mr38613537pbc.157.1349531910234;
        Sat, 06 Oct 2012 06:58:30 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id vf8sm7699227pbc.27.2012.10.06.06.58.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Oct 2012 06:58:29 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 06 Oct 2012 20:51:31 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <20121006132127.GC11712@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207147>

We support backslash escape, but we hide the details behind the phrase
"a shell glob suitable for consumption by fnmatch(3)". So it may not
be obvious how one can get literal # or ! at the beginning of pattern.
Add a few lines on how to work around the magic characters.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Sat, Oct 6, 2012 at 8:21 PM, Jeff King <peff@peff.net> wrote:
 > It works fine for me with asciidoc 8.6.7. <sigh>

 8.6.5 works. I don't care deeply as I read .txt anyway. Here it goes
 again with examples.

 Documentation/gitignore.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 96639e0..0bcf079 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -73,12 +73,16 @@ PATTERN FORMAT
  - A blank line matches no files, so it can serve as a separator
    for readability.
=20
- - A line starting with # serves as a comment.
+ - A line starting with "`#`" serves as a comment.
+   Use "`\#`" instead for patterns that begin with "`#`",
+   for example, "`\#backup#.txt`".
=20
- - An optional prefix '!' which negates the pattern; any
+ - An optional prefix "`!`" which negates the pattern; any
    matching file excluded by a previous pattern will become
    included again.  If a negated pattern matches, this will
    override lower precedence patterns sources.
+   Use "`\!`" instead for patterns that begin with "`!`",
+   for example, "`\!important!.txt`".
=20
  - If the pattern ends with a slash, it is removed for the
    purpose of the following description, but it would only find
--=20
1.7.12.1.406.g6ab07c4
