From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 05/17] Change regerror() declaration from K&R style to ANSI C (C89)
Date: Mon, 14 Sep 2009 15:11:18 +0200
Message-ID: <54b586ed58d1e9b4204658871f6f34453b48758b.1252925290.git.mstormo@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com>
 <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com>
 <7786dfa1b74b5c4974bcf2018d3991c215a9466f.1252925290.git.mstormo@gmail.com>
 <e2eff51e8d956e7cf854bea9fb9f10491f6d6543.1252925290.git.mstormo@gmail.com>
 <baa73a58d459d9cd29227b1f0fb02306c14db807.1252925290.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Mon Sep 14 15:12:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnBMN-0004Gq-Fr
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 15:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755412AbZINNMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 09:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755405AbZINNMj
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 09:12:39 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:61613 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755381AbZINNMf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 09:12:35 -0400
Received: by mail-ew0-f206.google.com with SMTP id 2so642503ewy.17
        for <git@vger.kernel.org>; Mon, 14 Sep 2009 06:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=18mLT1QDUU+ePY0mPGJoxwpaUzON5OQAOwwAqIG/L5w=;
        b=Dc3piQJpRIb0LL2JQWOuoAbywMt3Jceg0W6aXrrsnRRL34rfArSSOsWZVls1Z6i54N
         KU2Thw3A1APiQvXGPiBQetO6u+BfCkCuoBRwmm6SAOCBbOZ3SvJj9RfNBAcC05R9URMN
         NtvKxKl0cU2HET1nLxe7X2IyxYgipxmy4ekHE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=U8fzcbZ5Uh4x4dqdpVPIftOheX/dpIk6ZsFNVNRyJnKx+M0aFmlDtWf6ZyMcnlJXBF
         stNDQRZ6YsXp6rbp+T9uPM8AAYRF3mkgKCA7xbL/INFbf9/fsTwm8boUEKVXWvuCP45i
         q3j1Kooi5VQyhRzVUDhJNBZnOMHZB1aA0anOA=
Received: by 10.211.146.5 with SMTP id y5mr3123507ebn.85.1252933958298;
        Mon, 14 Sep 2009 06:12:38 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104])
        by mx.google.com with ESMTPS id 10sm2690277eyz.2.2009.09.14.06.12.34
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Sep 2009 06:12:35 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <baa73a58d459d9cd29227b1f0fb02306c14db807.1252925290.git.mstormo@gmail.com>
In-Reply-To: <cover.1252925290.git.mstormo@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128462>

From: Frank Li <lznuaa@gmail.com>

The MSVC headers typedef errcode as int, and thus confused the
compiler in the K&R style definition. ANSI style deconfuses it.

Signed-off-by: Frank Li <lznuaa@gmail.com>
Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/regex/regex.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/compat/regex/regex.c b/compat/regex/regex.c
index 5ea0075..67d5c37 100644
--- a/compat/regex/regex.c
+++ b/compat/regex/regex.c
@@ -4852,11 +4852,8 @@ regexec (preg, string, nmatch, pmatch, eflags)
    from either regcomp or regexec.   We don't use PREG here.  */
 
 size_t
-regerror (errcode, preg, errbuf, errbuf_size)
-    int errcode;
-    const regex_t *preg;
-    char *errbuf;
-    size_t errbuf_size;
+regerror(int errcode, const regex_t *preg,
+	 char *errbuf, size_t errbuf_size)
 {
   const char *msg;
   size_t msg_size;
-- 
1.6.2.1.418.g33d56.dirty
