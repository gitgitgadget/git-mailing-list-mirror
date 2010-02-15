From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 5/6] am: Fix launching of pager
Date: Sun, 14 Feb 2010 23:42:24 -0500
Message-ID: <20100215044223.GA3336@coredump.intra.peff.net>
References: <462027ff1002131314k62069160h63760fc8316aa43b@mail.gmail.com>
 <20100213235156.GA9054@coredump.intra.peff.net>
 <20100214115430.GA1849@progeny.tock>
 <20100214120731.GE3499@progeny.tock>
 <20100215025958.GB17444@progeny.tock>
 <20100215032533.GA19230@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sebastian Celis <sebastian@sebastiancelis.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 05:42:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngsmv-0001Sz-Ax
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 05:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755230Ab0BOEmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 23:42:20 -0500
Received: from peff.net ([208.65.91.99]:56149 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755222Ab0BOEmT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 23:42:19 -0500
Received: (qmail 13114 invoked by uid 107); 15 Feb 2010 04:42:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 14 Feb 2010 23:42:30 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Feb 2010 23:42:24 -0500
Content-Disposition: inline
In-Reply-To: <20100215032533.GA19230@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139968>

On Sun, Feb 14, 2010 at 09:25:33PM -0600, Jonathan Nieder wrote:

> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -107,6 +107,25 @@ git_editor() {
>  	eval "$GIT_EDITOR" '"$@"'
>  }
>  
> +git_pager() {
> +	if test -z "${GIT_PAGER+set}"
> +	then
> +		if tty <&1 >/dev/null 2>/dev/null

We seem to use "test -t 1" for this elsewhere, and I don't see us using
"tty" anywhere else. It is POSIX, and I tested that even Solaris 8 and
AIX 6.1 have it. So I don't think it is a portability issue, but others
may know more than I.

-Peff
