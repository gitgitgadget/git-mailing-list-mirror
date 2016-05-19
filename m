From: larsxschneider@gmail.com
Subject: [PATCH v1] travis-ci: enable web server tests t55xx on Linux
Date: Thu, 19 May 2016 10:45:11 +0200
Message-ID: <1463647511-54811-1-git-send-email-larsxschneider@gmail.com>
Cc: Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 10:45:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3Ja9-00081a-7i
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 10:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbcESIpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 04:45:20 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36267 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064AbcESIpP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 04:45:15 -0400
Received: by mail-wm0-f67.google.com with SMTP id w143so18983033wmw.3
        for <git@vger.kernel.org>; Thu, 19 May 2016 01:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=xWVXD+KwzejSrsY9iwr+QCGAVuzGCnrJeOa5CGdn4g8=;
        b=k0yGjp3vaQSHoHXDFAZbK/MnRaYOMgnZBlNZRTFaqVQdUggxzgm3poIfkXyyZDKr4K
         88SrZtBUlbAWqcTzlOYUzFCOPyRtvRL08R4WdV7+sXWnKKzzZPadvFk+fSkFQlNjDFrp
         oqf50PWW8XpEoRQoSciDzB5E4vpSg0kQpfQVKkyNuiCMcZNZk2r85ox3LzLhRa5c3jNJ
         ZmsgkjWGtHfw4Rn6HO0KobWCffXo71ef04GQoltPQ2rhYiZNihutXUabNhQirIaYldHs
         C9aK5bsTB6t/C3yCBVGObTBkIpKgBuAMHG+2mMZ8de0SKE4XNPcDYQPWV8X1TExI596Y
         EcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xWVXD+KwzejSrsY9iwr+QCGAVuzGCnrJeOa5CGdn4g8=;
        b=mRzkuo1bO2rLYPsWgfYtzyOHVPkC1MxCjeYKhcMS3Rc35oK34yGRl08FzRuGTOdw8V
         KUturS1Qpk6zmfKCmTTtl6mvZ3KZ56ay3guL7fak+Wu+4lgzM53AmZdxXwGUUk2myF2X
         sW6h9sZv7FoPz5PzPoYodzXN77p5i9q6zq9/qzuXJVDqY6VvlavcLhRzuiB6GlNePIw4
         PrAbNtmzhzSdmHFxLdZZ8eMbXXQ3J2Av3pPAuWO96Jafur0CfCfrFkBSQ1fqJ5vC+lT9
         6grcTN1+hwhy5TgywOCnBg+mqD+qCQIKK3Sv8dWaCqja9mxT3L1Z3YA8+v38G9BJaEhZ
         cakg==
X-Gm-Message-State: AOPr4FUO78Eqb4BisQWVE5+qhOY6dFS8eq0JINC0ZLZyl+Hgc2Q9H9SPq/kkQb0/9scKCw==
X-Received: by 10.28.37.129 with SMTP id l123mr37047727wml.1.1463647513783;
        Thu, 19 May 2016 01:45:13 -0700 (PDT)
Received: from slxBook3.fritz.box (p5DDB7732.dip0.t-ipconnect.de. [93.219.119.50])
        by smtp.gmail.com with ESMTPSA id f11sm34219805wmf.22.2016.05.19.01.45.12
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 19 May 2016 01:45:12 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295045>

From: Lars Schneider <larsxschneider@gmail.com>

Install the "apache" package to run the Git web server tests on
Travis-CI Linux build machines. The tests are already executed on OS X
build machines since the apache web server is installed by default.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 .travis.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index adab5b8..3c54080 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -18,6 +18,7 @@ addons:
   apt:
     packages:
     - language-pack-is
+    - apache2

 env:
   global:
@@ -30,6 +31,7 @@ env:
     - DEFAULT_TEST_TARGET=prove
     - GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
     - GIT_TEST_OPTS="--verbose --tee"
+    - GIT_TEST_HTTPD=true
     - GIT_TEST_CLONE_2GB=YesPlease
     # t9810 occasionally fails on Travis CI OS X
     # t9816 occasionally fails with "TAP out of sequence errors" on Travis CI OS X
--
2.5.1
