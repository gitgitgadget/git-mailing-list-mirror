From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 0/8] Expose submodule parallelism to the user
Date: Tue,  2 Feb 2016 09:51:29 -0800
Message-ID: <1454435497-26429-1-git-send-email-sbeller@google.com>
Cc: Jens.Lehmann@web.de, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Feb 02 18:51:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQf7K-0001po-WF
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 18:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756329AbcBBRvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 12:51:48 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35638 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756248AbcBBRvp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 12:51:45 -0500
Received: by mail-pa0-f47.google.com with SMTP id ho8so102593466pac.2
        for <git@vger.kernel.org>; Tue, 02 Feb 2016 09:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ZKdwOuUA/iUrTVgK7gZuL8oq3BN/wcPazED5jCmXOZc=;
        b=VTIIPA4LFJUgdXhDPG4MVx/RTTnYvGqW1OnbjGHYPqRjT3NrdU3nsrz/j1KgnWVvrD
         9mn5Atm+MZDOPwAT1cy7+mpnqMXMYKXEfVo/i6rD9hzQpRVl+Q1+D1gLZqAzdtcX/wNE
         68rGTfDd3S0jct7Xi9x9VbjEvZnRCE0JSPWqOqAbG1mtor/CcDxfze5R2Z/rMy7G1KvW
         R4V23qnQJTSnh9/sVntCDpq7rpdFnwPm26jHtGbnvYK/CQ9NNug5G2C8iNtC0E+0yOm9
         mmv10O8HVeDmh0E2g2N9YHsrxHy4r4RKbLKt1Gm5QkbpWR2U+owsc3uxnAQmRh1Jftch
         C8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZKdwOuUA/iUrTVgK7gZuL8oq3BN/wcPazED5jCmXOZc=;
        b=Sx2XWSV1hIrweQl6bhmnn9StXA/EPQyQQ87M2aAkz3Qia6KRnj38wASuik7lx2mAFS
         /96mPnThULlsAF9SI+o4dMuUC9AO7xhAsT2qBpNX55+ft0LngQ4BgcaMRVH4BxYRO4fS
         kxaaR2GGIRXNdzVC1W0yCvbFiuwETfx9b0pHLLlYeXxoI78RWem8B8AWM1jfS7hyQFA/
         fPtAkwn0UXY2KvWHOYLudCTsr5nUMWSro2HzCCPnHPnbuVFOsN2QoOnqbKFKAFcgopbN
         /WmSlJHjlec8qldIHm+hu/R9QuYpOZ3l3NBsAyG8xfv4WUNCpR9I2vLngSi6rsOvZi55
         MQbg==
X-Gm-Message-State: AG10YORcr+F6R5aGZLdu2HUGw/FExBSq/ax7m5iWtF1FhSqP9aDn0XLtsamdoX2QZTwtlDqM
X-Received: by 10.66.236.69 with SMTP id us5mr49261076pac.93.1454435504905;
        Tue, 02 Feb 2016 09:51:44 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:11e1:ff63:6d72:465a])
        by smtp.gmail.com with ESMTPSA id z67sm4079298pfa.71.2016.02.02.09.51.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 Feb 2016 09:51:44 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.42.ge5f5e2d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285285>

This is a resend of sb/submodule-parallel-update as is (directly taken from
Junios tree), and I put it on the list to ease the life of reviewers.

It applies on top of origin/sb/submodule-parallel-fetch
(which is part of master already)

I have looked over the patches and they still look fine to me.
They had some early reviews end of last year, however not enough review
yet to make them proceed.

Any review is welcome!
Thanks,
Stefan

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
2.7.0.rc0.42.ge5f5e2d
