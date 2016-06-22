Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 561D220189
	for <e@80x24.org>; Wed, 22 Jun 2016 16:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbcFVQx3 (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 12:53:29 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34761 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbcFVQx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 12:53:28 -0400
Received: by mail-pa0-f65.google.com with SMTP id us13so4358194pab.1
        for <git@vger.kernel.org>; Wed, 22 Jun 2016 09:53:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=FYbZcWRAwIp4X0gUfpjh4dXus10QZgWUF0D/VMVjLzw=;
        b=YwhOL2EJRys5jJb3O2RRFEWCYJfbhQrSbC7WMqPxynpsmOtZw5ZXb+UTiadlVW931B
         qBNnIv9C1LBqZ4oyzRgUVk4x11i3xkGwlA3TNM2keDSGJKYTxg4M6QxzFE9e+2NLgt2N
         650JrDYURcmS7+Kqw+ku+uRB24pgBvI0KXEMiz0ccAZ6Kg5XWv+KBg7SCSpWgc0DAr26
         o0bbhQzmnvn6hge+vHQ4g/RCeoOkO8ZH8j1wX/10hTkReF800XHvmPTbMMFkNnIX3wWI
         k1Uxjm5mP4lJ3zJlmzYyjaS+F+G0sHsbcK4XULt0D+/DqvYBA/SYDRdZlGCUGiMYEQoq
         gTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FYbZcWRAwIp4X0gUfpjh4dXus10QZgWUF0D/VMVjLzw=;
        b=UL/SwWaz3q39CC3PAmafAP1FLJYDIebbHoF5t4DLKHy6i4n3v+Lsr6m953qeah4RTr
         3CSiV4+rNnc43/O5lpkUGMX2DaX45TTHvMJd1kHiXFP8fru1R/B32Xb7GUihOXa4XG05
         ZwKNcQwQLNJIFdZ1i6AU/PJ1j6mYBSSW4seZgi/gAWNYDhAvjE1nDaDstK52IyaLLX6C
         vE9gYxDLNLMdibbIte4ofecbpBzFJrShULGodTcx81mBd2OjTkRcTBrrTabK5xw4aibw
         qE1PsOmxdu0qsq8jSnLSqtQ77AtCEcLI9c6uPkFbfgjzSaz2AIDWkwr4CIBmdfOf4XfL
         ljBA==
X-Gm-Message-State: ALyK8tJYznEFzFqLq9nSAV0yAzFrU3X4taB4S7+a1p3dL9ZQfCPyBZYQGYZ2BqzTrmOtTQ==
X-Received: by 10.66.248.169 with SMTP id yn9mr35292710pac.13.1466614407841;
        Wed, 22 Jun 2016 09:53:27 -0700 (PDT)
Received: from localhost.localdomain ([106.218.86.37])
        by smtp.gmail.com with ESMTPSA id sz7sm1132865pab.23.2016.06.22.09.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Jun 2016 09:53:27 -0700 (PDT)
From:	Mehul Jain <mehul.jain2029@gmail.com>
To:	git@vger.kernel.org
Cc:	Eric Sunshine <sunshine@sunshineco.com>,
	Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v3 0/3] Introduce log.showSignature config variable
Date:	Wed, 22 Jun 2016 22:21:23 +0530
Message-Id: <20160622165126.12786-1-mehul.jain2029@gmail.com>
X-Mailer: git-send-email 2.9.0.rc0.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Add a new configuratation variable "log.showSignature" for git-log
and related commands. "log.showSignature=true" will enable user to
see GPG signature by default for git-log and related commands.

Changes compared to v2:
	* A preparatory patch 1/3 has been introduced so that tests
	  in patches 2/3 and 3/3 can take advantage of it.
	* Mistake regarding branch in [patch v2 2/2] has been
	  corrected.
	* Tight coupling between the tests in [patch v2 2/2] has
	  been resovled.

I would like to thanks Eric Sunshine for his feedback on previous
series [1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/297648 

Mehul Jain (3):
  t4202: refactoring of test
  log: add "--no-show-signature" command line option
  log: add log.showSignature configuration variable

 Documentation/git-log.txt |  4 ++++
 builtin/log.c             |  6 ++++++
 revision.c                |  2 ++
 t/t4202-log.sh            | 32 ++++++++++++++++++++++++++++++--
 t/t7510-signed-commit.sh  |  7 +++++++
 5 files changed, 49 insertions(+), 2 deletions(-)

-- 
2.9.0.rc0.dirty

