From: Ian Ward Comfort <icomfort@stanford.edu>
Subject: [PATCH/RFC] Ship bash completion package in RPMs
Date: Fri, 19 Mar 2010 11:26:53 -0700
Message-ID: <1269023213-18432-1-git-send-email-icomfort@stanford.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 19 19:27:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsguj-0001RD-L7
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 19:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100Ab0CSS04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 14:26:56 -0400
Received: from smtp1.Stanford.EDU ([171.67.219.81]:47175 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751942Ab0CSS04 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 14:26:56 -0400
Received: from smtp.stanford.edu (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id 97B1B1789BB
	for <git@vger.kernel.org>; Fri, 19 Mar 2010 11:26:55 -0700 (PDT)
Received: from ashbury.stanford.edu (ashbury.Stanford.EDU [171.67.43.200])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.stanford.edu (Postfix) with ESMTPS id 025AD178991
	for <git@vger.kernel.org>; Fri, 19 Mar 2010 11:26:54 -0700 (PDT)
Received: by ashbury.stanford.edu (Postfix, from userid 26037)
	id D2B081D0054; Fri, 19 Mar 2010 11:26:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142627>

RPM-based distributions tend to have bash. Let's add the bash completion
routines to our core RPM in the standard location.

---

... Unless this is undesirable because the completion support is in contrib/?
Anyway, having this upstream would save me some patching, so I thought I'd
give it a shot.

 git.spec.in |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index ee74a5e..d2527c3 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -127,6 +127,9 @@ find $RPM_BUILD_ROOT -type f -name perllocal.pod -exec rm -f {} ';'
 rm -rf $RPM_BUILD_ROOT%{_mandir}
 %endif
 
+mkdir -p $RPM_BUILD_ROOT%{_sysconfdir}/bash_completion.d
+install -m 644 -T contrib/completion/git-completion.bash $RPM_BUILD_ROOT%{_sysconfdir}/bash_completion.d/git
+
 %clean
 rm -rf $RPM_BUILD_ROOT
 
@@ -136,6 +139,7 @@ rm -rf $RPM_BUILD_ROOT
 %doc README COPYING Documentation/*.txt
 %{!?_without_docs: %doc Documentation/*.html Documentation/howto}
 %{!?_without_docs: %doc Documentation/technical}
+%{_sysconfdir}/bash_completion.d
 
 %files svn
 %defattr(-,root,root)
-- 
1.7.0.2
