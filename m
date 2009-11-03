From: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
Subject: [PATCH 0/1] Port of pthreads to Windows API threads
Date: Tue,  3 Nov 2009 22:30:01 +0100
Message-ID: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com>
Cc: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 03 22:30:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5QxU-0001ry-HL
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 22:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429AbZKCVaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 16:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754413AbZKCVaN
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 16:30:13 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:54154 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278AbZKCVaM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 16:30:12 -0500
Received: by bwz27 with SMTP id 27so8109508bwz.21
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 13:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=g2n4XPzBpRn66+Su/c+TF6JYw8MnCCNLVsA+8eGp9mo=;
        b=LtBYuiJsLUQ0fW58t5kiKXnLlwYcOr860S1GoNP6vJsX9FnJCKqgs/qzVrz+H7Zyct
         trDzSfbtkwdm0ZtfbQ/rV9aMe92xqvGuNCwb+FmEIoBinVBh4kANW+jx5Vkzby53GC3D
         mVs9q87YiIwO39Im/bP3nnsSbyvg7WkZcP2EE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=KoNkPwIwB/c6fhZH5jKoTwt4Ortd3ayFKAWvYHa7YSOhS8GGv8cyx38N2C1CT62yvf
         uTmMh6kl9sttGueKNHGKMEwOy5Zm//GcC/mPS8lxviwYvn6yJKmjI6KV2kLMXIc85N8k
         SytCw2GCTd5Jn37uvHC82fbcF0c3y7jwM+HSg=
Received: by 10.204.35.142 with SMTP id p14mr563016bkd.21.1257283816629;
        Tue, 03 Nov 2009 13:30:16 -0800 (PST)
Received: from evo.home.haczewski.net (14-mi2-10.acn.waw.pl [85.222.57.14])
        by mx.google.com with ESMTPS id z15sm1252593fkz.44.2009.11.03.13.30.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Nov 2009 13:30:16 -0800 (PST)
Received: by evo.home.haczewski.net (Postfix, from userid 1000)
	id 751DEA7EADE; Tue,  3 Nov 2009 22:30:13 +0100 (CET)
X-Mailer: git-send-email 1.6.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131998>

Here is a small patch that allows use of native Windows API threads for
where git uses pthreads. I don't have full msysgit environment to test it,
all I know is it compiles, so someone else could test it a little. I enabled
it for MSVC only (since msysgit uses win32-pthreads and cygwin has it's own).
I assume that patch could help with getting rid of that one dependency for
msysgit.

PS. I'm new here (actually new for whole kernel-like-development-cycle-with-
patches-flying-low-on-mailing-lists), so please be kind to my stupidity for
a while... please? ;-)

Andrzej K. Haczewski (1):
  MSVC: port pthread code to native Windows threads

 Makefile               |    2 +-
 builtin-pack-objects.c |   42 +++++++++-
 compat/winthread.h     |  219 ++++++++++++++++++++++++++++++++++++++++++++++++
 preload-index.c        |   12 +++
 4 files changed, 272 insertions(+), 3 deletions(-)
 create mode 100644 compat/winthread.h
