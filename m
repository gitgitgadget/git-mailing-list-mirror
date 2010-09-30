From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 10/16] send-email: sanitize_address use qq["foo"], not "\"foo\""
Date: Thu, 30 Sep 2010 13:43:03 +0000
Message-ID: <1285854189-10240-11-git-send-email-avarab@gmail.com>
References: <1285854189-10240-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ryan Anderson <rda@google.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 30 15:44:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1JQs-00019e-Av
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 15:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756072Ab0I3NoL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 09:44:11 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42011 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656Ab0I3NoK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 09:44:10 -0400
Received: by mail-wy0-f174.google.com with SMTP id 28so1858034wyb.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 06:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=HAlCz6HBNcupnbmUpw5ASkswMMCIeT5uVreKVt8vc4o=;
        b=MB4wBa8w/Lxse3ZMInd0QO6CynaE/7lX2gAfmBREDihmmpgpvmpRiN+RvQuC01w9cp
         mELsTcqCxn2hVjxrHBtkfIze1ZXa/2J5FKNDPs9ubKL0YZT1qjGVv1PdcGIa6T1VFqjK
         unyssdHKKgelfnxlHikd51SgIiiXSRyUBTVno=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=K1R7O/mVquGAyIZxZpXxqCQaBCfhWNCXRa990PUEW5WvaPAp530aP53QlWwhGYHZ+1
         WTW5l1HhBF84KT1YEvOEzxvXpn6YKmbkzyr4jXli2R489CRETUoPdWhAxGW7Z0XpQ3OD
         6yIp4XBuvujaz1Ioj1kievnEfHLbtNkHblG7w=
Received: by 10.216.145.198 with SMTP id p48mr3048415wej.18.1285854249813;
        Thu, 30 Sep 2010 06:44:09 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e56sm6328567wer.46.2010.09.30.06.44.08
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 06:44:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
In-Reply-To: <1285854189-10240-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157659>

Perl provides an alternate quote syntax which can make using "" inside
interpolated strings easier to read.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 1bf090a..c012b95 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -881,7 +881,7 @@ sub sanitize_address {
 	# double quotes are needed if specials or CTLs are included
 	elsif ($recipient_name =3D~ /[][()<>@,;:\\".\000-\037\177]/) {
 		$recipient_name =3D~ s/(["\\\r])/\\$1/g;
-		$recipient_name =3D "\"$recipient_name\"";
+		$recipient_name =3D qq["$recipient_name"];
 	}
=20
 	return "$recipient_name $recipient_addr";
--=20
1.7.3.159.g610493
