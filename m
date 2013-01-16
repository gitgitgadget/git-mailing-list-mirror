From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [GUILT] [PATCH 2/7] The tests should not fail if log.date or
 log.decorate are set.
Date: Tue, 15 Jan 2013 18:27:33 -0800
Message-ID: <20130116022733.GK12524@google.com>
References: <20130116022606.GI12524@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>,
	Theodore Ts'o <tytso@mit.edu>, Iulian Udrea <iulian@linux.com>,
	Axel Beckert <abe@deuxchevaux.org>
To: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Wed Jan 16 03:28:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvIjO-0000Dj-6E
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 03:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757316Ab3APC1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 21:27:38 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:50519 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756839Ab3APC1h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 21:27:37 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so485630pad.19
        for <git@vger.kernel.org>; Tue, 15 Jan 2013 18:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=0j4VSGrLCES8IXJBHvFxKfIVDjXr4HzFpivLQd9Ywis=;
        b=MJ0ZwqnBLCPMFuucUEpTa54xAWCAyYBwkh1COv1nf2At3PJTMHBiHS8R2GhLWTGbq+
         o/kAg7sXUgk8Ibe63IUmpLe3a46FEKooaVziXAIRjDCIW93S6EWFnYHQFgttNcQhI1Uo
         8feErxINkVQH2GMEGrCvw6GO8BS8oKf3a/CNxzqfeOPEMvrJNz8evH+vsgI43pRxtKmZ
         YTXtxLg9Jdfj9oqjqrGfK+zqCb170eiDKxXKpSsa731xxIyvRsSfIsOSj1DbibHvIOMR
         zTa37nBI3IcocYjBxqFP77jYFzP4rYIdkGAbEg5I75KdYpksVMnEVkRueKcD11/JCJv2
         cXDQ==
X-Received: by 10.66.84.232 with SMTP id c8mr66057865paz.8.1358303257197;
        Tue, 15 Jan 2013 18:27:37 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id gj1sm11292780pbc.11.2013.01.15.18.27.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 15 Jan 2013 18:27:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130116022606.GI12524@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213710>

From: Per Cederqvist <cederp@opera.com>
Date: Mon, 30 Apr 2012 12:25:49 +0200

Explicitly set log.date and log.decorate to their Git default values,
so that git produces the expected output even if log.date and
log.decorate are set by the user in his .gitconfig.

Signed-off-by: Per Cederqvist <cederp@opera.com>
Acked-by: Jeff Sipek <jeffpc@josefsipek.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 regression/scaffold | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/regression/scaffold b/regression/scaffold
index 8769058..9db79a9 100644
--- a/regression/scaffold
+++ b/regression/scaffold
@@ -82,6 +82,10 @@ function setup_git_repo
 	git add def
 	git commit -s -m "initial" 2> /dev/null > /dev/null
 	# the commit should be d4850419ccc1146c7169f500725ce504b9774ed0
+
+	# Explicitly set config that the tests rely on.
+	git config log.date default
+	git config log.decorate no
 }
 
 function setup_guilt_repo
-- 
1.8.1
