From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] Make sure to use Araxis' "compare" and not e.g. ImageMagick's
Date: Mon, 23 Jul 2012 21:37:23 +0200
Message-ID: <500DA7F3.3000403@gmail.com>
References: <500CF8CE.90906@gmail.com> <500CF9D2.30102@gmail.com> <500CFB19.6010905@gmail.com> <7vmx2qmnfw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 21:37:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StORl-00057l-96
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 21:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754614Ab2GWThb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 15:37:31 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:50747 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754510Ab2GWTha (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 15:37:30 -0400
Received: by wgbdr13 with SMTP id dr13so6156034wgb.1
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 12:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=pdvJx0+WfqEjbAqHsVQoAHtWs1x3Eeix7j57OKsqAeA=;
        b=xiuClmQHTPT6biy2GSw4a8lg8b1bA/s+xg8uXhmRn6qMVc1qqHYeSYOY4z6Ng4IvQK
         uAljDsPiiixftlYddw+QiYwbzoco5gkFK1EAasyeUHuQLNg3Cj0rduI40JWv0YZmTJ7F
         f34R35dnhx4fcZ+aQUi08gCdR6r5lw0/RVwZsaC5GlRtT6OdYBm7PEdeRyv9RJ2/mex/
         YhXDz/6zhznN51NijeJlpaL73hTnIGb1l3n063EFTKPyM9d4aMCAvVZw9LDL64zby3Mv
         IMVVTi9Y1NRYkpO9icYEAinXigjjQ2S24vZnK0FtlwcTR7DSimfkuKsJYao6Ph+K8fC/
         O60g==
Received: by 10.180.104.5 with SMTP id ga5mr285368wib.21.1343072249181;
        Mon, 23 Jul 2012 12:37:29 -0700 (PDT)
Received: from [192.168.178.22] (p5DDB0653.dip0.t-ipconnect.de. [93.219.6.83])
        by mx.google.com with ESMTPS id o2sm352940wiz.11.2012.07.23.12.37.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Jul 2012 12:37:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7vmx2qmnfw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201967>

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 mergetools/araxis | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mergetools/araxis b/mergetools/araxis
index 64f97c5..f8899f8 100644
--- a/mergetools/araxis
+++ b/mergetools/araxis
@@ -16,5 +16,12 @@ merge_cmd () {
 }
 
 translate_merge_tool_path() {
-	echo compare
+	# Only accept "compare" in a path that contains "araxis" to not
+	# accidently use e.g. ImageMagick's "compare".
+	if type compare | grep -i araxis >/dev/null 2>&1
+	then
+		echo compare
+	else
+		echo "$1"
+	fi
 }
-- 
1.7.11.msysgit.2
