From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How do I .gitignore files starting with "#"?
Date: Fri, 10 Sep 2010 21:56:29 +0200
Message-ID: <201009102156.31439.jnareb@gmail.com>
References: <AANLkTimaPrDX4rn2xRYyLn-bh2rB-TgKaEtGSQ+JxSnM@mail.gmail.com> <AANLkTimw5pzdGjiPps-CE1PJS1sBXYw3dE4vhdwm1CYP@mail.gmail.com> <201009102133.19427.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Bruce Korb <bruce.korb@gmail.com>, git@vger.kernel.org
To: "=?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason" 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 10 21:57:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou9iX-0000dS-4w
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 21:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754756Ab0IJT4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Sep 2010 15:56:45 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63679 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453Ab0IJT4o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 15:56:44 -0400
Received: by bwz11 with SMTP id 11so2555307bwz.19
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 12:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=zqSziibeJSwbKiWkSGxX1pUVmIikCkT1Q0xWY5Wt9Rw=;
        b=OSSOFA1fHh+CSMs0tEFrJLBHWHkslyv0eyUYC/6Ocek/t8rG9t9y78Tpc23zc6kRBe
         VR1jjkW99a42gZyFu78Hh+HhmtWUaKjnAUyBkqP2COinIZJXyJ1XJvSnTVSNeaIw9vtQ
         uMiDSPE3VS9kYKTwrmTrbCmJ7klg/4JYmbtYU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=AvpKbM4yHMcoibgifojgVS6w8iJils/ALotkKecfCzZrdT2BeQHLMeE+CizH0GyOqr
         YTNJTE3gldhe6ZnLo8lTYee6qcjpQcnjyXy4RDtqRe+A7+556vBodliJtt+z0pDnCCh4
         KiC1A/MCgvdGVsxVVov0XhPNls2+9j6T8tBXM=
Received: by 10.204.113.20 with SMTP id y20mr838897bkp.170.1284148602922;
        Fri, 10 Sep 2010 12:56:42 -0700 (PDT)
Received: from [192.168.1.13] (abuz124.neoplus.adsl.tpnet.pl [83.8.197.124])
        by mx.google.com with ESMTPS id x19sm2265951bkv.21.2010.09.10.12.56.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Sep 2010 12:56:42 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201009102133.19427.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155967>

Jakub Narebski wrote:

> Something like this?

Err, rather like this.
-- >8 --
Subject: [PATCH] Document escaping of special characters in gitignore files

Requested-by: Bruce Korb <bruce.korb@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 Documentation/gitignore.txt |    7 +++++++
 templates/info--exclude     |    1 +
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 7dc2e8b..20abc20 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -68,6 +68,7 @@ Patterns have the following format:
    for readability.
 
  - A line starting with # serves as a comment.
+   Use `\#` for a literal # character starting filename.
 
  - An optional prefix '!' which negates the pattern; any
    matching file excluded by a previous pattern will become
@@ -98,6 +99,12 @@ Patterns have the following format:
    For example, "/{asterisk}.c" matches "cat-file.c" but not
    "mozilla-sha1/sha1.c".
 
+ - You can escape special characters using backslash.
+   For example, "{backslash}#*" matches files beginning in `#`
+   (otherwise it would be considered comment),
+   and "{backslash}!*{backslash}?" matches files starting with `!`
+   (negate pattern prefix) and ending with `?` (glob wildcard).
+
 An example:
 
 --------------------------------------------------------------
diff --git a/templates/info--exclude b/templates/info--exclude
index a5196d1..2ebaf0d 100644
--- a/templates/info--exclude
+++ b/templates/info--exclude
@@ -4,3 +4,4 @@
 # exclude patterns (uncomment them if you want to use them):
 # *.[oa]
 # *~
+# \#*#
-- 
1.7.2.1
