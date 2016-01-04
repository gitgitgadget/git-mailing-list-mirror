From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.6.5
Date: Mon, 04 Jan 2016 15:43:49 -0800
Message-ID: <xmqqsi2clxl6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Tue Jan 05 00:44:01 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1aGEn9-0002nc-RP
	for glk-linux-kernel-3@plane.gmane.org; Tue, 05 Jan 2016 00:44:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753856AbcADXn4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 4 Jan 2016 18:43:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57295 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752658AbcADXnw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jan 2016 18:43:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 550D438ADB;
	Mon,  4 Jan 2016 18:43:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=YFKtQ5v8Vx44lW9PkFpduNpmj
	yk=; b=VGwQzbIzUGP3eBxSf2CdGvhmWIx0C6X+h8R24xGxlErLOO+UJlrseJnDL
	+A2RHKqAWVDroCDqp+qTmlCEiiCAEvuFsajvP99XMXCz5qGtZ+I+KSe+yQ2UB6S9
	+JaW9EKLwOaGiVjuOH0kbQf8blxrpNDkLWWmmV6BbWYkwmyLYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=vLzsj+UZQ0ZZQSvFDKW
	Xtqe4AUsUeLpii+QTssojVuQ4+Q6F3Oh0yeibRjrGR0/WIdU47MEeQlL2c2EaCmx
	8QK/AJLjE7n1AEtLUMPZlvaqTJ9Uz5EPNF3uQSsXg7wizoYqubvs8FqxK1xGzWwX
	yonVnVUedeZp87Ye3GLzxQwo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4C29A38ADA;
	Mon,  4 Jan 2016 18:43:51 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8BA0938AD7;
	Mon,  4 Jan 2016 18:43:50 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 01A37626-B33D-11E5-A391-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283333>

The latest maintenance release Git v2.6.5 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.6.5'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git v2.6.5 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v2.6.4
------------------

 * Because "test_when_finished" in our test framework queues the
   clean-up tasks to be done in a shell variable, it should not be
   used inside a subshell.  Add a mechanism to allow 'bash' to catch
   such uses, and fix the ones that were found.

 * Update "git subtree" (in contrib/) so that it can take whitespaces
   in the pathnames, not only in the in-tree pathname but the name of
   the directory that the repository is in.

 * Cosmetic improvement to lock-file error messages.

 * mark_tree_uninteresting() has code to handle the case where it gets
   passed a NULL pointer in its 'tree' parameter, but the function had
   'object =3D &tree->object' assignment before checking if tree is
   NULL.  This gives a compiler an excuse to declare that tree will
   never be NULL and apply a wrong optimization.  Avoid it.

 * The helper used to iterate over loose object directories to prune
   stale objects did not closedir() immediately when it is done with a
   directory--a callback such as the one used for "git prune" may want
   to do rmdir(), but it would fail on open directory on platforms
   such as WinXP.

 * "git p4" used to import Perforce CLs that touch only paths outside
   the client spec as empty commits.  It has been corrected to ignore
   them instead, with a new configuration git-p4.keepEmptyCommits as a
   backward compatibility knob.

 * The exit code of git-fsck did not reflect some types of errors
   found in packed objects, which has been corrected.

 * The completion script (in contrib/) used to list "git column"
   (which is not an end-user facing command) as one of the choices

 * Improve error reporting when SMTP TLS fails.

 * When getpwuid() on the system returned NULL (e.g. the user is not
   in the /etc/passwd file or other uid-to-name mappings), the
   codepath to find who the user is to record it in the reflog barfed
   and died.  Loosen the check in this codepath, which already accepts
   questionable ident string (e.g. host part of the e-mail address is
   obviously bogus), and in general when we operate fmt_ident() functio=
n
   in non-strict mode.

 * "git symbolic-ref" forgot to report a failure with its exit status.

 * History traversal with "git log --source" that starts with an
   annotated tag failed to report the tag as "source", due to an
   old regression in the command line parser back in v2.2 days.

Also contains typofixes, documentation updates and trivial code
clean-ups.

----------------------------------------------------------------

Changes since v2.6.4 are as follows:

Alexey Shumkin (2):
      t7900-subtree: test the "space in a subdirectory name" case
      contrib/subtree: respect spaces in a repository path

Charles Bailey (1):
      t3404: fix quoting of redirect for some versions of bash

Christian Couder (1):
      Documentation/git-update-index: add missing opts to synopsis

David Turner (1):
      verify_pack: do not ignore return value of verification function

Elia Pinto (1):
      ident.c: add support for IPv6

Jeff King (7):
      ident: make xgetpwuid_self() a static local helper
      ident: keep a flag for bogus default_email
      ident: loosen getpwuid error in non-strict mode
      ident: fix undefined variable when NO_IPV6 is set
      revision.c: propagate tag names from pending array
      symbolic-ref: propagate error code from create_symref()
      t1401: test reflog creation for git-symbolic-ref

Johannes Sixt (1):
      prune: close directory earlier during loose-object directory trav=
ersal

John Keeping (6):
      t7610: don't use test_config in a subshell
      t5801: don't use test_when_finished in a subshell
      test-lib-functions: support "test_config -C <dir> ..."
      t7800: don't use test_config in a subshell
      test-lib-functions: detect test_when_finished in subshell
      send-email: enable SSL level 1 debug output

Junio C Hamano (3):
      Prepare for 2.6.5
      Update draft release notes to 2.6.5
      Git 2.6.5

Lars Schneider (1):
      git-p4: add option to keep empty commits

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
      git-check-ref-format.txt: typo, s/avoids/avoid/

Ren=C3=A9 Scharfe (2):
      use pop_commit() for consuming the first entry of a struct commit=
_list
      show-branch: use argv_array for default arguments

SZEDER G=C3=A1bor (3):
      Make error message after failing commit_lock_file() less confusin=
g
      completion: remove 'git column' from porcelain commands
      credential-store: don't pass strerror to die_errno()

Stefan Beller (1):
      document submodule sync --recursive

Stefan Naewe (1):
      revision.c: fix possible null pointer arithmetic
