From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCHv2 0/3] Show author and/or committer in some cases
Date: Thu,  1 May 2008 14:09:32 +0200
Message-ID: <1209643775-2362-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 14:10:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrXcd-0004kc-Nn
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 14:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756926AbYEAMJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 08:09:57 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756936AbYEAMJ5
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 08:09:57 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:1094 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756926AbYEAMJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 08:09:56 -0400
Received: by fg-out-1718.google.com with SMTP id 19so526390fgg.17
        for <git@vger.kernel.org>; Thu, 01 May 2008 05:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=bBo1k1tzuK0HkUIwmEBPLSHAkhaE6O74j1bwWGwMgwY=;
        b=pJGV8rNdvtj0SJYLllrYs8GBFiEK91luoYTGfRlwWGFheMXnEnU2ZBMtNM10IXUflMuXeUO60G5xMm3gxZcCnQEu9wLH70tEmczMxu51iXBoSbGfehnLP6lH0W2ixE48MbLn/aVe5ahTTs93x9tY5t8s5EkYcnzQeu1s8kZsMnA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=RWVctzlIvydhAzkSC0gO84hTCyabOwTKaLy1950FG/usVGVfBxXDAWyZD6L0tZpngrVxO1rQdCluV3BeDVZ28yN8oE0RODD7VkTEFWTICmtR+YXWtqWNRaVLZCUAwPrPfRKkk03R//6tUi1VCH7x+nHBdWML2qym9DBrVzBTVL0=
Received: by 10.86.4.14 with SMTP id 14mr1927473fgd.44.1209643795134;
        Thu, 01 May 2008 05:09:55 -0700 (PDT)
Received: from localhost ( [91.13.119.190])
        by mx.google.com with ESMTPS id g1sm9758945muf.7.2008.05.01.05.09.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 May 2008 05:09:54 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.102.gfcc7d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80901>

Hi *,

  This patch series tries to make more evident the author and committer=
 ident
used in a commit trying to minimize when it is shown.

Changes since v1:

- Add blank line before and after Author/Committer lines,
  but not beetween
- Fix for the initial commit, thanks to Jeff
- Only show the committer if not set with the user.* configs.

Santi

Santi B=C3=A9jar (3):
  Preparation to call determine_author_info from prepare_to_commit
  commit: Show author if different from committer
  commit: Show committer if different from the parent and automatic

 builtin-commit.c  |  135 +++++++++++++++++++++++++++++++++++++--------=
--------
 cache.h           |    1 +
 config.c          |    4 ++
 environment.c     |    1 +
 t/t7502-commit.sh |   23 +++++++++
 5 files changed, 124 insertions(+), 40 deletions(-)
