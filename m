From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/5] gitweb: Use "return" instead of "return undef" for some subs
Date: Tue, 26 Sep 2006 01:56:17 +0200
Message-ID: <200609260156.17939.jnareb@gmail.com>
References: <200609260153.08503.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Sep 26 02:00:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS0NF-0005hZ-NH
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 02:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbWIZAAK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 20:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbWIZAAJ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 20:00:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:47704 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751780AbWIZAAD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Sep 2006 20:00:03 -0400
Received: by ug-out-1314.google.com with SMTP id o38so538803ugd
        for <git@vger.kernel.org>; Mon, 25 Sep 2006 17:00:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fSMF465jOLQoajfV1oWvbRgMToyp5UCR2JCnBYHv2up0xLc+zkLu6uuGygCLIhHy2U1xhMbHG8M/nRsRY/VC/Te3N9h5TNAzwbCpjRiKd/3/cBNxOge3ZX+jW+E0uKpWhcxryaFRERtxl5F7jV6j4qlVQgoHFfzeb5UqSeIsYjU=
Received: by 10.66.242.20 with SMTP id p20mr85899ugh;
        Mon, 25 Sep 2006 17:00:02 -0700 (PDT)
Received: from host-81-190-26-109.torun.mm.pl ( [81.190.26.109])
        by mx.gmail.com with ESMTP id s1sm2153117uge.2006.09.25.17.00.01;
        Mon, 25 Sep 2006 17:00:01 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200609260153.08503.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27761>

Use "return" instead of "return undef" when subroutine can return, or
always return, non-scalar (list) value.

Other places are left as is.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is inspired by "gitweb: Fix @git_base_url_list usage" patch
(74d6166751ddcf08029ffc90a14158a86f80cd40) by Petr Baudis.

 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2ad7eed..6458d7b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -106,7 +106,7 @@ our %feature = (
 
 sub gitweb_check_feature {
 	my ($name) = @_;
-	return undef unless exists $feature{$name};
+	return unless exists $feature{$name};
 	my ($sub, $override, @defaults) = (
 		$feature{$name}{'sub'},
 		$feature{$name}{'override'},
@@ -781,7 +781,7 @@ sub git_get_projects_list {
 		# 'git%2Fgit.git Linus+Torvalds'
 		# 'libs%2Fklibc%2Fklibc.git H.+Peter+Anvin'
 		# 'linux%2Fhotplug%2Fudev.git Greg+Kroah-Hartman'
-		open my ($fd), $projects_list or return undef;
+		open my ($fd), $projects_list or return;
 		while (my $line = <$fd>) {
 			chomp $line;
 			my ($path, $owner) = split ' ', $line;
-- 
1.4.2.1
