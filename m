From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFH] RPM gurus? (Re: rpmbuild fails)
Date: Wed, 11 Oct 2006 01:25:51 -0700
Message-ID: <7vpscztg1c.fsf@assigned-by-dhcp.cox.net>
References: <pan.2006.10.10.20.31.48.692444@alarsen.net>
	<200610110018.19035.Josef.Weidendorfer@gmx.de>
	<7v64erznyj.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Oct 11 10:26:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXZPe-0003t8-No
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 10:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965167AbWJKIZx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 04:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbWJKIZx
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 04:25:53 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:51925 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S965167AbWJKIZw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 04:25:52 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061011082551.FRIB6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Oct 2006 04:25:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YwRu1V00Y1kojtg0000000
	Wed, 11 Oct 2006 04:25:55 -0400
To: git@vger.kernel.org
In-Reply-To: <7v64erznyj.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 10 Oct 2006 17:38:12 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28704>

Junio C Hamano <junkio@cox.net> writes:

> Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:
>
>> Obviously, the generated perl/Makefile installs Git.pm
>> into the perl vendor *library* directory, and not the arch
>> one.

Does this look reasonable?

-- >8 --
git.spec.in: perl subpackage is installed in perl_vendorlib not vendorarch

Signed-off-by: Junio C Hamano <junio@hera.kernel.org>
---
 git.spec.in |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index 6d90034..9b1217a 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -97,7 +97,7 @@ find $RPM_BUILD_ROOT -type f -name '*.bs
 find $RPM_BUILD_ROOT -type f -name perllocal.pod -exec rm -f {} ';'
 
 (find $RPM_BUILD_ROOT%{_bindir} -type f | grep -vE "arch|svn|cvs|email|gitk" | sed -e s@^$RPM_BUILD_ROOT@@)               > bin-man-doc-files
-(find $RPM_BUILD_ROOT%{perl_vendorarch} -type f | sed -e s@^$RPM_BUILD_ROOT@@) >> perl-files
+(find $RPM_BUILD_ROOT%{perl_vendorlib} -type f | sed -e s@^$RPM_BUILD_ROOT@@) >> perl-files
 %if %{!?_without_docs:1}0
 (find $RPM_BUILD_ROOT%{_mandir} $RPM_BUILD_ROOT/Documentation -type f | grep -vE "arch|svn|git-cvs|email|gitk" | sed -e s@^$RPM_BUILD_ROOT@@ -e 's/$/*/' ) >> bin-man-doc-files
 %else
-- 
1.4.3.rc2.gcc59
