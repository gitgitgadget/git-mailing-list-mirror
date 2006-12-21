From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [BUG] daemon.c blows up on OSX
Date: 20 Dec 2006 17:35:08 -0800
Message-ID: <86psaevxo3.fsf@blue.stonehenge.com>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
	<86vek6z0k2.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>
	<86irg6yzt1.fsf_-_@blue.stonehenge.com>
	<7vr6uu6w8e.fsf@assigned-by-dhcp.cox.net>
	<86ejquyz4v.fsf@blue.stonehenge.com>
	<86ac1iyyla.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201502090.3576@woody.osdl.org>
	<86wt4mximh.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201524230.3576@woody.osdl.org>
	<caf068570612201636g75180138r223aef7c42f69a50@mail.gmail.com>
	<8664c6xdgi.fsf@blue.stonehenge.com>
	<24BF45E9-DD98-4609-9D65-B01EAA30CCA8@silverinsanity.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: "Terje Sten Bjerkseth" <terje@bjerkseth.org>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 02:35:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxCqB-0001Qp-Am
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 02:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161125AbWLUBfO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Dec 2006 20:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161128AbWLUBfO
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 20:35:14 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:13562 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161125AbWLUBfK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Dec 2006 20:35:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 995388D55F;
	Wed, 20 Dec 2006 17:35:09 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 00841-01-78; Wed, 20 Dec 2006 17:35:09 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 0FD948F35F; Wed, 20 Dec 2006 17:35:09 -0800 (PST)
To: Brian Gernhardt <benji@silverinsanity.com>
x-mayan-date: Long count = 12.19.13.16.7; tzolkin = 8 Manik; haab = 0 Kankin
In-Reply-To: <24BF45E9-DD98-4609-9D65-B01EAA30CCA8@silverinsanity.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35003>

--=-=-=

>>>>> "Brian" == Brian Gernhardt <benji@silverinsanity.com> writes:

Brian> On Dec 20, 2006, at 8:08 PM, Randal L. Schwartz wrote:

>>>>>>> "Terje" == Terje Sten Bjerkseth <terje@bjerkseth.org> writes:
>> 
>> 
Terje> +#ifndef __APPLE_CC__
Terje> #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500,  OpenBSD
Terje> needs 600 for S_ISLNK() */
Terje> #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
Terje> +#endif
Terje> #define _GNU_SOURCE
Terje> #define _BSD_SOURCE
Terje> -
>> 
>> I tried the moral equivalent of that, and it failed to compile many
>> other things then.  So that's not it.

Brian> Well, it seems to work for me as is (although I applied it manually  instead
Brian> of dealing with copy/paste with a patch).

I did it with #if 0 / #end instead of the __APPLE_CC__ symbol.
But, weirdly, now that I used the symbol, I get a good compile.

Does #if 0 not work? :)

Sorry for being objectionable earlier then.  I've attached the precise
patch I used and works and verified.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!

--=-=-=
Content-Disposition: attachment; filename=0001-patch-from-email.txt

>From 9e3f88df3f6b17804f53fb497202f0879ea5e5f3 Mon Sep 17 00:00:00 2001
From: Randal L. Schwartz <merlyn@stonehenge.com>
Date: Wed, 20 Dec 2006 17:32:21 -0800
Subject: [PATCH] patch-from-email

---
 git-compat-util.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index bc296b3..41fa7f6 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -11,8 +11,10 @@
 
 #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
 
+#ifndef __APPLE_CC__
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
+#endif
 #define _GNU_SOURCE
 #define _BSD_SOURCE
 
-- 
1.4.4.3.g9e3f8


--=-=-=--
