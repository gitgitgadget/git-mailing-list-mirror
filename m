From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] cvs: initialize empty password
Date: Thu, 17 Sep 2009 09:21:02 +0200
Message-ID: <20090917072101.GA12769@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Dirk =?iso-8859-1?Q?H=F6rner?= <dirker@gmail.com>,
	Pascal Obry <pascal@obry.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 09:21:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoBIu-0001SD-Bj
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 09:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758481AbZIQHVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 03:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758348AbZIQHVJ
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 03:21:09 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:64810 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755910AbZIQHVI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 03:21:08 -0400
Received: by fg-out-1718.google.com with SMTP id 22so1408486fge.1
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 00:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:bcc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=ydWqyLreO/gQnqaaj7zBd2u+kx64uFAyIbJf2vzYeTo=;
        b=chjwe2CV41l8YuxhFs3ZaIfaygmhqZnkeS/i69PKKger9Lp+Hyuv5xugML2SfbMaac
         AN9h9+jQWkaIVPS1ow/MQ0DlATuF499No98zw+Xjvu/uKWCgczmDjuMbPdw/UvZ+JFDB
         JFbcVE7mbFQkF50unYl9RF4BNTJo46KCLhc8I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        b=PVeI2DTk5ZkmEZKBb6jYMUltrjxst/akE9UOFWVTaSWz7/2GbzjY3zkb7JfBsJ0LWP
         92CA/r8aUmWEt5l9k8QwhoH4j+s0io2WaU89gZWezPSV9F46IESL8gW9YDwJirwmPAq4
         nB/ncmBRP3fx0SLzXdYrzDympn6CKT1dy8iQQ=
Received: by 10.86.226.5 with SMTP id y5mr229228fgg.36.1253172071080;
        Thu, 17 Sep 2009 00:21:11 -0700 (PDT)
Received: from darc.lan (p549A4B63.dip.t-dialin.net [84.154.75.99])
        by mx.google.com with ESMTPS id 12sm515650fgg.0.2009.09.17.00.21.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Sep 2009 00:21:09 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MoBIc-00067O-1O; Thu, 17 Sep 2009 09:21:02 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128721>

If we do not read a password from the command line, and there are no
passwords stored in .cvspass, we have to initialize the password with
just "A".

This fixes a regression introduced by 3fb9d582 (Do not scramble
password read from .cvspass).

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 git-cvsimport.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index d741115..1ad20ac 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -253,6 +253,7 @@ sub conn {
 					}
 				}
 			};
+			$pass = "A" unless $pass;
 		}
 
 		my ($s, $rep);
-- 
1.6.5.rc0
