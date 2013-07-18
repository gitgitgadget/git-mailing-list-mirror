From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: git svn fetch segfault on exit
Date: Thu, 18 Jul 2013 14:18:16 +0200
Message-ID: <878v146ozb.fsf@linux-k42r.v.cablecom.net>
References: <51E7B382.8050302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Jonathan Lambrechts <jonathanlambrechts@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 14:18:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UznAF-0004Qp-R7
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 14:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758914Ab3GRMSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 08:18:21 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:3304 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757988Ab3GRMST (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 08:18:19 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 18 Jul
 2013 14:18:12 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 18 Jul 2013 14:18:16 +0200
In-Reply-To: <51E7B382.8050302@gmail.com> (Jonathan Lambrechts's message of
	"Thu, 18 Jul 2013 11:21:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230686>

Jonathan Lambrechts <jonathanlambrechts@gmail.com> writes:

> Every git svn call that involves a fetch produces a segmentation fault
> on exit (but the operation succeeds).
>
> *** Error in `/usr/bin/perl': double free or corruption (!prev):
> 0x0000000002ce1ac0 ***
> ======= Backtrace: =========
> /usr/lib/libc.so.6(+0x788ae)[0x7fd4d83798ae]
> /usr/lib/libc.so.6(+0x79587)[0x7fd4d837a587]
> /usr/lib/libapr-1.so.0(apr_allocator_destroy+0x1d)[0x7fd4d568e9ad]
> /usr/lib/libapr-1.so.0(apr_pool_terminate+0x30)[0x7fd4d568f590]
> /usr/lib/perl5/vendor_perl/auto/SVN/_Core/_Core.so(_wrap_apr_terminate+0x50)[0x7fd4d6886920]
> /usr/lib/perl5/core_perl/CORE/libperl.so(Perl_pp_entersub+0x571)[0x7fd4d876f821]
> /usr/lib/perl5/core_perl/CORE/libperl.so(Perl_runops_standard+0x16)[0x7fd4d8767e26]
> /usr/lib/perl5/core_perl/CORE/libperl.so(Perl_call_sv+0x3b0)[0x7fd4d86f93b0]
> /usr/lib/perl5/core_perl/CORE/libperl.so(Perl_call_list+0x2c7)[0x7fd4d86fb477]
> /usr/lib/perl5/core_perl/CORE/libperl.so(perl_destruct+0x1321)[0x7fd4d86fca91]
> /usr/bin/perl(main+0x111)[0x400e01]
> /usr/lib/libc.so.6(__libc_start_main+0xf5)[0x7fd4d8322a15]
> /usr/bin/perl[0x400e71]

Can you check if your version of the perl subversion bindings were
compiled against the perl and subversion versions that you have
installed?

Perl -- as an interpreted language -- is mostly supposed to be safe from
such segfaults, and since git-svn is pure perl, the likely culprit is in
the bindings or the svn libraries.  And the easiest way to get that to
break is a version mismatch.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
