From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/4] gitweb: Extend parse_difftree_raw_line to save commit info
Date: Thu, 31 Aug 2006 00:36:04 +0200
Message-ID: <200608310036.04302.jnareb@gmail.com>
References: <200608310030.33512.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 31 00:37:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIYga-0002lo-8V
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 00:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWH3WhV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Aug 2006 18:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWH3WhU
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Aug 2006 18:37:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:7397 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932219AbWH3WhP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Aug 2006 18:37:15 -0400
Received: by nf-out-0910.google.com with SMTP id x30so271645nfb
        for <git@vger.kernel.org>; Wed, 30 Aug 2006 15:37:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ChxtqXIPMjlvtrN2b19n2XiY85Bc8sp7AdJ1vZMa75pTQkcwCKIyA/BxPewlVh3KqUvxq5+i4oEABnjusPATVuxCBM0zIK2BzOxoUoLQtb0NmTi6r2fD+IVEPsR+iKe+7EgxJdNmzDs+eMs3KNLqUlg9aEN3QHO8DYRWzd3ZfjI=
Received: by 10.49.8.4 with SMTP id l4mr325536nfi;
        Wed, 30 Aug 2006 15:37:14 -0700 (PDT)
Received: from host-81-190-21-28.torun.mm.pl ( [81.190.21.28])
        by mx.gmail.com with ESMTP id o9sm377359nfa.2006.08.30.15.37.13;
        Wed, 30 Aug 2006 15:37:14 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608310030.33512.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26236>

Extend parse_difftree_raw_line to save commit info from when
git-diff-tree is given only one <tree-ish>, for example when fed
from git-rev-list using --stdin option.

git-diff-tree outputs a line with the commit ID when applicable.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This can be applied regardless that it is proof-of-concept series.
Need checking if it doesn't break anything.

 gitweb/gitweb.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d8b94a1..b193bc6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1014,9 +1014,9 @@ sub parse_difftree_raw_line {
 		}
 	}
 	# 'c512b523472485aef4fff9e57b229d9d243c967f'
-	#elsif ($line =~ m/^([0-9a-fA-F]{40})$/) {
-	#	$res{'commit'} = $1;
-	#}
+	elsif ($line =~ m/^([0-9a-fA-F]{40})$/) {
+		$res{'commit'} = $1;
+	}
 
 	return wantarray ? %res : \%res;
 }
-- 
1.4.1.1
