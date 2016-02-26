From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [GSoC] Microproject :- Teaching git pull --rebase the --no-autostash flag
Date: Fri, 26 Feb 2016 16:53:44 +0530
Message-ID: <1456485825-21309-1-git-send-email-mehul.jain2029@gmail.com>
Cc: me@ikke.info, pyokagan@gmail.com,
	Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 12:25:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZGWE-0005CC-C6
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 12:25:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbcBZLZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 06:25:04 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34676 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbcBZLZD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 06:25:03 -0500
Received: by mail-pf0-f169.google.com with SMTP id x65so50881603pfb.1
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 03:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=jEZakn2cGBcbgfm5PmfIavkhpuEyqurMlmBiBKd47ss=;
        b=Lb4XsG65J88ECCCoJUhETdEtVIOwsBN8mAYVFqQoPVG5Z4Mv2atExr0XifobyIvvXU
         6GW6Ey5T5LsQn+bfXGWi6oydXcO23x6w/dcCYtETm1mCfRRALjbv8RNd0r+kORz/HcRs
         II/iNGOfSJxuachwppEvhW0Mt4dYOohQq7qXZE2mMsJcUDNzRYAwB4d/ywiGW+xhNR22
         d/9KB/+EGs8HU/aDyPCAkdiGKEoLCwL3b0sBtPYgnVJRr3mAX8TzBlbaPNhJA/aOijxo
         Is2QN496w17GCxTxJEm2NgEcIKsm2TdrJswEOEV1NiGgAOcs+IPd4/C94OjirkgQ5rF6
         Fquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jEZakn2cGBcbgfm5PmfIavkhpuEyqurMlmBiBKd47ss=;
        b=XT7tLmM7H+Y2Tb9ZLb7/+lmwAkg1G2f0K9p85ODYo2n/KpTfQcypgV1XJgO6JkDwVT
         rgIvjQRltR6aFLwYy+8ryzVx29fUkwa3W+QHPmB5xuB6EJAEsSNj8UhJCzrQV2mDq782
         K7ADfbyrT+VQMdxYvAGn0bbC3buYMlEXXwK+Y9tNHvpL1/AC9Fz+huO+5RlBHgbH3TzL
         beC83a2S/8PGbn/6USL5SLHxPy2zk+4OGHiG75/4iwUo+ZjsTS6uMCuBRAnXwW4NMOIN
         4dOytcbOlYkL0yXCHnRANVSwtnsIn7ayapf6Y/fNDedKg62yKF3fAd0WjAdjF5+5KGhQ
         lngg==
X-Gm-Message-State: AD7BkJKDOG0c+WjgJNZm/qgwuXxzrzA6pgHRyFj3+OgMq9NOa3gGBnQZvhdH3PuKdDKgXg==
X-Received: by 10.98.73.143 with SMTP id r15mr1303775pfi.118.1456485902068;
        Fri, 26 Feb 2016 03:25:02 -0800 (PST)
Received: from localhost.localdomain ([1.39.137.118])
        by smtp.gmail.com with ESMTPSA id 3sm18733071pfn.59.2016.02.26.03.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Feb 2016 03:25:01 -0800 (PST)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287568>

With this patch, git pull --rebase will understand --no-autostash command line flag.
This flag will override "rebase.autostash" configuration(if set) and leads to a
failure if current working directory is dirty. If "rebase.autostash" is not configured
and no flag is passed then by default command will die if directory is to be dirty, before
even calling rebase.

I am also thinking of adding a "--autostash" flag for git pull --rebase, which will
override "rebase.autostash" configuration(if set false) and will pass --autostash to
git rebase. I would like to know your opinion on this option. 

Thanks! 

Mehul Jain (1):
  Add --no-autostash flag to git pull --rebase

 builtin/pull.c          | 12 ++++++++----
 t/t5520-pull.sh         |  8 ++++++++
 t/t5521-pull-options.sh | 24 ++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 4 deletions(-)

-- 
2.7.1.340.g69eb491.dirty
