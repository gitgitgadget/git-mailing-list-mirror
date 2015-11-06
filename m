From: larsxschneider@gmail.com
Subject: [PATCH v4 4/4] Add Travis CI support
Date: Fri,  6 Nov 2015 09:58:43 +0100
Message-ID: <1446800323-2914-5-git-send-email-larsxschneider@gmail.com>
References: <1446800323-2914-1-git-send-email-larsxschneider@gmail.com>
Cc: sunshine@sunshineco.com, sschuberth@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, avila.jn@gmail.com, luke@diamand.org,
	dturner@twopensource.com, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 09:59:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZucrM-0007cS-Q4
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 09:59:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032936AbbKFI6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 03:58:54 -0500
Received: from mail-wi0-f182.google.com ([209.85.212.182]:38570 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032931AbbKFI6v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 03:58:51 -0500
Received: by wicll6 with SMTP id ll6so24479375wic.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2015 00:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ptJ5p+izrrrOpIpo+In1FZBfFCjgFu1rWkuc3H8gr+c=;
        b=uxLPhZ89GLk67ZLlNZzHl7HmTGvZXslMUwJ5zqFppE20A5vWNRG1FMvJfIozlA9Nze
         6SsPFcUk4MAj3JUYbsHwz/fGj0dIFF1+xUgHD6ybVuIYFpjqSwqrfaMHHlQTh6Pw9E+g
         07+LKxBrM16Koy1ZLy5IxFIz4UfKx3U2Y6bO+aoUOiF39Rgd1DvoSMNXwcgCgYlc7A3N
         AeG6CpR2Lmw9ReE5LC+RkDnvkTwjzAWmHcRjCjFTDtllzc2FCGem18SvD9rW1wPgLLOM
         F0+JEwf0tYwW6x22XsEK2WW5q4MLjTY71ImjO0XNw3mo+JYeGEPMhDBbV3AlObEPgauK
         19dA==
X-Received: by 10.194.205.130 with SMTP id lg2mr13488408wjc.9.1446800330463;
        Fri, 06 Nov 2015 00:58:50 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB59AE.dip0.t-ipconnect.de. [93.219.89.174])
        by smtp.gmail.com with ESMTPSA id cr5sm11098003wjb.16.2015.11.06.00.58.49
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Nov 2015 00:58:49 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1446800323-2914-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280964>

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
