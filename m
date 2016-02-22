From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.7.2
Date: Mon, 22 Feb 2016 14:18:30 -0800
Message-ID: <xmqqa8ms5qyx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Mon Feb 22 23:18:45 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1aXyoW-0001i6-2x
	for glk-linux-kernel-3@plane.gmane.org; Mon, 22 Feb 2016 23:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755999AbcBVWSe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 22 Feb 2016 17:18:34 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63842 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755973AbcBVWSc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Feb 2016 17:18:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0E95647AAB;
	Mon, 22 Feb 2016 17:18:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=3Sp+VGoecz3bzkQZLCATMoacH
	jQ=; b=rZJYKlqvTAw3RcHF5Xp/RKI9D7NILAzNxdLDhFT8nkNKiT693Fax/Aa/7
	kEYaOAvjv3pFcw2YxrymuZ/4KHu/rIXcPcOLDtHhHyd5byHGG1BWGDnwNd6cPP6V
	m7jCHXqM4qQQc4DstyZh9iU9NP0ob44Eu6TXtajB3xSPaxvCE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=D/5sNDSzWxzoSS/pKip
	jvpgI1qfVhg1gjkx5g97eJZKk7txHoaI0JVqU3rj5htT1Fx9Ey/ZuqqV1U1tM/AU
	cZvqOlJKlcJbo2qocvYMJQm3RAF+SC+XvooeJsofte9n2KGO+NDwiXSL+vHd02yj
	E5XMKkLvLwqCiFSJO5ZHyT5A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0427447AAA;
	Mon, 22 Feb 2016 17:18:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7B14847AA7;
	Mon, 22 Feb 2016 17:18:31 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 34A31982-D9B2-11E5-A52F-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286961>

The latest maintenance release Git v2.7.2 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.7.2'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git v2.7.2 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v2.7.1
------------------

 * The low-level merge machinery has been taught to use CRLF line
   termination when inserting conflict markers to merged contents that
   are themselves CRLF line-terminated.

 * "git worktree" had a broken code that attempted to auto-fix
   possible inconsistency that results from end-users moving a
   worktree to different places without telling Git (the original
   repository needs to maintain backpointers to its worktrees, but
   "mv" run by end-users who are not familiar with that fact will
   obviously not adjust them), which actually made things worse
   when triggered.

 * "git push --force-with-lease" has been taught to report if the push
   needed to force (or fast-forwarded).

 * The emulated "yes" command used in our test scripts has been
   tweaked not to spend too much time generating unnecessary output
   that is not used, to help those who test on Windows where it would
   not stop until it fills the pipe buffer due to lack of SIGPIPE.

 * The vimdiff backend for "git mergetool" has been tweaked to arrange
   and number buffers in the order that would match the expectation of
   majority of people who read left to right, then top down and assign
   buffers 1 2 3 4 "mentally" to local base remote merge windows based
   on that order.

 * The documentation for "git clean" has been corrected; it mentioned
   that .git/modules/* are removed by giving two "-f", which has never
   been the case.

 * Paths that have been told the index about with "add -N" are not
   quite yet in the index, but a few commands behaved as if they
   already are in a harmful way.

Also includes tiny documentation and test updates.

----------------------------------------------------------------

Changes since v2.7.1 are as follows:

Alex Henrie (1):
      stripspace: call U+0020 a "space" instead of a "blank"

Andrew Wheeler (1):
      push: fix ref status reporting for --force-with-lease

Dickson Wong (1):
      mergetool: reorder vim/gvim buffers in three-way diffs

GyuYong Jung (1):
      git-cvsserver.perl: fix typo

Johannes Schindelin (3):
      merge-file: let conflict markers match end-of-line style of the c=
ontext
      merge-file: ensure that conflict sections match eol style
      test-lib: limit the output of the yes utility

Junio C Hamano (2):
      Start preparing for 2.7.2
      Git 2.7.2

Matt McCutchen (1):
      Documentation/git-clean.txt: don't mention deletion of .git/modul=
es/*

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
      blame: remove obsolete comment
      add and use a convenience macro ce_intent_to_add()
      grep: make it clear i-t-a entries are ignored
      worktree.c: fix indentation
      worktree: stop supporting moving worktrees manually

SZEDER G=C3=A1bor (1):
      completion: fix mis-indentation in _git_stash()
