From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 1/3] tests: Adjust the configuration for Apache 2.2
Date: Mon, 09 May 2016 09:42:32 -0700
Message-ID: <xmqqwpn3w5c7.fsf@gitster.mtv.corp.google.com>
References: <cover.1462342213.git.johannes.schindelin@gmx.de>
	<cover.1462774709.git.johannes.schindelin@gmx.de>
	<4a15c4e6c35cfb425da568d87e8b20b984e5325c.1462774709.git.johannes.schindelin@gmx.de>
	<20160509080315.GA14383@sigill.intra.peff.net>
	<alpine.DEB.2.20.1605091557050.4092@virtualbox>
	<20160509142711.GA9552@sigill.intra.peff.net>
	<alpine.DEB.2.20.1605091710310.4092@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Lars Schneider <larsxschneider@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 09 18:42:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azoGY-0001ms-FJ
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 18:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbcEIQmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 12:42:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61788 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751076AbcEIQmg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 12:42:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C37BA1AA16;
	Mon,  9 May 2016 12:42:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7HbHEK5zCmFBcmhTumqZoiE7VFE=; b=lrdzBi
	CJfUIFkP1I34UPqx/5qTpNCgOWnr9mHpHrDUOCluc/ILJUzPjJnOZ9u1Z6SuMSw2
	dScfuOCDSiMQlyE8FPxbx6G9fZwnuhOZ9S9MkwlrJL1h9Gz69XFPbS7kFpI3MUPP
	Z8LKuKAF/MSGzMqwEh2ne0+NRkw+IonPlcEMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Un9b67vEZ2xtFvKpMElfS5hojqh9EHxd
	Ek51UtpIowkSAw9bDT6Hp055m6Jo08ymtEIiW9V0su7o1HdYtTHMcRVBkr99AC0c
	skx9W+ix/IaM1GX6d0ndklfzklm9MZ+1V4Vwq/QtX5Hh/Y3+6gH4KAaNJXlN0Mty
	KZcnaa+zeng=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BA55B1AA15;
	Mon,  9 May 2016 12:42:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 320311AA10;
	Mon,  9 May 2016 12:42:34 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1605091710310.4092@virtualbox> (Johannes
	Schindelin's message of "Mon, 9 May 2016 17:11:44 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 07C21636-1605-11E6-B6A5-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294014>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Okay, I already force-pushed my extra-http-header branch and the next
> iteration will sport this paragraph.

The new explanation is well written and can and should also replace
the comment before the implementation in the configuration file to
help readers.

To be honest, I do not quite understand why you call it "ugly hack"
at all.  It is saying "The client is sending a satisfactory request
when these two headers are there; otherwise the request is not
good", which sounds quite natural way to express what is being
tested.  The rejection being part of "Rewrite" may be clever, but I
do not see it as ugly.

And it matches the spirit of the implementation for 2.3+ that uses
<RequireAll/> quite well--you just do not need to say "Fail"
yourself over there, as that is implied.

> Hopefully your patch to remove the -c ... sanitizing makes it to `master`
> soon, then I can submit my next iteration.

Or we can just merge that "do not sanitize" branch in, and then
queue the "next iteration" which I'd assume would only be the test
addition?

Thanks.

-- >8 --
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Mon, 9 May 2016 07:59:16 +0200
Subject: [PATCH] tests: adjust the configuration for Apache 2.2

Lars Schneider noticed that the configuration introduced to test the
extra HTTP headers cannot be used with Apache 2.2 (which is still
actively maintained, as pointed out by Junio Hamano).

To let the tests pass with Apache 2.2 again, let's substitute the
offending <RequireAll> and `expr` by using old school RewriteCond
statements.

As RewriteCond does not allow testing for *non*-matches, we simply match
the desired case first and let it pass by marking the RewriteRule as
'[L]' ("last rule, do not process any other matching RewriteRules after
this"), and then have another RewriteRule that matches all other cases
and lets them fail via '[F]' ("fail").

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/lib-httpd/apache.conf | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 838770c..2dcbb00 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -102,10 +102,6 @@ Alias /auth/dumb/ www/auth/dumb/
 	Header set Set-Cookie name=value
 </LocationMatch>
 <LocationMatch /smart_headers/>
-	<RequireAll>
-		Require expr %{HTTP:x-magic-one} == 'abra'
-		Require expr %{HTTP:x-magic-two} == 'cadabra'
-	</RequireAll>
 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
 	SetEnv GIT_HTTP_EXPORT_ALL
 </LocationMatch>
@@ -135,6 +131,18 @@ RewriteRule ^/ftp-redir/(.*)$ ftp://localhost:1000/$1 [R=302]
 RewriteRule ^/loop-redir/x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-(.*) /$1 [R=302]
 RewriteRule ^/loop-redir/(.*)$ /loop-redir/x-$1 [R=302]
 
+# Apache 2.2 does not understand <RequireAll>, so we use RewriteCond.
+# And as RewriteCond does not allow testing for non-matches, we match
+# the desired case first (one has abra, two has cadabra), and let it
+# pass by marking the RewriteRule as [L], "last rule, do not process
+# any other matching RewriteRules after this"), and then have another
+# RewriteRule that matches all other cases and lets them fail via '[F]',
+# "fail the request".
+RewriteCond %{HTTP:x-magic-one} =abra
+RewriteCond %{HTTP:x-magic-two} =cadabra
+RewriteRule ^/smart_headers/.* - [L]
+RewriteRule ^/smart_headers/.* - [F]
+
 <IfDefine SSL>
 LoadModule ssl_module modules/mod_ssl.so
 
-- 
2.8.2-557-gee41d5e
