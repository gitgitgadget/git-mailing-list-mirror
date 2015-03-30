From: Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
Subject: [PATCH/RFC 0/4] Adding '-' notation as @{-1}  (pu, d40f108)
Date: Mon, 30 Mar 2015 13:41:51 -0400
Message-ID: <1427737315-7229-1-git-send-email-kenny.lee28@gmail.com>
Cc: gitster@pobox.com, Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 19:42:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ycdhb-0002ax-NN
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 19:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753729AbbC3RmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 13:42:16 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:38538 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753718AbbC3RmO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 13:42:14 -0400
Received: by igbqf9 with SMTP id qf9so79813629igb.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 10:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=qznEoYv2r6JZhpBFhD4Tu+0Y0AMUuMew841iJLLUKKQ=;
        b=tV0KcXIQympM/XR6T93r3o2yVWzsnTwEv9M33O1wPur5QVJ43A43lug+zwDiMSECKS
         c09ekCdp7vEHWkqcxpqYgYp+dgjYdRAouUb5YyNy1WGY37idoG51C0CJWnppcNqNYPcG
         q6p3LbgMaLLxxdcy+P00slN9Fjd5ah68jyleguv1MNHKYyOESX18dgQIArLjcyGHNLmP
         OnyNxbkkSf3XAcFT/8UWCQmW6Kqgh1WpRUKk2sw/MhrKXLcnykvWWD15E3iXQBPvBb75
         55LB7DCV59oOlWlUzCLSQHMeBRagbBpHXm8GI8FJWoBpD4xtx2u6gyuOOgjWW8PLxOcl
         zKuQ==
X-Received: by 10.107.167.3 with SMTP id q3mr49891476ioe.18.1427737333375;
        Mon, 30 Mar 2015 10:42:13 -0700 (PDT)
Received: from fujitsu.wireless.concordia.ca ([132.205.236.26])
        by mx.google.com with ESMTPSA id x9sm8246356igl.2.2015.03.30.10.42.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Mar 2015 10:42:11 -0700 (PDT)
X-Mailer: git-send-email 2.3.3.203.g8ffb468.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266463>

This is an attempt to allow '-' everywhere a revision is normally allowed.
I previously attempted this  as a microproject and the subject was disscussed at : http://article.gmane.org/gmane.comp.version-control.git/265672

Currently, something like '-~2' does not work. I tried tracing the execution of, say 'log -~2' vs 'log master -~2' and noticed when calling dwim_ref() with '-~2', it returns 0 (no refs found) whereas when given 'master~2', it returned non-zero. However I'm not sure how exactly dwim_ref() works.

Kenny Lee Sin Cheong (4):
  Add "-" as @{-1} support for the rev-parse command
  t1505: add tests for '-' notation in rev-parse
  Handle arg as revision first, then option.
  t0102: add tests for '-' notation

 builtin/rev-parse.c           | 37 +++++++++++++-------------
 revision.c                    | 61 +++++++++++++++++++++++--------------------
 sha1_name.c                   |  2 +-
 t/t0102-previous-shorthand.sh | 40 ++++++++++++++++++++++++++++
 t/t1505-rev-parse-last.sh     | 12 ++++++---
 5 files changed, 101 insertions(+), 51 deletions(-)
 create mode 100644 t/t0102-previous-shorthand.sh

-- 
2.3.3.203.g8ffb468.dirty
