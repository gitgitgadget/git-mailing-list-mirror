From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/2] auto-detect getdelim()
Date: Tue,  2 Jun 2015 17:15:42 -0400
Message-ID: <1433279744-23379-1-git-send-email-sunshine@sunshineco.com>
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 23:16:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YztY4-0008Ap-Lp
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 23:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbbFBVQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 17:16:26 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:32866 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbbFBVQD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 17:16:03 -0400
Received: by igbpi8 with SMTP id pi8so96237411igb.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 14:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=z0kqUf7+AidBUyzm9vEcZYxr7bD6daVml/qlktu5ZS4=;
        b=s5FKIiRSYTZ7XvAeK9RRDLz9gXt1f0WFKGAIF/GHzq/SVGBC0jLSuuM2nVRTUTWrsY
         gqDMbCFw9dYtFoXjpo9JwdOGqZWiZg5xFRHsBxhWfKeoEyslVKKqPRlx1E7SuTFWEJZr
         EBgwOSkTBonK4bSpSIvqQTM6WQ6seddohtAUTNcfBKj9ibsyXGoOQZYVR0X4lvYbbYyC
         /FLAGenwhpsPLRdxtP6UvpGAwourkJ6aaF6VkCRd/v20Tk4J+NwC5IDuMG9fd5FAyhfv
         66WkGg/8ybOseHQVbChKOirH8OY03u+MlYYMAUc0jyQVEs2k5BFW9J2aJaDa3lzWN/1A
         0CZw==
X-Received: by 10.107.13.130 with SMTP id 124mr13149464ion.70.1433279763232;
        Tue, 02 Jun 2015 14:16:03 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id h128sm13302227ioh.38.2015.06.02.14.16.02
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 14:16:02 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.674.gb037150
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270600>

This series updates config.mak.uname to define HAVE_GETDELIM on Mac OS X
when appropriate, and adds a configure check for the same.

Changes since v1[1]:

patch 1/2 -- optimize OS X version recognition:

* Use `...` for 'expr' invocation to extract digits from $(uname_R),
  thus only a fork(), rather than gmake $(shell...), which spawns via
  fork()+exec().

* Use 'test' relational operator -ge rather than 'expr >=', along with
  'echo' to compare version number. Since 'test' and 'echo' are
  typically shell builtins, this should be faster than invoking 'expr' a
  second time.

patch 2/2 -- unchanged

[1]: http://thread.gmane.org/gmane.comp.version-control.git/270576

Eric Sunshine (2):
  config.mak.uname: Darwin: define HAVE_GETDELIM for modern OS X
    releases
  configure: add getdelim() check

 config.mak.uname | 3 +++
 configure.ac     | 6 ++++++
 2 files changed, 9 insertions(+)

-- 
2.4.2.598.gb4379f4
