From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] transport-helper: remove duplicate free()
Date: Wed, 2 Dec 2009 15:39:50 +0800
Message-ID: <20091202153950.c18095b7.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 08:41:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFjqU-00038P-JH
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 08:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752982AbZLBHlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 02:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbZLBHll
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 02:41:41 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:59949 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933AbZLBHll (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 02:41:41 -0500
Received: by mail-gx0-f226.google.com with SMTP id 26so378142gxk.1
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 23:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=OTzmuHHN2ro6sNXY97Z8t6SAsr2nfPKigWcojBSqDDY=;
        b=CSuqlJHrpiJ0oLdiqMhNail2bys3vR72W8XOlgisBCwg6G/C98CyFJJu8jARB15sOQ
         lTsL1NsXR0MPp+Uf0CwQcsrzHabq7s7hyZRRRmRByWP0LRmdkLnN2zjJga/RbafLN7wA
         twQ2gRMa/Hj6T+fK7xUAe03J7nc1m4JWZlLEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=Fi3Tk0J+dlDhTg+AK5oOZpjogoo03lzPZCWP8TQ5U/3vynDrEtAKdgauj+4uivV35e
         adfTciGRRL52sy1p0EGWrhCp+5rBWF8//ChZYJa5VBTKYHE5e1RSkxr/LD+QEtmWbSt6
         WMykaYChdreeMAtgiyeQou83rWSoC3W872NAo=
Received: by 10.90.11.24 with SMTP id 24mr9519030agk.100.1259739707618;
        Tue, 01 Dec 2009 23:41:47 -0800 (PST)
Received: from your-cukc5e3z5n (cm81.zeta152.maxonline.com.sg [116.87.152.81])
        by mx.google.com with ESMTPS id 21sm450780yxe.55.2009.12.01.23.41.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 23:41:46 -0800 (PST)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134312>

Remove the free() invocation on transport->data in release_helper(), as
disconnect_helper() has already done so.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

  Applies on top of 'next'.

 transport-helper.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 9c5f860..2f77bd5 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -196,7 +196,6 @@ static int release_helper(struct transport *transport)
 	free_refspec(data->refspec_nr, data->refspecs);
 	data->refspecs = NULL;
 	disconnect_helper(transport);
-	free(transport->data);
 	return 0;
 }

--
1.6.6.rc0.306.g5bb1c0
