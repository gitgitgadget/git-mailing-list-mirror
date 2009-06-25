From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 7/8] gitweb: recognize 'trivial' acks
Date: Thu, 25 Jun 2009 12:43:06 +0200
Message-ID: <1245926587-25074-8-git-send-email-giuseppe.bilotta@gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1245926587-25074-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1245926587-25074-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1245926587-25074-4-git-send-email-giuseppe.bilotta@gmail.com>
 <1245926587-25074-5-git-send-email-giuseppe.bilotta@gmail.com>
 <1245926587-25074-6-git-send-email-giuseppe.bilotta@gmail.com>
 <1245926587-25074-7-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 12:44:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJmQy-0008IK-Uo
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 12:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757449AbZFYKnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 06:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756907AbZFYKnd
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 06:43:33 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:47512 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757462AbZFYKnW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 06:43:22 -0400
Received: by mail-bw0-f213.google.com with SMTP id 9so1301579bwz.37
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 03:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0WLYjBdXJjzZZ1fv4CdzUFUbP1LpU4Nw6SGscqJRhgA=;
        b=VtT5qefwEWjnakBk67a2c6jhevQLSi8+O1SiKp6vxThbDs7BGmp/gn6nY2Ny2c02KJ
         1Qr9BD//9FplzwVwUH3PvRmLsjcEMHRT/kn0MEAK2yeaw0ore2TMi/6ehZfCzaSv1Z06
         XjJ1k1nOy2KMxUwpzccWcsX68H2hyAYuteu9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PMf8ReQAwPOempWXQo9mbaPeWALYZ046ZFQoX5dqmrA2/io4BNJYZDpM4Apm1mJjCw
         LC0upm3zfDA/Pmu8DxMYGzkgENsev3+GHWwCUOITUNV5pViLVe7/VdUba1cKYIKOBlV2
         Ju0sfG7Z4ZYWC/ggalBMCEJb9E26z1MYfplhI=
Received: by 10.204.112.1 with SMTP id u1mr2383344bkp.37.1245926605438;
        Thu, 25 Jun 2009 03:43:25 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-13-28.clienti.tiscali.it [94.37.13.28])
        by mx.google.com with ESMTPS id 1sm3187440fkt.57.2009.06.25.03.43.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 03:43:24 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <1245926587-25074-7-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122197>

Sometimes patches are trivially acked rather than just acked, so
extend the signoff regexp to include this case.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3e6786b..7ca115f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3403,7 +3403,7 @@ sub git_print_log {
 	my $signoff = 0;
 	my $empty = 0;
 	foreach my $line (@$log) {
-		if ($line =~ m/^ *(signed[ \-]off[ \-]by[ :]|acked[ \-]by[ :]|cc[ :])/i) {
+		if ($line =~ m/^ *(signed[ \-]off[ \-]by[ :]|(?:trivially[ \-])?acked[ \-]by[ :]|cc[ :])/i) {
 			$signoff = 1;
 			$empty = 0;
 			if (! $opts{'-remove_signoff'}) {
-- 
1.6.3.rc1.192.gdbfcb
