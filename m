From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [RFC PATCH v2 2/2] headers: include dependent headers
Date: Sun, 07 Sep 2014 08:41:48 +0200
Message-ID: <540BFE2C.6060409@web.de>
References: <1410049821-49861-1-git-send-email-davvid@gmail.com> <1410049821-49861-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>
To: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 07 08:42:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQWB4-0004PH-TL
	for gcvg-git-2@plane.gmane.org; Sun, 07 Sep 2014 08:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbaIGGmI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Sep 2014 02:42:08 -0400
Received: from mout.web.de ([212.227.15.3]:57270 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822AbaIGGmH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2014 02:42:07 -0400
Received: from [192.168.178.27] ([79.250.174.198]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0LqDD6-1Y3xee3Hgu-00dlFw; Sun, 07 Sep 2014 08:42:04
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
In-Reply-To: <1410049821-49861-2-git-send-email-davvid@gmail.com>
X-Provags-ID: V03:K0:DddK+U7rU7lXMhYXBCF16qaoqKtulykTWdmVSK/yK/Ks/wXhP3F
 d9rGEJsJ88U4x1m0mk1BXS9TN6lHQ2ygCgRrJNvYVbzhYhfLJsMmpK2Hge6lMsc0RzYMfB0
 mIbj9bYKAlHyOyuOdPFTP80GaJhj9hhQcbeM+wW29fFesTGhdL8Ez9bnjgYQbrHSx0BXjvR
 5golpd6+rz7957BpUX0KA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256611>

Am 07.09.2014 um 02:30 schrieb David Aguilar:
> Add dependent headers so that including a header does not
> require including additional headers.
>=20
> This makes it so that "gcc -c $header" succeeds for each header.
>=20
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> Addresses Ren=C3=A9's note to not include strbuf.h when cache.h is al=
ready
> included.

Perhaps squash this in in order to catch two more cases and also
avoid including git-compat-util.h if we already have cache.h:

diff --git a/builtin.h b/builtin.h
index df40fce..0419af3 100644
--- a/builtin.h
+++ b/builtin.h
@@ -1,7 +1,6 @@
 #ifndef BUILTIN_H
 #define BUILTIN_H
=20
-#include "git-compat-util.h"
 #include "cache.h"
 #include "commit.h"
=20
diff --git a/commit.h b/commit.h
index 1fe0731..dddc876 100644
--- a/commit.h
+++ b/commit.h
@@ -3,7 +3,6 @@
=20
 #include "object.h"
 #include "tree.h"
-#include "strbuf.h"
 #include "decorate.h"
 #include "gpg-interface.h"
 #include "string-list.h"
diff --git a/dir.h b/dir.h
index 727160e..6b00001 100644
--- a/dir.h
+++ b/dir.h
@@ -3,7 +3,6 @@
=20
 /* See Documentation/technical/api-directory-listing.txt */
=20
-#include "strbuf.h"
 #include "pathspec.h"
 #include "cache.h"
=20
diff --git a/khash.h b/khash.h
index 89f9579..fc8b1bf 100644
--- a/khash.h
+++ b/khash.h
@@ -26,7 +26,6 @@
 #ifndef __AC_KHASH_H
 #define __AC_KHASH_H
=20
-#include "git-compat-util.h"
 #include "cache.h"
=20
 #define AC_VERSION_KHASH_H "0.2.8"
