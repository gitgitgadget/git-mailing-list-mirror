From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2010, #03; Wed, 10)
Date: Thu, 11 Mar 2010 21:40:07 -0800
Message-ID: <7vtysmt7wo.fsf@alter.siamese.dyndns.org>
References: <7v7hpj4k7w.fsf@alter.siamese.dyndns.org>
 <fcaeb9bf1003112041m7c8b4012j187d9a0c2537acbb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Larry D'Anna" <larry@elder-gods.org>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 12 06:41:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npxc5-0003hf-5e
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 06:40:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863Ab0CLFki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 00:40:38 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65044 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940Ab0CLFkh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 00:40:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CBBFA1224;
	Fri, 12 Mar 2010 00:40:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bbuhr3F16Bbjf1B1dCI6FYK5bAQ=; b=PGXCKQ
	FX7/fnSgxl1ImUSnSiuHz7yB7rRx4pl+wfF10HJlyV/CM4REirgoUVtqZ0huM4s0
	nEiYDd/LImsnvjA832saw8/fb3fdRC344qVLG5spZkMBHyW4Nkq07LHY77vLOs6q
	Hhevu2VpGaoOLA6mKNZDB/69WIQ2NngIdAZ7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=POCb9mkDzC40JB5cUAafTYmLFgAzNqyc
	CJPemMVp12dYUjgemg1i3EmkbNDtUULefjSPKXovOyVEg9YwCvC3ea3iAJhf6+td
	ZSLSmyIV5vp5rw/1QDEApx+QK2uw1+Og0jjREyruG9mowcKIfSKwDYxNUrecYfTQ
	z6qXFzPIiMs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C944EA1223;
	Fri, 12 Mar 2010 00:40:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 13261A121D; Fri, 12 Mar
 2010 00:40:20 -0500 (EST)
In-Reply-To: <fcaeb9bf1003112041m7c8b4012j187d9a0c2537acbb@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Fri\, 12 Mar 2010 11\:41\:04 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C68011FA-2D99-11DF-BA4B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142016>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> "diff -q" in t5516, "add tests for git push --porcelain" is not
> suported on Solaris. test_cmp should be used instead.

Heh, t9400 also uses it.  Nobody has ever tested cvsserver on Solaris?

-- >8 --
Subject: t9400: Use test_cmp when appropriate

Consistently using test_cmp would make debugging test scripts far easier,
as output from them run under "-v" option becomes readable.

Besides, some platforms' "diff" implementations lack "-q" option.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * meant for 'maint'.

 t/t9400-git-cvsserver-server.sh |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 4327eb8..daef2d6 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -226,7 +226,7 @@ test_expect_success 'gitcvs.ext.enabled = true' \
   'GIT_DIR="$SERVERDIR" git config --bool gitcvs.ext.enabled true &&
    GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled false &&
    GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 master >cvs.log 2>&1 &&
-   diff -q cvswork cvswork2'
+   test_cmp cvswork cvswork2'
 
 rm -fr cvswork2
 test_expect_success 'gitcvs.ext.enabled = false' \
@@ -247,7 +247,7 @@ test_expect_success 'gitcvs.dbname' \
   'GIT_DIR="$SERVERDIR" git config --bool gitcvs.ext.enabled true &&
    GIT_DIR="$SERVERDIR" git config gitcvs.dbname %Ggitcvs.%a.%m.sqlite &&
    GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 master >cvs.log 2>&1 &&
-   diff -q cvswork cvswork2 &&
+   test_cmp cvswork cvswork2 &&
    test -f "$SERVERDIR/gitcvs.ext.master.sqlite" &&
    cmp "$SERVERDIR/gitcvs.master.sqlite" "$SERVERDIR/gitcvs.ext.master.sqlite"'
 
@@ -257,7 +257,7 @@ test_expect_success 'gitcvs.ext.dbname' \
    GIT_DIR="$SERVERDIR" git config gitcvs.ext.dbname %Ggitcvs1.%a.%m.sqlite &&
    GIT_DIR="$SERVERDIR" git config gitcvs.dbname %Ggitcvs2.%a.%m.sqlite &&
    GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 master >cvs.log 2>&1 &&
-   diff -q cvswork cvswork2 &&
+   test_cmp cvswork cvswork2 &&
    test -f "$SERVERDIR/gitcvs1.ext.master.sqlite" &&
    test ! -f "$SERVERDIR/gitcvs2.ext.master.sqlite" &&
    cmp "$SERVERDIR/gitcvs.master.sqlite" "$SERVERDIR/gitcvs1.ext.master.sqlite"'
@@ -282,7 +282,7 @@ test_expect_success 'cvs update (create new file)' \
    cd cvswork &&
    GIT_CONFIG="$git_config" cvs -Q update &&
    test "$(echo $(grep testfile1 CVS/Entries|cut -d/ -f2,3,5))" = "testfile1/1.1/" &&
-   diff -q testfile1 ../testfile1'
+   test_cmp testfile1 ../testfile1'
 
 cd "$WORKDIR"
 test_expect_success 'cvs update (update existing file)' \
@@ -293,7 +293,7 @@ test_expect_success 'cvs update (update existing file)' \
    cd cvswork &&
    GIT_CONFIG="$git_config" cvs -Q update &&
    test "$(echo $(grep testfile1 CVS/Entries|cut -d/ -f2,3,5))" = "testfile1/1.2/" &&
-   diff -q testfile1 ../testfile1'
+   test_cmp testfile1 ../testfile1'
 
 cd "$WORKDIR"
 #TODO: cvsserver doesn't support update w/o -d
@@ -322,7 +322,7 @@ test_expect_success 'cvs update (subdirectories)' \
    (for dir in A A/B A/B/C A/D E; do
       filename="file_in_$(echo $dir|sed -e "s#/# #g")" &&
       if test "$(echo $(grep -v ^D $dir/CVS/Entries|cut -d/ -f2,3,5))" = "$filename/1.1/" &&
-           diff -q "$dir/$filename" "../$dir/$filename"; then
+	test_cmp "$dir/$filename" "../$dir/$filename"; then
         :
       else
         echo >failure
@@ -349,7 +349,7 @@ test_expect_success 'cvs update (re-add deleted file)' \
    cd cvswork &&
    GIT_CONFIG="$git_config" cvs -Q update &&
    test "$(echo $(grep testfile1 CVS/Entries|cut -d/ -f2,3,5))" = "testfile1/1.4/" &&
-   diff -q testfile1 ../testfile1'
+   test_cmp testfile1 ../testfile1'
 
 cd "$WORKDIR"
 test_expect_success 'cvs update (merge)' \
@@ -366,7 +366,7 @@ test_expect_success 'cvs update (merge)' \
    cd cvswork &&
    GIT_CONFIG="$git_config" cvs -Q update &&
    test "$(echo $(grep merge CVS/Entries|cut -d/ -f2,3,5))" = "merge/1.1/" &&
-   diff -q merge ../merge &&
+   test_cmp merge ../merge &&
    ( echo Line 0; cat merge ) >merge.tmp &&
    mv merge.tmp merge &&
    cd "$WORKDIR" &&
@@ -377,7 +377,7 @@ test_expect_success 'cvs update (merge)' \
    cd cvswork &&
    sleep 1 && touch merge &&
    GIT_CONFIG="$git_config" cvs -Q update &&
-   diff -q merge ../expected'
+   test_cmp merge ../expected'
 
 cd "$WORKDIR"
 
@@ -402,13 +402,13 @@ test_expect_success 'cvs update (conflict merge)' \
    git push gitcvs.git >/dev/null &&
    cd cvswork &&
    GIT_CONFIG="$git_config" cvs -Q update &&
-   diff -q merge ../expected.C'
+   test_cmp merge ../expected.C'
 
 cd "$WORKDIR"
 test_expect_success 'cvs update (-C)' \
   'cd cvswork &&
    GIT_CONFIG="$git_config" cvs -Q update -C &&
-   diff -q merge ../merge'
+   test_cmp merge ../merge'
 
 cd "$WORKDIR"
 test_expect_success 'cvs update (merge no-op)' \
@@ -420,7 +420,7 @@ test_expect_success 'cvs update (merge no-op)' \
     cd cvswork &&
     sleep 1 && touch merge &&
     GIT_CONFIG="$git_config" cvs -Q update &&
-    diff -q merge ../merge'
+    test_cmp merge ../merge'
 
 cd "$WORKDIR"
 test_expect_success 'cvs update (-p)' '
