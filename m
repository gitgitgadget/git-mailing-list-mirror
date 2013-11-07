From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH 2/2] gitignore.txt: clarify recursive nature of excluded directories
Date: Thu, 07 Nov 2013 17:31:36 +0100
Message-ID: <527BC068.3040303@gmail.com>
References: <527BC00D.8000501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 17:31:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeSUb-0006md-Sg
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 17:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753123Ab3KGQbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 11:31:34 -0500
Received: from mail-ee0-f44.google.com ([74.125.83.44]:42263 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106Ab3KGQbd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 11:31:33 -0500
Received: by mail-ee0-f44.google.com with SMTP id d41so434977eek.17
        for <git@vger.kernel.org>; Thu, 07 Nov 2013 08:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=wCRum6ivD6L4xswO4VaC2mAtdTIO+JAH0SY/fg42PC4=;
        b=m3151NWUTjcpDtyiRWCK2UoxWjEL8LGtaRfPe/QeIv9j465vdBZY90VrbreKDkr6tW
         GrPTTX0nyTpW0Uu0DR720nwghL3dJTIOk+OWlTWTGklxhF2MWAMlhqxKY0urlN0HnlZa
         qolLsnkknKNUyQBjVA4Q5opt/+IjuMhggQHFSqwxDThZPCwCN/7exrWXNbvlRKMEI51d
         v8evSwBFHQ7k3v+3axW5v8fU3hFWsyTjC/hNiVPYMD7w4wbbXhvzbdEWeqdSrh6yzL2H
         ZI4kYhyiiVfE17E306A/7cUAsH+UY5IYPPuOIfMhnD2XL9nwZxa1NbfT7DvW5A1/FsXk
         zabA==
X-Received: by 10.14.93.133 with SMTP id l5mr550319eef.125.1383841892283;
        Thu, 07 Nov 2013 08:31:32 -0800 (PST)
Received: from [10.1.100.55] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id w6sm11122373eeo.12.2013.11.07.08.31.30
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Nov 2013 08:31:31 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <527BC00D.8000501@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237416>

Additionally, precedence of negated patterns is exactly as outlined in
the DESCRIPTION section, we don't need to repeat this.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 Documentation/gitignore.txt | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index f971960..5ecc48e 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -79,8 +79,9 @@ PATTERN FORMAT
 
  - An optional prefix "`!`" which negates the pattern; any
    matching file excluded by a previous pattern will become
-   included again.  If a negated pattern matches, this will
-   override lower precedence patterns sources.
+   included again. It is not possible to re-include a file if a parent
+   directory of that file is excluded (i.e. excluding a directory
+   will recursively and irrevocably exclude the entire content).
    Put a backslash ("`\`") in front of the first "`!`" for patterns
    that begin with a literal "`!`", for example, "`\!important!.txt`".
 
@@ -182,6 +183,19 @@ Another example:
 The second .gitignore prevents Git from ignoring
 `arch/foo/kernel/vmlinux.lds.S`.
 
+Example to exclude everything except a specific directory `foo/bar`
+(note the `/*` - without the slash, the wildcard would also exclude
+everything within `foo/bar`):
+
+--------------------------------------------------------------
+    $ cat .gitignore
+    # exclude everything except directory foo/bar
+    /*
+    !/foo
+    /foo/*
+    !/foo/bar
+--------------------------------------------------------------
+
 SEE ALSO
 --------
 linkgit:git-rm[1],
-- 
1.8.4.msysgit.0.12.g88f5ed0
