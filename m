From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv6 0/8] Expose submodule parallelism to the user
Date: Mon, 14 Dec 2015 14:54:17 -0800
Message-ID: <1450133665-3783-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com, j6t@kdbg.org
To: sbeller@google.com, git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 14 23:55:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8c1m-000154-EF
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 23:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612AbbLNWy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 17:54:57 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36768 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453AbbLNWy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 17:54:56 -0500
Received: by pfbu66 with SMTP id u66so68623236pfb.3
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 14:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=MymYW+RjTtN6b0Codq5/MHVG0ZYqZ9IaKYZN8epeLbw=;
        b=SwOChgVsoGaYndZiWnIwOi7xSWpdF3As2iFn7xDqrYtvFNrcep9xaoL6j+4z2d3qvg
         olDifFcCV+d8nju7DsPpdyY9nhI9dCSFqI89MCkN+gHndZPPJVZi2u6UHT8Lze6P4dVj
         KRYdaUcEsbtETW8z8gVPGBZqzJJat+qYNztymUTeVtGOJVleFBsd/scBIyk/k8ptoQ/Q
         d1esOPM9ytPvRMR+zw+WVcxNnBLS8+R3SnG+fv3A4Yd3F1hCnjMBB+fa3opW5DljwkO0
         sIrn7geWuzQEVV1QXL+VVXGCI3vjvmS3gPT2owJeSLUQRXEqLn/qcUkt6M4/2EpaQMR3
         TLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MymYW+RjTtN6b0Codq5/MHVG0ZYqZ9IaKYZN8epeLbw=;
        b=gbNHHQWyAaoRTuh/QG2ZBT6HQFLPph9V2JZPrPvnsjEIXZfHKL117KtjYsxOnFKcS5
         LhnQG/+JsaS+pJ7UK5VO3PzqS6rhWeaMQ8Q/nd8rEL3U41s/gvkghVAZCxV7444vglOE
         k97EjRxHbx3RYOv591b3DY8Fin+RovQA+kftUG83otdcjFFTH/4TDslnHccW7UHt4/hX
         xN/Rp7tWG+wQmgMdH+Qgnxhb9w7zXtOxszPBlTsZtEbwQOJ48y1WLmt9G8cVC5qVxhcR
         ayQM4INwh84HOwGMT1dhl0S9mcHL6dE/irwLGRBFTIoS8fQtPJZSJB0DaUqdu64/ypoS
         aCWw==
X-Gm-Message-State: ALoCoQkp0tDmR2u7mXoPcCybkHR4lI1Dp9IEoKnp7Byf6IXHJv5XxRbOPbVYbQOoVIm+pA1btPheTEx3c5WsMMdk/tRZCOI4nQ==
X-Received: by 10.98.72.14 with SMTP id v14mr27393309pfa.159.1450133695973;
        Mon, 14 Dec 2015 14:54:55 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e502:49aa:9791:cefa])
        by smtp.gmail.com with ESMTPSA id c14sm44523590pfd.38.2015.12.14.14.54.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 14 Dec 2015 14:54:55 -0800 (PST)
X-Mailer: git-send-email 2.6.4.443.ge094245.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282437>

This is a resend of sb/submodule-parallel-update and is available at github[1] as well.

What does it do?
---
This series should finish the on going efforts of parallelizing
submodule network traffic. The patches contain tests for clone,
fetch and submodule update to use the actual parallelism both via
command line as well as a configured option. I decided to go with
"submodule.fetchJobs" for all three for now.

What changed to v5?
---
No major changes, I just made it compile again as thr order of parameters
to the parallel processing engine changed.

Thanks,
Stefan


[1] https://github.com/stefanbeller/git/tree/submodule-parallel-update-2 which is on
top of https://github.com/stefanbeller/git/tree/submodule-parallel-fetch-2 which I sent
to the list about 3 hours ago.

Stefan Beller (8):
  submodule-config: keep update strategy around
  submodule-config: drop check against NULL
  submodule-config: remove name_and_item_from_var
  submodule-config: introduce parse_generic_submodule_config
  fetching submodules: respect `submodule.fetchJobs` config option
  git submodule update: have a dedicated helper for cloning
  submodule update: expose parallelism to the user
  clone: allow an explicit argument for parallel submodule clones

 Documentation/config.txt        |   7 ++
 Documentation/git-clone.txt     |   6 +-
 Documentation/git-submodule.txt |   7 +-
 builtin/clone.c                 |  19 +++-
 builtin/fetch.c                 |   2 +-
 builtin/submodule--helper.c     | 239 ++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh                |  54 ++++-----
 submodule-config.c              | 109 +++++++++++-------
 submodule-config.h              |   3 +
 submodule.c                     |   5 +
 t/t5526-fetch-submodules.sh     |  14 +++
 t/t7400-submodule-basic.sh      |   4 +-
 t/t7406-submodule-update.sh     |  27 +++++
 13 files changed, 413 insertions(+), 83 deletions(-)

-- 
2.6.4.443.ge094245.dirty
