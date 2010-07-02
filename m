From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 4/7] t/README: Document test_external*
Date: Fri,  2 Jul 2010 14:59:46 +0000
Message-ID: <1278082789-19872-5-git-send-email-avarab@gmail.com>
References: <1278082789-19872-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 02 17:01:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUhjg-0004LD-80
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 17:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758757Ab0GBPAv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jul 2010 11:00:51 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57428 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755851Ab0GBPAs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 11:00:48 -0400
Received: by mail-wy0-f174.google.com with SMTP id 23so1196622wyf.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 08:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=6e58sS19LK+9RiNIDDru8c+1PLgboLFB2uDAF5wSLlc=;
        b=uT3vZPo/99ycTyAon7lOEqNtymIA2NRkfcA2AZVbgrJCi35kRWDFidX+STvxvhox9P
         g3K/jFhbUtuUvqsIsS7GRVP40e0Na9+3ihH7pi/OpfitSFM/fcag5SMzxIB7a53ALY0A
         HncZPQ0VIX+eGuYuc7kewcTdoj8fjWpBeUqZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=dflxmghjK595ZFOhpuAbETobtDJ6sd5xohMxNRRRFhdD1f54/HV0B/3a/IEdyPJh2/
         so53/e581AdyVEvJX6SfRghJInUAWTVCL+7VvBeW6tVHhdRQg1jEG+rDY6I0atuVEEQl
         l/YqDwRv0fkxww/Skb0L5uFSaviPpiUcC9d0o=
Received: by 10.213.30.15 with SMTP id s15mr4058531ebc.69.1278082847887;
        Fri, 02 Jul 2010 08:00:47 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id a48sm6206858eei.19.2010.07.02.08.00.44
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 02 Jul 2010 08:00:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <1278082789-19872-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150132>

There was do documentation for the test_external_without_stderr and
test_external functions.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/README |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index c1fd092..b40403d 100644
--- a/t/README
+++ b/t/README
@@ -330,6 +330,33 @@ library for your script to use.
 	    test_done
 	fi
=20
+ - test_external [<prereq>] <message> <external> <script>
+
+   Execute a <script> with an <external> interpreter (like perl). This
+   was added for tests like t9700-perl-git.sh which do most of their
+   work in an external test script.
+
+	test_external \
+	    'GitwebCache::*FileCache*' \
+	    "$PERL_PATH" "$TEST_DIRECTORY"/t9503/test_cache_interface.pl
+
+   If the test is outputting its own TAP you should set the
+   test_external_has_tap variable somewhere before calling the first
+   test_external* function. See t9700-perl-git.sh for an example.
+
+	# The external test will outputs its own plan
+	test_external_has_tap=3D1
+
+ - test_external_without_stderr [<prereq>] <message> <external> <scrip=
t>
+
+   Like test_external but fail if there's any output on stderr,
+   instead of checking the exit code.
+
+	test_external_without_stderr \
+	    'Perl API' \
+	    "$PERL_PATH" "$TEST_DIRECTORY"/t9700/test.pl
+
+
 Tips for Writing Tests
 ----------------------
=20
--=20
1.7.1.251.g92a7
