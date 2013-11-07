From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH 2/2] gitignore.txt: clarify recursive nature of excluded directories
Date: Thu, 07 Nov 2013 22:36:29 +0100
Message-ID: <527C07DD.9090809@gmail.com>
References: <527BC00D.8000501@gmail.com> <527BC068.3040303@gmail.com> <xmqqa9hg59av.fsf@gitster.dls.corp.google.com> <xmqq61s457gd.fsf@gitster.dls.corp.google.com> <20131107195546.GA13456@sigill.intra.peff.net> <527BF7A4.6070203@gmail.com> <20131107205732.GA16564@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 22:36:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeXFe-0000cE-Gq
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 22:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032Ab3KGVg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 16:36:26 -0500
Received: from mail-wi0-f177.google.com ([209.85.212.177]:39672 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009Ab3KGVgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 16:36:25 -0500
Received: by mail-wi0-f177.google.com with SMTP id f4so1308988wiw.10
        for <git@vger.kernel.org>; Thu, 07 Nov 2013 13:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=xaz6rZwOO4jGh/+fRXVoLk9jd75FXEpkJll0X+LxZNU=;
        b=tzaIUHheZGpnyvJpyJaMWU17zVgG2wMvKv60pUQuWAkNWSu9a6fZimYey04ZKQNaNg
         bHtkjLmUWfs7HIBfE2fJaNHTlitL5pVfFsiqFcdCs0egtprZcq2NlELQasvgrmwz93+A
         /FAHjgr194v/EW3LaH5JfPIi/ci8JXr8/R/bkIQez7YimyDXT1MV0OQAwq6FwsGXY8tN
         uBOXpHabNa76MsnqMq6TLZTPCQeKlVKfdpm0sgpk83HS8b54IFyql2pbKKYhi5JEwvEd
         n/JMkS+Ek1li70+2p0t4ItmkxL5lfHmm5XrlZHgBiQ9Jkc6jQwDnVnML+ufMuo/SMoQl
         EqfA==
X-Received: by 10.180.11.168 with SMTP id r8mr4469044wib.16.1383860184486;
        Thu, 07 Nov 2013 13:36:24 -0800 (PST)
Received: from [10.1.100.55] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id ma3sm10617755wic.1.2013.11.07.13.36.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Nov 2013 13:36:23 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <20131107205732.GA16564@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237429>

Additionally, precedence of negated patterns is exactly as outlined in
the DESCRIPTION section, we don't need to repeat this.

Signed-off-by: Karsten Blees <blees@dcon.de>
---

I also force-pushed to git://github.com/kblees/git.git kb/gitignore-doc.

 Documentation/gitignore.txt | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index f971960..205e80e 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -79,8 +79,10 @@ PATTERN FORMAT
 
  - An optional prefix "`!`" which negates the pattern; any
    matching file excluded by a previous pattern will become
-   included again.  If a negated pattern matches, this will
-   override lower precedence patterns sources.
+   included again. It is not possible to re-include a file if a parent
+   directory of that file is excluded. Git doesn't list excluded
+   directories for performance reasons, so any patterns on contained
+   files have no effect, no matter where they are defined.
    Put a backslash ("`\`") in front of the first "`!`" for patterns
    that begin with a literal "`!`", for example, "`\!important!.txt`".
 
@@ -182,6 +184,19 @@ Another example:
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
1.8.4.msysgit.1
