From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 5/5] Git::SVN: rename private path field
Date: Mon, 17 Sep 2012 02:13:31 -0700
Message-ID: <20120917091331.GF358@elie.Belkin>
References: <1343419252-9447-1-git-send-email-schwern@pobox.com>
 <1343419252-9447-2-git-send-email-schwern@pobox.com>
 <20120917090435.GA358@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca,
	"Michael G. Schwern" <schwern@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 11:13:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDXOh-0006zb-HC
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 11:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755360Ab2IQJNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 05:13:36 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64302 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755342Ab2IQJNf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 05:13:35 -0400
Received: by pbbrr13 with SMTP id rr13so8707480pbb.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 02:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=huSsaGJd3Q1f3/HD3q6rvxDvbv4fuxEZmq+q45US1kM=;
        b=YhZWVKX5VDJ+wkw7EHuaBAy8FkozbpPFKmDOOXwUyqek5LDfJCsQ59anGa1R/jQOWB
         oSEvMDf6ElaNRPXYdJniO0CecBrNEB44Uo9+AjZgtuPZrEpi2HACYkbFcPZJU/WhnpaC
         lHCpziVqzfJpv8Ypil1Vm3RAOfGzNTciseHMwhMMT8BIKIJO/YWEA1e5WE6HNchfcgZL
         zwOISNqVCUnGLxoXvAB/pcRrGf6pB/pBxrR0hFXInCDiBkTOhWmG76z7l4XxTfrdXTfC
         fzmt6kbEsPb5r1C4wWDQFHjYgIliAWAUd4JEZw+7JL9kpEV5MhTnT1tHBqIrpzmnwFkE
         Ny0Q==
Received: by 10.66.83.234 with SMTP id t10mr19219359pay.39.1347873214847;
        Mon, 17 Sep 2012 02:13:34 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id gv1sm6630809pbc.38.2012.09.17.02.13.33
        (version=SSLv3 cipher=OTHER);
        Mon, 17 Sep 2012 02:13:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120917090435.GA358@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205670>

All users of $gs->{path} should have been converted to use the
accessor by now.  Check our work by renaming the underlying variable
to break callers that try to use it directly.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 perl/Git/SVN.pm |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 3aa20109..33f15682 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -2293,11 +2293,11 @@ sub path {
 
 	if (@_) {
 		my $path = shift;
-		$self->{path} = $path;
+		$self->{_path} = $path;
 		return;
 	}
 
-	return $self->{path};
+	return $self->{_path};
 }
 
 # for read-only access of old .rev_db formats
-- 
1.7.10.4
