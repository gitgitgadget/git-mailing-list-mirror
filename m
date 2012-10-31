From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 'git describe' is very slow on development trees with lots of
 commits
Date: Wed, 31 Oct 2012 18:52:26 +0100
Message-ID: <20121031175226.GB20660@elf.ucw.cz>
References: <1351261913-28250-1-git-send-email-acme@infradead.org>
 <20121026145451.GA14379@gmail.com>
 <508AA709.7010202@gmail.com>
 <20121027133352.GB30001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Ahern <dsahern@gmail.com>, git@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@infradead.org>,
	linux-kernel@vger.kernel.org, Andrew Vagin <avagin@openvz.org>,
	Borislav Petkov <bp@amd64.org>,
	David Howells <dhowells@redhat.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Stephane Eranian <eranian@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, arnaldo.melo@gmail.com,
	Arnaldo Carvalho de Melo <acme@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
X-From: linux-kernel-owner@vger.kernel.org Wed Oct 31 18:53:00 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1TTcTI-0001GP-HW
	for glk-linux-kernel-3@plane.gmane.org; Wed, 31 Oct 2012 18:52:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423013Ab2JaRwa (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 31 Oct 2012 13:52:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53906 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759382Ab2JaRw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Oct 2012 13:52:27 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
	id 74B54F082B; Wed, 31 Oct 2012 18:52:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20121027133352.GB30001@gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208843>

Hi!

> (Cc:-ed the Git development list.)
> 
> * David Ahern <dsahern@gmail.com> wrote:
> 
> > PERF-VERSION-GEN and specifically the git commands are the 
> > cause of more delay than the config checks, especially when 
> > doing the build in a VM with the kernel source on an NFS 
> > mount.
> 
> Yes, I have noticed that too.
....
> The cost on this pretty fast machine is about 1 msecs per commit 
> - which adds up to about 2.5 seconds during much of the 
> development cycle.

Well... I noticed my builds when little changed are very slow... and
it was due to the computation of version string. Ouch.

pavel@amd:~/mainline-altera/linux$ time git describe
fixes-for-linus-506-g71ca8691
0.68user 0.22system 27.82 (0m27.820s) elapsed 3.26%CPU
pavel@amd:~/mainline-altera/linux$ 

(Cached it is more reasonable 3 seconds, but it keeps going out of
cache all the time. Uncached clean build is 3 minutes, cached is 9
seconds + time to do git describe).

Thikpad X60.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
