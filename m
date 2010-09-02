From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/4] gitweb: make logo optional
Date: Thu, 2 Sep 2010 18:56:23 -0500
Message-ID: <20100902235623.GD6466@burratino>
References: <20100812131152.2333.9604.reportbug@octopus.hi.pengutronix.de>
 <20100902221211.GA4789@burratino>
 <20100902223624.GA9613@dcvr.yhbt.net>
 <20100902235237.GA6466@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Sep 03 01:58:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrJfn-0000Bt-7A
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 01:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757383Ab0IBX6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 19:58:13 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:32864 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757351Ab0IBX6L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 19:58:11 -0400
Received: by mail-qw0-f46.google.com with SMTP id 6so1108899qwh.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 16:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=qCVQt3j+JqF0FnYBYp3L97vZ08kexzewvX8CJXYn9Ts=;
        b=EMmM/gJ+BOR9uBxNF/OIGxfC9fAZaoY9UH83hUWIEoCXh1fzHj+PFx6KBMlo4fyycQ
         wgBpwLsQ2zVu/j0cSyU33bHAlNbUODlyFjUKG4IxQj68x2T2I/V5nKZirjMj6N9TW5/u
         umwQntZG8w6b6vyKyM8ESRvEPvEQHxgRoR0N4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oo4h5m/Sc5mY7P0nZqmJIcprfRpEGc7vH5seumv+f2ESoChhUicSaEwRhRQcqf8e8g
         aXyTU3oCt/UWwtjAPAbnnGR9W2EIxU5WtRdxL8ybhc5YQB4yEEdG4klI2JQ3NuNCrApf
         Z8YXE3/PxzMg9BOBmFrSBwQFs8EA9bHvn5ExQ=
Received: by 10.224.74.1 with SMTP id s1mr685526qaj.26.1283471891021;
        Thu, 02 Sep 2010 16:58:11 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id f15sm1112268qcr.37.2010.09.02.16.58.09
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 16:58:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100902235237.GA6466@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155227>

Some sites may not want to have a logo at all.  In particular,
git instaweb can benefit from this.

Cc: Jakub Narebski <jnareb@gmail.com>
Cc: Eric Wong <normalperson@yhbt.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 gitweb/gitweb.perl |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index cc20e74..9a72562 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3269,10 +3269,12 @@ EOF
 		insert_file($site_header);
 	}
 
-	print "<div class=\"page_header\">\n" .
-	      $cgi->a({-href => esc_url($logo_url),
-	               -title => $logo_label},
-	              qq(<img src="$logo" width="72" height="27" alt="git" class="logo"/>));
+	print "<div class=\"page_header\">\n";
+	if (defined $logo) {
+		print $cgi->a({-href => esc_url($logo_url),
+		               -title => $logo_label},
+		              qq(<img src="$logo" width="72" height="27" alt="git" class="logo"/>));
+	}
 	print $cgi->a({-href => esc_url($home_link)}, $home_link_str) . " / ";
 	if (defined $project) {
 		print $cgi->a({-href => href(action=>"summary")}, esc_html($project));
-- 
1.7.2.2
