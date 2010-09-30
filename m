From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 09/16] send-email: sanitize_address use $foo, not "$foo"
Date: Thu, 30 Sep 2010 13:43:02 +0000
Message-ID: <1285854189-10240-10-git-send-email-avarab@gmail.com>
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
X-From: git-owner@vger.kernel.org Thu Sep 30 15:45:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1JSI-0001tO-El
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 15:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756098Ab0I3Npb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 09:45:31 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:48402 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756099Ab0I3Npa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 09:45:30 -0400
Received: by wwi14 with SMTP id 14so306658wwi.1
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 06:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ONoRXalGAHa4U82s8HV5uBLvnXcW9ixTSy77OGJtsjg=;
        b=HkCs6jMXTp+6zf+dvCOa2pxIduhxeqlzBRh20SOF6DktFxuYK9q5Eu6OY59ABiXt/p
         s2M/OkscQYnBwE0oyTBMgA9HCD7qb+zGB8ir6URavlJMjmrVLsh+4LWZr2SkSRosDX9m
         oaqJm900gHFuuEnqb06OhLvHeebEJBTBhKQ68=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=eXj42rLZFb+Ks85igK886QdI03yLMy/5yYb+Bd//3/ERIr/dlrSofd+p27hxvaMCYl
         9878B1if63Q1BLYuNYGLKHIHYp+DvXvLPamLoC1BShozKIFqgRfzi2HnZ8gyLDqYMJuS
         Lq+W4xdMEVW/SBOirnCtKHKTilkKAde/zjLnI=
Received: by 10.216.167.74 with SMTP id h52mr709183wel.35.1285854247210;
        Thu, 30 Sep 2010 06:44:07 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e56sm6328567wer.46.2010.09.30.06.44.05
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 06:44:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
In-Reply-To: <1285854189-10240-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157667>

There's no reason to explicitly stringify a variable in Perl unless
it's an overloaded object and you want to call overload::StrVal,
otherwise it's just creating a new scalar redundantly.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 1218bbe..1bf090a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -864,7 +864,7 @@ sub sanitize_address {
 	my ($recipient_name, $recipient_addr) =3D ($recipient =3D~ /^(.*?)\s*=
(<.*)/);
=20
 	if (not $recipient_name) {
-		return "$recipient";
+		return $recipient;
 	}
=20
 	# if recipient_name is already quoted, do nothing
--=20
1.7.3.159.g610493
