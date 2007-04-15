From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: Re: [PATCH 01/02] ident.c: Use const qualifier when possible
Date: Sun, 15 Apr 2007 18:40:31 -0300
Organization: Mandriva
Message-ID: <20070415184031.2df65364@gnut>
References: <20070415155110.365070d8@gnut>
	<200704152106.51082.andyparkins@gmail.com>
	<7vslb12y4e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 15 23:40:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdCSv-0008B4-3Q
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 23:40:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980AbXDOVkj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 17:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753981AbXDOVkj
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 17:40:39 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:37421 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753980AbXDOVki (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 17:40:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 51F3018B1C;
	Sun, 15 Apr 2007 18:40:37 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id Py1zF8PrrBcg; Sun, 15 Apr 2007 18:40:34 -0300 (BRT)
Received: from gnut (unknown [201.21.180.171])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 0DD5918B16;
	Sun, 15 Apr 2007 18:40:33 -0300 (BRT)
In-Reply-To: <7vslb12y4e.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Claws Mail 2.7.2 (GTK+ 2.10.3; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44530>

Em Sun, 15 Apr 2007 13:14:57 -0700
Junio C Hamano <junkio@cox.net> escreveu:

| Andy Parkins <andyparkins@gmail.com> writes:
| 
| > On Sunday 2007, April 15, Luiz Fernando N. Capitulino wrote:
| >
| >> -static const char *env_hint =
| >> +static const char const *env_hint =
| >
| > You can see then that
| >
| >  const char const *env_hint
| >
| > is redundant, it's simply saying twice that (*env_hint) is const.
| 
| I think he wanted to say
| 
| 	static const char *const env_hint = ...

 Urgh, yes. And it's not possible to make the pointer const
because we change the value it points to (-2 for me).

 Updated version follows. I don't need to send the second
again, right?

From: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>
Subject: [PATCH] ident.c: Use const qualifier for 'struct passwd' parameters

Signed-off-by: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>
---
 ident.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ident.c b/ident.c
index bb03bdd..b557ecd 100644
--- a/ident.c
+++ b/ident.c
@@ -9,7 +9,7 @@
 
 static char git_default_date[50];
 
-static void copy_gecos(struct passwd *w, char *name, int sz)
+static void copy_gecos(const struct passwd *w, char *name, int sz)
 {
 	char *src, *dst;
 	int len, nlen;
@@ -43,7 +43,7 @@ static void copy_gecos(struct passwd *w, char *name, int sz)
 
 }
 
-static void copy_email(struct passwd *pw)
+static void copy_email(const struct passwd *pw)
 {
 	/*
 	 * Make up a fake email address
-- 
1.5.1.1.86.gfd56-dirty
