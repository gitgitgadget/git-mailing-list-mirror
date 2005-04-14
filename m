From: David Woodhouse <dwmw2@infradead.org>
Subject: Date handling.
Date: Thu, 14 Apr 2005 09:16:32 +0100
Message-ID: <1113466592.12012.192.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Apr 14 10:13:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLzTQ-0003rU-Df
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 10:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVDNIQg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 04:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbVDNIQg
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 04:16:36 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:1935 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261455AbVDNIQe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 04:16:34 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by baythorne.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DLzWb-0007yE-OZ
	for git@vger.kernel.org; Thu, 14 Apr 2005 09:16:33 +0100
To: git@vger.kernel.org
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The date handling is somewhat unreliable. We render dates into textual
representation using the committer's locale (day names, etc), then later
attempt to interpret that in some other locale. And we were just using
localtime without even specifying the timezone so the timestamp was
fairly randomised anyway. In fact, an $AUTHOR_DATE environment variable
was making its way into the database entirely unchecked. 

I see two possible solutions:
	1. Just store seconds-since-GMT-epoch and if we really want, the
	   timezone as auxiliary information.
	2. Store dates in RFC2822 form.

Unless someone convincingly expresses a preference before I get to work
and start playing with it, I'll implement the latter.

-- 
dwmw2


