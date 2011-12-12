From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 1/3] test-terminal: give the child an empty stdin TTY
Date: Mon, 12 Dec 2011 20:14:31 +0100
Message-ID: <201112122014.32029.trast@student.ethz.ch>
References: <b97d14da67bd6097e5b04f6ae3057c0f1d536a0b.1323713230.git.trast@student.ethz.ch> <7vfwgp4niu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 20:14:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaBKl-00005s-3J
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 20:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546Ab1LLTOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 14:14:39 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:57770 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752023Ab1LLTOh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 14:14:37 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Dec
 2011 20:14:32 +0100
Received: from thomas.inf.ethz.ch (80.219.158.96) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Dec
 2011 20:14:35 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.3-1-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <7vfwgp4niu.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [80.219.158.96]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186935>

Junio C Hamano wrote:
> 
> Perhaps "make test" should do that for all tests, not just this terminal
> related one? Doing it this way we do not have to worry about other tests
> reading from the standard input by mistake.
[...]
> --- a/Makefile
> +++ b/Makefile
> @@ -2239,7 +2239,7 @@ export NO_SVN_TESTS
>  ### Testing rules
>  
>  test: all
> -	$(MAKE) -C t/ all
> +	$(MAKE) -C t/ all </dev/null

But now you haven't fixed (in t/) 'make prove', 'make valgrind', or
./tXXXX-foo.sh.  If anything, this angle of attack should go into
test-lib.sh...

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
