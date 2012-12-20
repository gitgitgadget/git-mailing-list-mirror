From: Matthew Blissett <matt@blissett.me.uk>
Subject: [PATCH] Highlight the link target line in Gitweb using CSS
Date: Thu, 20 Dec 2012 18:16:38 +0000
Message-ID: <1356027399-5356-1-git-send-email-matt@blissett.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthew Blissett <matt@blissett.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 20 19:17:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tlkgh-0008SW-KE
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 19:17:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883Ab2LTSRZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Dec 2012 13:17:25 -0500
Received: from mail-wg0-f42.google.com ([74.125.82.42]:55024 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427Ab2LTSRW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 13:17:22 -0500
Received: by mail-wg0-f42.google.com with SMTP id dr1so1059487wgb.5
        for <git@vger.kernel.org>; Thu, 20 Dec 2012 10:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blissett.me.uk; s=g;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=imNUiBNhQpQ6q6DNJ5rIGMlVyfq4kbVHvRxNOFfTLEE=;
        b=H6G2WBN4L3Sio9Bqvr4kg7k8sqsRw3eQ3wTrMaAEOIpHXrBES30Z2brw4sRKkIW/XY
         eKwwKnZ3ZX4ePBNn2F+JUIYhLwFfbTV+bWgS/Xi3l1+nuDPk/sLIBQRla/0u+/7OeYOA
         3MxrfdaSkG8NaihUBBCIRf9QOSdMbvN9f3TAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=imNUiBNhQpQ6q6DNJ5rIGMlVyfq4kbVHvRxNOFfTLEE=;
        b=MNVnULvjOd40sU5w/wIuSM/4hc/S9FHJhaYfVnDAlmpPJa4papXlI2F/bPXzJhR+Ej
         OAgLuWhFXPjYf38ZHbxB1jacb9C8jcU1y/KeWTKrjJE1GycKmiQmRPs7U72RJ2UmS9Bo
         fdV++2oaCS3VEHW4v7NyQOjUjFtb5ZwPOYcNUChWSnWAudIZ+B5lDZ7f7yGO9MMLLqlx
         h/1sn5mFxLA/Uxk3aNoo9BstBr0o+F+/YyvgX//hdszdmcv0UBDF7LiCyfoMs/DMwLHC
         3/zIUF5/vvdKsSMRHQeUAKo7aGSgAOvaqFC+Fzp0WTpTjUfML1SIoDRvM8tgbGzSmq5q
         D/jw==
X-Received: by 10.194.57.206 with SMTP id k14mr19157756wjq.26.1356027441190;
        Thu, 20 Dec 2012 10:17:21 -0800 (PST)
Received: from a9487.ad.kew.org ([193.128.243.115])
        by mx.google.com with ESMTPS id p2sm14275250wic.7.2012.12.20.10.17.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 20 Dec 2012 10:17:20 -0800 (PST)
X-Mailer: git-send-email 1.7.10.4
X-Gm-Message-State: ALoCoQl7GUFLh0H8A8JskVLJkl/yNpRtCQECjYYoPRudTShBdT0wO8qn8MMvhgZlHC5Hk+5H0HkJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211911>

This is useful when a Gitweb link with a target (like #l100) refers to
a line in the last screenful of text.  Highlight the background in
yellow, and display a =E2=9A=93 character on the left.  Show the same
highlight when hovering the mouse over a line number.

Signed-off-by: Matthew Blissett <matt@blissett.me.uk>
---
The background-colour change is the 'main' (tiny) change.

Consider the ::before part a suggestion.  I think it helps show the
target line, but it does overlap the first character of any line >999.

I've tested this on the browsers I have access to, which excludes
Internet Explorer.  Since it's cosmetic it shouldn't matter if it doesn=
't
work.

Wikipedia use similar CSS for their citation links:
<http://en.wikipedia.org/wiki/Git_(software)#cite_note-1>

 gitweb/static/gitweb.css |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index cb86d2d..9f54311 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -546,6 +546,16 @@ a.linenr {
 	text-decoration: none
 }
=20
+a.linenr:hover, a.linenr:target {
+	color: #444444;
+	background-color: #ff4;
+}
+
+a.linenr:hover::before, a.linenr:target::before {
+	content: '=E2=9A=93';
+	position: absolute;
+}
+
 a.rss_logo {
 	float: right;
 	padding: 3px 0px;
--=20
1.7.10.4
