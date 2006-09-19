From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Require project for all actions except few
Date: Tue, 19 Sep 2006 14:38:28 +0200
Message-ID: <200609191438.28685.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 19 14:37:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPerD-0004cQ-7J
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 14:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbWISMho (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 08:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbWISMho
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 08:37:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:63402 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030223AbWISMhn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Sep 2006 08:37:43 -0400
Received: by nf-out-0910.google.com with SMTP id o25so137633nfa
        for <git@vger.kernel.org>; Tue, 19 Sep 2006 05:37:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=hZhP3bXyk4GbT/uBllZfFfeVKhQaJwUQEywNKEAF+vuOAoZUK1kjE0MdQYDYFTXPKxxi+9u+RFawBz1+gEFZTObS1o54YNSI68tjfTmwC58SsJ6ijOn1Mgz+XxuIslvCZD+6e+Ub2chjOWK9t4MYNjWivVFr2hhWJTsmoJkiofo=
Received: by 10.78.200.3 with SMTP id x3mr3893234huf;
        Tue, 19 Sep 2006 05:37:42 -0700 (PDT)
Received: from host-81-190-25-93.torun.mm.pl ( [81.190.25.93])
        by mx.gmail.com with ESMTP id 35sm13297119huc.2006.09.19.05.37.38;
        Tue, 19 Sep 2006 05:37:39 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27276>

Require that project (repository) is given for all actions except project_list,
project_index and opml.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 034cdf1..34311ee 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -341,6 +341,10 @@ if (defined $project) {
 if (!defined($actions{$action})) {
 	die_error(undef, "Unknown action");
 }
+if ($action !~ m/^opml|project_list|project_index$/ &&
+    !$project) {
+	die_error(undef, "Project needed");
+}
 $actions{$action}->();
 exit;
 
-- 
1.4.2.1
