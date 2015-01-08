From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv12 00/10] atomic pushes
Date: Wed,  7 Jan 2015 19:23:14 -0800
Message-ID: <1420687404-13997-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
	mhagger@alum.mit.edu, ronniesahlberg@gmail.com, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jan 08 04:24:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y93hS-00062p-6G
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 04:23:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811AbbAHDXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 22:23:44 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:60287 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640AbbAHDXn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 22:23:43 -0500
Received: by mail-ie0-f171.google.com with SMTP id ar1so7492907iec.2
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 19:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=FJxrWx7DDE3+jE1pcnYqw+IrovOTVNf5KzNcCpc7+P0=;
        b=g652pyqrLI+FOZVsGESVevXM4jqZRrBheXwU3ff2PG/KJRM/IYaR24kl2eR0sHlerN
         ZVO3Wad6TrsZuvbiuSbmFgNXFS3KZtLv7udTRedOZXq9NR7YUKVV4BKwCPSfbUzJDWRJ
         FpuDrNdwRyN9y5QBbSrF8/ws+5mTVdYNGFv9e0jDDn3oBQ813Hb+ODMtZxYzl8g3frLf
         oLrTRcKvqK2TND4Toi5XAcC7nRamqrD+QHLnSS0MGQfOtulq6C0T72iE9+2C3sMVAl7y
         Ym5uAiYOb9WR2uS3jisITU0Ks9mRw9tZ4kZUn8Qt2aOvXuLp4HqTjLsVopGulo6PKP6C
         Chvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FJxrWx7DDE3+jE1pcnYqw+IrovOTVNf5KzNcCpc7+P0=;
        b=QJ5wHycQbX3ZGa2NWAcIqfA6Qq2w0XpHHHeidgABaNI96KA3lFUnp7MYYwy2hsfeeG
         L1nHuoRRLRtDm0qOiQW4r5sJ7Yoi96BbUAOLKYqoqkxTNBoA7EFcQs1xUKcP7o4tjkX2
         5y88kpYdYczJapLkUexbTnk8TNq54SfvnxGv6B2d+r9wyZx7tgOo0FntKeGsyjQb8wEZ
         +ivIxiWk+qmzOwOnunG3Stw57wLAje47Y0jdQShweKH5VpSVBhGcHHApaS7petayeNxA
         s0igMiz3GS0UG9nIshYMnHredTb2ky3kt67UYkhPeofyd7OPDUFO++hV5dPEk6cEN/ij
         RO7Q==
X-Gm-Message-State: ALoCoQmM/1cWaNVV1siMNZxM9HerMRrRaglGnt5F+lV3sLfr7sWeKeOs9L3VBoZ2Mk/idjM8XLsH
X-Received: by 10.107.8.149 with SMTP id h21mr6702873ioi.74.1420687422781;
        Wed, 07 Jan 2015 19:23:42 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:948f:12c6:eb26:9b9c])
        by mx.google.com with ESMTPSA id t8sm7447683igs.21.2015.01.07.19.23.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 07 Jan 2015 19:23:42 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262174>

There wasn't discussion within the last 24 hours and we were discussing only 
about minor changes. Changes compared to v9 (the last time I completely sent the
series) is only found in the first 2 patches, where we had a back and forth 
about naming the method warn_if_skipped_connectivity_check and its behavior.
I'm mainly sending this as a whole series, so Junio can pick it up easier
as opposed to finding the latest version of each patch himself.

This patch series adds a flag to git push to update the remote refs atomically.
This series applies on top of origin/mh/reflog-expire
It can also be found at https://github.com/stefanbeller/git/tree/atomic-push-v12

Any comment is welcome!

Thanks,
Stefan

Ronnie Sahlberg (3):
  receive-pack.c: negotiate atomic push support
  send-pack.c: add --atomic command line argument
  push.c: add an --atomic argument

Stefan Beller (7):
  receive-pack.c: shorten the execute_commands loop over all commands
  receive-pack.c: die instead of error in case of possible future bug
  receive-pack.c: move iterating over all commands outside
    execute_commands
  receive-pack.c: move transaction handling in a central place
  receive-pack.c: add execute_commands_atomic function
  send-pack: rename ref_update_to_be_sent to check_to_send_update
  t5543-atomic-push.sh: add basic tests for atomic pushes

 Documentation/git-push.txt                        |   7 +-
 Documentation/git-send-pack.txt                   |   7 +-
 Documentation/technical/protocol-capabilities.txt |  13 +-
 builtin/push.c                                    |   5 +
 builtin/receive-pack.c                            | 165 ++++++++++++++----
 builtin/send-pack.c                               |   6 +-
 remote.h                                          |   3 +-
 send-pack.c                                       |  65 +++++++-
 send-pack.h                                       |   3 +-
 t/t5543-atomic-push.sh                            | 194 ++++++++++++++++++++++
 transport.c                                       |   5 +
 transport.h                                       |   1 +
 12 files changed, 424 insertions(+), 50 deletions(-)
 create mode 100755 t/t5543-atomic-push.sh

-- 
2.2.1.62.g3f15098
