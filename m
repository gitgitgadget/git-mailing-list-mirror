From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] Change error messages in ident.c Make error messages
 caused by failed reads of the /etc/passwd file easier to understand.
 Signed-off-by: Angus Hammond <angusgh@gmail.com>
Date: Fri, 11 May 2012 18:35:12 +0700
Message-ID: <CACsJy8AfrF8YyOA41F80igwG8DGfWyi+wRwpo6TvADe=FnZgag@mail.gmail.com>
References: <1336676770-17965-1-git-send-email-angusgh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Angus Hammond <angusgh@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 11 13:36:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSo8k-0000ze-Tg
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 13:36:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356Ab2EKLfq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 May 2012 07:35:46 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:60974 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751459Ab2EKLfo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 07:35:44 -0400
Received: by lahd3 with SMTP id d3so1813442lah.19
        for <git@vger.kernel.org>; Fri, 11 May 2012 04:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=XOAhefDIJdz+Szcj94wqUZa/w0G0QwZVl8Wog63LnZs=;
        b=Lk1rKYBabQG2j2Mj5XKTwnbAk9POXFhnAgY2OvS7PG9Vg26mTOmtLlG5I+idtqKVN5
         Y+FwzpT7SB1itYPXyxb2gYObInNgfjJ76PNe/61AvfRb2AsjFAepYo3oWP+Lu6KwIX3c
         DFsviftAMyvqWZM2LdnMlTUeWFIfv72A1iXZhjKmmpuwH8n3Lj9cZtLOiOX2HY15VgHU
         aYiGUTj74iXqFr3iG5kiOnTVaJ+frBK6HgfBZ4RJe0IS03c+FK9TLo+Jb9Lf7pVBXahl
         VKhFtzYSrAbWLlc2A1JI/cxJ9UY/sy9OKSOiqRfjfCOOcqfvYa5flYZMhQ/YwpZOjd8p
         YXAw==
Received: by 10.152.131.74 with SMTP id ok10mr8099799lab.17.1336736143015;
 Fri, 11 May 2012 04:35:43 -0700 (PDT)
Received: by 10.112.17.167 with HTTP; Fri, 11 May 2012 04:35:12 -0700 (PDT)
In-Reply-To: <1336676770-17965-1-git-send-email-angusgh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197664>

On Fri, May 11, 2012 at 2:06 AM, Angus Hammond <angusgh@gmail.com> wrot=
e:
> ---
> =C2=A0ident.c | =C2=A0 10 +++++-----
> =C2=A01 file changed, 5 insertions(+), 5 deletions(-)

While you are touching this, perhaps you can also turn all die(xxx) in
this file to die(_(xxx)), same for warning()? You touch 5 out of 11
already. And it helps make sure all the new strings are in the same
humor level (aka none). _() allows the messages to be translated in
another language, by the way.

Also this on top so we get nice advice

diff --git a/ident.c b/ident.c
index 87c697c..b5a631f 100644
--- a/ident.c
+++ b/ident.c
@@ -289,7 +289,7 @@ person_only:
 }

 static const char *env_hint =3D
-"\n"
+N_("\n"
 "*** Please tell me who you are.\n"
 "\n"
 "Run\n"
@@ -299,7 +299,7 @@ static const char *env_hint =3D
 "\n"
 "to set your account\'s default identity.\n"
 "Omit --global to set the identity only in this repository.\n"
-"\n";
+"\n");

 const char *fmt_ident(const char *name, const char *email,
 		      const char *date_str, int flag)
@@ -318,7 +318,7 @@ const char *fmt_ident(const char *name, const char =
*email,

 		if ((warn_on_no_name || error_on_no_name) &&
 		    name =3D=3D git_default_name && env_hint) {
-			fputs(env_hint, stderr);
+			fputs(_(env_hint), stderr);
 			env_hint =3D NULL; /* warn only once */
 		}
 		if (error_on_no_name)
--=20
Duy
