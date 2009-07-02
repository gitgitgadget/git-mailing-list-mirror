From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 0/2] git apply: cope with whitespace differences
Date: Thu,  2 Jul 2009 14:52:15 +0200
Message-ID: <1246539137-24754-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Robert Fitzsimons <robfitz@273k.net>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 14:52:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMLmC-00056H-Ld
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 14:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475AbZGBMwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 08:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752246AbZGBMwV
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 08:52:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:14447 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbZGBMwU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 08:52:20 -0400
Received: by fg-out-1718.google.com with SMTP id e12so1106378fga.17
        for <git@vger.kernel.org>; Thu, 02 Jul 2009 05:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=RA/IzacxX/5u9KqQtIoaSPxh/OEAsPSgiSVOMAeqhiI=;
        b=fWSsJ+gOOnxU2/1j2VLNRTYRhg95j4roHxb+4utsHWnlewQbinjnHrgGSZX0wEVBAZ
         0d+5MVNXysep39eumsXeDiKUIyl62Lp5HMyFKtHlY8JhDtldDBml6ovfca/6fWq6qYou
         RC9+x63mm2GoNusvICLksh29RQGnlVlFpdyx8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=SHQKfsOeZDyqiKaFiA2qjUJUhfhyV4KU6SiH2+5cq8Vkye4Ivk0wWG/kU4mbOLRtbD
         hTpuYRK036gHYoPSVnmP9xg3Grf2MsgLcdM4COKL5cF/qKf4XVGKj0AbipLn6LXSh0Pu
         0AVOo1XUZHSUMxAnFCa9aDn+ujyVeup4qj/xw=
Received: by 10.86.65.18 with SMTP id n18mr171960fga.7.1246539142766;
        Thu, 02 Jul 2009 05:52:22 -0700 (PDT)
Received: from localhost (host-78-15-5-16.cust-adsl.tiscali.it [78.15.5.16])
        by mx.google.com with ESMTPS id 4sm13806422fge.8.2009.07.02.05.52.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Jul 2009 05:52:21 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.3.512.g1f6a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122641>

A small patchset that allows git-apply (and thus git-am and git-rebase)
to cope with whitespace differences that would otherwise generate a conflict.

The first patch is basically an update of Rober Fitzsimons' previous work
http://permalink.gmane.org/gmane.comp.version-control.git/7876
whereas the second one is entirely mine and makes the context lines
match the original instead of the patched whitespace.

Giuseppe Bilotta (2):
  git apply: option to ignore whitespace differences
  git apply: preserve original whitespace with --ignore-whitespace

 builtin-apply.c                        |   83 ++++++++++++++++++++++++++++++--
 contrib/completion/git-completion.bash |    2 +
 git-am.sh                              |    3 +-
 git-rebase.sh                          |    3 +
 t/t4107-apply-ignore-whitespace.sh     |   74 ++++++++++++++++++++++++++++
 5 files changed, 159 insertions(+), 6 deletions(-)
 create mode 100755 t/t4107-apply-ignore-whitespace.sh
