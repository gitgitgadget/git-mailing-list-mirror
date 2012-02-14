From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-svn, perl/Git.pm: extend and use Git->prompt
 method for querying users
Date: Tue, 14 Feb 2012 14:35:23 -0800
Message-ID: <7v4nut59hw.fsf@alter.siamese.dyndns.org>
References: <4EF9ED58.8080205@tu-clausthal.de>
 <20120103184022.GA20926@sigill.intra.peff.net>
 <4F37E2B0.9060007@tu-clausthal.de> <201202121711.45920.jnareb@gmail.com>
 <4F37E843.6070107@tu-clausthal.de>
 <20120214222055.GE24802@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 14 23:35:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxQyB-0002sb-8q
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 23:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626Ab2BNWf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 17:35:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46181 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932601Ab2BNWf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 17:35:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E1F173BE;
	Tue, 14 Feb 2012 17:35:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zKC8TQCX/1E8YCDFp4xQ6vS29M4=; b=QHPZI3
	Lapd4jQhoi1l+jEOnL0KLTk538w5MU5YwPxYzgJqgB16rUWAT4eLOEWMw7V92yEc
	B0m6V3jFH4BdrikdAi7raomWs8T/0Bp3vcE06GUw+VjSf/tHtRoNiYs9UI73gJaB
	JVyT7EWddcf+orXyg51EMcVhc9+vp8KtttUng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ElUFsMs7BJhaz+NJLVM2fPmrbKcEAdu4
	2txAFtHp/CvD8Lld1vIK4pB0brFuxtK9UQMf2CPQiNKaoWX0axkh2kLeYfLv0Zlo
	Kda7kDmy7cmuikJBKn4uviDc35d+ryBLrJIRIzJDephBQThcU3cG2hQG5z3ZkQJ8
	PU8aPnzroo8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2518B73BD;
	Tue, 14 Feb 2012 17:35:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB1E773BC; Tue, 14 Feb 2012
 17:35:24 -0500 (EST)
In-Reply-To: <20120214222055.GE24802@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 14 Feb 2012 17:20:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2FB98D8E-575C-11E1-BB77-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190785>

Jeff King <peff@peff.net> writes:

>   export SSH_ASKPASS=whatever
>
>   # this will try the terminal first, then SSH_ASKPASS, because it is
>   # ssh doing the asking
>   git push ssh://example.com/repo.git

Sorry, you lost me here.  Does "ssh example.com" consult the terminal
first and then fall back to SSH_ASKPASS environment variable?

I was under the impression that SSH_ASKPASS was to either give hands-free
access to the keychain or give GUI experience so that people do not have
to type from their terminals...

>   # this will try SSH_ASKPASS first, then the terminal, because git is
>   # doing the asking
>   git push https://example.com/repo.git
>
> So now I'm more convinced than ever that the order should be
> GIT_ASKPASS, terminal, SSH_ASKPASS.
