From: Robert Schiele <rschiele@gmail.com>
Subject: [PATCH] HP-UX traditionally has no sys/select.h
Date: Thu, 24 Jan 2008 18:53:00 +0100
Message-ID: <20080124175300.GI30676@schiele.dyndns.org>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 18:53:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI6Gj-0005WI-GR
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 18:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696AbYAXRxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 12:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752684AbYAXRxI
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 12:53:08 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:57446 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbYAXRxF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 12:53:05 -0500
Received: by fg-out-1718.google.com with SMTP id e21so310516fga.17
        for <git@vger.kernel.org>; Thu, 24 Jan 2008 09:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from:reply-to;
        bh=XBAY0l3osGtAo7tsxLK4gHLnOTu++aInVWEDCeA7CHQ=;
        b=cMCaYMSCv4ZWiEVFwG0kG3L1/PCGpWbRAvjqq8mB2+qHOB/CFJIjw5CvA+7ssJBT9eJCJF4cFMF6ba4QNpQfher6ArUabHBr+hZ5/u3FyNMo5CkMk63SaD4HNYLai8QGaxq9XdfiSo3to2ZWqPich4pWJ5ItSrhqZHQdc6jaR94=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from:reply-to;
        b=NzaqdJ6kk8R9P5MxXm5V/nqRI+yIvsBPPkBIAfxmz+jmQyfu0z9xjxQC0zEztbzJewz5ChK2CCakJ7Uc/wlGfsa5MD56MduREHyTGM3dQ3AgNuyvrqSywLLrEZtFXU8Ah1hvAvcLC0X2bGhuSyq/GIY4hP64cQ5UsRCVDfZ7Wts=
Received: by 10.86.89.4 with SMTP id m4mr881683fgb.12.1201197182481;
        Thu, 24 Jan 2008 09:53:02 -0800 (PST)
Received: from sigkill.schiele.dyndns.org ( [91.18.121.55])
        by mx.google.com with ESMTPS id 4sm1021757fge.3.2008.01.24.09.53.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Jan 2008 09:53:01 -0800 (PST)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 4A9DC2730C; Thu, 24 Jan 2008 18:53:00 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71636>

The select stuff is already in sys/time.h on traditional HP-UX
systems thus we should not include sys/select.h there because older
releases don't have it.
---
 git-compat-util.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index b6ef544..77de915 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -68,7 +68,9 @@
 #include <sys/poll.h>
 #include <sys/socket.h>
 #include <sys/ioctl.h>
+#ifndef __hpux
 #include <sys/select.h>
+#endif
 #include <assert.h>
 #include <regex.h>
 #include <netinet/in.h>
-- 
1.5.2.4
