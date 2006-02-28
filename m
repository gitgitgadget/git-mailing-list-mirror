From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH 1/2] Enable tree (directory) history display
Date: Tue, 28 Feb 2006 04:38:54 -0800 (PST)
Message-ID: <20060228123854.79702.qmail@web31815.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Feb 28 13:39:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FE48B-00054G-SR
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 13:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbWB1Mi4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 07:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbWB1Mi4
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 07:38:56 -0500
Received: from web31815.mail.mud.yahoo.com ([68.142.206.168]:46694 "HELO
	web31815.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751804AbWB1Miz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2006 07:38:55 -0500
Received: (qmail 79704 invoked by uid 60001); 28 Feb 2006 12:38:54 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=6s83/EqT+jw8vSBPPx1+2M2f0iXUTSRLvjoFxw+DVeyJpqZZRe5AQHP3K3jBv8EN2CmgmtBTQ5tLWnfzy3dlLL9TRVoUXmcbLN7ENIkgSzEDUL//cbA8kgZXdG/PvrPqOZWWNQZXLafNz3cvhdHI0KTsDA6yEtBcelIgxcvW1SE=  ;
Received: from [68.186.53.141] by web31815.mail.mud.yahoo.com via HTTP; Tue, 28 Feb 2006 04:38:54 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16931>

This patch allows history display of whole trees/directories,
a la "git-rev-list HEAD <dir or file>", but somewhat
slower, since exported git repository doesn't have
the files checked out so we have to use
"$gitbin/git-rev-list $hash | $gitbin/git-diff-tree -r --stdin \'$file_name\'"
method.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>

---

 gitweb.cgi |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

5c8ae3db3561238a57201fcb3297f16d7b37f377
diff --git a/gitweb.cgi b/gitweb.cgi
index c1bb624..452528f 100755
--- a/gitweb.cgi
+++ b/gitweb.cgi
@@ -1504,6 +1504,7 @@ sub git_tree {
 			      "</td>\n" .
 			      "<td class=\"link\">" .
 			      $cgi->a({-href => "$my_uri?" .
esc_param("p=$project;a=tree;h=$t_hash$base_key;f=$base$t_name")}, "tree") .
+			      " | " . $cgi->a({-href => "$my_uri?" .
esc_param("p=$project;a=history;h=$hash_base;f=$base$t_name")}, "history") .
 			      "</td>\n";
 		}
 		print "</tr>\n";
-- 
1.2.3.g975a
