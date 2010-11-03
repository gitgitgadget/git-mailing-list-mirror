From: martin.von.zweigbergk@gmail.com
Subject: [PATCH 0/5] Make git-rebase.sh more readable and easier to extend
Date: Wed,  3 Nov 2010 22:09:35 +0100
Message-ID: <1288818580-7576-1-git-send-email-martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 04 04:10:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDqDR-0001u6-Ta
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 04:10:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492Ab0KDDKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 23:10:11 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:57010 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653Ab0KDDKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 23:10:09 -0400
Received: by qyk10 with SMTP id 10so860265qyk.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 20:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=pU8xRDwkPFY6FTDCh2u0QARA+VezzBInJp+F4tCNxJc=;
        b=hbMa4un6ZSgcplJddzICVDj2aA8EhOAhWF3xwhvgo4kU/91VYZvtlGC1dPnm3Iq/6T
         H/HHe5s+Hx0fOutr4BiBUKYvdxf25ak0QmdOkxIsm2BEovtkdlEzE+7nE4dI8VIogVpN
         CBZiriOMGsZ7iitd58MNHL+E3FrTS6BMDj4Xk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=Dj0NKHGrojgGsHlEPdQ+AVTzSDtMr3yF6Fyudavyj2+DE5cI49B8IEHdurbsBDD7nC
         fWPfuc1OgpacdedcEqB6Wwgdfa++9JlNHQ9zkYx2Qq2UIojZqZWH0gz5a+FmNpGjNxii
         xldLyZmYleC5IN/vRsGadIKFII2k33kDobnZE=
Received: by 10.229.215.76 with SMTP id hd12mr117768qcb.44.1288840209067;
        Wed, 03 Nov 2010 20:10:09 -0700 (PDT)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id u2sm7746119qcq.31.2010.11.03.20.10.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 20:10:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.4.g5879b6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160682>

This is my first patch set to mail to this list, so I hope I get things right...

This patch set tries to make git-rebase.sh a bit more readable and to make it a
bit easier to extend. The only change in behavior that I know I have introduced
(in PATCH 2) is that "git rebase (--continue | --skip)" when an empty
"$GIT_DIR/rebase-merge" exists now gives slightly fewer error messages while
trying to cat files in that directory. The only reason for this change was to
make it better aligned with the behavior when an empty
"$GIT_DIR/rebase-apply" exists.

These patches are related to, but different from, the mail I sent about
extracting common code between git-rebase.sh and git-rebase--interactive.sh (see
http://thread.gmane.org/gmane.comp.version-control.git/160517). I would like to
base that work on the current patch set.

 git-rebase.sh |  148 +++++++++++++++++++++++++--------------------------------
 1 files changed, 65 insertions(+), 83 deletions(-)
