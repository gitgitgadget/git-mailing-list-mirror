From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v5 0/2] cleanup duplicate name_compare() functions
Date: Thu, 19 Jun 2014 19:06:42 -0700
Message-ID: <1403230004-11034-1-git-send-email-jmmahler@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeremiah Mahler <jmmahler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 04:07:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxoEc-0001AD-4s
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 04:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754516AbaFTCHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 22:07:08 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:58938 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201AbaFTCHH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 22:07:07 -0400
Received: by mail-pd0-f179.google.com with SMTP id w10so2414979pde.24
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 19:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=PfqkK2KcQHlRFSdnIupYKsSljCcln+S3axZjG78/MBY=;
        b=hx9OZLkipAD9Ky9WOSbfHXOpDFG42coRpqxqyThPAIyneLy8PYAcX6kgzToH/5RTHi
         htT36w2ysY+K17UDkbb9mLXs17jx7hLBG3QkO6Satxp1MYpBJpo6Xdti2tCpf+Mb/rT2
         CUDhM8nAPshNG3ra1Ps1pHlMxjKWozIqiC9i3vPDlG62EC4XMrWp3r1dSywZy8lbHhWT
         3RJT/K2UfAGhNAbpHxaHCQsRMgHMoQHbnDS00eCa7OdM/JN5iFVkYUm2yVEcHTxvj91q
         RuLyHijIac7VPutQkWgaFZ8A0DP7VacZ40PW8e7d9DKLhbOqfDFTZFMtdx1t4xAy2weM
         LWxQ==
X-Received: by 10.66.228.133 with SMTP id si5mr523934pac.48.1403230025822;
        Thu, 19 Jun 2014 19:07:05 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id h5sm10703399pbw.81.2014.06.19.19.07.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jun 2014 19:07:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.694.g5736dad
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252205>

Version 5 of the patch series to cleanup the duplicate name_compare()
functions.

  - name-hash.c had a call to cache_name_compare() but it required that
    the lengths were equal.  Since cache_name_compare() is equivalent to
    memcmp() when the lengths are equal, replace it with memcmp().
    This avoids renaming cache_name_compare() to name_compare() in a
    later patch.

  - Cleanup of log message by Junio C Humano.


Jeremiah Mahler (2):
  name-hash.c: replace cache_name_compare() with memcmp()
  cleanup duplicate name_compare() functions

 cache.h        |  2 +-
 dir.c          |  3 +--
 name-hash.c    |  2 +-
 read-cache.c   | 23 +++++++++++++----------
 tree-walk.c    | 10 ----------
 unpack-trees.c | 11 -----------
 6 files changed, 16 insertions(+), 35 deletions(-)

-- 
2.0.0.694.g5736dad
