From: Vasily Titskiy <qehgt0@gmail.com>
Subject: Re: [PATCH v1 1/2] Ignore dirty submodule states during stash
Date: Tue, 17 May 2016 03:40:08 +0000
Message-ID: <20160517034008.GB2782@gmail.com>
References: <20160517033632.GA2782@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 05:40:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Vs5-0000Wy-Po
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 05:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222AbcEQDke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 23:40:34 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33929 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbcEQDkd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 23:40:33 -0400
Received: by mail-yw0-f196.google.com with SMTP id i22so557138ywc.1
        for <git@vger.kernel.org>; Mon, 16 May 2016 20:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sR3jdKF/1hVCT3fUDys0KqvDU2gi5GmK9lImdr+zBzw=;
        b=xwOhSTa93NiOhoCD6Cb5l+PjuRCi8th8YpTnBHV+vbp9f4lz3hT3u5/tU67pNAnuZZ
         A2uJ58iqojOYOftHYZmUYp4rEjtwF6dpGWdFjjeFQYRIIK57L8eS5vAMjeZj1lNUxlEf
         Frt8DfI7LphJaWOWzERrK2K22CcPcw5FR7y98Ag73XQKzhAfG9IaaVzzLlsLYsyFr63D
         3KzZ5xSEMsdcnizHu6zKw9dpSoOhg9/2Ls6PQ2k53WgioqdxBcAd7ySOB1JOIsICKm0a
         LdAng0gFSej3ninLsiH3mCfYOS4Mu7YfEqtVbvgeDhZuqRa1khNDSKjSw6fT0nHd/BjA
         lueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sR3jdKF/1hVCT3fUDys0KqvDU2gi5GmK9lImdr+zBzw=;
        b=QM6GwPFpWj4VBBkD/upQkjoncVcg/uwbEPhrO26drZTU7AqarWJShKSYMcXetlb7ON
         7NrpcSYbIsM1TTxNYUl10HtArUpuZojYDvMlrT8fb9pVfcksXG/A/m5uzJvHRV2lqkx3
         kbmOPSt9yX0YgtpFCNym60gLtIU6xjZ6LmmhNVAT4d6ZJb4yGnPeZPqcE1MxsMHAYzG1
         gFT9hD30QBNhjTTs4qB311g+YOLO/R2XF+YXdD2/OMOSHFeKXKgwLtAqAE+AiZkmoDRB
         Xejz9gP6KI1H2LE+86em3Kb6vvixVzphrbwI2ZWwBFdqchrcJRiykZcKSKFazfQKuzMc
         y34Q==
X-Gm-Message-State: AOPr4FXSTbQoD6wpgWuoDzoflnxDfaTJVu4BaKZsQ0SU9Rxbay24ZUhsTisu4TR8xtQq7w==
X-Received: by 10.129.130.135 with SMTP id s129mr15600286ywf.139.1463456409798;
        Mon, 16 May 2016 20:40:09 -0700 (PDT)
Received: from gmail.com ([2600:3c02::f03c:91ff:fe96:da77])
        by smtp.gmail.com with ESMTPSA id q132sm505130ywc.21.2016.05.16.20.40.09
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 May 2016 20:40:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160517033632.GA2782@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294845>

As stash does not know how to deal with submodules,
it should not try to save/restore their states
as it leads to redundant merge conflicts.

Signed-off-by: Vasily Titskiy <qehgt0@gmail.com>
---
 git-stash.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index c7c65e2..b500c44 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -116,7 +116,7 @@ create_stash () {
 			git read-tree --index-output="$TMPindex" -m $i_tree &&
 			GIT_INDEX_FILE="$TMPindex" &&
 			export GIT_INDEX_FILE &&
-			git diff --name-only -z HEAD -- >"$TMP-stagenames" &&
+			git diff --name-only --ignore-submodules -z HEAD -- >"$TMP-stagenames" &&
 			git update-index -z --add --remove --stdin <"$TMP-stagenames" &&
 			git write-tree &&
 			rm -f "$TMPindex"
-- 
2.1.4
