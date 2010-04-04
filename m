From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Rename ONE_FILESYSTEM to DISCOVERY_ACROSS_FILESYSTEM
Date: Mon, 05 Apr 2010 00:37:37 +0200
Message-ID: <vpqd3ye26a6.fsf@bauges.imag.fr>
References: <1268855753-25840-1-git-send-email-lars@pixar.com>
	<1268855753-25840-4-git-send-email-lars@pixar.com>
	<20100328092253.GA17563@coredump.intra.peff.net>
	<7vr5n44crq.fsf@alter.siamese.dyndns.org>
	<alpine.LFD.2.00.1003301537150.3707@i5.linux-foundation.org>
	<20100330230211.GC608@coredump.intra.peff.net>
	<alpine.LFD.2.00.1003301610151.3707@i5.linux-foundation.org>
	<40aa078e1003301754u3a1e5e9je7bb2aa2dc04f6a1@mail.gmail.com>
	<7v4ojr85ee.fsf_-_@alter.siamese.dyndns.org>
	<7vzl1iyhof.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Lars R. Damerow" <lars@pixar.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@googlemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 00:41:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyYV1-0007Gt-D6
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 00:40:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694Ab0DDWk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 18:40:56 -0400
Received: from imag.imag.fr ([129.88.30.1]:50014 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752453Ab0DDWky (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 18:40:54 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o34MbbFN002710
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 5 Apr 2010 00:37:37 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NyYRl-0006PK-Jn; Mon, 05 Apr 2010 00:37:37 +0200
In-Reply-To: <7vzl1iyhof.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Sun\, 04 Apr 2010 15\:30\:24 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 05 Apr 2010 00:37:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143960>

Junio C Hamano <gitster@pobox.com> writes:

> If a missing ONE_FILESYSTEM defaults to true, the only users who set this
> variable set it to false to tell git not to limit the discovery to one
> filesystem; there are too many negations in one sentence to make a simple
> panda brain dizzy.

Right.

+	an explicit respository directory set via 'GIT_DIR' or on the

While you're there, you can spell respository as "repository" ;-).

> diff --git a/setup.c b/setup.c
> index d290633..5a26b5b 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -392,7 +392,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  	 *   etc.
>  	 */
>  	offset = len = strlen(cwd);
> -	one_filesystem = git_env_bool("GIT_ONE_FILESYSTEM", 0);
> +	one_filesystem = !git_env_bool("GIT_DISCOVERY_ACROSS_FILESYSTEM", 0);
>  	if (one_filesystem) {
>  		if (stat(".", &buf))
>  			die_errno("failed to stat '.'");

I guess you still have one instance of GIT_ONE_FILESYSTEM a little
below in the error message:

"Stopping at filesystem boundary since GIT_ONE_FILESYSTEM is true."

which should become

"Stopping at filesystem boundary since GIT_DISCOVERY_ACROSS_FILESYSTEM\n"
"is not set."

or so.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
