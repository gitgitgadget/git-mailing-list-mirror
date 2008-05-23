From: "Paul Oliver" <puzza007@gmail.com>
Subject: [PATCH] Make git-cvsimport remove ['s from tags, as bad_ref_char doesn't allow them.
Date: Fri, 23 May 2008 13:00:05 +0100
Message-ID: <a4cc77ec0805230500r756ba085x2161ff8769bd4369@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 14:01:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzVxF-0005mv-6j
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 14:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbYEWMAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 08:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752362AbYEWMAH
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 08:00:07 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:51252 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbYEWMAG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 08:00:06 -0400
Received: by rv-out-0506.google.com with SMTP id l9so721672rvb.1
        for <git@vger.kernel.org>; Fri, 23 May 2008 05:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=BZk315tzrVFHmGNlxLbLVDfKTzQSIBPm9YDnZrHlMwU=;
        b=JzT2ZGG2615tul21BKRzkiLOklPs8Z3cnzFljXcKrH4Vpj6lmYJArcdpv+7U6EyT2DKzKpvlJaYETF3ZWhsekc8q/d+nEgfudyUw9UQuQeLZ2fbffBneljpZOiUsdjGSLwBjxetcDXR9/20G2B5nxuTjlUyUw/aJSUKu3ECmOL0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dS2qZ0ZL0PfO/LvBt3YxhXY4QRCl5JNr6h5MyzB7Rof1xVowu2SdHOHWDTA0mIbO8DMlz6P10HMbQ8rzDqw7EAyIZV9/X5/7RZu5c8S/e6hrdFCs3sB+E6PtYiH10ifc+OHRiRjvCcDVGOfgCTpv5fCAqddCTZl6m6MwBtdUnHg=
Received: by 10.140.132.8 with SMTP id f8mr609911rvd.206.1211544005295;
        Fri, 23 May 2008 05:00:05 -0700 (PDT)
Received: by 10.141.136.7 with HTTP; Fri, 23 May 2008 05:00:05 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82697>

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
