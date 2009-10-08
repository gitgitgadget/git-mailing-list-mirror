From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git log -S not finding all commits?
Date: Thu, 08 Oct 2009 13:40:45 +0200
Message-ID: <vpqbpkixgea.fsf@bauges.imag.fr>
References: <7ae12651.522df17b.4acda0f5.21a31@o2.pl> <4ACDACE6.9060509@op5.se>
	<362436ca.6b5d0fc3.4acdc7e1.41b23@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Daniel <mjucde@o2.pl>
X-From: git-owner@vger.kernel.org Thu Oct 08 13:43:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvrPG-0008F2-OC
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 13:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757676AbZJHLle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 07:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757673AbZJHLld
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 07:41:33 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33233 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757668AbZJHLld (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 07:41:33 -0400
Received: from archeboc.imag.fr (archeboc.imag.fr [129.88.43.1])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n98Bekli023590
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 8 Oct 2009 13:40:46 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by archeboc.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1MvrMT-00060o-BN; Thu, 08 Oct 2009 13:40:45 +0200
In-Reply-To: <362436ca.6b5d0fc3.4acdc7e1.41b23@o2.pl> (Daniel's message of "Thu\, 08 Oct 2009 13\:07\:13 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 08 Oct 2009 13:40:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n98Bekli023590
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1255606847.4057@qHBE2PnfKXVGVW6WA3WBww
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129687>

Daniel <mjucde@o2.pl> writes:

> Andreas Ericsson <ae@op5.se> wrote:
>
>> Yes, it's the correct behaviour. -S finds only lines where what you search
>> for was added or deleted. It counts the number of occurrences of what you
>> specify in each resulting tree and only shows the commits where that number
>> changed. In your case, searching for "Free data " would have printed both
>> commits, since you first introduce that entire string and then remove it.
>
> Thanks. However, your suggestion doesn't work. It prints only commit 2. Maybe
> you meant:
>
> $ PAGER=cat git log --pickaxe-regex -S'Free data$' --oneline
>
> but that doesn't solve my problem. I want to find all commits which changed
> lines containing "Free data" (the example I posted is simplified).
>
> Seems I have to use "git log -p" and search its output using pager...

Search the ML's archives, this is a FAQ. People have proposed an
option to allow log -S to actually search the diff (much slower, but
sometimes what you really want), but AFAIK, no one wrote the code. But
I think someone posted a small perl script along the lines of

git log -p --format="%s\n%x00"  | perl -0 -ne 'print if(/whatever-you-search/);'

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
