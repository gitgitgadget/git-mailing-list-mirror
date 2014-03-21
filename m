From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] remote-hg: do not fail on invalid bookmarks
Date: Fri, 21 Mar 2014 15:32:24 -0700
Message-ID: <xmqq7g7nrxmv.fsf@gitster.dls.corp.google.com>
References: <A4F451CA-D1DE-43A9-A4DA-23594C08C4DD@quendi.de>
	<532CA557.20007@web.de>
	<10F8010F-96E2-45E0-B6D4-C3709AED3C28@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Fri Mar 21 23:32:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR7ze-0002Rn-0b
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 23:32:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691AbaCUWc3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Mar 2014 18:32:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44516 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752348AbaCUWc2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Mar 2014 18:32:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B52DF75BB2;
	Fri, 21 Mar 2014 18:32:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MKXFbljSJXqS
	iMXDAbRDtR+c+/E=; b=tWu2NFYxTV8BRc6IVTqMAzX3Iwetq4J8tb4n2HZfzlCp
	lJJanj7gsg3QQUNFXUz8FVMXgTfxOHIW3V6F7QjZ2ZndtOOTO3dA5EMorN+c1j/M
	twhxPxNTx879HvsetN5AFp/ur3bAdazsiM0SzUQOTswzYRALpBPhsJfQxGM90Pc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PUYFUI
	PHQz3Znfnyq3VHDUXep/o7pgIj/YkNnoJwjxE6KuIZRuOZKm0TreWPTlkLWI4iLj
	QLP9VcNt1XTtmsP4emm/J7v+AjEI1T/LneDb7ZQb9IvbKAr6Hp8BrP+yrb0e92Gt
	/Y3Udrbd6r+heK6mpszlfJw80omJNCGpXwvk8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A443975BB1;
	Fri, 21 Mar 2014 18:32:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D0CE675BAC;
	Fri, 21 Mar 2014 18:32:26 -0400 (EDT)
In-Reply-To: <10F8010F-96E2-45E0-B6D4-C3709AED3C28@quendi.de> (Max Horn's
	message of "Fri, 21 Mar 2014 22:44:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AE24ED38-B148-11E3-83AF-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244759>

Max Horn <max@quendi.de> writes:

> Hi Torsten,
>
> On 21.03.2014, at 21:47, Torsten B=C3=B6gershausen <tboegi@web.de> wr=
ote:
>
>> On 2014-03-21 12.36, Max Horn wrote:
>> All tests passed :-),
>
> Excellent.
>
>> thanks from my side.
>> comments inline, some are debatable
>
> Thanks for having a close look and for the constructive feedback!
> Unfortunately, I won't have time to look into this for the next 7 day=
s
> or so. I wouldn't mind if the patch gets queued with the changes you
> suggest; but of course that might be a tad too much to ask for, so I'=
ll
> also be happy to do a "proper" re-roll, but then it has to wait a bit=
=2E

In the meantime, I'll pile this on top as "SQUASH???".

I am not sure how the original, which went into a subdirectory
gitrepo that is to be cleaned with test_when_finished, was working.
Perhaps it didn't clean and dug the trash directory hierarchy deeper
and deeper, or something?


 contrib/remote-helpers/test-hg.sh | 80 +++++++++++++++++++++----------=
--------
 1 file changed, 43 insertions(+), 37 deletions(-)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers=
/test-hg.sh
index 6925ca3..8834482 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -694,68 +694,74 @@ test_expect_success 'remote double failed push' '
 test_expect_success 'clone remote with master null bookmark, then push=
 to the bookmark' '
 	test_when_finished "rm -rf gitrepo* hgrepo*" &&
=20
-	(
 	hg init hgrepo &&
-	cd hgrepo &&
-	echo a >a &&
-	hg add a &&
-	hg commit -m a &&
-	hg bookmark -r null master
+	(
+		cd hgrepo &&
+		echo a >a &&
+		hg add a &&
+		hg commit -m a &&
+		hg bookmark -r null master
 	) &&
=20
 	git clone "hg::hgrepo" gitrepo &&
 	check gitrepo HEAD a &&
-	cd gitrepo &&
-	git checkout --quiet -b master &&
-	echo b >b &&
-	git add b &&
-	git commit -m b &&
-	git push origin master
+	(
+		cd gitrepo &&
+		git checkout --quiet -b master &&
+		echo b >b &&
+		git add b &&
+		git commit -m b &&
+		git push origin master
+	)
 '
=20
 test_expect_success 'clone remote with default null bookmark, then pus=
h to the bookmark' '
 	test_when_finished "rm -rf gitrepo* hgrepo*" &&
=20
-	(
 	hg init hgrepo &&
-	cd hgrepo &&
-	echo a >a &&
-	hg add a &&
-	hg commit -m a &&
-	hg bookmark -r null -f default
+	(
+		cd hgrepo &&
+		echo a >a &&
+		hg add a &&
+		hg commit -m a &&
+		hg bookmark -r null -f default
 	) &&
=20
 	git clone "hg::hgrepo" gitrepo &&
 	check gitrepo HEAD a &&
-	cd gitrepo &&
-	git checkout --quiet -b default &&
-	echo b >b &&
-	git add b &&
-	git commit -m b &&
-	git push origin default
+	(
+		cd gitrepo &&
+		git checkout --quiet -b default &&
+		echo b >b &&
+		git add b &&
+		git commit -m b &&
+		git push origin default
+	)
 '
=20
 test_expect_success 'clone remote with generic null bookmark, then pus=
h to the bookmark' '
 	test_when_finished "rm -rf gitrepo* hgrepo*" &&
=20
-	(
 	hg init hgrepo &&
-	cd hgrepo &&
-	echo a >a &&
-	hg add a &&
-	hg commit -m a &&
-	hg bookmark -r null bmark
+	(
+		cd hgrepo &&
+		echo a >a &&
+		hg add a &&
+		hg commit -m a &&
+		hg bookmark -r null bmark
 	) &&
=20
 	git clone "hg::hgrepo" gitrepo &&
 	check gitrepo HEAD a &&
-	cd gitrepo &&
-	git checkout --quiet -b bmark &&
-	git remote -v &&
-	echo b >b &&
-	git add b &&
-	git commit -m b &&
-	git push origin bmark
+	(
+		cd gitrepo &&
+		git checkout --quiet -b bmark &&
+		git remote -v &&
+		echo b >b &&
+		git add b &&
+		git commit -m b &&
+		git push origin bmark
+	)
 '
=20
 test_done
