From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 6/8] config: Don't allow extra arguments for -e or -l.
Date: Tue, 17 Feb 2009 02:54:52 +0200
Message-ID: <1234832094-15541-6-git-send-email-felipe.contreras@gmail.com>
References: <1234832094-15541-1-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-2-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-3-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-4-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-5-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 01:57:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZEGh-0008Gx-E6
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 01:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbZBQAzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 19:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbZBQAzQ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 19:55:16 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:51434 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628AbZBQAzI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 19:55:08 -0500
Received: by mail-bw0-f161.google.com with SMTP id 5so3545414bwz.13
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 16:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=nqoqDFPbQBsh97wNSKuuTils1Sl0EkFUHTqyGE5ZJlw=;
        b=LrOcgSEYbijXwOTo2yDl9GnZXS7UjfZSnKy7i7yYrnVTOD3B0JTN4FfA3BvZSTRI1R
         2d4W+kz/CPPk+b+N8DiboRaCnVmyHmZ64HVTdPceYmadgn1QsIfBmojE1fOdgXf3KJr/
         TFdELy6xBewPuUWMOownK1BJ3sMDfe2cWECB8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=thBUbE2bx4XbOMqiGsOyz1SGD+8RXs8h6Fz1yhMMleDGP8yV4ITecgh3yFYDXY6koD
         q4LObJfPrN59HpOqW1d77zFXW8lFQvG1nTSxjSATTq+oku7IglLGGNeIG2geeyTUdbFT
         12BoqA2BhtCu0weYIVk+drFXGjYhOHx+6kSjQ=
Received: by 10.103.243.9 with SMTP id v9mr3290093mur.5.1234832107981;
        Mon, 16 Feb 2009 16:55:07 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id y37sm279441mug.23.2009.02.16.16.55.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Feb 2009 16:55:07 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1234832094-15541-5-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110280>

As suggested by Johannes Schindelin.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index cdd8a12..5891a4e 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -363,10 +363,12 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 		}
 
 	if (actions & ACTION_LIST) {
+		check_argc(argc, 0, 0);
 		if (git_config(show_all_config, NULL) < 0)
 			die("error processing config file(s)");
 	}
 	else if (actions & ACTION_EDIT) {
+		check_argc(argc, 0, 0);
 		const char *config_filename;
 		if (config_exclusive_filename)
 			config_filename = config_exclusive_filename;
-- 
1.6.1.3
