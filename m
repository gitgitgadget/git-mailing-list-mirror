From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 16/19] gitweb: Use git-diff-tree or git-diff patch output for blobdiff
Date: Sat, 26 Aug 2006 11:23:47 +0200
Organization: At home
Message-ID: <ecp3uq$k1f$1@sea.gmane.org>
References: <200608240015.15071.jnareb@gmail.com> <200608252113.34731.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Aug 26 11:24:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGuOh-0002eD-5K
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 11:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWHZJXv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 05:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWHZJXv
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 05:23:51 -0400
Received: from main.gmane.org ([80.91.229.2]:18592 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750801AbWHZJXu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Aug 2006 05:23:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GGuOK-0002cb-Hx
	for git@vger.kernel.org; Sat, 26 Aug 2006 11:23:48 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 26 Aug 2006 11:23:48 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 26 Aug 2006 11:23:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26041>

Jakub Narebski wrote:

> ATTENTION: The order of arguments (operands) to git-diff is reversed
> (sic!) to have correct diff in the legacy (no hash_parent_base) case.
> $hash_parent, $hash ordering is commented out, as it gives reversed
> patch (at least for git version 1.4.1.1) as compared to output in new
> scheme and output of older gitweb version.

By the way, wa it corrected later? git version 1.4.1.1


1010:jnareb@roke:~/git> git diff-tree 599f8d63140^ 599f8d63140 
:100644 100644 0bd517b2649af37d9980f85e784f9a00c3263922 8213ce240232a1dc8a0a498972323a33e8fcb7a0 M  builtin-grep.c


1011:jnareb@roke:~/git> git diff-tree -p 599f8d63140^ 599f8d63140
diff --git a/builtin-grep.c b/builtin-grep.c
index 0bd517b..8213ce2 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -293,9 +293,6 @@ static void compile_patterns(struct grep
         */
        p = opt->pattern_list;
        opt->pattern_expression = compile_pattern_expr(&p);
-#if DEBUG
-       dump_pattern_exp(opt->pattern_expression, 0);
-#endif
        if (p)
                die("incomplete pattern expression: %s", p->pattern);
 }


1012:jnareb@roke:~/git> git diff 0bd517b2649af37d9980f85e784f9a00c3263922 8213ce240232a1dc8a0a498972323a33e8fcb7a0
diff --git a/0bd517b2649af37d9980f85e784f9a00c3263922 b/0bd517b2649af37d9980f85e784f9a00c3263922
index 8213ce2..0bd517b 100644
--- a/0bd517b2649af37d9980f85e784f9a00c3263922
+++ b/0bd517b2649af37d9980f85e784f9a00c3263922
@@ -293,6 +293,9 @@ static void compile_patterns(struct grep
         */
        p = opt->pattern_list;
        opt->pattern_expression = compile_pattern_expr(&p);
+#if DEBUG
+       dump_pattern_exp(opt->pattern_expression, 0);
+#endif
        if (p)
                die("incomplete pattern expression: %s", p->pattern);
 }


-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
