From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: git.git as of tonight
Date: Mon, 2 Nov 2015 22:15:18 +0100
Message-ID: <5637D266.4060904@kdbg.org>
References: <xmqqpoztf6ok.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 22:15:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtMRr-0001Ae-KB
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 22:15:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256AbbKBVPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 16:15:23 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:64577 "EHLO bsmtp4.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751275AbbKBVPW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 16:15:22 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp4.bon.at (Postfix) with ESMTPSA id 3nqRpv1S1Vz5tlG;
	Mon,  2 Nov 2015 22:15:19 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 6A08C5380;
	Mon,  2 Nov 2015 22:15:18 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <xmqqpoztf6ok.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280720>

Am 02.11.2015 um 03:58 schrieb Junio C Hamano:
> * sb/submodule-parallel-fetch (2015-10-21) 14 commits
>    (merged to 'next' on 2015-10-23 at 8f04bbd)
>   + run-command: fix missing output from late callbacks
>   + test-run-command: increase test coverage
>   + test-run-command: test for gracefully aborting
>   + run-command: initialize the shutdown flag
>   + run-command: clear leftover state from child_process structure
>   + run-command: fix early shutdown
>    (merged to 'next' on 2015-10-15 at df63590)
>   + submodules: allow parallel fetching, add tests and documentation
>   + fetch_populated_submodules: use new parallel job processing
>   + run-command: add an asynchronous parallel child processor
>   + sigchain: add command to pop all common signals
>   + strbuf: add strbuf_read_once to read without blocking
>   + xread_nonblock: add functionality to read from fds without blocking
>   + xread: poll on non blocking fds
>   + submodule.c: write "Fetching submodule <foo>" to stderr
>   (this branch is used by rs/daemon-leak-fix and sb/submodule-parallel-update.)
> 
>   Add a framework to spawn a group of processes in parallel, and use
>   it to run "git fetch --recurse-submodules" in parallel.
> 
>   Will merge to 'master'.

Please don't, yet. This series does not build on Windows:

run-command.c: In function 'set_nonblocking':
run-command.c:1011: error: 'F_GETFL' undeclared (first use in this function)
run-command.c:1011: error: (Each undeclared identifier is reported only once
run-command.c:1011: error: for each function it appears in.)
run-command.c:1015: error: 'F_SETFL' undeclared (first use in this function)
run-command.c:1015: error: 'O_NONBLOCK' undeclared (first use in this function)
make: *** [run-command.o] Error 1

I have to investigate whether we can have some sort of Posixy
non-blocking IO on Windows or whether we have to opt-out from this
parallel-process facility. Any help from Windows experts would be
appreciated.

-- Hannes
