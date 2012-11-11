From: Kalle Olavi Niemitalo <kon@iki.fi>
Subject: Re: What's cooking in git.git (Nov 2012, #02; Fri, 9)
Date: Sun, 11 Nov 2012 09:02:48 +0200
Message-ID: <87wqxs4o6f.fsf@Niukka.kon.iki.fi>
References: <20121109192336.GA9401@sigill.intra.peff.net>
	<87a9uq5tql.fsf@Niukka.kon.iki.fi>
	<20121110155209.75EFC2E8B68@grass.foxharp.boston.ma.us>
	<871ug15k5c.fsf@Niukka.kon.iki.fi>
	<20121110220811.DC6A42E8B68@grass.foxharp.boston.ma.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Fox <pgf@foxharp.boston.ma.us>
X-From: git-owner@vger.kernel.org Sun Nov 11 08:01:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXRYJ-0008Bn-Fc
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 08:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170Ab2KKHBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 02:01:32 -0500
Received: from saarni.dnainternet.net ([83.102.40.136]:41905 "EHLO
	saarni.dnainternet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077Ab2KKHBb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 02:01:31 -0500
Received: from localhost (localhost [127.0.0.1])
	by saarni.dnainternet.net (Postfix) with ESMTP id 8A00460366;
	Sun, 11 Nov 2012 09:01:29 +0200 (EET)
X-Virus-Scanned: DNA Postiturva at dnainternet.net
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from saarni.dnainternet.net ([83.102.40.136])
	by localhost (saarni.dnainternet.net [127.0.0.1]) (DNA Postiturva, port 10041)
	with ESMTP id f-NvMju3Qs1d; Sun, 11 Nov 2012 09:01:28 +0200 (EET)
Received: from omenapuu.dnainternet.net (omenapuu.dnainternet.net [83.102.40.212])
	by saarni.dnainternet.net (Postfix) with ESMTP id D9E6B60342;
	Sun, 11 Nov 2012 09:01:28 +0200 (EET)
Received: from Niukka.Niemitalo.private (85-131-104-149.bb.dnainternet.fi [85.131.104.149])
	by omenapuu.dnainternet.net (Postfix) with ESMTP id 950732BAD5;
	Sun, 11 Nov 2012 09:01:26 +0200 (EET)
In-Reply-To: <20121110220811.DC6A42E8B68@grass.foxharp.boston.ma.us> (Paul
	Fox's message of "Sat, 10 Nov 2012 17:08:11 -0500")
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/23.0.51 (gnu/linux)
X-Accept-Language: fi;q=1.0, en;q=0.9, sv;q=0.5, de;q=0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209325>

Paul Fox <pgf@foxharp.boston.ma.us> writes:

> you're sending SIGINT to the cvs commit command, and that causes the
> editor to die right away?

That's right.  It is not a quirk of shell-mode in Emacs, because
I get the same result with ^C in xterm too.

% EDITOR="$HOME/prefix/x86_64-unknown-linux-gnu/bin/emacsclient --current-frame"
% export EDITOR
% cvs commit BUGIT
Waiting for Emacs...^Ccvs commit: warning: editor session failed

Log message unchanged or not specified
a)bort, c)ontinue, e)dit, !)reuse this message unchanged for remaining dirs
Action: (continue) a
cvs [commit aborted]: aborted by user
% 

While cvs was waiting from emacsclient:

% cat /proc/2030/stat
2030 (cvs) S 1849 2030 1849 34816 2030 4202496 598 0 0 0 0 0 0 0 20 0 1 0 94752537 34254848 410 18446744073709551615 140168182550528 140168183348316 140737407935424 140737407931680 140168163193950 0 0 6 20513 0 0 0 17 2 0 0 0 0 0
% grep 'Name\|Pid\|Sig' /proc/2030/status
Name:	cvs
Pid:	2030
PPid:	1849
TracerPid:	0
SigQ:	0/28998
SigPnd:	0000000000000000
SigBlk:	0000000000000000
SigIgn:	0000000000000006
SigCgt:	0000000180005021
% cat /proc/2031/stat
2031 (emacsclient) S 2030 2030 1849 34816 2030 4202496 155 0 0 0 0 0 0 0 20 0 1 0 94752538 4169728 81 18446744073709551615 4194304 4210620 140735996104016 140735996095456 140664960886018 0 0 0 0 0 0 0 17 1 0 0 0 0 0
% grep 'Name\|Pid\|Sig' /proc/2031/status
Name:	emacsclient
Pid:	2031
PPid:	2030
TracerPid:	0
SigQ:	0/28998
SigPnd:	0000000000000000
SigBlk:	0000000000000000
SigIgn:	0000000000000000
SigCgt:	0000000000000000
%

which I interpret to mean both processes were in process group
2030, the cvs process ignored SIGINT and SIGQUIT, the emacsclient
process neither ignored nor handled any signals, and neither
process blocked any signals (not even SIGCHLD as system(3) would).
When ^C in the terminal sent SIGINT to the process group, it
terminated the emacsclient process only.

If git did the same thing as cvs here, i.e. ignore the signals in
the parent process only and check the exit status of the editor,
I think that would be OK.
