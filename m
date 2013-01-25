From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: [PATCH] send-email: Honor multi-part email messages
Date: Fri, 25 Jan 2013 19:28:54 +0400
Message-ID: <4de442db9fd0896f78166e6038b6ea35ed5ab266.1359126360.git.Alex.Crezoff@gmail.com>
References: <cover.1359126360.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Krzysztof Mazur <krzysiek@podlesie.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 25 16:29:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TylDx-0003vc-RJ
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 16:29:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757375Ab3AYP3N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jan 2013 10:29:13 -0500
Received: from mail-lb0-f170.google.com ([209.85.217.170]:40148 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754935Ab3AYP3J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 10:29:09 -0500
Received: by mail-lb0-f170.google.com with SMTP id ge1so930241lbb.29
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 07:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=5aZ7S1l6od+YDjqLzGo30uqYmtfNtkQsYdy3L1smpDs=;
        b=TVRmD8seNcKvYD9I5e8aMP395R2njKGL+ojMP8v7jQrfwks4SKnapJvWIRXXN2N7az
         DnOB44HWMYs7Fwi7vzyKTzQku7D0+MlwDA6YNKdg8bGfaoXtjBdn9QsPIzca00i9S0Fi
         Txf5oc1l4jiO2ggbu4VKj/3zHxBLYBMcXzaPY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=5aZ7S1l6od+YDjqLzGo30uqYmtfNtkQsYdy3L1smpDs=;
        b=BR7NAFndjqoYyxGPj0PRLOpt19JPmlpxeCbg1Ewe1MwjcB34LjCbORc1KyMfNRiwGE
         1j2U+YWQFiHRFaU+H8ERwrQBPF3AO52CxCg4bpqy+5gkbghPiUK5D/68xVPqXieeJbTU
         eH+OldVkGwNmHyfMxAwZQMRUQxXlbfU3kM3nyuJSbm1epmcruL5CCIb+0+2TupKdB+zP
         aGi5D14RGr+KgV789LJc8yAGbsX6A+C+lLZ9ZvRsKMUzTybKnvzYgE5Mc4vFYJcKsrzD
         xKtWa7yBadObWPZnuiHNUmx7f3QDdw8jL1pCMBh5Mqbwt3JWy6OZzVaFE1f7RhtnXypz
         2R1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=5aZ7S1l6od+YDjqLzGo30uqYmtfNtkQsYdy3L1smpDs=;
        b=h//Wg36tUjim3sYNXflIGmWD8CeZgTwD7LHSNzklMlNhdGei/JrRB0mc6s6VZ76YxC
         B+kQAFShfKuvLm3Oolq24wckJnecpCuS86KCow21FdMG9Y8QIKcW7oNPBF09RE1xbzuH
         bcqWoPq0iEVF5KDfkC856F1PorfXcxN1CIf1Tc77ao9UP0yX6uh5+1WjoEOM41+i6enQ
         7yksMwBvEiZzsTLMEOoPjG5xsuWHec2xkuBR7mdu16/g1z6GofKQWZ6IrH60voB25MPA
         txIasQD77lltlByZJDekMh9enCqeqf2+TK7qULx4CXC8ZmWpcyFHopFP7xVHkbE0l0A2
         rc3A==
X-Received: by 10.112.25.70 with SMTP id a6mr2321937lbg.117.1359127747020;
        Fri, 25 Jan 2013 07:29:07 -0800 (PST)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPS id j9sm702170lbd.13.2013.01.25.07.29.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 07:29:06 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.10.g9255f3f
In-Reply-To: <cover.1359126360.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1359126360.git.Alex.Crezoff@gmail.com>
References: <cover.1359126360.git.Alex.Crezoff@gmail.com>
X-Gm-Message-State: ALoCoQkRcy3bhheSClt2W+CMKVmkH4qaG/CnKs9CdWYLjBloOz2GBQfVA83OyNl8evx+09l2ij6K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214558>

"git format-patch --attach/--inline" generates multi-part messages.
Every part of such messages can contain non-ASCII characters with its o=
wn
"Content-Type" and "Content-Transfer-Encoding" headers.
But git-send-mail script interprets a patch-file as one-part message
and does not recognize multi-part messages.
So already quoted printable email subject may be encoded as quoted prin=
table
again. Due to this bug email subject looks corrupted in email clients.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
---
 git-send-email.perl   |  5 ++++
 t/t9001-send-email.sh | 66 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 71 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 94c7f76..d49befe 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1499,12 +1499,17 @@ sub file_has_nonascii {
=20
 sub body_or_subject_has_nonascii {
 	my $fn =3D shift;
+	my $multipart =3D 0;
 	open(my $fh, '<', $fn)
 		or die "unable to open $fn: $!\n";
 	while (my $line =3D <$fh>) {
 		last if $line =3D~ /^$/;
+		if ($line =3D~ /^Content-Type:\s*multipart\/mixed.*$/) {
+			$multipart =3D 1;
+		}
 		return 1 if $line =3D~ /^Subject.*[^[:ascii:]]/;
 	}
+	return 0 if $multipart;
 	while (my $line =3D <$fh>) {
 		return 1 if $line =3D~ /[^[:ascii:]]/;
 	}
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 97d6f4c..c7ed370 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1323,4 +1323,70 @@ test_expect_success $PREREQ 'sendemail.aliasfile=
=3D~/.mailrc' '
 	grep "^!someone@example\.org!$" commandline1
 '
=20
+test_expect_success $PREREQ 'setup multi-part message' '
+cat >multi-part-email-using-8bit <<EOF
+From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 2001
+Message-Id: <bogus-message-id@example.com>
+From: author@example.com
+Date: Sat, 12 Jun 2010 15:53:58 +0200
+Subject: [PATCH] =3D?UTF-8?q?=3DD0=3D94=3DD0=3DBE=3DD0=3DB1=3DD0=3DB0=3D=
D0=3DB2=3DD0=3DBB=3DD0=3DB5=3DD0=3DBD=3D20?=3D
+ =3D?UTF-8?q?=3DD1=3D84=3DD0=3DB0=3DD0=3DB9=3DD0=3DBB?=3D
+MIME-Version: 1.0
+Content-Type: multipart/mixed; boundary=3D"------------123"
+
+This is a multi-part message in MIME format.
+--------------1.7.6.3.4.gf71f
+Content-Type: text/plain; charset=3DUTF-8; format=3Dfixed
+Content-Transfer-Encoding: 8bit
+
+This is a message created with "git format-patch --attach=3D123"
+---
+ master   |    1 +
+ =D1=84=D0=B0=D0=B9=D0=BB |    1 +
+ 2 files changed, 2 insertions(+), 0 deletions(-)
+ create mode 100644 master
+ create mode 100644 =D1=84=D0=B0=D0=B9=D0=BB
+
+
+--------------123
+Content-Type: text/x-patch; name=3D"0001-.patch"
+Content-Transfer-Encoding: 8bit
+Content-Disposition: attachment; filename=3D"0001-.patch"
+
+diff --git a/master b/master
+new file mode 100644
+index 0000000..1f7391f
+--- /dev/null
++++ b/master
+@@ -0,0 +1 @@
++master
+diff --git a/=D1=84=D0=B0=D0=B9=D0=BB b/=D1=84=D0=B0=D0=B9=D0=BB
+new file mode 100644
+index 0000000..44e5cfe
+--- /dev/null
++++ b/=D1=84=D0=B0=D0=B9=D0=BB
+@@ -0,0 +1 @@
++=D1=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D0=BC=D0=BE=D0=B5 =D1=84=D0=
=B0=D0=B9=D0=BB=D0=B0
+
+--------------123--
+EOF
+'
+
+test_expect_success $PREREQ 'setup expect' '
+cat >expected <<EOF
+Subject: [PATCH] =3D?UTF-8?q?=3DD0=3D94=3DD0=3DBE=3DD0=3DB1=3DD0=3DB0=3D=
D0=3DB2=3DD0=3DBB=3DD0=3DB5=3DD0=3DBD=3D20?=3D =3D?UTF-8?q?=3DD1=3D84=3D=
D0=3DB0=3DD0=3DB9=3DD0=3DBB?=3D
+EOF
+'
+
+test_expect_success $PREREQ '--attach/--inline also treats subject' '
+	clean_fake_sendmail &&
+	echo bogus |
+	git send-email --from=3Dauthor@example.com --to=3Dnobody@example.com =
\
+			--smtp-server=3D"$(pwd)/fake.sendmail" \
+			--8bit-encoding=3DUTF-8 \
+			multi-part-email-using-8bit >stdout &&
+	grep "Subject" msgtxt1 >actual &&
+	test_cmp expected actual
+'
+
 test_done
--=20
1.8.1.1.10.g9255f3f
