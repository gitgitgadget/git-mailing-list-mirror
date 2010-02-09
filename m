From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: OS X Unicode Normalization Hits Again
Date: Mon, 8 Feb 2010 22:38:45 -0500
Message-ID: <C417EBAD-9254-448C-9FD1-2D2FABB8CF32@gernhardtsoftware.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 04:38:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NegwB-0002w8-Ni
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 04:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753549Ab0BIDiu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2010 22:38:50 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:38585 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150Ab0BIDiu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Feb 2010 22:38:50 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 5F1651FFC1CE; Tue,  9 Feb 2010 03:38:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-67-240-172-169.rochester.res.rr.com [67.240.172.169])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id CFEA61FFC146
	for <git@vger.kernel.org>; Tue,  9 Feb 2010 03:38:37 +0000 (UTC)
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139353>

git fails test t3902-quoted for me starting with 8424981: Fix invalid r=
ead in quote_c_style_counted

The problem isn't with the code, or the test.  It's that OS X is "norma=
lizing" the file paths again.

diff --git a/t/t3902-quoted.sh b/t/t3902-quoted.sh
index 5868052..14da45f 100755
--- a/t/t3902-quoted.sh
+++ b/t/t3902-quoted.sh
@@ -33,6 +33,7 @@ for_each_name () {
=20
 test_expect_success setup '
=20
+       mkdir "caract=E8re sp=E9cial" &&
        for_each_name "echo initial >\"\$name\""
        git add . &&
        git commit -q -m Initial &&

Git makes the directory "caract\303\250re sp\303\251cial" but OS X stor=
es "caracte\314\200re spe\314\201cial".

Should I just alter the test to use the same form as OS X, or is there =
a better method?

~~ Brian
