From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Submodule's .git file contains absolute path when created using 'git clone --recursive'
Date: Thu, 05 May 2016 10:19:04 -0700
Message-ID: <xmqq1t5gctiv.fsf@gitster.mtv.corp.google.com>
References: <loom.20160505T140253-275@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Loet Avramson <loet@forter.com>
X-From: git-owner@vger.kernel.org Thu May 05 19:19:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayMvh-0004ot-Mx
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 19:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560AbcEERTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 13:19:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55687 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751389AbcEERTI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 13:19:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A782917B3D;
	Thu,  5 May 2016 13:19:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ihkjHwSc4L3y6398GRarvDFX0ZQ=; b=PdAPhU
	wFvWBVGUUBrrw/iaYMAnUKYQk9F7I6J9PBAcm2NLsoBQVeqQ1je7E9z8oI0RGfJy
	cEIUgCRr+YKQvLT4V7ko9xZ9tAhcZmJ0moQAbjmvHljOkr6pBmskvE0VKPlAoyJQ
	VUinl+e+xDHSCm+AcS1HKOBbc2I8LbCWZRAew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m32tdslvn0ghYO6xQXZsnxC8amoEw1S6
	M1GXVmcPK4NFC1Dd+Q+VJ0gxHcyZq7Ct6MfMgH2qxn+W7hrKrxeUw8TZPuEcwFCY
	6BtdrkAqKkt47MK0bxG9BDAwN+U09x/U2bCvkk8mnWPCKc8sMXnDoOJ9QChIrC20
	g3GtAQX0kQg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9EE9817B3C;
	Thu,  5 May 2016 13:19:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1ED0517B3B;
	Thu,  5 May 2016 13:19:06 -0400 (EDT)
In-Reply-To: <loom.20160505T140253-275@post.gmane.org> (Loet Avramson's
	message of "Thu, 5 May 2016 12:51:22 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 78979D2C-12E5-11E6-84E5-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293653>

Loet Avramson <loet@forter.com> writes:

> According to git-clone man page - running 'git clone --recursive' "...is 
> equivalent to running 'git submodule update --init --recursive' immediately 
> after the clone is finished...", though I found a little difference between 
> the two regarding the submodule's .git file:
>
> 1. Running 'git clone' and 'git submodule update --init --recursive' 
> separately will create the .git file in each submodule containing a relative 
> path to the superproject's .git directory as expected.
>
> 2. Running 'git clone --recursive' will create the .git file containing an 
> *absolute* path to the superproject's .git directory. (as it was expected 
> using git versions 1.7.8 - 1.7.10 as far as I understand)
>
> Not sure if that's a bug but it got stuff behaving really weird in a specific 
> usecase on one of our environments. It would be highly appreciated to update 
> the docs at least.

If the documentation already says "equivalent" and does not say
"identical", I am not sure if there is anything to update.

In any case, I thought some people are already working to make the
result consistently use relative paths (or was it absolute?), so
this may soon become a non-issue.
