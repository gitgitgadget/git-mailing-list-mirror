From: "Paul Oliver" <puzza007@gmail.com>
Subject: [PATCH] Make git-cvsimport remove ['s from tags, as bad_ref_char doesn't allow them.
Date: Fri, 23 May 2008 19:29:22 +0100
Message-ID: <a4cc77ec0805231129t45b2b81cka3365a71505240a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Miklos Vajna" <vmiklos@frugalware.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 20:30:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzc2I-0000So-Jv
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 20:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759469AbYEWS3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 14:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759464AbYEWS3Z
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 14:29:25 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:59847 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759274AbYEWS3X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 14:29:23 -0400
Received: by rv-out-0506.google.com with SMTP id l9so940394rvb.1
        for <git@vger.kernel.org>; Fri, 23 May 2008 11:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=U71a9AcAjjLHXDfqAyDmVYhR9RCNEUFhYqniPkXbjQU=;
        b=C1jbhPqymZ8jF9PzcGOBbO8esS6lXvYGZtz3vfePxH59etd3rsqwOonepKZo8WEI/xxxuJvsqbXvjy9rUX/UlIqinGER1IJ/reHzYMlLnqV7xlTs7veMwWMDN96yK8Ycnm4KADvW0EynQhyxtesq3u09kCrZSG+ajgrH1GZOA8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=n9SMi3uYeNilBDdTjXDqUOMeZCcfMkZkpln1rs3/RXgqmNIwwTuE6aopFkVZaaW4PTDgjv/u3+Utx/LgGaYxYJ6YDKbz46znrExM0ItXtWKVHyboIkCF97/jbwAjhvXpSTXzM1ExjGR52UNr2rl3YdMY0Oj2mJw5r+LZkj9B3a8=
Received: by 10.140.203.9 with SMTP id a9mr790290rvg.288.1211567362159;
        Fri, 23 May 2008 11:29:22 -0700 (PDT)
Received: by 10.141.136.7 with HTTP; Fri, 23 May 2008 11:29:22 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82725>

Signed-off-by: puzza007 <puzza007@gmail.com>
---
 git-cvsimport.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index bdac5d5..5a02550 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -780,6 +780,7 @@ sub commit {
 		$xtag =~ s/\s+\*\*.*$//; # Remove stuff like ** INVALID ** and ** FUNKY **
 		$xtag =~ tr/_/\./ if ( $opt_u );
 		$xtag =~ s/[\/]/$opt_s/g;
+		$xtag =~ s/\[//g;

 		system('git-tag', '-f', $xtag, $cid) == 0
 			or die "Cannot create tag $xtag: $!\n";
-- 
1.5.3.6
