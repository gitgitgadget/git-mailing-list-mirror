From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/7] t1020-subdirectory: test alias expansion in a subdirectory
Date: Thu, 11 Nov 2010 21:20:42 +0700
Message-ID: <1289485248-8966-2-git-send-email-pclouds@gmail.com>
References: <1289485248-8966-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 15:22:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGY31-0000C2-Ej
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 15:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755332Ab0KKOWi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Nov 2010 09:22:38 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64186 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243Ab0KKOWh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 09:22:37 -0500
Received: by pva4 with SMTP id 4so398203pva.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 06:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Njad/q84zfobUauaYeQKeUgPbLR3t8t7KBacmLMFkfI=;
        b=f04t8TWHH8sfqFO+qzwnT3ROhebZ7BALyDrPKW/1FPZsxGYMu9EHxNSSetO/Rzg+a6
         ShLXxEcjChND4j/1+ry6qYz9TPmpl8XW8xZVLyForuBoVIahzmYD8krhLSwLvqX//+qS
         rz3oJUVYUtqZ1OU1KbDTPQhNYkHg8xKhUC2so=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=N+5e94tsPGuf6Hz0RDUZmDjovyIAtuJlw59AW546ySBLFklUIL/wLiNZPBoATCArUy
         MtFAVa405J5NQSeyr9+OBcGyvLOYaS8HvljfUtr7uRWoayKAHTr9hIEMz2tGGcGr9yHp
         HZUdLWwNBllI9kpQzc07NvY/uWBYkTnOVAVbA=
Received: by 10.142.57.19 with SMTP id f19mr714978wfa.94.1289485357296;
        Thu, 11 Nov 2010 06:22:37 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.247.75])
        by mx.google.com with ESMTPS id y42sm2420954wfd.22.2010.11.11.06.22.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 06:22:36 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Nov 2010 21:21:14 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
In-Reply-To: <1289485248-8966-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161255>

=46rom: Michael J Gruber <git@drmicha.warpmail.net>

Add a test for alias expansion in a subdirectory of the worktree.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1020-subdirectory.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index a3ac338..1fd187c 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -110,6 +110,14 @@ test_expect_success 'read-tree' '
 	)
 '
=20
+test_expect_success 'alias expansion' '
+	(
+		git config alias.ss status &&
+		cd dir &&
+		git status &&
+		git ss
+	)
+'
 test_expect_success 'no file/rev ambiguity check inside .git' '
 	git commit -a -m 1 &&
 	(
--=20
1.7.3.2.210.g045198
