From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [PATCH 1/8] remote-bzr: fix export of utf-8 authors
Date: Thu, 29 Aug 2013 14:25:41 -0700
Message-ID: <xmqqd2ow2nqi.fsf@gitster.dls.corp.google.com>
References: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
	<1377717793-27170-2-git-send-email-felipe.contreras@gmail.com>
	<vpqhae97f8j.fsf@anie.imag.fr>
	<CAMP44s2bu9gUE=McYq1prhjC3O2CRj1W_Yc+-CjTkk6Gc3JFTw@mail.gmail.com>
	<vpqy57l4jcx.fsf@anie.imag.fr>
	<xmqq7gf58okw.fsf@gitster.dls.corp.google.com>
	<xmqqhae82nsb.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 29 23:25:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF9iy-0004AJ-B9
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 23:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755513Ab3H2VZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 17:25:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46552 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751755Ab3H2VZr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 17:25:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 730D93D183;
	Thu, 29 Aug 2013 21:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xQdp77YikL1X9gk3JASGedxMqXY=; b=Ax/xt5
	/dCUE8eRgdKhWXsk23gO16DkrVCdI9+pLRyqIN+uyYbXRI8KiFdvwECdK/KJsXu9
	fJ41ijp9wq2WOpEWtGi4mQ5Bc1Ym/ssJ+fFggAuRsrelVqDVOVpF3VA3o4Hhe/JD
	+NWvztUY5sfSLLBIvA8O5Y40N7zw4cuAk7GkA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W2dXOUwUB2Cjvwvg8BEjYL+eLjhcDCcI
	LguYvkUG+OLtefv1nT0u8BKNN2igXQxiKBWVkNjyuQc9Q/wQ68Re4OUJ0738wjL+
	4dLyrH/Vi1Hv+7PUfvWFBvI5uyXk2ej4BqrFiWCWu14orK6eF0pXhm8XndsGLvEV
	S8ZdKQccIg0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43AFF3D181;
	Thu, 29 Aug 2013 21:25:46 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BCE623D173;
	Thu, 29 Aug 2013 21:25:44 +0000 (UTC)
In-Reply-To: <xmqqhae82nsb.fsf_-_@gitster.dls.corp.google.com> (Junio
	C. Hamano's message of "Thu, 29 Aug 2013 14:24:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 90856C8C-10F1-11E3-BA02-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233366>

Junio C Hamano <gitster@pobox.com> writes:

> Actually, I think not fixing it inside that 1/8 is good, as there
> are many existing "cmd > file" (and worse, "cmd > file-$x") in these
> test-*.sh scripts.  Clean-up is better done as a follow-up patch.
>
> Here are two that I noticed.
>
> -- >8 --
> Subject: [PATCH 9/8] contrib/remote-helpers: style updates for test scripts

And here is the second one.

-- >8 --
Subject: [PATCH 10/8] remote-helpers: quote variable references in redirection targets

Even though it is not required by POSIX to double-quote the
redirection target in a variable, our code does so because some
versions of bash issue a warning without the quotes.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/remote-helpers/test-hg-hg-git.sh | 40 ++++++++++++++++----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-helpers/test-hg-hg-git.sh
index a5123ca..6dcd95d 100755
--- a/contrib/remote-helpers/test-hg-hg-git.sh
+++ b/contrib/remote-helpers/test-hg-hg-git.sh
@@ -144,10 +144,10 @@ test_expect_success 'executable bit' '
 		hg_log . &&
 		hg manifest -r 1 -v &&
 		hg manifest -v
-		) >output-$x &&
+		) >"output-$x" &&
 
 		git_clone_$x hgrepo-$x gitrepo2-$x &&
-		git_log gitrepo2-$x >log-$x
+		git_log gitrepo2-$x >"log-$x"
 	done &&
 
 	test_cmp output-hg output-git &&
@@ -175,10 +175,10 @@ test_expect_success 'symlink' '
 		cd hgrepo-$x &&
 		hg_log . &&
 		hg manifest -v
-		) >output-$x &&
+		) >"output-$x" &&
 
 		git_clone_$x hgrepo-$x gitrepo2-$x &&
-		git_log gitrepo2-$x >log-$x
+		git_log gitrepo2-$x >"log-$x"
 	done &&
 
 	test_cmp output-hg output-git &&
@@ -212,8 +212,8 @@ test_expect_success 'merge conflict 1' '
 	do
 		git_clone_$x hgrepo1 gitrepo-$x &&
 		hg_clone_$x gitrepo-$x hgrepo2-$x &&
-		hg_log hgrepo2-$x >hg-log-$x &&
-		git_log gitrepo-$x >git-log-$x
+		hg_log hgrepo2-$x >"hg-log-$x" &&
+		git_log gitrepo-$x >"git-log-$x"
 	done &&
 
 	test_cmp hg-log-hg hg-log-git &&
@@ -247,8 +247,8 @@ test_expect_success 'merge conflict 2' '
 	do
 		git_clone_$x hgrepo1 gitrepo-$x &&
 		hg_clone_$x gitrepo-$x hgrepo2-$x &&
-		hg_log hgrepo2-$x >hg-log-$x &&
-		git_log gitrepo-$x >git-log-$x
+		hg_log hgrepo2-$x >"hg-log-$x" &&
+		git_log gitrepo-$x >"git-log-$x"
 	done &&
 
 	test_cmp hg-log-hg hg-log-git &&
@@ -283,8 +283,8 @@ test_expect_success 'converged merge' '
 	do
 		git_clone_$x hgrepo1 gitrepo-$x &&
 		hg_clone_$x gitrepo-$x hgrepo2-$x &&
-		hg_log hgrepo2-$x >hg-log-$x &&
-		git_log gitrepo-$x >git-log-$x
+		hg_log hgrepo2-$x >"hg-log-$x" &&
+		git_log gitrepo-$x >"git-log-$x"
 	done &&
 
 	test_cmp hg-log-hg hg-log-git &&
@@ -323,8 +323,8 @@ test_expect_success 'encoding' '
 		hg_clone_$x gitrepo hgrepo-$x &&
 		git_clone_$x hgrepo-$x gitrepo2-$x &&
 
-		HGENCODING=utf-8 hg_log hgrepo-$x >hg-log-$x &&
-		git_log gitrepo2-$x >git-log-$x
+		HGENCODING=utf-8 hg_log hgrepo-$x >"hg-log-$x" &&
+		git_log gitrepo2-$x >"git-log-$x"
 	done &&
 
 	test_cmp hg-log-hg hg-log-git &&
@@ -361,10 +361,10 @@ test_expect_success 'file removal' '
 		hg_log . &&
 		hg manifest -r 3 &&
 		hg manifest
-		) >output-$x &&
+		) >"output-$x" &&
 
 		git_clone_$x hgrepo-$x gitrepo2-$x &&
-		git_log gitrepo2-$x >log-$x
+		git_log gitrepo2-$x >"log-$x"
 	done &&
 
 	test_cmp output-hg output-git &&
@@ -392,7 +392,7 @@ test_expect_success 'git tags' '
 	for x in hg git
 	do
 		hg_clone_$x gitrepo hgrepo-$x &&
-		hg_log hgrepo-$x >log-$x
+		hg_log hgrepo-$x >"log-$x"
 	done &&
 
 	test_cmp log-hg log-git
@@ -457,8 +457,8 @@ test_expect_success 'hg author' '
 		hg_push_$x hgrepo-$x gitrepo-$x &&
 		hg_clone_$x gitrepo-$x hgrepo2-$x &&
 
-		hg_log hgrepo2-$x >hg-log-$x &&
-		git_log gitrepo-$x >git-log-$x
+		hg_log hgrepo2-$x >"hg-log-$x" &&
+		git_log gitrepo-$x >"git-log-$x"
 	done &&
 
 	test_cmp hg-log-hg hg-log-git &&
@@ -494,8 +494,8 @@ test_expect_success 'hg branch' '
 		hg_push_$x hgrepo-$x gitrepo-$x &&
 		hg_clone_$x gitrepo-$x hgrepo2-$x &&
 
-		hg_log hgrepo2-$x >hg-log-$x &&
-		git_log gitrepo-$x >git-log-$x
+		hg_log hgrepo2-$x >"hg-log-$x" &&
+		git_log gitrepo-$x >"git-log-$x"
 	done &&
 
 	test_cmp hg-log-hg hg-log-git &&
@@ -532,7 +532,7 @@ test_expect_success 'hg tags' '
 		git --git-dir=gitrepo-$x/.git tag -l &&
 		hg_log hgrepo2-$x &&
 		cat hgrepo2-$x/.hgtags
-		) >output-$x
+		) >"output-$x"
 	done &&
 
 	test_cmp output-hg output-git
-- 
1.8.4-335-g2c126a6
