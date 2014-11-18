From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 0/1] Don't make $GIT_DIR/config executable
Date: Tue, 18 Nov 2014 14:50:23 +0100
Message-ID: <1416318624-23048-1-git-send-email-mhagger@alum.mit.edu>
Cc: Eric Wong <normalperson@yhbt.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 14:50:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqjB5-0001J5-TQ
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 14:50:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753808AbaKRNuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 08:50:40 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:57852 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753300AbaKRNuj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Nov 2014 08:50:39 -0500
X-AuditID: 12074413-f79f26d0000030e7-74-546b4ea77cce
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id BB.6D.12519.7AE4B645; Tue, 18 Nov 2014 08:50:31 -0500 (EST)
Received: from michael.fritz.box (p5DDB3D42.dip0.t-ipconnect.de [93.219.61.66])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAIDoRUd004896
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 18 Nov 2014 08:50:28 -0500
X-Mailer: git-send-email 2.1.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsUixO6iqLvcLzvE4PIfKYuuK91MFg29V5gt
	nsy9y2yx8N9Rdov/OxawWNxeMZ/ZYn9TksWa7h1MFmfeNDJadHZ8ZXTg8vj7/gOTx85Zd9k9
	jh1rZfZ4+KqL3ePiJWWPxQ+8PD5vkvO4/Wwbi0fzlPOsAZxR3DZJiSVlwZnpefp2CdwZd0+v
	YSp4z1bxfu0f5gbGs6xdjBwcEgImEh3zfLoYOYFMMYkL99azdTFycQgJXGaU6JixlRXCOc4k
	8exHIzNIFZuArsSinmYmEFtEQE1iYtshFpAiZoE2ZokTl48ygkwVFrCV2HRDH6SGRUBVYuqF
	h6wgNq+Ai8SkXzugFstJbF3nPYGRewEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXXO93MwS
	vdSU0k2MkLAT3sG466TcIUYBDkYlHt6EqVkhQqyJZcWVuYcYJTmYlER5g3yyQ4T4kvJTKjMS
	izPii0pzUosPMUpwMCuJ8J7rBirnTUmsrEotyodJSXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJ
	ynBwKEnwWvkCDRUsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHhXl8MTDQQVI8QHtl
	QNp5iwsSc4GiEK2nGHU5Wpre9jIJseTl56VKifOmghQJgBRllObBrYAlmVeM4kAfC/OWglTx
	ABMU3KRXQEuYgJbM2ZAJsqQkESEl1cAo0ezQwx9vxPOlO/mMvXyx2ee9/7477lwXzF/9Sma6
	8Lle4xjPpX/eXlBa/WL+QZZ1S+5evXi31CvvyjnVOCfLr6dWGqir7O7vFq14Yhab 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a new, svelte version of the patch to avoid setting the u+x
bit on $GIT_DIR/config. Thanks to the many people who reviewed
versions v1 [1] and v2 [2].

This time there is no attempt to fix the permissions in existing
repositories; it only avoids creating new problems. It also includes a
test, as suggested by Eric and sketched by Junio.

This version, like the previous versions, applies to maint. But
(thanks to its new minimalist nature) this version can be merged to
master without conflict.

Michael

[1] http://thread.gmane.org/gmane.comp.version-control.git/259620
[2] http://thread.gmane.org/gmane.comp.version-control.git/259644

Michael Haggerty (1):
  create_default_files(): don't set u+x bit on $GIT_DIR/config

 builtin/init-db.c | 3 ++-
 t/t0001-init.sh   | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.1.3
