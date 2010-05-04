From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/5] shortlog: Document and test --format option
Date: Mon, 3 May 2010 21:59:55 -0500
Message-ID: <20100504025954.GE7322@progeny.tock>
References: <7v7hnmuvtv.fsf@alter.siamese.dyndns.org>
 <1272912875.3537.6.camel@dreddbeard>
 <20100504002526.GA7061@progeny.tock>
 <20100504015635.GA7258@progeny.tock>
 <20100504025217.GA7322@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 04 04:59:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O98MO-0003Xx-G9
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 04:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757495Ab0EDC7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 22:59:43 -0400
Received: from mail-iw0-f202.google.com ([209.85.223.202]:38993 "EHLO
	mail-iw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756435Ab0EDC7m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 22:59:42 -0400
Received: by iwn40 with SMTP id 40so4260142iwn.1
        for <git@vger.kernel.org>; Mon, 03 May 2010 19:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=HSK6hZhRKnwrRIpXZmcimwUefZ38x4wl+FJ0kwkqC2Y=;
        b=iiwEj9G3rqleh+tllKe1W/IZ1VusF605I5JdcFM7JEzzbc+87Tn5IcIg13eYji9NT/
         mN19GDp6hwB5BHOxWU3N+v5Dedx0E7bZW6u/FEZS+rk52lG2sGOXo3Jf/K+YWHN6CK3P
         UqDgJ0fpJ7GqgcXYfKwLwThcCbPulskOYRFnw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RSURh8DhnLrM/8TSWkZApKG/w+FeOl9sPKU9N3/47X7oYz07waUwYqvuEtYWcthHSD
         jEPTrCxtCJPWOnXe3PUfoHX/zZ97hnbIv0pLejkqqKBWiRX1itkFOZ2xeZKGmB23lOVM
         A38lwiLY0rQz0bA3VQ/gOsUmpk25w8mv8RFFk=
Received: by 10.231.145.146 with SMTP id d18mr2609121ibv.16.1272941980407;
        Mon, 03 May 2010 19:59:40 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm4898817iwn.2.2010.05.03.19.59.38
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 03 May 2010 19:59:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100504025217.GA7322@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146286>

Do not document the --pretty synonym, since it takes too long to
explain the name to people.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 - Pass HEAD to shortlog
 - Use {asterisk} helper for manual

 Documentation/git-shortlog.txt |    8 ++++++
 t/t4201-shortlog.sh            |   53 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 60 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index f11ea90..a820fcb 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -44,6 +44,14 @@ OPTIONS
 --email::
 	Show the email address of each author.
 
+--format[='<format>']::
+	Instead of the commit subject, use some other information to
+	describe each commit.  '<format>' can be any string accepted
+	by the `--format` option of 'git log', such as '{asterisk} [%h] %s'.
+	(See the "PRETTY FORMATS" section of linkgit:git-log[1].)
+
+	Each pretty-printed commit will be rewrapped before it is shown.
+
 -w[<width>[,<indent1>[,<indent2>]]]::
 	Linewrap the output by wrapping each line at `width`.  The first
 	line of each entry is indented by `indent1` spaces, and the second
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 6bfd0c0..13fdeb2 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -39,7 +39,58 @@ test_expect_success 'setup' '
 
 	echo 6 >a1 &&
 	git commit --quiet -m "Commit by someone else" \
-		--author="Someone else <not!me>" a1
+		--author="Someone else <not!me>" a1 &&
+
+	cat >expect.template <<-\EOF
+	A U Thor (5):
+	      SUBJECT
+	      SUBJECT
+	      SUBJECT
+	      SUBJECT
+	      SUBJECT
+
+	Someone else (1):
+	      SUBJECT
+
+	EOF
+'
+
+fuzz() {
+	file=$1 &&
+	sed "
+			s/$_x40/OBJECT_NAME/g
+			s/$_x05/OBJID/g
+			s/^ \{6\}[CTa].*/      SUBJECT/g
+			s/^ \{8\}[^ ].*/        CONTINUATION/g
+		" <"$file" >"$file.fuzzy" &&
+	sed "/CONTINUATION/ d" <"$file.fuzzy"
+}
+
+test_expect_success 'default output format' '
+	git shortlog HEAD >log &&
+	fuzz log >log.predictable &&
+	test_cmp expect.template log.predictable
+'
+
+test_expect_success 'pretty format' '
+	sed s/SUBJECT/OBJECT_NAME/ expect.template >expect &&
+	git shortlog --format="%H" HEAD >log &&
+	fuzz log >log.predictable &&
+	test_cmp expect log.predictable
+'
+
+test_expect_failure '--abbrev' '
+	sed s/SUBJECT/OBJID/ expect.template >expect &&
+	git shortlog --format="%h" --abbrev=5 HEAD >log &&
+	fuzz log >log.predictable &&
+	test_cmp expect log.predictable
+'
+
+test_expect_success 'output from user-defined format is re-wrapped' '
+	sed "s/SUBJECT/two lines/" expect.template >expect &&
+	git shortlog --format="two%nlines" HEAD >log &&
+	fuzz log >log.predictable &&
+	test_cmp expect log.predictable
 '
 
 test_expect_success 'shortlog wrapping' '
-- 
1.6.5
