From: Junio C Hamano <gitster@pobox.com>
Subject: Re: About git-diff
Date: Wed, 10 Aug 2011 21:49:57 -0700
Message-ID: <7vr54sr1qi.fsf@alter.siamese.dyndns.org>
References: <m2hb5pb3pe.fsf@igel.home>
 <1313024025.97405.YahooMailClassic@web121818.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Luiz Ramos <luizzramos@yahoo.com.br>
X-From: git-owner@vger.kernel.org Thu Aug 11 06:50:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrNDd-0008QS-6R
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 06:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677Ab1HKEuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 00:50:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48199 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751026Ab1HKEuC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 00:50:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A03D127D;
	Thu, 11 Aug 2011 00:49:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dScuJIAnU5TZKXYbNt8EMPgI+oU=; b=JTI4Zv
	nwtebSbN9ezLh5u4rYwI0xj3C1ekZcn+vMxwmYPEYhfD7k0Z29cL98O356VMcxF0
	GfqF5lzAQItdaGHU+BlaqLS4LhSxdGTyY2fbCVDxZULwZAU/Hkn9MJWqxuQ/9VzK
	Cz/QBPWnmK7N/yryMfrqSNiFCZ2Es1q3yczJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IW25BtBR83skkxPSuRT7ZHQmQFOBAKeE
	4Jk001LPzxFWffV8fveHB5GEr+i6IlnJMLhFj1D2sR8DvDcvnTsxZOhsjnBf4/T5
	vrb2ckT2+Jk4pGAK8pcXyUMajyqawI8tCgahxqhkOnMvvzieaODRkY+3bF/yFgR4
	BMXbTQAhwMA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21EE8127C;
	Thu, 11 Aug 2011 00:49:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A68BF1274; Thu, 11 Aug 2011
 00:49:58 -0400 (EDT)
In-Reply-To: <1313024025.97405.YahooMailClassic@web121818.mail.ne1.yahoo.com>
 (Luiz Ramos's message of "Wed, 10 Aug 2011 17:53:45 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5D99F0EC-C3D5-11E0-BC1B-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179081>

Luiz Ramos <luizzramos@yahoo.com.br> writes:

> Given this, I'd suggest to change the inline documentation of git-diff (git help diff). In the version of my machine (1.7.4.4), it's like that:
>
> (snip)
> ...
>        git diff [--options] <commit> [--] [<path>...]
>            This form is to view the changes you have in your working tree
>            relative to the named <commit>. You can use HEAD to compare it with
>            the latest commit, or a branch name to compare with the tip of a
>            different branch.
> ...

Strictly speaking, "the changes you have in your working tree" may be what
is confusing. Your working tree does _not_ have "changes"; it only has
"contents". Changes are perceived only if you compare it with something
else, as their _difference_.

This operation compares "the contents of tracked files in your working
tree" with "the contents recorded in the named <commit>"---the result of
this comparison comparison matches what humans perceive as "changes".

So perhaps updating the first sentence with:

	Compare the contents of tracked files in your working tree with
	what is recorded in the named <commit>.

would be all that is necessary. I didn't bother to look but I suspect we
have a simlar description for "git diff [--options] [--] [<path>...]"
form, and it should be updated in a similar way (the only difference is
that it compares "with what is recorded in the index").
