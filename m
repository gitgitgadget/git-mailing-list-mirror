From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 06/17] transport.c::get_refs_via_curl(): do not leak
 refs_url
Date: Sat, 30 May 2009 01:59:03 +0800
Message-ID: <20090530015903.96c4a18f.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 29 20:02:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA6P4-0000Xl-GA
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 20:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759056AbZE2SAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 14:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758844AbZE2SAz
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 14:00:55 -0400
Received: from mail-px0-f123.google.com ([209.85.216.123]:53739 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758793AbZE2SAy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 14:00:54 -0400
Received: by mail-px0-f123.google.com with SMTP id 29so1678194pxi.33
        for <git@vger.kernel.org>; Fri, 29 May 2009 11:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=O7FiSNxui75LNgacbCSQygg9QZ1k+PY9YhP6razkptg=;
        b=JgbEFuy0sEtEBiQnO/lJDyFe2h134Q4UeyI6ob5p+odMrn5KO/Kax84P68H+xr5D6T
         qHxQQyTMh1cQNo1WNVIgOTajkLzY/VltQVtCjZbvcY2XCflvnkOlcWiKYJRR9dMVc6JA
         oboJcTIjJqgSJggLONMVRCALvlNvZcdM28n/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=uiQAOMLlU7gkbp7WhNIQr6DD5wPkCh0jioooAp/4OgTpojW4E9th2M9IGnNQE3YdDA
         45yP2T4V82yvfWTCFvT3BdKi4Q+ScNznqGuowHmpawm98TnbjEHuyPxQmNhKcSiYTiGK
         1XJyCPI8zAelN0zhKVpjByuuByiP2xVRBPGNM=
Received: by 10.114.159.17 with SMTP id h17mr4489167wae.197.1243620056785;
        Fri, 29 May 2009 11:00:56 -0700 (PDT)
Received: from your-cukc5e3z5n (cm189.zeta148.maxonline.com.sg [116.87.148.189])
        by mx.google.com with ESMTPS id j34sm2539771waf.64.2009.05.29.11.00.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 May 2009 11:00:56 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120293>

From:	Mike Hommey <mh@glandium.org>
Subject: [WIP Patch 02/12] Some cleanup in get_refs_via_curl()
Date:	Sun, 18 Jan 2009 09:04:27 +0100

Signed-off-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 transport.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/transport.c b/transport.c
index 17891d5..0aa57bd 100644
--- a/transport.c
+++ b/transport.c
@@ -519,6 +519,7 @@ static struct ref *get_refs_via_curl(struct transport *transport, int for_push)
 		free(ref);
 	}

+	free(refs_url);
 	return refs;
 }

--
1.6.3.1
