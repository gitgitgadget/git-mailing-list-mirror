From: larsxschneider@gmail.com
Subject: [RFC/PATCH v1] Add Travis CI support
Date: Thu, 24 Sep 2015 23:43:24 +0200
Message-ID: <1443131004-39284-2-git-send-email-larsxschneider@gmail.com>
References: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
Cc: Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:43:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfEIg-00033L-Jt
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152AbbIXVna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:43:30 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37945 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539AbbIXVn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:43:29 -0400
Received: by wiclk2 with SMTP id lk2so1916788wic.1
        for <git@vger.kernel.org>; Thu, 24 Sep 2015 14:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iYaleUO9R/4IM3dp6LIWQOeNS0pUh7RloynSNh847SY=;
        b=Rr67JcrDfCPALnKK5dT64QLPicnGJxz8SouhW2C2NE/wIE/w/90a5Y2Jljtuti0VPE
         8ioBZbADId1Sps1t8bX+vwGbe0lqTwAv3iJvho3cv7bzOtCx2o0lSBfoQUhvx3Yee/5T
         GJY5RFuH6HxzVnv/+ot482y9z/Kn/bQL23kvulyfw0EJc7F1mE2q7sUTQilI8GbTTEuD
         Kg4W8cpYrVYEKlxB1ozpPobKRG4Jtzmxknghej0aBPmINWUHyGxJyA/b/zWvxxHrlM2E
         azmMywk12c3Q/iuXYpmiACC84wF60UflBzsKsFESUbxaDvz9RcoKl1U9nRaJRTJv19Wd
         BPBA==
X-Received: by 10.194.238.168 with SMTP id vl8mr2176567wjc.128.1443131008382;
        Thu, 24 Sep 2015 14:43:28 -0700 (PDT)
Received: from slxBook3.fritz.box (dslb-094-223-081-222.094.223.pools.vodafone-ip.de. [94.223.81.222])
        by smtp.gmail.com with ESMTPSA id az6sm155603wib.12.2015.09.24.14.43.27
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Sep 2015 14:43:27 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278634>

From: Lars Schneider <larsxschneider@gmail.com>

The tests are executed on "Ubuntu 12.04 LTS Server Edition 64 bit" and
on "OS X Mavericks" using gcc and clang.

Perforce and Git-LFS are installed and therefore available for the
respective tests.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 .travis.yml | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 .travis.yml

diff --git a/.travis.yml b/.travis.yml
new file mode 100644
index 0000000..056cc99
--- /dev/null
+++ b/.travis.yml
@@ -0,0 +1,28 @@
+language: c
+
+os:
+  - linux
+  - osx
+
+compiler:
+  - clang
+  - gcc
+
+before_script:
+  - "if [ ${TRAVIS_OS_NAME:-'linux'} = 'linux' ]; then wget -q https://package.perforce.com/perforce.pubkey -O - | sudo apt-key add -; fi"
+  - "if [ ${TRAVIS_OS_NAME:-'linux'} = 'linux' ]; then echo 'deb http://package.perforce.com/apt/ubuntu precise release' | sudo tee -a /etc/apt/sources.list; fi"
+  - "if [ ${TRAVIS_OS_NAME:-'linux'} = 'linux' ]; then sudo apt-get update -qq; fi"
+  - "if [ ${TRAVIS_OS_NAME:-'linux'} = 'linux' ]; then sudo apt-get install perforce-server; fi"
+  - "if [ ${TRAVIS_OS_NAME:-'linux'} = 'linux' ]; then wget -q https://packagecloud.io/gpg.key -O - | sudo apt-key add -; fi"
+  - "if [ ${TRAVIS_OS_NAME:-'linux'} = 'linux' ]; then sudo apt-get install -y apt-transport-https; fi"
+  - "if [ ${TRAVIS_OS_NAME:-'linux'} = 'linux' ]; then echo 'deb https://packagecloud.io/github/git-lfs/debian/ wheezy main' | sudo tee -a /etc/apt/sources.list; fi"
+  - "if [ ${TRAVIS_OS_NAME:-'linux'} = 'linux' ]; then sudo apt-get update -qq; fi"
+  - "if [ ${TRAVIS_OS_NAME:-'linux'} = 'linux' ]; then sudo apt-get install git-lfs; fi"
+  - "if [ ${TRAVIS_OS_NAME:-'linux'} = 'osx' ]; then brew update; fi"
+  - "if [ ${TRAVIS_OS_NAME:-'linux'} = 'osx' ]; then brew install git-lfs; fi"
+  - "if [ ${TRAVIS_OS_NAME:-'linux'} = 'osx' ]; then brew tap homebrew/binary; fi"
+  - "if [ ${TRAVIS_OS_NAME:-'linux'} = 'osx' ]; then sed -i.bak 's/b42758ebe7b54e672b513c34c88f399d0da7b4de1fd23b9f56d222a4f1f3bae5/e987475bfc54129d8d54a0d54363db3ecf6e6852a00daa0c6ffc20b8df1e0e63/' /usr/local/Library/Taps/homebrew/homebrew-binary/perforce-server.rb; fi"
+  - "if [ ${TRAVIS_OS_NAME:-'linux'} = 'osx' ]; then brew install perforce; fi"
+  - "if [ ${TRAVIS_OS_NAME:-'linux'} = 'osx' ]; then brew install perforce-server; fi"
+
+install: make configure
--
2.5.1
