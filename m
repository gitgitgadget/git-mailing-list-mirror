From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH] contrib/subtree: remove contradicting use options on echo wrapper
Date: Fri, 15 Feb 2013 22:20:13 +0000
Message-ID: <CALeLG_=p9k2B6AmTG0iKf9GpGB=_6kcECmCdDV1nmruJ4bdGcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Adam Tkac <atkac@redhat.com>,
	"David A. Greene" <greened@obbligato.org>,
	"Jesper L. Nielsen" <lyager@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Schubert <mschub@elegosoft.com>,
	Techlive Zheng <techlivezheng@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 15 23:20:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6Te6-00008j-A8
	for gcvg-git-2@plane.gmane.org; Fri, 15 Feb 2013 23:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357Ab3BOWUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2013 17:20:15 -0500
Received: from mail-oa0-f54.google.com ([209.85.219.54]:42944 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061Ab3BOWUO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2013 17:20:14 -0500
Received: by mail-oa0-f54.google.com with SMTP id n12so4314278oag.13
        for <git@vger.kernel.org>; Fri, 15 Feb 2013 14:20:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=kidpTJr91FTvMhABgUL8Ax38wo2BbvN2rK0nlGozXC0=;
        b=ZisABk+2zmQq1Qsxa165tKxbp/iBgbX/wbLqPZJxK8W/E0l+EKaTkbRVlBCC4oG2jx
         Kpy4XiXlZnVIHjklLngA8uXoTwFnnHjyyGBZNcGorMaW7yeOrti9pLDgz8lj9PwThGoa
         hSQIBjmuuVYT4vWGVYvZUD3n//4AHoStswp1J3lfHHNna2jDdlK+SnDaRx+1UbK1FQ/k
         DYVmYV86ZdF+5hfy+58YVvNnsSJc9w/L1bZWk3q/BwTIDofWDNLbNqQ7Zt+x8s7k5Rc5
         LbMX7Ak8LapPxTlZzKPBEEwvzT6v2AP+AffW5juYDEZpWxzyDCLSxtT8JrzLhCvWzShp
         YRqw==
X-Received: by 10.182.232.65 with SMTP id tm1mr2930047obc.32.1360966813712;
 Fri, 15 Feb 2013 14:20:13 -0800 (PST)
Received: by 10.76.143.67 with HTTP; Fri, 15 Feb 2013 14:20:13 -0800 (PST)
X-Originating-IP: [2.102.85.14]
X-Gm-Message-State: ALoCoQk2L2IiAuQM3lLw7VQjXxyaass8hpWlaw1ycy97zxdPGTxFItGUIz4nuxjHB6Kyj6O21w20
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216356>

Remove redundant -n option and raw ^M in call to echo.

Call to 'say' function, a wrapper of 'echo', passed the parameter -n, then
included a raw ^M newline in the end of the last parameter. Yet the -n option
is meant to suppress the addition of new line by echo.

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 8a23f58..51146bd 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -592,7 +592,7 @@ cmd_split()
 	eval "$grl" |
 	while read rev parents; do
 		revcount=$(($revcount + 1))
-		say -n "$revcount/$revmax ($createcount)
"
+		say "$revcount/$revmax ($createcount)"
 		debug "Processing commit: $rev"
 		exists=$(cache_get $rev)
 		if [ -n "$exists" ]; then
-- 
1.8.1.3.605.g02339dd
