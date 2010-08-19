From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v3 0/4] Support for running tests outside t/ + don't run a TODO test
Date: Thu, 19 Aug 2010 16:08:08 +0000
Message-ID: <1282234092-27429-1-git-send-email-avarab@gmail.com>
References: <1282138473-15613-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 19 18:08:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om7fM-0001LY-2O
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 18:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419Ab0HSQIZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 12:08:25 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:34318 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080Ab0HSQIY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 12:08:24 -0400
Received: by wwf26 with SMTP id 26so4268384wwf.1
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 09:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=5QWGRv4pw3mgS4xiVKN8casOhwHEt9R6X8nzuL5QUuM=;
        b=ryTTBs8VaJ+VuVdsFHwwCZIloBsRL7hcCEoZFdy918pCtj6iRNUbcDVDJyWt/GeHFY
         jNPuPCrsQPRQnj3WvsfrunTAlQNrvLDu3r9P9tjPmKN/5GB9MEQBCsupwI4L+/zOeZHk
         4aV1enufKD3+lG0m7CXS3gUZSyCSCzmNWRFzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=UU8Ky0B8T2wdgYnCAQRcsev8yC6h9XoBl8DycvqKDot27srw53xjmp3O+kCCC2IcF0
         hguH5D6zUDT7uPmHwVKIN6hN2BxOmJQbYF+tMxYy+NAHdTiSB9LKG7W/+HebVehmxcdb
         UNuONLBM3W4HiNxDEG/RK7txWw9jwG9Pkzbvk=
Received: by 10.227.155.20 with SMTP id q20mr37992wbw.98.1282234102722;
        Thu, 19 Aug 2010 09:08:22 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e8sm1118781wej.46.2010.08.19.09.08.21
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 19 Aug 2010 09:08:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.446.g168052
In-Reply-To: <1282138473-15613-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153936>

This *really* v3, I just sent another copy of v2 unchanged
accidentally (this is really not my day). This one:

 * Fixes a trivial shell syntax error in the last patch (oops!)

 * Uses #!$SHELL_PATH for a shebang instead of #!/bin/sh in the file
   we're about to write out. This now passes e.g. on Solaris which has
   an insane /bin/sh.

As an aside there's a bunch of other things in our tests that are
writing out shellscripts with a #!/bin/sh shebang instead of
#!$SHELL_PATH. These are passing purely by accident since they just
happen to use shell syntax that doesn't run afoul of grumpy old shells
like Solaris's /bin/sh.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (4):
  test-lib: Use $TEST_DIRECTORY or $GIT_BUILD_DIR instead of $(pwd) and
    ../
  test-lib: Use "$GIT_BUILD_DIR" instead of "$TEST_DIRECTORY"/../
  test-lib: Allow overriding of TEST_DIRECTORY
  t/t0000-basic.sh: Run the passing TODO test inside its own test-lib

 t/t0000-basic.sh |   31 +++++++++++++++++++++++++++++++
 t/test-lib.sh    |   39 +++++++++++++++++++++++----------------
 2 files changed, 54 insertions(+), 16 deletions(-)

--=20
1.7.2.1.446.g168052
