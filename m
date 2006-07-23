From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH 3/4] gitweb.cgi: Show "raw" head of project link even when $hash is not defined
Date: Sun, 23 Jul 2006 13:30:08 -0700 (PDT)
Message-ID: <20060723203008.94485.qmail@web31805.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-72965512-1153686608=:93849"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sun Jul 23 22:30:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4kae-0000C8-TY
	for gcvg-git@gmane.org; Sun, 23 Jul 2006 22:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWGWUaK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Jul 2006 16:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWGWUaK
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Jul 2006 16:30:10 -0400
Received: from web31805.mail.mud.yahoo.com ([68.142.207.68]:25168 "HELO
	web31805.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751300AbWGWUaI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jul 2006 16:30:08 -0400
Received: (qmail 94487 invoked by uid 60001); 23 Jul 2006 20:30:08 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=3kzb2+0LNZcEgoNAYKRbR8DJlUDVbXqGsyP8Q4fg4/f07VqNO/RKt2+AYV/JoyHaPZ/WdXyjEsnMRfIksgA5UvHLiGr1PgiWkuDnejFQbLDAGdM2oEb+pHGzTVMw4FZJmwHrCQr2UZ0G/lRwZX+2RQkuCZXJF8hombepZgQQWWQ=  ;
Received: from [71.80.232.189] by web31805.mail.mud.yahoo.com via HTTP; Sun, 23 Jul 2006 13:30:08 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24102>

--0-72965512-1153686608=:93849
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Some callers of git_history() do not set $hash of $file_name.
Add code to find it, if it is not defined.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.cgi |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)
--0-72965512-1153686608=:93849
Content-Type: text/inline; name="p3.patch"
Content-Description: 963471848-p3.patch
Content-Disposition: name="p3.patch"; filename="p3.patch"

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 7a61de4..c04283b 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -2326,7 +2326,9 @@ sub git_history {
 	print "<div>\n" .
 	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_base"), -class => "title"}, esc_html($co{'title'})) . "\n" .
 	      "</div>\n";
+	if (!defined $hash && defined $file_name) {
+		$hash = git_get_hash_by_path($hash_base, $file_name);
+	}
 	if (defined $hash) {
 		my $ftype = git_get_type($hash);
 
-- 
1.4.2.rc1.g9b54


--0-72965512-1153686608=:93849--
