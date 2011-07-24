From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC 0/9] bisect: allow git bisect to be used with repos containing
 damaged trees.
Date: Sun, 24 Jul 2011 10:05:37 +0200
Message-ID: <4E2BD251.6060306@kdbg.org>
References: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 24 10:05:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qkth8-0006lZ-LU
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 10:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567Ab1GXIFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 04:05:46 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:32804 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751457Ab1GXIFl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 04:05:41 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 01EAF2C4008;
	Sun, 24 Jul 2011 10:05:37 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id BA56519F43A;
	Sun, 24 Jul 2011 10:05:37 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.18) Gecko/20110616 SUSE/3.1.11 Thunderbird/3.1.11
In-Reply-To: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177732>

Am 24.07.2011 07:57, schrieb Jon Seymour:
> Currently git bisect assumes that the respository to be undamaged. This limits the usefulness
> of git bisect when working with damaged repositories.

So, what? Isn't a broken repository also (almost) useless w.r.t. log,
checkout, rebase, reset, push, fetch...?

> This series introduces an option, --ignore-checkout-failure, which can be used with 
> "git bisect start" to indicate that checkout failures should be tolerated for the life
> of the (new) bisection process. This allows git bisect to be used on damaged repositories. In
> particular, it allows git bisect to be used to locate commits containing damaged trees.

I have to wonder: why do you care only about git-bisect? If you want to
be able to use a broken repository, aren't there many more commands that
fail and for which you also want to have a similar work-around? Or is
git-bisect the only one where the work-around was missing?

> If the --ignore-checkout-failure option is specified, then if git checkout fails either 
> at the start of the bisection process or later while probing a new trial commit, then the 
> checkout failure will be noisily ignored and the HEAD reference will be updated to the 
> intended commit. This may leave the working tree and index in an inconsistent state
> w.r.t the HEAD commit.

But what is an inconsistent state good for? In general, it makes no
sense to decide whether the result is "good" or "bad" when you know in
advance that the checked-out state is inconsistent.

-- Hannes
