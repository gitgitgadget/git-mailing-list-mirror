From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/3] test: use test_i18ncmp for "Patch format detection
 failed" message
Date: Fri, 13 Apr 2012 23:46:18 -0500
Message-ID: <20120414044618.GC1791@burratino>
References: <20110320090111.GA15641@sigill.intra.peff.net>
 <20110320090918.GB15948@sigill.intra.peff.net>
 <20120413225901.GA13220@burratino>
 <20120413233010.GA16663@sigill.intra.peff.net>
 <20120413234607.GE13995@burratino>
 <20120414022452.GA17535@sigill.intra.peff.net>
 <20120414044413.GA1791@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 14 06:46:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIusY-0003pW-6a
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 06:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244Ab2DNEq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 00:46:26 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50010 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175Ab2DNEqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 00:46:25 -0400
Received: by iagz16 with SMTP id z16so5107120iag.19
        for <git@vger.kernel.org>; Fri, 13 Apr 2012 21:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=csZrCasMxiWeqb8f3xBk22LNBAFkMnrvA+6Nc/Gteq4=;
        b=Gi6EMoHczQ8UVRXSSa9XkExpJ062vhET49eADqlpSpixyeLiz+y2gz9mPiaokkUrgJ
         o4rtqewl6DnIA1+WcsHn2OmMT/tBIuMCE57sjyuCiVJpoS6l650SBa4df4/59dxSfuxk
         RZJDTT85Q3LwqwHmVWsNrdqvHJhoIrgcI9jFG7qhM3HKj63c9X+8dbaRB5YOreEyUUx4
         bzvZYsWV9hXiyRQ1As74gpZnDTPJMNj3pwzGvt60o93IA7i/QUJxx49ShHcNXyxFVkW+
         9FftnYN0HGJw5JjLAAWnCweNqjjRnzHzxL+dBcnwrNazIWGcBRGFG5UIcmcNl9hxY+MP
         DrKA==
Received: by 10.50.42.164 with SMTP id p4mr389450igl.72.1334378785059;
        Fri, 13 Apr 2012 21:46:25 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id en3sm2461263igc.2.2012.04.13.21.46.23
        (version=SSLv3 cipher=OTHER);
        Fri, 13 Apr 2012 21:46:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120414044413.GA1791@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195467>

v1.7.8.5~2 (am: don't infloop for an empty input file, 2012-02-25)
added a check for the human-readable message "Patch format detection
failed." but we forgot to suppress that check when running tests with
git configured to write output in another language.

Noticed by running tests with GETTEXT_POISON=YesPlease.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t4150-am.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index ccc0280f..ebb4a26a 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -527,7 +527,7 @@ test_expect_success 'am empty-file does not infloop' '
 	test_tick &&
 	{ git am empty-file > actual 2>&1 && false || :; } &&
 	echo Patch format detection failed. >expected &&
-	test_cmp expected actual
+	test_i18ncmp expected actual
 '
 
 test_done
-- 
1.7.10
