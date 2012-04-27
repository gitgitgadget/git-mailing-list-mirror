From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5570: fix forwarding of git-daemon messages via cat
Date: Fri, 27 Apr 2012 08:02:25 -0700
Message-ID: <xmqqzk9x9q0u.fsf@junio.mtv.corp.google.com>
References: <1334393070-7123-1-git-send-email-zbyszek@in.waw.pl>
	<20120414121358.GA26372@ecki> <20120414122127.GA31220@ecki>
	<4F8C3E0F.2040300@in.waw.pl>
	<20120416174230.GA19226@sigill.intra.peff.net>
	<20120416224424.GA10314@ecki>
	<20120419060326.GA13982@sigill.intra.peff.net>
	<4F8FB779.60004@viscovery.net>
	<20120426130129.GA27785@sigill.intra.peff.net> <4F999105.200@kdbg.org>
	<20120426195503.GA29526@ecki> <4F99B777.4020103@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org, gitster@pobox.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Apr 27 17:02:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNmgz-0006vr-Ag
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 17:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760417Ab2D0PC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Apr 2012 11:02:29 -0400
Received: from mail-yw0-f74.google.com ([209.85.213.74]:64962 "EHLO
	mail-yw0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760412Ab2D0PC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 11:02:27 -0400
Received: by yhgm50 with SMTP id m50so88189yhg.1
        for <git@vger.kernel.org>; Fri, 27 Apr 2012 08:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=r1WO76gTlguIj0u4eE2aWh93krz8hYnYqz7cje0eHck=;
        b=hgRfEPqnhrdgqtlxuq8tyYRHHXA6k5+ST3g/k/p74glxTZcBdMHTlDAh9Jj9dcq+Zi
         yvHMcX4pVeLkM8VTE2ndHTXIz7lZWjEsr/xPULJ1m915bm5Qlp3c/weaxF12rSgk0rR7
         IXecYXfBw53weINdd3z7g/jPU20awHUcSS8gvZx/qRE9GncZ9xTzzqem6WoLyCmz2/h/
         ze33AC5ligjUcRy4LixynvCv/UCJr1a9/0k9VppTN+QYaKjsgES7qIO0r1PmYmRk7wgg
         7pyzGsNzkfgSMzdn25BklKy55nPjBoLn5Gjai/lSThgwS9ciBN7aE//t61YxH+r6tEBL
         Lurw==
Received: by 10.101.133.8 with SMTP id k8mr4366327ann.19.1335538946716;
        Fri, 27 Apr 2012 08:02:26 -0700 (PDT)
Received: by 10.101.133.8 with SMTP id k8mr4366301ann.19.1335538946362;
        Fri, 27 Apr 2012 08:02:26 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id u47si30528yhm.4.2012.04.27.08.02.26
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 27 Apr 2012 08:02:26 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 42E02101203;
	Fri, 27 Apr 2012 08:02:26 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id E15A0E125C; Fri, 27 Apr 2012 08:02:25 -0700 (PDT)
In-Reply-To: <4F99B777.4020103@kdbg.org> (Johannes Sixt's message of "Thu, 26
	Apr 2012 23:00:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQnIhQaGL+ZIL1XbUVlhP9BnyaZHzH5MDzyCGNl2IachOR3qhQii1bssuGwYCy03bxn7/eYoATZXSVJdJebycbfDL+93z+cz4N0qR6NGQE/uTxhVZDy5lfbjzQD9jZJZwDBY2VVOlwgH3Sx8DGqoPOur9Jl6AKEyYIDBTRaw7cFaHh6RtUw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196473>

Johannes Sixt <j6t@kdbg.org> writes:

> The shell function that starts git-daemon wants to read the first line of
> the daemon's stderr to ensure that it started correctly. Subsequent daemon
> errors should be redirected to fd 4 (which is the terminal in verbose mode
> or /dev/null in quiet mode). To that end the shell script used 'read' to
> get the first line of output, and then 'cat &' to forward everything else
> in a background process.
>
> The problem is, that 'cat >&4 &' does not produce any output because the
> shell redirects a background process's stdin to /dev/null. To have this
> command invocation do anything useful, we have to redirect its stdin
> explicitly (which overrides the /dev/null redirection).
>
> The shell function connects the daemon's stderr to its consumers via a
> FIFO. We cannot just do this:
>
>    read line <git_daemon_output
>    cat <git_daemon_output >&4 &
>
> because after the first redirection the pipe is closed and the daemon
> could receive SIGPIPE if it writes at the wrong moment. Therefore, we open
> the readable end of the FIFO only once on fd 7 in the shell and dup from
> there to the stdin of the two consumers.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>

Very clearly explained and fixed; thanks.

Will replace cb/daemon-test-race-fix and queue.
