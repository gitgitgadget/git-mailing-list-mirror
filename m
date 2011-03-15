From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/3] tests: suppress global and system gitattributes
Date: Tue, 15 Mar 2011 01:56:43 -0500
Message-ID: <20110315065643.GB29530@elie>
References: <20110315064909.GA25738@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Petr Onderka <gsvick@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 07:56:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzOBZ-0007mC-GG
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 07:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753577Ab1COG4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 02:56:48 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:53146 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753450Ab1COG4s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 02:56:48 -0400
Received: by yia27 with SMTP id 27so113655yia.19
        for <git@vger.kernel.org>; Mon, 14 Mar 2011 23:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ml34o4Lq25qyhozsZgF86+6RsUfdI3sg/XZHoAuNDbE=;
        b=uG8RkHg3Pa6+4s36AFzq3g7E1wSJmgibS5dXZkZgbiN3hRtlnjDby/JVAmCux/WIFt
         lGr4sV7FQx2mLMJ94GZaN9UdjsV2NkQw7ZTmyy23FEbs1yO0MepTU63BN0bAAWNGzF+r
         cgKw6Krij6IaEt/WFgSQG+gHS6wgaO7/S9Rhs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QdzrNUZfz0cFdJec24qzOg36ClLboOM44W/84PswUpXrDuFXo5geseIV73pa4vm9wT
         6Kmd9rwvc/dFgjMvvq2UkANq7NqtJvjFZI12mVXa/593YxJM3j0zaunbZXKE93iuLCM1
         7hyZnfb427psJzsnuAmvAzIHHk7DCZQo/8ixg=
Received: by 10.236.77.42 with SMTP id c30mr7317209yhe.6.1300172207524;
        Mon, 14 Mar 2011 23:56:47 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id 14sm5914016yhl.22.2011.03.14.23.56.45
        (version=SSLv3 cipher=OTHER);
        Mon, 14 Mar 2011 23:56:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110315064909.GA25738@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169047>

Set GIT_ATTR_NOGLOBAL and GIT_ATTR_NOSYSTEM in test-lib to make
tests more reliable in two ways:

 - an invalid GIT_ATTR_NOGLOBAL or GIT_ATTR_NOSYSTEM setting
   should not cause tests to fail with

	fatal: bad config value for 'GIT_ATTR_NOGLOBAL'

 - /etc/gitattributes should not change the outcome of tests.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/test-lib.sh |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0fdc541..8ae03c7 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -955,7 +955,10 @@ GIT_TEMPLATE_DIR="$GIT_BUILD_DIR"/templates/blt
 unset GIT_CONFIG
 GIT_CONFIG_NOSYSTEM=1
 GIT_CONFIG_NOGLOBAL=1
-export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_CONFIG_NOGLOBAL
+GIT_ATTR_NOSYSTEM=1
+GIT_ATTR_NOGLOBAL=1
+export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR
+export GIT_CONFIG_NOSYSTEM GIT_CONFIG_NOGLOBAL GIT_ATTR_NOSYSTEM GIT_ATTR_NOGLOBAL
 
 . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
 
-- 
1.7.4.1
