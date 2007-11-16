From: "Elijah Newren" <newren@gmail.com>
Subject: git-cvsimport bug with dates
Date: Thu, 15 Nov 2007 21:59:44 -0700
Message-ID: <51419b2c0711152059q55ced86gd224310c8c4a1851@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 16 06:00:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IstJE-0003pO-2w
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 06:00:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756171AbXKPE7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 23:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753179AbXKPE7q
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 23:59:46 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:50941 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756047AbXKPE7p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 23:59:45 -0500
Received: by wa-out-1112.google.com with SMTP id v27so914668wah
        for <git@vger.kernel.org>; Thu, 15 Nov 2007 20:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=yJ8oZxXkTvuBu3fZ4bd4Cwf0Yl2Eu/rnp/I7tyyrvDw=;
        b=c+MryhRhfPEwgZfDJZsLz7iQpMDXn0WTfKUbssX52WCYamAglzUqy4tYtb4R7MgcFGVEoLQZMmHoNvqg/mM/Fg0Ux344TIWx3preu2aniKdoDoT6I606GzrkLocuL2D+an6IegtxF0Ael5anoHDFTvFsR7lAoV7WSNoLweDb6Jo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=T0rkp3zZ0/Dk7R2uAWZNQ51lYamRHRViHdmeFgqT7B6Wt5q/4GpeHG+U6Aeyf9e1gRVjnXj+Sz/Afm4gTQKrdOqgPeP5SNlhyeogcHGctzjrXSHFLSk/dRetYWjWwy98IJ2yxqtT9o55B9HmoRBOPqQBePNJVpRYxiY8CIfN4nk=
Received: by 10.115.108.1 with SMTP id k1mr40303wam.1195189184147;
        Thu, 15 Nov 2007 20:59:44 -0800 (PST)
Received: by 10.114.211.8 with HTTP; Thu, 15 Nov 2007 20:59:44 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65189>

Hi,

It appears that there's some kind of bug with git-cvsimport and dates.
 In a small repository I imported on Oct 24, I'm getting:

$ git log | grep ^Date | wc -l
957
$ git log | grep ^Date | tail
Date:   Tue Oct 29 21:10:17 2002 +0000
Date:   Tue Oct 29 17:41:05 2002 +0000
Date:   Tue Oct 29 00:43:27 2002 +0000
Date:   Mon Oct 28 23:36:40 2002 +0000
Date:   Mon Oct 21 21:35:57 2002 +0000
Date:   Fri Sep 20 22:18:01 2002 +0000
Date:   Mon Sep 16 20:05:27 2002 +0000
Date:   Wed Sep 11 21:14:03 2002 +0000
Date:   Tue Sep 10 16:37:16 2002 +0000
Date:   Fri Aug 23 16:03:22 2002 +0000
$ git diff @{2007-10-01}
warning: Log for '' only goes back to Wed, 24 Oct 2007 19:31:38 +0000.
fatal: bad object @{2007-10-01}


It appears that passing a date to git diff on any repository imported
by git-cvsimport will show this error, as long as the date is prior to
when the repository was imported.


Elijah
