From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 09/14] gitweb: split heads list in head view if appropriate
Date: Fri, 31 Aug 2007 13:18:40 +0200
Message-ID: <11885591321597-git-send-email-giuseppe.bilotta@gmail.com>
References: <cb7bb73a0708301915y47ca4a05nf511889b2bb2eaec@mail.gmail.com>
 <11885591201440-git-send-email-giuseppe.bilotta@gmail.com>
 <11885591283893-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 13:21:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR4Yr-0002jD-Jd
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 13:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbXHaLU7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 07:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbXHaLU6
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 07:20:58 -0400
Received: from qb-out-0506.google.com ([72.14.204.230]:30330 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932397AbXHaLUk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 07:20:40 -0400
Received: by qb-out-0506.google.com with SMTP id e11so1069197qbe
        for <git@vger.kernel.org>; Fri, 31 Aug 2007 04:20:39 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZH8f7B6ExxQfrFtSM8iEQ9zNvrWDuEFen45VJV0kO+kuPFlDmVTBu+Cs8NPQ8oJq3nc1osqaK2YCDriFxuDEX76Lux5PGu71HyOcoTQLN5HnHeLTszWcM4sRVIioddsjCDeR0lzLbRsZScnSWJf0gDdfxfJpkypDvtNzQPO1h3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WY4v2VuRp6VI2LMPuEoJ+EcCW8w+i4PiRbNHLhKdr5PyHtqAxMCoAj7HfqUH3Dx8jJBaQOl1FVR5B9Nyz1tS7eisUnTqxo057zYmJD7jlGcF2uiDuDlV6TEPTEXvNj9HacuaN8Ohj07FTiRoJ/7LNyfbDQh7ec4nwjRMRGuRR/c=
Received: by 10.65.74.9 with SMTP id b9mr3133056qbl.1188559239184;
        Fri, 31 Aug 2007 04:20:39 -0700 (PDT)
Received: from localhost ( [84.221.55.162])
        by mx.google.com with ESMTPS id 7sm6850134nfv.2007.08.31.04.20.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 31 Aug 2007 04:20:34 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.5
In-Reply-To: <11885591283893-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57157>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6dfb2f4..09d9793 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4195,6 +4195,9 @@ sub git_heads {
 
 	my @headslist = git_get_heads_list();
 	if (@headslist) {
+		my ($remote_heads) = gitweb_check_feature('remote_heads');
+		$remote_heads ? 
+		git_split_heads_body(\@headslist, $head) :
 		git_heads_body(\@headslist, $head);
 	}
 	git_footer_html();
-- 
1.5.2.5
