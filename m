From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 16/24] Show usage string for 'git unpack-file -h'
Date: Mon,  9 Nov 2009 09:04:56 -0600
Message-ID: <1257779104-23884-16-git-send-email-jrnieder@gmail.com>
References: <20091109150235.GA23871@progeny.tock>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 15:56:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7VfC-0002nn-DT
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 15:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755905AbZKIOzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 09:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755643AbZKIOzj
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 09:55:39 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:44620 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755712AbZKIOzg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 09:55:36 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so3179619ewy.37
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 06:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=tBl10ov1pqHF4huGBQ91ZUUng7alO3Sjy/vqM+OKTqA=;
        b=P6f9REtFDjghmV9mGvsqDS5K6qjXEHFyz9rhJmwqldl7C1cAJropCFR+YrIA7byjfU
         KrBSggeOTgoIgYa0FZ4ue0h07ffDt9iauxt/21H3VwyhdysjRXMTGsp2AhXMjeB4On0i
         h+ZetO1SvYgmQBu+k3s11lReaI9DVXqFvuJMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NFyIYpbSaBvo8L0TKy2XIt4WMfedAOPovzJsi3vaXEz16T2NHIucgAtZ1eUOuMFLht
         YTIa1hwxo+SRKRPGkZdrhTkbtBwkaI9HS7obMUnPg4yb8GBHotoik0uFdS4Mb4ht4kH7
         9g2PbFuahd7V/v4+J9QXzX+wePIpkX7oYyahE=
Received: by 10.216.86.213 with SMTP id w63mr2488788wee.71.1257778541696;
        Mon, 09 Nov 2009 06:55:41 -0800 (PST)
Received: from localhost.localdomain (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p37sm8922607gvf.9.2009.11.09.06.55.39
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 06:55:40 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <20091109150235.GA23871@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132472>

"unpack-file -h" could be asking to save the contents of a blob
named "-h".  Strictly speaking, such a pathological ref name is
possible, but the user would have to had said something like
"tags/-h" to name such a pathological ref already.  When used in
scripts, unpack-file is typically not passed a user-supplied tag
name directly.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 unpack-file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/unpack-file.c b/unpack-file.c
index ac9cbf7..e9d8934 100644
--- a/unpack-file.c
+++ b/unpack-file.c
@@ -28,7 +28,7 @@ int main(int argc, char **argv)
 
 	git_extract_argv0_path(argv[0]);
 
-	if (argc != 2)
+	if (argc != 2 || !strcmp(argv[1], "-h"))
 		usage("git unpack-file <sha1>");
 	if (get_sha1(argv[1], sha1))
 		die("Not a valid object name %s", argv[1]);
-- 
1.6.5.2
