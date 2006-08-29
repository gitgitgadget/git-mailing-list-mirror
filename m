From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH] use do() instead of require() to include configuration
Date: Tue, 29 Aug 2006 09:19:02 +0200
Message-ID: <20060829071902.G648e8860@leonov.stosberg.net>
References: <20060824151246.G465d67c8@leonov.stosberg.net> <11567801982990-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 29 09:19:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHxsM-0006jS-41
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 09:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWH2HTG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Aug 2006 03:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWH2HTG
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 03:19:06 -0400
Received: from kleekamp.stosberg.net ([85.116.201.130]:18563 "EHLO
	kleekamp.stosberg.net") by vger.kernel.org with ESMTP
	id S1750833AbWH2HTE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Aug 2006 03:19:04 -0400
Received: by kleekamp.stosberg.net (Postfix, from userid 500)
	id E4E28E8B1D; Tue, 29 Aug 2006 09:19:02 +0200 (CEST)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <11567801982990-git-send-email-jnareb@gmail.com>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26191>

When run under mod_perl, require() will read and execute the configuration
file on the first invocation only.  On every subsequent invocation, all
configuration variables will be reset to their default values.  do() reads
and executes the configuration file unconditionally.

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 352236b..39ebcf4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -152,7 +152,7 @@ # - one might want to include '-B' optio
 our @diff_opts = ('-M'); # taken from git_commit
 
 our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
-require $GITWEB_CONFIG if -e $GITWEB_CONFIG;
+do $GITWEB_CONFIG if -e $GITWEB_CONFIG;
 
 # version of the core git binary
 our $git_version = qx($GIT --version) =~ m/git version (.*)$/ ? $1 : "unknown";
-- 
1.4.2
