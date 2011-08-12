From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Overriding ~/.gitconfig using GIT_CONFIG
Date: Fri, 12 Aug 2011 12:16:44 -0700
Message-ID: <7vr54qmodf.fsf@alter.siamese.dyndns.org>
References: <1313163498.14274.505.camel@rex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Richard Purdie <rpurdie@rpsys.net>
X-From: git-owner@vger.kernel.org Fri Aug 12 21:16:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrxDz-0004lN-IB
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 21:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297Ab1HLTQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 15:16:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45161 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754233Ab1HLTQt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 15:16:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8F963E59;
	Fri, 12 Aug 2011 15:16:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zTtts6i+9mZrk1bAdpRlRJ0LH6o=; b=de5OIX
	QOduLQRtQVtjOu4eKcpcp6nE2I5i633mTtqbE9Zvkyn5Eu8OU06NKAeKZPrN6i8i
	6r75NgIaHMyA2arRgHv9EedOL14mLy5PW9HLYWgdu36j7LP9T1SUDClYNZPiqQAo
	gLOVDRFZrg8CuZ+Y7lKQc3Xos0+XnE2CtfIzA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ax63IezrBx1d9F8NjM7OHRQOxpZ8HJU1
	du1hbVexmrRQY5ZqlPgu2Ba5jfy/cYCFwFhkvCPy8pUkaKRpef34h1Mle8G3umsY
	Z4SNKa6IRMUuR6xLPW2lpaFe1DmnEWw2LCYdWa8YH1ePDZWvrPqYJt5s8ZV+IydL
	Vjzg6Qd65MY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF6883E57;
	Fri, 12 Aug 2011 15:16:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 558D73E56; Fri, 12 Aug 2011
 15:16:46 -0400 (EDT)
In-Reply-To: <1313163498.14274.505.camel@rex> (Richard Purdie's message of
 "Fri, 12 Aug 2011 16:38:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9F003044-C517-11E0-99FA-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179241>

Richard Purdie <rpurdie@rpsys.net> writes:

> Looking through the manuals/code, it suggests I should be able to do:
>
> GIT_CONFIG=/dev/null git XXX
>
> and all should work happily. It doesn't though. As an example, with a
> ~/.gitconfig, "GIT_CONFIG=/dev/null git fetch --all" is clearly
> accessing the file in ~ and then acting upon it.

If the manual says the above is expected for any value of XXX, then that
is a bug in the manual since mid 2008, I think.

See dc87183 (Only use GIT_CONFIG in "git config", not other programs,
2008-06-30).

I _think_ these days a workaround to force a known config is to set HOME
to a value that has a known .gitconfig (or no such file), and decline
usage of /etc/git.config by exporting GIT_CONFIG_NOSYSTEM.
