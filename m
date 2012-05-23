From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v4 0/2] submodule: fix handling of relative superproject origin URLs
Date: Thu, 24 May 2012 02:45:52 +1000
Message-ID: <1337791554-31294-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 23 18:46:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXEhc-0005jg-CP
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 18:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309Ab2EWQqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 12:46:19 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38840 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197Ab2EWQqS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 12:46:18 -0400
Received: by pbbrp8 with SMTP id rp8so10118333pbb.19
        for <git@vger.kernel.org>; Wed, 23 May 2012 09:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=7vOPi28457tDqyG+Ooe/hOVYKGMtAixleWrrczQV2ZQ=;
        b=O+tgqqLIK6xv7kaQ7WXMhyEEisJ/AirsrdcDfFPbgv9YPHokBm+OlO57m1rRuCwKAT
         NNmkUGNJPsjdyJUhCg+020YcacO3hCkaifu2/Az8N2tfpLV6u//u7cwRrd8DoAqywdSi
         YP9lZx5NBeu+eY+1sJbObGNhOGf4YA/bF98sl9igBKgffUnK0A0lw++3nllKSlF+WJzn
         EEilUi45UD0DMDLiYrWdB7nczTL9BBzSRj0HsAC7QGjzXL4DG1DZFRuWm8VNpzW16Xn8
         f/99XQuOzMepnlvKKzZFZW6pO1qaHYE861ukEEaPbtJIG5zX8B6qnExN9aO+qMfbUspC
         N2Xg==
Received: by 10.68.225.69 with SMTP id ri5mr11627732pbc.147.1337791577279;
        Wed, 23 May 2012 09:46:17 -0700 (PDT)
Received: from ubuntu.au.ibm.com ([101.114.128.220])
        by mx.google.com with ESMTPS id ss8sm2352494pbc.43.2012.05.23.09.46.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 May 2012 09:46:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.594.g24e850d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198307>

This series ensures that git submodule handles relative superproject origin URLs correctly.

Current behaviour:

* does not guarantee that the submodule.{name}.url property of the superproject is 
always confgured with a valid path to the submodule's origin repo that is 
relative to the working tree of the superproject.
* does not guarantee that the remote.origin.url property of the submodule is
always configured with a valid path to the submodule's origin repo that is 
relative to the working tree of the submodule
* errors out (origin URL = foo) even though this is not strictly necessary.

These changes:

* guarantee that the configured paths are always valid relative paths
from the working tree of the repo containing to the configuration to the
origin repo of the described submodule.

Jon Seymour (2):
  submodule: document handling of relative superproject origin URLs
  submodule: fix handling of relative superproject origin URLs

 git-submodule.sh           | 17 ++++++++++--
 t/t7400-submodule-basic.sh | 60 +++++++++++++++++++++++++++++++++++++++++++
 t/t7403-submodule-sync.sh  | 64 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 138 insertions(+), 3 deletions(-)

-- 
1.7.10.2.594.g24e850d
