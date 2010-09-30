From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 08/16] send-email: use \E***\Q instead of \*\*\*
Date: Thu, 30 Sep 2010 13:43:01 +0000
Message-ID: <1285854189-10240-9-git-send-email-avarab@gmail.com>
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
X-From: git-owner@vger.kernel.org Thu Sep 30 15:45:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1JRt-0001fc-Ls
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 15:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756105Ab0I3NpR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 09:45:17 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:65259 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756098Ab0I3NpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 09:45:16 -0400
Received: by wwi14 with SMTP id 14so306669wwi.1
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 06:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=5/yft2tx2dHHfGaYbJs4Qippp0ImxXHPTtOHIO1y5ks=;
        b=lJhwJ15tT6/X5zW7NiWL3f1dusZYLUVwbxTyLZqbBF8Cs3sBefV2Ud+kdmA+20asoL
         UflIEpuqkg+mrsEt22ea5vVjzbX/ldIoLXexzLheWz8MvcLK1gNZMkzWx1SM0DorZCgF
         b1Pk+AYoi6yqOPingbuEjbnxYoaDzSeqwbLaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=rQiQjPg1JXmY6BGhnniUr5qFgUrikLy4eqNJsx4qJfon+iclsBRyviQxxRyzyJPhfT
         K9Wa7rJLsi8PMhoLcOB6edpseLsRwaTVFKg/zCBcD2ccJPhuFOTe+KLW3MlqMxjDfKTe
         sO6zu/42Rdp2sBy5ADZXU0fYS/DHpClXk0UIU=
Received: by 10.227.27.193 with SMTP id j1mr2909482wbc.137.1285854242959;
        Thu, 30 Sep 2010 06:44:02 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e56sm6328567wer.46.2010.09.30.06.44.01
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 06:44:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
In-Reply-To: <1285854189-10240-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157666>

Change the regex introduced in a03bc5b to use the \E...\Q escape
syntax instead of using backslashes. It's more readable like this, and
easier to grep for.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index ce9b5eb..1218bbe 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -705,7 +705,7 @@ if (!defined $auto_8bit_encoding && scalar %broken_=
encoding) {
=20
 if (!$force) {
 	for my $f (@files) {
-		if (get_patch_subject($f) =3D~ /\*\*\* SUBJECT HERE \*\*\*/) {
+		if (get_patch_subject($f) =3D~ /\Q*** SUBJECT HERE ***\E/) {
 			die "Refusing to send because the patch\n\t$f\n"
 				. "has the template subject '*** SUBJECT HERE ***'. "
 				. "Pass --force if you really want to send.\n";
--=20
1.7.3.159.g610493
