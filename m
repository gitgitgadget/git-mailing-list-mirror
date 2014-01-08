From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] t5537: fix incorrect expectation in test case 10
Date: Wed,  8 Jan 2014 19:13:19 +0700
Message-ID: <1389183199-6496-1-git-send-email-pclouds@gmail.com>
References: <20140108112543.GA4419@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 08 13:08:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0rw4-00014z-0U
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 13:08:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414AbaAHMId convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jan 2014 07:08:33 -0500
Received: from mail-pd0-f170.google.com ([209.85.192.170]:65381 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755201AbaAHMIb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 07:08:31 -0500
Received: by mail-pd0-f170.google.com with SMTP id g10so1714127pdj.1
        for <git@vger.kernel.org>; Wed, 08 Jan 2014 04:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+8A1XHc06vTVMEtujKi+E6ij9GY/6mFY4LwSA752yRg=;
        b=cCXeAQlWFjPz/Z4oUAfuS9RBJ/yeR5ZKnKkldleVUmHz4yyg2uH+J8HNCM7IO+jcgv
         hsfsq+abGh7hch7a9C0P1xkCiVU+czOVPSV1fyiugZAXWRF2kbfaw2H4zPNZg68VHhxo
         GsjZ48fAu+b4VD2N522d+duRsFXExNUHfknrhLLJ0C1nftCymHxZ45rHQcSR04aNn8Y6
         w9qSeqUfFFZUTRogNATj6X3E2SHYvuWm/jZ/K/TCw291zvE98G9jz9pIt1UfzMhtg5yY
         J1+zIBNMf1DK38pfnMagLMDmBq6FeO8APnPtHITrjtmizQoTUKqkRvrprTTua8ZT9y96
         Tvag==
X-Received: by 10.68.203.197 with SMTP id ks5mr29805327pbc.14.1389182910851;
        Wed, 08 Jan 2014 04:08:30 -0800 (PST)
Received: from lanh ([115.73.249.143])
        by mx.google.com with ESMTPSA id wp8sm1985984pbc.26.2014.01.08.04.08.07
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 08 Jan 2014 04:08:28 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 08 Jan 2014 19:13:21 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <20140108112543.GA4419@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240211>

Commit 48d25ca adds a new commit "7" to the repo that the next test cas=
e
in commit 1609488 clones from. But the next test case does not expect
this commit. For these tests, it's the bottom that's important, not
the top. Fix the expected commit list.

While at it, fix the default http port number to 5537. Otherwise when
t5536 learns to test httpd, running test in parallel may fail.

References:

48d25ca fetch: add --update-shallow to accept... - 2013-12-05
1609488 smart-http: support shallow fetch/clone - 2013-12-05

Noticed-by: Jeff King <peff@peff.net>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I obviously made a mistake with patch reordering or something. And
 embarassing because I did not run tests with GIT_TEST_HTTPD again
 before submission.

 t/t5537-fetch-shallow.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 79ce472..b0fa738 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -178,7 +178,7 @@ if test -n "$NO_CURL" -o -z "$GIT_TEST_HTTPD"; then
 	test_done
 fi
=20
-LIB_HTTPD_PORT=3D${LIB_HTTPD_PORT-'5536'}
+LIB_HTTPD_PORT=3D${LIB_HTTPD_PORT-'5537'}
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
=20
@@ -190,6 +190,7 @@ test_expect_success 'clone http repository' '
 	git fsck &&
 	git log --format=3D%s origin/master >actual &&
 	cat <<EOF >expect &&
+7
 6
 5
 4
--=20
1.8.5.2.240.g8478abd
