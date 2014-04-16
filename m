From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH] Update SVN.pm
Date: Wed, 16 Apr 2014 16:16:05 +0200
Organization: <)><
Message-ID: <20140416141605.GA9692@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 16:24:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaQlU-0003oz-Ms
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 16:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161480AbaDPOYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 10:24:36 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:55065 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161403AbaDPOYg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 10:24:36 -0400
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 186B81C00ED
	for <git@vger.kernel.org>; Wed, 16 Apr 2014 16:16:06 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s3GEG5np009696
	for <git@vger.kernel.org>; Wed, 16 Apr 2014 16:16:05 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s3GEG5Gl009695
	for git@vger.kernel.org; Wed, 16 Apr 2014 16:16:05 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246335>

From: RomanBelinsky <belinsky.roman@gmail.com>
Date: Tue, 11 Feb 2014 18:23:02 +0200

fix parsing error for dates like:
2014-01-07T5:58:36.048176Z
previous regex can parse only:
2014-01-07T05:58:36.048176Z
reproduced in my svn repository during conversion.

Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 perl/Git/SVN.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index a59564f..09cff13 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1321,7 +1321,7 @@ sub get_untracked {
 sub parse_svn_date {
 	my $date = shift || return '+0000 1970-01-01 00:00:00';
 	my ($Y,$m,$d,$H,$M,$S) = ($date =~ /^(\d{4})\-(\d\d)\-(\d\d)T
-	                                    (\d\d)\:(\d\d)\:(\d\d)\.\d*Z$/x) or
+	                                    (\d\d?)\:(\d\d)\:(\d\d)\.\d*Z$/x) or
 	                                 croak "Unable to parse date: $date\n";
 	my $parsed_date;    # Set next.
 
-- 
1.9.2.msysgit.0.154.g978f18d
