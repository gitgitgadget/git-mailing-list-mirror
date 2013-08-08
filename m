From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Reproducible, corrupt packfile after fresh git-svn checkout message 3 of 20)
Date: Thu, 8 Aug 2013 15:20:51 +0200
Message-ID: <87y58c1fpo.fsf@linux-k42r.v.cablecom.net>
References: <52037F47.5010302@exxcellent.de> <52037F84.9060006@exxcellent.de>
	<f1d8f80d6fa3678ac043bfdb19bebf6bf4261273@localhost>
	<877gfw4byx.fsf@linux-k42r.v.cablecom.net>
	<262a9f8309a3812970f47ac9f4e4b49bb972ca49@localhost>
	<87fvuk2wl0.fsf@linux-k42r.v.cablecom.net>
	<9aa1672d5c04994f416dccd84b5983c960c0fdf9@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: <gitml.jexpert@recursor.net>
X-From: git-owner@vger.kernel.org Thu Aug 08 15:20:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7Q9C-0001IV-3A
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 15:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934255Ab3HHNUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 09:20:54 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:46452 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934221Ab3HHNUx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 09:20:53 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 8 Aug
 2013 15:20:49 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.253) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 8 Aug 2013 15:20:51 +0200
In-Reply-To: <9aa1672d5c04994f416dccd84b5983c960c0fdf9@localhost> (gitml
	jexpert's message of "Thu, 08 Aug 2013 15:12:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.253]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231883>

gitml.jexpert@recursor.net writes:

> So - now the puzzling thing: With valgrind it seems to work! 
> If I run it plain, it doesn't:
>
> /tmp/project.git $ valgrind --track-origins=yes  ~/projects/git.git/git-fsck
[...]
> ==3431== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 2 from 2)
> /tmp/project.git $ ~/projects/git.git/git-fsck
> Checking object directories: 100% (256/256), done.
> error: packed 49cdd0b21a351f3366008615d2cf8d03ca943978 from
> .git/objects/pack/pack-6a6f5355584a5d71215d5fc867ce09602ceab533.pack
> is corrupt
> *** glibc detected *** <unknown>: free(): invalid pointer: 0x00007f8576682010 ***
> ======= Backtrace: =========
> /lib/x86_64-linux-gnu/libc.so.6(+0x7eb96)[0x7f85ad765b96]
> [0x4e727c]
[...]
> Any further hints?

Hrm.  Can you try getting a backtrace from

  $ gdb ~/projects/git.git/git-fsck
  (gdb) run
  ... wait until it crashes ...
  (gdb) backtrace full

I would have been more interested in error output from valgrind, because
memory corruption invariably happens long before glibc finally figures
out that something is amiss.  But as things stand, the backtrace is
probably the only thing we have...

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
