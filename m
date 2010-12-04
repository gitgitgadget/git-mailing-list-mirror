From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 0/14] misc msvc patches
Date: Sat, 04 Dec 2010 18:49:49 +0000
Message-ID: <4CFA8D4D.2020500@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 04 21:38:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POysh-0000Ke-8q
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 21:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755831Ab0LDUiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 15:38:16 -0500
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:63266 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755811Ab0LDUiO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Dec 2010 15:38:14 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1POys1-0005VJ-jM; Sat, 04 Dec 2010 20:38:13 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162901>

Hi Junio,

The msvc build of git.git is currently broken; these patches fix
the build and suppress most of the *many* compiler warnings.
[These patches are based on master @ 94fdb6f from 2 days ago]

[PATCH 01/14] msvc: Fix compilation errors in compat/win32/sys/poll.c
[PATCH 02/14] msvc: git-daemon.exe: Fix linker "unresolved externals" error
[PATCH 03/14] msvc: Fix build by adding missing INTMAX_MAX define

These patches actually fix the build. Note that I haven't actually tested
git-daemon.exe, but it should behave exactly the same as the MinGW build
(famous last words).

[PATCH 04/14] msvc: Fix macro redefinition warnings

Prior to this patch, the msvc build spews 1184 warnings. After this patch,
the warning count is down to 176! :-P

[PATCH 05/14] run-command.c: Initialise variable to suppress msvc warnings
[PATCH 06/14] match-trees.c: Initialise variables to suppress msvc warnings
[PATCH 07/14] fast-import.c: Initialise variables to suppress msvc warnings
[PATCH 08/14] submodule.c: Initialise variables to suppress msvc warnings
[PATCH 09/14] merge-recursive.c: Initialise variable to suppress msvc warning
[PATCH 10/14] fast-export.c: Initialise variable to suppress msvc warning
[PATCH 11/14] cat-file.c: Initialise variable to suppress msvc warning
[PATCH 12/14] rev-list.c: Initialise variables to suppress msvc warnings
[PATCH 13/14] transport.c: Initialise variable to suppress msvc warning
[PATCH 14/14] wt-status.c: Initialise variable to suppress msvc warning

These patches were originally a single patch, since they all implement the
same fix, and could be squashed back into a single commit.  However, I
decided to split it up by file to make it easier to review. Note that the
warnings here are issued by the linker, since we have requested link-time
code generation, which explains why the one-liner in patch 5 fixes 26
warnings (start_command() is linked into 26 executables). These patches
reduce the warning count to 126.

[The remaining 126 warnings are all very similar, see an up-coming RFC series]

ATB,
Ramsay Jones
