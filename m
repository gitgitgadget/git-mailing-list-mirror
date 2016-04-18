From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Extend runtime prefix computation
Date: Mon, 18 Apr 2016 09:20:25 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604180918500.2967@virtualbox>
References: <20160415143001.GA67437@dinsnail.net> <xmqqfuumddqm.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Michael Weiser <michael.weiser@gmx.de>, git@vger.kernel.org,
	David Abdurachmanov <David.Abdurachmanov@cern.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 09:20:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1as3UC-0004gq-QM
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 09:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbcDRHUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 03:20:40 -0400
Received: from mout.gmx.net ([212.227.17.22]:61911 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751773AbcDRHUk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 03:20:40 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MNIO5-1aq8jT29jV-006t0l; Mon, 18 Apr 2016 09:20:26
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqfuumddqm.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:6cbZr8fFkiU0My1nMThU8aOfhcm5vBA9L393QLqpXPDSub6SZIk
 LZsCpSWvbxSm3GEUxbND8Q8/qx/23z+n1gOI8eN6s/37K0PqHnihI81l5sFXwSYfP4L4NBL
 uLWDneaU9VAk7WuK/H8vvTzgaXeICIa/iGI8As9VQrH0uBuJlTR3Fz40jvdZyNxSi0jQQO7
 tGTeOph9XurOCyrThKL8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QlWz0NJsSqE=:Kh3Qg0o18/fqqQbzD07Alw
 zPh668NTUMg1jl7GTbKZKFq3LDkBDKe2vjGgfOTvYH/HEEkX+V+FaollYYaaxW11dxGDfj+FG
 7x8EUn3zAi2q/BhSnRXVjrXo1CYofyenwLMBzH/28tRb56rOUwKHZMAgx9oPx9u6MITtcbk3f
 tvgw6yRwzUi59pB8BFjLJG68CNSH1jbu+lHxbZeBiHj1k+3TwFOGeaOUY8RFD8yx5oApotJac
 cWTXH1IYimZ/6a0qYyE7RxdOqzSt4rwPSbGbCNQJHwYk17JRWl6tNxPpjGPgQbHbwFJuIHDgu
 cfvB+2Dez0U6BRsC8C+foEzRNajC3p6i8Oy23r6dvH0oIoketw7isTMEk0LSQTMyEHsL1xCpW
 QEt1oZpl4jzsN2vP03iuuL+WPHCQvPt0Q+WnSbZivp+uUnYMXzxsrYDc4yZixE4+0SmeHlDkJ
 AypFBVNEg9pKfYeKV9M//uB0amAbqXDx6Qimf/tvixlRjjpPyvDPhUpY6tXcK1Ac3VwqY7YXc
 YUvqUiJf4W+ZDfnu7FPPvZaZT0pZ642o6PnqQeLsLplIe4jcp/j7mvRVeTyppsXqgidyRNQRd
 AzcKbXXwdRiys2JPuqXje8pWu9avcpvkwaNItmgH4ZDVgtTwKhGtv6UCfFNxTZgvJeSwZb6Ca
 X/LERZjuKXjNqT/JXETfPthTLscsc83OgjUydleWdt1dcGyIStO248Ar8PDrQ70wQwnK0s8NQ
 P2FWExiDuOH6b3jqCS+54WYgI/osp0XXTgSHInXw68DVQYOvIYCf2AFPLfg8P4hWRswAvoIz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291799>

Hi Junio,

On Fri, 15 Apr 2016, Junio C Hamano wrote:

> Michael Weiser <michael.weiser@gmx.de> writes:
> 
> > Make git fully relocatable at runtime extending the runtime prefix
> > calculation. Handle absolute and relative paths in argv0. Handle no path
> > at all in argv0 in a system-specific manner.  Replace assertions with
> > initialised variables and checks that lead to fallback to the static
> > prefix.
> 
> That's a dense description of "what" without saying much about
> "why".  Hint: start by describing what case(s) the current code
> fails to find the correct runtime prefix.  That would give readers a
> better understanding of what problem you are trying to solve.

I have to admit that I am really, *really* skeptical. To me, it looks like
this patch opens the door very wide to unintended consequences.

> >  #ifdef RUNTIME_PREFIX
> > -	assert(argv0_path);
> > -	assert(is_absolute_path(argv0_path));
> 
> Aren't these protecting against future and careless change that
> forgets to call extract-argv0-path or make that function return
> something that is not an absolute path?

This (first) assert() indeed saved me a couple of times from hunting for
bugs in the wrong place. Let's keep it.

Ciao,
Dscho
