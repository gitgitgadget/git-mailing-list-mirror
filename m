From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 0/2] git-am foreign patch support
Date: Mon, 25 May 2009 21:14:04 +0200
Message-ID: <1243278846-14120-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 21:14:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8fcx-0002ls-48
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 21:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778AbZEYTOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 15:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752722AbZEYTOL
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 15:14:11 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:47103 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbZEYTOK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 15:14:10 -0400
Received: by fxm12 with SMTP id 12so1539209fxm.37
        for <git@vger.kernel.org>; Mon, 25 May 2009 12:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=BKTfnFhEBC1nUYTGBTWoXNesIxHnuPgjdwsKPjkujAI=;
        b=d3qTD9LK/Am8PmL0oFUDP0/t+KydkpQnv2UdxGBnQU+/X+JEcBajaT1uhTO8zbksfS
         IrP8HAw/x4h4oi98AFAKxR5Mdc0I1nCMKzgu28zcYzWaLw8HimXCcqoLbHrq1rwLa5vq
         w/+ndy3XXmjdrsZZc0fTnMT32uKicVu2DGiis=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=bKS+Ykmb34oyYfDWEjCpn5C+o9ZYm6KQIb8ubSQidhq7W6iKMjjvGwEeuXqW4wsCS4
         fIJDGYrg/YBlhmbO8bGUwpR5ta2DVT5+N3Z2w4uzGshvQgrLxLySaYh2uAYX+a5PN73f
         6UMjfZ39E2KihpSeHAiOGtQHUKL0PhikU8KNU=
Received: by 10.103.137.12 with SMTP id p12mr3860705mun.94.1243278851185;
        Mon, 25 May 2009 12:14:11 -0700 (PDT)
Received: from localhost (host-78-15-9-104.cust-adsl.tiscali.it [78.15.9.104])
        by mx.google.com with ESMTPS id s11sm944697mue.50.2009.05.25.12.14.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 May 2009 12:14:10 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.245.g4529.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119953>

This small patchset introduces a framework to allow git-am to support
patchsets not in mailbox format.

The first patch introduces a new patch_format variable that holds the
(autodetected) patch format. All patches are assumed to be in the same
format. Autodetection for Mercurial and StGIT patches is also
implemented, including series index expansion for StGIT.

The second patch introduces actual support for StGIT patches by using
some awk code to convert them to mailbox format.

Giuseppe Bilotta (2):
  git-am foreign patch support: format autodetection
  git-am foreign patch support: StGIT

 git-am.sh |  140 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 137 insertions(+), 3 deletions(-)
