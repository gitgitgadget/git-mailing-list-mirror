From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/19] Let Git's tests pass on Windows
Date: Sun, 24 Jan 2016 17:34:08 -0800
Message-ID: <xmqqmvrubfxr.fsf@gitster.mtv.corp.google.com>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 25 02:34:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNW2p-0001Fs-Ns
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 02:34:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754557AbcAYBeM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jan 2016 20:34:12 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60325 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752543AbcAYBeK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jan 2016 20:34:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1FC3B3FCA2;
	Sun, 24 Jan 2016 20:34:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=HcLvhGL0wr/P
	dhpzxtnzOv29Zb4=; b=Jja2B4u5i1T3ul7yb4b1X+gZkfev5ZtG7l1/nurJGYmK
	P1zmwHKTwVgAAWz9kTKfQaskkoTgU+QmTf9R7Kdtl0z84tl08Ur6Q1VFslZklu8z
	pUphI1bTjyeNckMy9FtRpuIN++SJhxxvqqIhxXMgpsOJQPrXPi0y4PTZjogq7iw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dNyaT4
	uD2DY6N6IbcZMQX5o1YKGdcCPHTFtKw1lw6LZAzwv4d/aA3CHVTX7CryUqbEvYTE
	4bShP2BJlYgRzv3qA5SQucFpSweZwTeRlVFr3Pzh2P/iHKvS6qNw2A7LrgKK0WT3
	LiPOv/KIsj4XHZ9fzhqyHQIvhV+gSopYCqCIY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 174843FCA1;
	Sun, 24 Jan 2016 20:34:10 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 898773FCA0;
	Sun, 24 Jan 2016 20:34:09 -0500 (EST)
In-Reply-To: <cover.1453650173.git.johannes.schindelin@gmx.de> (Johannes
	Schindelin's message of "Sun, 24 Jan 2016 16:43:06 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BB1604F4-C303-11E5-B69E-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284706>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This is a big milestone. With these modifications, Git's source code
> does not only build without warnings in Git for Windows' SDK, but
> passes the entire regression test suite.

;-)

It is somewhat surprising that with only these changes my tree is no
longer behind the Git for Windows effort--all tests pass so everything
should be working perfectly, right ;-)

There were a few changes in the series that raised my eyebrows,
which I'll respond separately, but overall it's a great
achievement.

Thanks.

>
> The patch series contains three different types of patches. First,
> there are a couple of real fixes that were triggered by failures in
> the regression tests. Then there are a couple of fixes to the
> regression tests themselves. And finally, we have to disable a couple
> of tests because we simply cannot make them work on Windows.
>
>
> Johannes Schindelin (13):
>   mingw: let's use gettext with MSYS2
>   mingw: do not trust MSYS2's MinGW gettext.sh
>   Git.pm: stop assuming that absolute paths start with a slash
>   mingw: prepare the TMPDIR environment variable for shell scripts
>   mingw: let lstat() fail with errno =3D=3D ENOTDIR when appropriate
>   mingw: fix t5601-clone.sh
>   mingw: accomodate t0060-path-utils for MSYS2
>   mingw: disable mkfifo-based tests
>   tests: turn off git-daemon tests if FIFOs are not available
>   mingw: fix t9700's assumption about directory separators
>   mingw: work around pwd issues in the tests
>   mingw: skip a couple of git-svn tests that cannot pass on Windows
>   mingw: do not bother to test funny file names
>
> Karsten Blees (2):
>   mingw: factor out Windows specific environment setup
>   mingw: do not use symlinks with SVN in t9100
>
> Pat Thoyts (1):
>   mingw: avoid absolute path in t0008
>
> Thomas Braun (1):
>   mingw: outsmart MSYS2's path substitution in t1508
>
> =EB=A7=88=EB=88=84=EC=97=98 (2):
>   mingw: try to delete target directory before renaming
>   mingw: fix git-svn tests that expect chmod to work
>
>  Makefile                              |  1 +
>  compat/mingw.c                        | 91 +++++++++++++++++++++++++=
++++------
>  config.mak.uname                      |  3 +-
>  perl/Git.pm                           |  3 +-
>  t/lib-git-daemon.sh                   |  5 ++
>  t/t0008-ignores.sh                    |  8 ++-
>  t/t0060-path-utils.sh                 | 37 ++++++++------
>  t/t1508-at-combinations.sh            | 13 ++++-
>  t/t3300-funny-names.sh                |  1 +
>  t/t3600-rm.sh                         |  3 +-
>  t/t3703-add-magic-pathspec.sh         |  2 +-
>  t/t3902-quoted.sh                     |  1 +
>  t/t4016-diff-quote.sh                 |  1 +
>  t/t4135-apply-weird-filenames.sh      |  3 +-
>  t/t5601-clone.sh                      | 18 +++----
>  t/t7800-difftool.sh                   | 14 +++---
>  t/t9100-git-svn-basic.sh              | 29 +++++++----
>  t/t9118-git-svn-funky-branch-names.sh | 12 +++--
>  t/t9124-git-svn-dcommit-auto-props.sh | 20 ++++++--
>  t/t9130-git-svn-authors-file.sh       |  2 +-
>  t/t9200-git-cvsexportcommit.sh        |  2 +-
>  t/t9400-git-cvsserver-server.sh       |  6 +--
>  t/t9401-git-cvsserver-crlf.sh         |  6 +--
>  t/t9402-git-cvsserver-refs.sh         |  6 +--
>  t/t9700/test.pl                       |  2 +-
>  t/t9903-bash-prompt.sh                |  2 +-
>  t/test-lib.sh                         |  2 +-
>  test-fake-ssh.c                       | 30 ++++++++++++
>  28 files changed, 238 insertions(+), 85 deletions(-)
>  create mode 100644 test-fake-ssh.c
