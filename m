From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/2] Submodule shallow recommendation [WAS: Submodules: have a depth field in the .gitmodules file]
Date: Wed, 25 May 2016 17:06:31 -0700
Message-ID: <20160526000633.27223-1-sbeller@google.com>
Cc: gitster@pobox.com, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 02:06:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5ip7-0003EO-KO
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 02:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbcEZAGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 20:06:40 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33597 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbcEZAGk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 20:06:40 -0400
Received: by mail-pa0-f52.google.com with SMTP id xk12so23527424pac.0
        for <git@vger.kernel.org>; Wed, 25 May 2016 17:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=dg+ANG03PW3GEqVor9VxAlsgNTv2i4+5orpCNNUHb8I=;
        b=TXDbB1Qxyq32/5jVYZFGtjnYwI/n9wDZTlsmPPVLIoEOE1s5W0bYa1gnxVZfaQbl/E
         FghQSlq4hHc5TsfSGYvuyEWjKFMHbKETV7atNCIsEqwq/g4Ryy14FsLUeu0LLW9Y7ZNj
         rmEdR5qG7L6Jnpz3RhhYRuIBjfkAUhQap1/vt2Z7HHEZzxoSsiaSa4fOT0m7aryb3ph4
         HBbFJ0mgkcVmPpMbSvRBTvug7lTAmnY/VPZFPaCOkZW1dkwnDg4TzeG5V3KD7wlMSn8C
         o/DVrt92ngUC3kmiMlWqA5a8PsWzkraNgmKaIwquogF7+OtCmZh5nRRFUZj5/uQ5ut9G
         L5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dg+ANG03PW3GEqVor9VxAlsgNTv2i4+5orpCNNUHb8I=;
        b=MiaXNmwOYzXkYY4ooXu3e1XPwlV5tjWF12kxuHZ1EnN9HR7JfEDgTWZ7z9dbwvyxG4
         jdHx3/LnwUMaLcqIRyBZ2vbhyTCKcvGpcCF1YNQoVCH9Jl/3j7t17Bx3G5HbjRYta+q7
         f6VDFlBVy5OYOZNXNYpHp7dNHx9d2JoqjOcRnFcvxucPDiK605lo3m8ozdyJEXHTJuig
         lBhfYAIKxrZOd+GPOYZdSeGorJvWs9g2hAflQ+I6n5PTxL888J6zADZ+cdxECHXlUR7K
         qdvYCbXpZ8ZSN1EatCYPlWGhflC4/CY50hjBW1Q/NlHx5z4AUz3mKxhFHNs1gSdBYw+u
         Nt5A==
X-Gm-Message-State: ALyK8tJ8ev5Xv56w5el5FPa8tUJdcTqWoOVLx5QxjNs+pqfmavOogpedJBV/rdA8g2Ebgvsb
X-Received: by 10.66.224.141 with SMTP id rc13mr4543123pac.29.1464221199300;
        Wed, 25 May 2016 17:06:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9ded:7fc0:154a:2e3b])
        by smtp.gmail.com with ESMTPSA id 83sm1062549pfl.12.2016.05.25.17.06.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 25 May 2016 17:06:38 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc0.2.g145fc64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295622>

v2:
* Instead of storing the depth, we keep a boolean `shallow` field in the
  `.gitmodules` file.
* slightly renamed options (--recommend-shallow instead of --recommended-depth)
* one more test
* I dropped [PATCH 1/3] submodule update: make use of the existing fetch_in_submodule function
  as Junio picked it up separately as sb/submodule-misc-cleanups

v1:
Sometimes the history of a submodule is not considered important by
the projects upstream. To make it easier for downstream users, allow
a field 'submodule.<name>.depth' in .gitmodules, which can be used
to indicate the recommended depth.

Thanks,
Stefan

Stefan Beller (2):
  submodule-config: keep shallow recommendation around
  submodule update: learn `--[no-]recommend-shallow` option

 Documentation/git-submodule.txt | 10 ++++++--
 builtin/submodule--helper.c     |  7 +++++-
 git-submodule.sh                |  9 ++++++-
 submodule-config.c              | 10 ++++++++
 submodule-config.h              |  1 +
 t/t5614-clone-submodules.sh     | 52 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 85 insertions(+), 4 deletions(-)

-- 
2.9.0.rc0.2.g145fc64

base-commit: 3a0f269e7c82aa3a87323cb7ae04ac5f129f036b
