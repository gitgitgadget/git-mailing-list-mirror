From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb: Enable tree (directory) history display
Date: Mon, 27 Feb 2006 10:55:54 -0800 (PST)
Message-ID: <20060227185554.75822.qmail@web31810.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Feb 27 19:56:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDnXN-0002u5-N6
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 19:56:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbWB0Sz6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 13:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbWB0Sz6
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 13:55:58 -0500
Received: from web31810.mail.mud.yahoo.com ([68.142.207.73]:27045 "HELO
	web31810.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751621AbWB0Sz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 13:55:58 -0500
Received: (qmail 75824 invoked by uid 60001); 27 Feb 2006 18:55:54 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=tDnxf0z3VTD00AxXsdJs3nbvVIncPhQkRhIaDAlcfg63whS+L+mFOgMbfkEONjNnZ4xssoflE+jLp/GAokXjr8wKfRjj2F/GT0ZWkvADIM2zGd4iUvPOvTyeS6iMg041wc2lH9MWQdA/KadxutXYCFaZOajhHWq5tWt2pND77jo=  ;
Received: from [68.186.53.141] by web31810.mail.mud.yahoo.com via HTTP; Mon, 27 Feb 2006 10:55:54 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16876>

Hi,

I find this patch very useful, especially when a directory (tree) describes
a project.

This patch allows history display of whole trees/directories,
a la "git-rev-list HEAD <dir or file>", but somewhat
slower, since exported git repository doesn't have
the files checked out so we have to use
"$gitbin/git-rev-list $hash | $gitbin/git-diff-tree -r --stdin \'$file_name\'"
method.  Maybe someone can find a speed up for this.  And better yet,
maybe links can be static as opposed to dynamic, so that you don't have to
navigate each and everytime if you want to find the history of the same
directory.

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
+                             " | " . $cgi->a({-href => "$my_uri?" .
esc_param("p=$project;a=history;h=$hash_base;f=$base$t_name")}, "history") .
                              "</td>\n";
                }
                print "</tr>\n";
-- 
1.2.3.g6db0
