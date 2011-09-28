From: Cord Seele <cowose@googlemail.com>
Subject: [PATCH] git-send-email.perl: expand filename of aliasesfile
Date: Wed, 28 Sep 2011 15:13:07 +0200
Message-ID: <20110928131307.GB12586@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 15:13:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8twr-0000RX-Vq
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 15:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214Ab1I1NNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 09:13:11 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46851 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333Ab1I1NNK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 09:13:10 -0400
Received: by bkbzt4 with SMTP id zt4so7999554bkb.19
        for <git@vger.kernel.org>; Wed, 28 Sep 2011 06:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:user-agent;
        bh=UcqIBKysTlJBkEjgeENJvd57FQfgnxMAOAG6w1ZnGcc=;
        b=BQ/tQWYrtw6AWYcmb4UnORF7Hnq6FgxORD/5Cdhul1ujqRlWDzpCVI9TJAB1kpF8hK
         GFVPqJXFakJLR8qrLl7V3E3NWw4k7OC8/vf9MVORmdMxMoP+y9hFTf+ceExiHXKJE8Vg
         mowtBivPg43JaOaDTwbB1y44X7pQtAle8qtvY=
Received: by 10.204.153.27 with SMTP id i27mr5929503bkw.278.1317215589226;
        Wed, 28 Sep 2011 06:13:09 -0700 (PDT)
Received: from laptop (p4FF1B1D8.dip.t-dialin.net. [79.241.177.216])
        by mx.google.com with ESMTPS id j16sm22734448bks.3.2011.09.28.06.13.08
        (version=SSLv3 cipher=OTHER);
        Wed, 28 Sep 2011 06:13:08 -0700 (PDT)
Mail-Followup-To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182310>

Allow config variable sendemail.aliasesfile to contain a tilde, i.e.
make ~/.mutt/aliases work.

Signed-off-by: Cord Seele <cowose@gmail.com>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 98ab33a..b50b35f 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -481,7 +481,7 @@ my %parse_alias = (
 
 if (@alias_files and $aliasfiletype and defined $parse_alias{$aliasfiletype}) {
 	foreach my $file (@alias_files) {
-		open my $fh, '<', $file or die "opening $file: $!\n";
+		open my $fh, '<', glob($file) or die "opening $file: $!\n";
 		$parse_alias{$aliasfiletype}->($fh);
 		close $fh;
 	}
-- 
1.7.6.4.dirty


-- Cord
