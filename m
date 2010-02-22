From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] Use git_mkstemp_mode and xmkstemp_mode in
 odb_mkstemp, not chmod later.
Date: Mon, 22 Feb 2010 12:33:01 -0800
Message-ID: <7veikdau4i.fsf@alter.siamese.dyndns.org>
References: <1266597207-32036-1-git-send-email-Matthieu.Moy@imag.fr>
 <1266597207-32036-5-git-send-email-Matthieu.Moy@imag.fr>
 <7vy6inekxq.fsf@alter.siamese.dyndns.org> <vpqfx4tln64.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 22 21:33:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njexx-0001Fy-27
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 21:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092Ab0BVUdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 15:33:11 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43807 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753962Ab0BVUdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 15:33:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EB8A49C4D5;
	Mon, 22 Feb 2010 15:33:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p979GGKfAtjovcV7afGdtRkOQXw=; b=LcrNSE
	BH9kV0GwFLavrwyr+TnHGI3US2sJUurQKK+KraAGVYI0IfdyrCD+4EZG5SK8UpuX
	FR8DsViYLNEGOkSg9UFJGBGBm+8Xixe8+u0nV7cbf6RN2q8ejuL+CTNi4Ud9FK8L
	45bgIN/l2u4RJ09VWyKD9Nl4O2VjezrjBGj7s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gdoog7YQ3TaXxOkcodKm6oNDL8W6rUHr
	5JR4dLfUu+W81DWPy4PQWV6JweyvHmDmieIUduB9Szy5TH7kMIqAon/fPB8vgMdf
	s2Pv9ZLemk6H9mFRbKZEiM2dZhamZU5ZG1U/ZGiLNHftDGTcdZ0UpI5pTZnZzHEm
	yrpn/CanXO8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C17A29C4D4;
	Mon, 22 Feb 2010 15:33:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E88A9C4D1; Mon, 22 Feb
 2010 15:33:03 -0500 (EST)
In-Reply-To: <vpqfx4tln64.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon\, 22 Feb 2010 08\:55\:31 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7BB7F742-1FF1-11DF-A138-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140710>

--=-=-=

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> That is strange, it does pass (or it's skipped if I don't have
> setfacl) for me.
>
> What system are you using? Do you have ACLs enabled on the filesystem
> where you run the tests? What permission do you get for packs with
> Git-without-my-patch (I used to get 0400)?

On my primary box (happens to be Debian 5 but that does not matter) I do
not even have setfacl and the tests are properly skipped.

On another box with FC11 (git.git directory is on an ext4 partition), here
is what "sh -x t1304-default.acl.sh -i -v" gives me when run in 'pu'.


--=-=-=
Content-Disposition: inline; filename=fc11.log
Content-Description: sh -x t1304-default.acl.sh -i -v 2>&1

+ test_description='Test repository with default ACL'
+ . ./test-lib.sh
++ case "$GIT_TEST_TEE_STARTED, $* " in
++ ORIGINAL_TERM=screen
++ LANG=C
++ LC_ALL=C
++ PAGER=cat
++ TZ=UTC
++ TERM=dumb
++ export LANG LC_ALL PAGER TERM TZ
++ EDITOR=:
++ unset VISUAL
++ unset GIT_EDITOR
++ unset AUTHOR_DATE
++ unset AUTHOR_EMAIL
++ unset AUTHOR_NAME
++ unset COMMIT_AUTHOR_EMAIL
++ unset COMMIT_AUTHOR_NAME
++ unset EMAIL
++ unset GIT_ALTERNATE_OBJECT_DIRECTORIES
++ unset GIT_AUTHOR_DATE
++ GIT_AUTHOR_EMAIL=author@example.com
++ GIT_AUTHOR_NAME='A U Thor'
++ unset GIT_COMMITTER_DATE
++ GIT_COMMITTER_EMAIL=committer@example.com
++ GIT_COMMITTER_NAME='C O Mitter'
++ unset GIT_DIFF_OPTS
++ unset GIT_DIR
++ unset GIT_WORK_TREE
++ unset GIT_EXTERNAL_DIFF
++ unset GIT_INDEX_FILE
++ unset GIT_OBJECT_DIRECTORY
++ unset GIT_CEILING_DIRECTORIES
++ unset SHA1_FILE_DIRECTORIES
++ unset SHA1_FILE_DIRECTORY
++ GIT_MERGE_VERBOSITY=5
++ export GIT_MERGE_VERBOSITY
++ export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
++ export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
++ export EDITOR
++ GIT_TEST_CMP='diff -u'
++ unset CDPATH
++ case $(echo $GIT_TRACE |tr "[A-Z]" "[a-z]") in
+++ echo
+++ tr '[A-Z]' '[a-z]'
++ _x05='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
++ _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
++ '[' xscreen '!=' xdumb ']'
++ TERM=screen
++ export TERM
++ '[' -t 1 ']'
++ test 2 -ne 0
++ case "$1" in
++ immediate=t
++ shift
++ test 1 -ne 0
++ case "$1" in
++ verbose=t
++ shift
++ test 0 -ne 0
++ test -n ''
++ test 'Test repository with default ACL' '!=' ''
++ test '' = t
++ exec
++ test t = t
++ exec
++ test_failure=0
++ test_count=0
++ test_fixed=0
++ test_broken=0
++ test_success=0
++ GIT_EXIT_OK=
++ trap die EXIT
++ satisfied=' '
+++ pwd
++ TEST_DIRECTORY=/scratch/buildfarm/pu/t
++ test -n ''
++ test -n ''
++ git_bin_dir=/scratch/buildfarm/pu/t/../bin-wrappers
++ test -x /scratch/buildfarm/pu/t/../bin-wrappers/git
++ PATH=/scratch/buildfarm/pu/t/../bin-wrappers:/home/junio/g/Fedora-11-i686/git-active/bin:/home/junio/bin/common:/sbin:/usr/sbin:/usr/kerberos/bin:/usr/bin:/bin:/usr/local/sbin
++ GIT_EXEC_PATH=/scratch/buildfarm/pu/t/..
++ test -n ''
+++ pwd
++ GIT_TEMPLATE_DIR=/scratch/buildfarm/pu/t/../templates/blt
++ unset GIT_CONFIG
++ GIT_CONFIG_NOSYSTEM=1
++ GIT_CONFIG_NOGLOBAL=1
++ export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_CONFIG_NOGLOBAL
++ . ../GIT-BUILD-OPTIONS
+++ SHELL_PATH=/bin/sh
+++ PERL_PATH=/usr/bin/perl
+++ TAR=tar
+++ NO_CURL=
+++ NO_PERL=
+++ NO_PYTHON=
+++ pwd
+++ pwd
++ GITPERLLIB=/scratch/buildfarm/pu/t/../perl/blib/lib:/scratch/buildfarm/pu/t/../perl/blib/arch/auto/Git
++ export GITPERLLIB
++ test -d ../templates/blt
++ test -z ''
++ test -z ''
+++ pwd
++ GITPYTHONLIB=/scratch/buildfarm/pu/t/../git_remote_helpers/build/lib
++ export GITPYTHONLIB
++ test -d ../git_remote_helpers/build
++ test -x ../test-chmtime
+++ basename t1304-default-acl.sh .sh
++ test='trash directory.t1304-default-acl'
++ test -n ''
++ case "$test" in
++ TRASH_DIRECTORY='/scratch/buildfarm/pu/t/trash directory.t1304-default-acl'
++ test '!' -z ''
++ remove_trash='/scratch/buildfarm/pu/t/trash directory.t1304-default-acl'
++ rm -fr 'trash directory.t1304-default-acl'
++ test_create_repo 'trash directory.t1304-default-acl'
++ test 1 = 1
+++ pwd
++ owd=/scratch/buildfarm/pu/t
++ repo='trash directory.t1304-default-acl'
++ mkdir -p 'trash directory.t1304-default-acl'
++ cd 'trash directory.t1304-default-acl'
++ /scratch/buildfarm/pu/t/../git-init --template=/scratch/buildfarm/pu/t/../templates/blt/
Initialized empty Git repository in /scratch/buildfarm/pu/t/trash directory.t1304-default-acl/.git/
++ mv .git/hooks .git/hooks-disabled
++ cd /scratch/buildfarm/pu/t
++ cd -P 'trash directory.t1304-default-acl'
++ this_test=t1304-default-acl.sh
++ this_test=t1304
++ case $(uname -s) in
+++ uname -s
++ test_set_prereq POSIXPERM
++ satisfied=' POSIXPERM '
++ test_set_prereq BSLASHPSPEC
++ satisfied=' POSIXPERM BSLASHPSPEC '
++ test_set_prereq EXECKEEPSPID
++ satisfied=' POSIXPERM BSLASHPSPEC EXECKEEPSPID '
++ test -z ''
++ test_set_prereq PERL
++ satisfied=' POSIXPERM BSLASHPSPEC EXECKEEPSPID PERL '
++ test -z ''
++ test_set_prereq PYTHON
++ satisfied=' POSIXPERM BSLASHPSPEC EXECKEEPSPID PERL PYTHON '
++ ln -s x y
++ test -h y
++ test_set_prereq SYMLINKS
++ satisfied=' POSIXPERM BSLASHPSPEC EXECKEEPSPID PERL PYTHON SYMLINKS '
++ rm -f y
+ setfacl -Rm u:root:rwx .
+ setfacl -Rm d:u:junio:rwx .
+ setfacl -Rm d:u:root:rwx .
+ touch file.txt
+ git add file.txt
+ git commit -m init
[master (root-commit) 956f7d1] init
 Author: A U Thor <author@example.com>
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 file.txt
+ test_expect_success 'git gc does not break ACLs with restrictive umask' '
	umask 077 &&
	git gc &&
	actual=$(modebits .git/objects/pack/*.pack) &&
	case "$actual" in
	-r--r-----*)
		: happy
		;;
	*)
		echo "expected 440, got $actual"; false
		;;
	esac &&
	getfacl .git/objects/pack/*.pack > actual &&
	grep -q "user:root:rwx" actual &&
	grep -q "user:${LOGNAME}:rwx" actual &&
	grep -q "mask::r--" actual &&
	grep -q "group::---" actual
'
+ test 2 = 3
+ prereq=
+ test 2 = 2
+ test_skip 'git gc does not break ACLs with restrictive umask' '
	umask 077 &&
	git gc &&
	actual=$(modebits .git/objects/pack/*.pack) &&
	case "$actual" in
	-r--r-----*)
		: happy
		;;
	*)
		echo "expected 440, got $actual"; false
		;;
	esac &&
	getfacl .git/objects/pack/*.pack > actual &&
	grep -q "user:root:rwx" actual &&
	grep -q "user:${LOGNAME}:rwx" actual &&
	grep -q "mask::r--" actual &&
	grep -q "group::---" actual
'
+ test_count=1
+ to_skip=
+ test -z ''
+ test -n ''
+ case "$to_skip" in
+ false
+ say 'expecting success: 
	umask 077 &&
	git gc &&
	actual=$(modebits .git/objects/pack/*.pack) &&
	case "$actual" in
	-r--r-----*)
		: happy
		;;
	*)
		echo "expected 440, got $actual"; false
		;;
	esac &&
	getfacl .git/objects/pack/*.pack > actual &&
	grep -q "user:root:rwx" actual &&
	grep -q "user:${LOGNAME}:rwx" actual &&
	grep -q "mask::r--" actual &&
	grep -q "group::---" actual
'
+ say_color info 'expecting success: 
	umask 077 &&
	git gc &&
	actual=$(modebits .git/objects/pack/*.pack) &&
	case "$actual" in
	-r--r-----*)
		: happy
		;;
	*)
		echo "expected 440, got $actual"; false
		;;
	esac &&
	getfacl .git/objects/pack/*.pack > actual &&
	grep -q "user:root:rwx" actual &&
	grep -q "user:${LOGNAME}:rwx" actual &&
	grep -q "mask::r--" actual &&
	grep -q "group::---" actual
'
+ test -z info
+ shift
+ echo '* expecting success: 
	umask 077 &&
	git gc &&
	actual=$(modebits .git/objects/pack/*.pack) &&
	case "$actual" in
	-r--r-----*)
		: happy
		;;
	*)
		echo "expected 440, got $actual"; false
		;;
	esac &&
	getfacl .git/objects/pack/*.pack > actual &&
	grep -q "user:root:rwx" actual &&
	grep -q "user:${LOGNAME}:rwx" actual &&
	grep -q "mask::r--" actual &&
	grep -q "group::---" actual
'
* expecting success: 
	umask 077 &&
	git gc &&
	actual=$(modebits .git/objects/pack/*.pack) &&
	case "$actual" in
	-r--r-----*)
		: happy
		;;
	*)
		echo "expected 440, got $actual"; false
		;;
	esac &&
	getfacl .git/objects/pack/*.pack > actual &&
	grep -q "user:root:rwx" actual &&
	grep -q "user:${LOGNAME}:rwx" actual &&
	grep -q "mask::r--" actual &&
	grep -q "group::---" actual

+ test_run_ '
	umask 077 &&
	git gc &&
	actual=$(modebits .git/objects/pack/*.pack) &&
	case "$actual" in
	-r--r-----*)
		: happy
		;;
	*)
		echo "expected 440, got $actual"; false
		;;
	esac &&
	getfacl .git/objects/pack/*.pack > actual &&
	grep -q "user:root:rwx" actual &&
	grep -q "user:${LOGNAME}:rwx" actual &&
	grep -q "mask::r--" actual &&
	grep -q "group::---" actual
'
+ eval '
	umask 077 &&
	git gc &&
	actual=$(modebits .git/objects/pack/*.pack) &&
	case "$actual" in
	-r--r-----*)
		: happy
		;;
	*)
		echo "expected 440, got $actual"; false
		;;
	esac &&
	getfacl .git/objects/pack/*.pack > actual &&
	grep -q "user:root:rwx" actual &&
	grep -q "user:${LOGNAME}:rwx" actual &&
	grep -q "mask::r--" actual &&
	grep -q "group::---" actual
'
++ umask 077
++ git gc
+++ modebits .git/objects/pack/pack-9a3c3444a7e8660480c6ea70aa526e8299f7cfd6.pack
+++ ls -l .git/objects/pack/pack-9a3c3444a7e8660480c6ea70aa526e8299f7cfd6.pack
+++ sed -e 's|^\(..........\).*|\1|'
++ actual=-r--r--r--
++ case "$actual" in
++ echo 'expected 440, got -r--r--r--'
expected 440, got -r--r--r--
++ false
+ eval_ret=1
+ return 0
+ '[' 0 = 0 -a 1 = 0 ']'
+ test_failure_ 'git gc does not break ACLs with restrictive umask' '
	umask 077 &&
	git gc &&
	actual=$(modebits .git/objects/pack/*.pack) &&
	case "$actual" in
	-r--r-----*)
		: happy
		;;
	*)
		echo "expected 440, got $actual"; false
		;;
	esac &&
	getfacl .git/objects/pack/*.pack > actual &&
	grep -q "user:root:rwx" actual &&
	grep -q "user:${LOGNAME}:rwx" actual &&
	grep -q "mask::r--" actual &&
	grep -q "group::---" actual
'
+ test_failure=1
+ say_color error 'FAIL 1: git gc does not break ACLs with restrictive umask'
+ test -z error
+ shift
+ echo '* FAIL 1: git gc does not break ACLs with restrictive umask'
* FAIL 1: git gc does not break ACLs with restrictive umask
+ shift
+ echo '
	umask 077 &&
	git gc &&
	actual=$(modebits .git/objects/pack/*.pack) &&
	case "$actual" in
	-r--r-----*)
		: happy
		;;
	*)
		echo "expected 440, got $actual"; false
		;;
	esac &&
	getfacl .git/objects/pack/*.pack > actual &&
	grep -q "user:root:rwx" actual &&
	grep -q "user:${LOGNAME}:rwx" actual &&
	grep -q "mask::r--" actual &&
	grep -q "group::---" actual
'
+ sed -e 's/^/	/'
	
		umask 077 &&
		git gc &&
		actual=$(modebits .git/objects/pack/*.pack) &&
		case "$actual" in
		-r--r-----*)
			: happy
			;;
		*)
			echo "expected 440, got $actual"; false
			;;
		esac &&
		getfacl .git/objects/pack/*.pack > actual &&
		grep -q "user:root:rwx" actual &&
		grep -q "user:${LOGNAME}:rwx" actual &&
		grep -q "mask::r--" actual &&
		grep -q "group::---" actual
	
+ test t = ''
+ GIT_EXIT_OK=t
+ exit 1
+ die
+ code=1
+ test -n t
+ exit 1

--=-=-=--
