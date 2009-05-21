From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Getting Commits from One Repository to Another
Date: Thu, 21 May 2009 11:12:57 +0200
Message-ID: <vpq8wkq95uu.fsf@bauges.imag.fr>
References: <7D9240D0-C8BA-40C6-A89E-8BC7E08B1163@gmail.com>
	<20090521040451.GC8091@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Big Lebowski <duderino.lebowski@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 21 11:17:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M74PP-0003g4-Kk
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 11:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbZEUJRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 05:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752668AbZEUJRk
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 05:17:40 -0400
Received: from imag.imag.fr ([129.88.30.1]:56060 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051AbZEUJRi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 05:17:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n4L9D6UA015554
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 21 May 2009 11:13:06 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1M74Kf-0000Wg-SH; Thu, 21 May 2009 11:12:57 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1M74Kf-00011z-Pm; Thu, 21 May 2009 11:12:57 +0200
In-Reply-To: <20090521040451.GC8091@sigill.intra.peff.net> (Jeff King's message of "Thu\, 21 May 2009 00\:04\:51 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 21 May 2009 11:13:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119663>

Jeff King <peff@peff.net> writes:

> On Wed, May 20, 2009 at 07:37:54PM -0400, Big Lebowski wrote:
>
>> Essentially, when I came on a project, a git repository was made  
>> available to me (lets call that 'public_repo'). That repository was put up 
>> on an unfuddle account, as an initial check-in; it was not cloned from the 
>> repository they were working on (lets call that 'private_repo'). I wrote 
>> some code, and pushed it to the repository. Now that I guess they feel 
>> comfortable with me, they reveal to me the private_repo.
>>
>> How do I get my code from public_repo to private_repo?
>
> You could just repeat the push you made to public_repo to
> private_repo.

As I understand the situation, no, because the public repo was not a
clone of the private one, but a fresh import (without history?).
So, the ancestor of the commits of the OP do not exist in the private
repository.

But don't panic, "git rebase" will be able to replay your history on
another branch. The commands to type will be along the lines of:

cd public-repo
git remote add private url-of-private-repo
git fetch private
# not sure about the exact syntax here:
git rebase  --onto private/master your-first-commit^ master

and then perhaps

git push private master

-- 
Matthieu
