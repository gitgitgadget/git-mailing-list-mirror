From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] Git.pm: call Error::Simple() properly
Date: Tue, 13 Jan 2009 17:41:35 -0500
Message-ID: <1231886495-92821-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 23:43:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMryS-0005iN-Nj
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 23:43:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbZAMWlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 17:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbZAMWlk
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 17:41:40 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:4951 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbZAMWlj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 17:41:39 -0500
Received: by qw-out-2122.google.com with SMTP id 3so89697qwe.37
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 14:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=9vC7eKsIpqtq9ipv/N1oqaBlqOXvwho9Amv0OB3C0Rc=;
        b=p37ZXfRC/hodFItpXGPqDU/bne/ZzDWJDzhMe0lEsZXsJ9WNHe46MrEMhyetDeh8B8
         fAMXqlXYTw18MkrLACzmHVGj7FVoOXMgMh3iMmRye2XJpGBbsPPBO7/Ghqt3qIqZJsaA
         uWq9XQ/niSVvQjQEBW9LH7c3AVmKI2nhKXuFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=u8Uxtzob9AbVc+HJvTQnNLjFcXxvW7RuEIATm3kl3FmWEaFo5V7tOj9XB/O5iMLBrD
         T7DhzKEzi2mMUsTR4scKu7i5IRWbxeaDrDGsRf0i9JzGhtYws0hPKFtGejSk6ph6FIa2
         7lGKSXEk2uGMeJPc2ITTz+JA5gm95JcgcIzZs=
Received: by 10.214.44.2 with SMTP id r2mr27646795qar.146.1231886497939;
        Tue, 13 Jan 2009 14:41:37 -0800 (PST)
Received: from localhost (cpe-075-189-159-045.nc.res.rr.com [75.189.159.45])
        by mx.google.com with ESMTPS id 5sm8053994ywd.52.2009.01.13.14.41.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Jan 2009 14:41:37 -0800 (PST)
X-Mailer: git-send-email 1.6.1.77.g81ea1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105555>

The error message to Error::Simple() must be passed as a single argument.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 perl/Git.pm |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 8392a68..e9f8c9c 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1010,8 +1010,8 @@ sub _temp_cache {
 	my $temp_fd = \$TEMP_FILEMAP{$name};
 	if (defined $$temp_fd and $$temp_fd->opened) {
 		if ($TEMP_FILES{$$temp_fd}{locked}) {
-			throw Error::Simple("Temp file with moniker '",
-				$name, "' already in use");
+			throw Error::Simple("Temp file with moniker '" .
+				$name . "' already in use");
 		}
 	} else {
 		if (defined $$temp_fd) {
-- 
1.6.1.77.g81ea1
