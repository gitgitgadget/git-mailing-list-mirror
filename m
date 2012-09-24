From: Junio C Hamano <gitster@pobox.com>
Subject: Re: submodule: if $command was not matched, don't parse other args
Date: Mon, 24 Sep 2012 11:45:22 -0700
Message-ID: <7vbogvz2d9.fsf@alter.siamese.dyndns.org>
References: <CALkWK0npySdS7FDt=6VKdtoNS2gqQH5WaTQ4H6TEmXdP9fuF=g@mail.gmail.com>
 <7v8vc13ilc.fsf@alter.siamese.dyndns.org> <505F489B.1000309@web.de>
 <50607748.6000204@xiplink.com> <7v7grj1jkr.fsf@alter.siamese.dyndns.org>
 <CALkWK0mpDp652Hmgx2-KCw+SdFmFKHMLAOya=vRy-fsV_YH4MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: marcnarc@xiplink.com, Jens Lehmann <Jens.Lehmann@web.de>,
	Git List <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 20:45:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGDf5-0007D7-8h
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 20:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757611Ab2IXSpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 14:45:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47557 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756345Ab2IXSpb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 14:45:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87C5B9D93;
	Mon, 24 Sep 2012 14:45:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D51uUd5pEMo8iTeLYTNVMYitt0g=; b=YkbJln
	J06MO9VGn6I+/hdNH/lRbA6IpdyzIYyy3Qfy17O/cm7+VFhhz/Ztb1PbeivXKcFp
	kSRp/YP4Cfe4OUTFod/9/ywyDVtKXLx0jJrxjdvdP5PgJiuvZiuuYoz54w0PDd6n
	bd1hP0NkHIzTgTyAE/ENt4H3i9HaUA+ty3b8g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UVxE7eE/N92qRvJBuIro8VPZ92ENmNOz
	1FwC13mgSv8mDIR7HrCsw7js/afBaaPO2qaTd3KrCrZq3VKZYcPIzKhXZX34XVnt
	V26LCg3kNwfyCUgb2LP/Z3sxDDt+vB8jCMRlRE9aiBaBPp0zlkTXoC10kVtMhFmy
	/fOovdUBZtQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 754449D91;
	Mon, 24 Sep 2012 14:45:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB97F9D8D; Mon, 24 Sep 2012
 14:45:23 -0400 (EDT)
In-Reply-To: <CALkWK0mpDp652Hmgx2-KCw+SdFmFKHMLAOya=vRy-fsV_YH4MQ@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Tue, 25 Sep 2012 00:01:17 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FFE24350-0677-11E2-BCF4-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206308>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> OK, I do not think Ramkumar's patch hurts anybody, but dropping the
>> "nothing on the command line defaults to 'status' action" could.  So
>> let's queue the patch as-is at least for now and leave the default
>> discussion to a separarte thread if needed.
>
> Please don't do that, because it breaks test 41 in
> t7400-submodule-bash.  I'll add a hunk to remove the test and send a
> patch tomorrow.

I personally see no need waiting for something trivial like this.
Isn't it sufficient to squash the following in?  Is anything else
needed?

 Documentation/git-submodule.txt | 1 -
 t/t7400-submodule-basic.sh      | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git i/Documentation/git-submodule.txt w/Documentation/git-submodule.txt
index 2de7bf0..b4683bb 100644
--- i/Documentation/git-submodule.txt
+++ w/Documentation/git-submodule.txt
@@ -112,7 +112,6 @@ status::
 	initialized, `+` if the currently checked out submodule commit
 	does not match the SHA-1 found in the index of the containing
 	repository and `U` if the submodule has merge conflicts.
-	This command is the default command for 'git submodule'.
 +
 If `--recursive` is specified, this command will recurse into nested
 submodules, and show their status as well.
diff --git i/t/t7400-submodule-basic.sh w/t/t7400-submodule-basic.sh
index 0278f48..442dc44 100755
--- i/t/t7400-submodule-basic.sh
+++ w/t/t7400-submodule-basic.sh
@@ -438,8 +438,8 @@ test_expect_success 'moving to a commit without submodule does not leave empty d
 	git checkout second
 '
 
-test_expect_success 'submodule <invalid-path> warns' '
-	test_failure_with_unknown_submodule
+test_expect_success 'submodule <invalid-subcommand> fails' '
+	test_must_fail git submodule no-such-subcommand
 '
 
 test_expect_success 'add submodules without specifying an explicit path' '
