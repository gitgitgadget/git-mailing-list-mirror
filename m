From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: [PATCH 0/2] fix status_printf_ln calls "zero-length format" warnings
Date: Mon, 10 Mar 2014 20:27:25 +0100
Message-ID: <1394479647-22361-1-git-send-email-benoit.pierre@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 20:27:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN5rT-0003J4-JC
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 20:27:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297AbaCJT1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 15:27:38 -0400
Received: from mail-we0-f176.google.com ([74.125.82.176]:49642 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673AbaCJT1h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 15:27:37 -0400
Received: by mail-we0-f176.google.com with SMTP id x48so8974982wes.21
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 12:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=o9tD8/skROV8Eh7BWmvqoQIdnZWOODSiYWk/ubOhXe4=;
        b=RX4Y0XzWwS29du2NkqiEjOCqa3Fh/RF06lTkDNEE4y14TtuEbXXwhEy9grC1ir6FRE
         AcNo9t3IVAghYF0+t+FeXy4M/UbjwWd9ZnRPTY23EohOn5qh8n5Nu1NFRmnik7XsDTHV
         Lqm5u15t82JlAYcW/ZGnJrVV3Ev8St/DTAsFmQArNwSmjpggPmJ64QxAqOsc5ac4PYII
         Fu3F/H5Y1+lD6EHv7kJxZPVBxvu1BEL88PZiy1j63T5oXCrUlc4IuNaabmWQYPwU/PzM
         vyOiv9Xj4gOPdkRtjnQIGuDtnijddaC1Zintsq0yxq3ihQ7ZkInKDg7SfHyZRaRgkvqb
         N4nw==
X-Received: by 10.194.118.163 with SMTP id kn3mr3127541wjb.77.1394479656497;
        Mon, 10 Mar 2014 12:27:36 -0700 (PDT)
Received: from localhost (109.12.70.86.rev.sfr.net. [86.70.12.109])
        by mx.google.com with ESMTPSA id bj3sm54878641wjb.14.2014.03.10.12.27.35
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Mar 2014 12:27:35 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243795>

Those happens with "gcc -Wformat-zero-length". Since passing NULL does not
generate a warning (as __attribute__((printf())) does not imply nonull), modify
status_printf/status_printf_ln to allow a NULL format and update calls with an
empty string.

Benoit Pierre (2):
  status: allow NULL fmt for status_printf/status_vprintf_ln
  fix status_printf_ln calls "zero-length format" warnings

 builtin/commit.c |  2 +-
 wt-status.c      | 23 ++++++++++++-----------
 2 files changed, 13 insertions(+), 12 deletions(-)

-- 
1.9.0
