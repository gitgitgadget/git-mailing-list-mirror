From: larsxschneider@gmail.com
Subject: [PATCH v5 6/6] Add Travis CI support
Date: Sun, 15 Nov 2015 14:08:40 +0100
Message-ID: <1447592920-89228-7-git-send-email-larsxschneider@gmail.com>
References: <1447592920-89228-1-git-send-email-larsxschneider@gmail.com>
Cc: sunshine@sunshineco.com, gitster@pobox.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 15 14:09:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zxx3i-0002ry-1D
	for gcvg-git-2@plane.gmane.org; Sun, 15 Nov 2015 14:09:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbbKONJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2015 08:09:27 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36894 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbbKONIt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2015 08:08:49 -0500
Received: by wmww144 with SMTP id w144so85896008wmw.0
        for <git@vger.kernel.org>; Sun, 15 Nov 2015 05:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ptJ5p+izrrrOpIpo+In1FZBfFCjgFu1rWkuc3H8gr+c=;
        b=bkgZpPNUyFoZPsQWnbONEu6QwPm5YRa58fYM+NsVH4cxTiA9NZObPb1pf9vbkF7Zly
         n4tlUBbSW3GHgmXNO/43y72pSvaJe21HE811YF6X8aKj/oMd9UJ5VEkG/0XDsSRFPfAX
         0YO95n+I+NnXSXL853ZMBX3hwkrcciVWuN56hnC9h629queelRU9mZ/x3ZDCtmBBFIcy
         r2vEAEq2aA5/xmMbv0IPuncfH0mGKf1PHfNqgdpcMEPUSIqJZeHocq+l1JWcjCfbUDKV
         os1rzQJEDZ+hiFDtnjChYBsZOSpKjiUGcsL+YRD+QfpRYHdCmZCkf36uBzZg1KI6K2tu
         KdBA==
X-Received: by 10.28.175.208 with SMTP id y199mr14345949wme.24.1447592928375;
        Sun, 15 Nov 2015 05:08:48 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB712F.dip0.t-ipconnect.de. [93.219.113.47])
        by smtp.gmail.com with ESMTPSA id t2sm13472567wme.0.2015.11.15.05.08.47
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 Nov 2015 05:08:47 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1447592920-89228-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281316>

From: Lars Schneider <larsxschneider@gmail.com>

The tests are currently executed on "Ubuntu 12.04 LTS Server Edition
64 bit" and on "OS X Mavericks" using gcc and clang.

Perforce and Git-LFS are installed and therefore available for the
respective tests.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 .travis.yml | 131 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 .travis.yml

diff --git a/.travis.yml b/.travis.yml
new file mode 100644
index 0000000..61c70fa
--- /dev/null
+++ b/.travis.yml
@@ -0,0 +1,131 @@
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
+addons:
+  apt:
+    packages:
+    - language-pack-is
+
+env:
+  global:
+    - P4_VERSION="15.1"
+    - GIT_LFS_VERSION="1.0.2"
+    - DEFAULT_TEST_TARGET=prove
+    - GIT_PROVE_OPTS="--timer --jobs 3"
+    - GIT_TEST_OPTS="--verbose --tee"
+    - GETTEXT_ISO_LOCALE=YesPlease
+    - GETTEXT_LOCALE=YesPlease
+    # - GETTEXT_POISON=YesPlease
+    - GIT_TEST_CHAIN_LINT=YesPlease
+    - GIT_TEST_CLONE_2GB=YesPlease
+    # - GIT_TEST_LONG=YesPlease
+  matrix:
+    -
+      # NO_ICONV=YesPlease
+    - >
+      NO_CURL=YesPlease
+      NO_D_INO_IN_DIRENT=YesPlease
+      NO_DEFLATE_BOUND=YesPlease
+      NO_EXPAT=YesPlease
+      NO_GECOS_IN_PWENT=YesPlease
+      NO_GETTEXT=YesPlease
+      NO_HMAC_CTX_CLEANUP=YesPlease
+      NO_HSTRERROR=YesPlease
+      NO_INET_NTOP=YesPlease
+      NO_INET_PTON=YesPlease
+      NO_INITGROUPS=YesPlease
+      NO_INTTYPES_H=YesPlease
+      NO_IPV6=YesPlease
+      NO_IPV6=YesPlease
+      NO_LIBGEN_H=YesPlease
+      NO_MEMMEM=YesPlease
+      NO_MKDTEMP=YesPlease
+      NO_MKSTEMPS=YesPlease
+      NO_MMAP=YesPlease
+      NO_NSEC=YesPlease
+      NO_OPENSSL=YesPlease
+      NO_PERL=YesPlease
+      NO_PTHREADS=YesPlease
+      NO_REGEX=YesPlease
+      NO_SETENV=YesPlease
+      NO_SETITIMER=YesPlease
+      NO_SOCKADDR_STORAGE=YesPlease
+      NO_STRCASESTR=YesPlease
+      NO_STRLCPY=YesPlease
+      NO_STRTOUMAX=YesPlease
+      NO_STRUCT_ITIMERVAL=YesPlease
+      NO_SYMLINK_HEAD=YesPlease
+      NO_SYS_POLL_H=YesPlease
+      NO_SYS_SELECT_H=YesPlease
+      NO_UINTMAX_T=YesPlease
+      NO_UNSETENV=YesPlease
+
+before_install:
+  - >
+    case "${TRAVIS_OS_NAME:-linux}" in
+    linux)
+      mkdir --parents custom/p4
+      pushd custom/p4
+        wget --quiet http://filehost.perforce.com/perforce/r$P4_VERSION/bin.linux26x86_64/p4d
+        wget --quiet http://filehost.perforce.com/perforce/r$P4_VERSION/bin.linux26x86_64/p4
+        chmod u+x p4d
+        chmod u+x p4
+        export PATH="$(pwd):$PATH"
+      popd
+      mkdir --parents custom/git-lfs
+      pushd custom/git-lfs
+        wget --quiet https://github.com/github/git-lfs/releases/download/v$GIT_LFS_VERSION/git-lfs-linux-amd64-$GIT_LFS_VERSION.tar.gz
+        tar --extract --gunzip --file "git-lfs-linux-amd64-$GIT_LFS_VERSION.tar.gz"
+        cp git-lfs-$GIT_LFS_VERSION/git-lfs .
+        export PATH="$(pwd):$PATH"
+      popd
+      ;;
+    osx)
+      brew_force_set_latest_binary_hash () {
+        FORMULA=$1
+        SHA=$(brew fetch --force $FORMULA 2>&1 | grep ^SHA256: | cut -d ' ' -f 2)
+        sed -E -i.bak "s/sha256 \"[0-9a-f]{64}\"/sha256 \"$SHA\"/g" \
+          /usr/local/Library/Taps/homebrew/homebrew-binary/$FORMULA.rb
+      }
+      brew update --quiet
+      brew tap homebrew/binary --quiet
+      brew_force_set_latest_binary_hash perforce
+      brew_force_set_latest_binary_hash perforce-server
+      brew install git-lfs perforce-server perforce
+      ;;
+    esac;
+    echo "$(tput setaf 6)Perfoce Server Version$(tput sgr0)";
+    p4d -V | grep Rev.;
+    echo "$(tput setaf 6)Perfoce Client Version$(tput sgr0)";
+    p4 -V | grep Rev.;
+    echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)";
+    git-lfs version;
+
+before_script: make configure && ./configure && make --jobs=2
+
+script: make --quiet test
+
+after_failure:
+  - >
+    : '<-- Click here to see detailed test output!                                                        ';
+    for TEST_EXIT in t/test-results/*.exit;
+    do
+      if [ "$(cat "$TEST_EXIT")" != "0" ];
+      then
+        TEST_OUT="${TEST_EXIT%exit}out";
+        echo "------------------------------------------------------------------------";
+        echo "$(tput setaf 1)${TEST_OUT}...$(tput sgr0)";
+        echo "------------------------------------------------------------------------";
+        cat "${TEST_OUT}";
+      fi;
+    done;
+
+notifications:
+  email: false
-- 
2.5.1
