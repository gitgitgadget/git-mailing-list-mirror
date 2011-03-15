From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/3] tests: suppress system gitattributes
Date: Tue, 15 Mar 2011 04:05:10 -0500
Message-ID: <20110315090510.GD1576@elie>
References: <20110315064909.GA25738@elie>
 <20110315065643.GB29530@elie>
 <20110315071625.GA11754@sigill.intra.peff.net>
 <20110315090225.GA1576@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Onderka <gsvick@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 15 10:05:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzQBt-0003JA-T4
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 10:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451Ab1COJFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 05:05:17 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64603 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879Ab1COJFP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 05:05:15 -0400
Received: by iwn34 with SMTP id 34so387793iwn.19
        for <git@vger.kernel.org>; Tue, 15 Mar 2011 02:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=z9o7kMJjo/N8SnKEXoBzDEk2Fbr187kL4gGiaPnpG3c=;
        b=nxhP11fbxEQazPvbn2uysIQHjBiNP1sUHZu2CgmzgUXCWEQeaUJwYurZN0xz+0B3nX
         2iegkdULCZ+cUr5jlFSDZVNED8HkLaUTBLlV/JoYi7WulU0f/DKF16a5dA5clydoNZI6
         OIPxRvgku1ovESGtirsUH0iJxIx/FGqlyye5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fooJXLoRsc9H/OwDmhjSfBgwI6oypXrwaMbLHQLlQOvHN98D2D6jMyUC1Z7ebzCzS/
         1Q5a5SRvvKd13fpiaYUyun3Kd9i+thE7a4z3KZMTuupXJVdCL16xia9n+LvbccJBhu4v
         yYs23YsfZ6kDuf73TNyvT2ipQ4iEpTSqhghlE=
Received: by 10.231.180.2 with SMTP id bs2mr3305707ibb.137.1300179914485;
        Tue, 15 Mar 2011 02:05:14 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.sbcglobal.net [69.209.56.53])
        by mx.google.com with ESMTPS id gy41sm7460827ibb.23.2011.03.15.02.05.12
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Mar 2011 02:05:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110315090225.GA1576@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169054>

Set GIT_ATTR_NOSYSTEM in test-lib to make tests more reliable in two
ways:

 - an invalid GIT_ATTR_NOSYSTEM setting should not cause tests to fail
   with "fatal: bad config value for 'GIT_ATTR_NOSYSTEM'".

 - /etc/gitattributes should not change the outcome of tests.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Improved-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 94595e3..f35ba6f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -954,7 +954,8 @@ fi
 GIT_TEMPLATE_DIR="$GIT_BUILD_DIR"/templates/blt
 unset GIT_CONFIG
 GIT_CONFIG_NOSYSTEM=1
-export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM
+GIT_ATTR_NOSYSTEM=1
+export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_ATTR_NOSYSTEM
 
 . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
 
-- 
1.7.4.1
