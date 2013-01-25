From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9902: protect test from stray build artifacts
Date: Thu, 24 Jan 2013 20:11:07 -0800
Message-ID: <7vvcal7vhg.fsf@alter.siamese.dyndns.org>
References: <201301212330.10824.jn.avila@free.fr>
 <7v7gn6f6ya.fsf@alter.siamese.dyndns.org>
 <20130122003954.GA23297@sigill.intra.peff.net>
 <7vehha89j5.fsf_-_@alter.siamese.dyndns.org>
 <20130125011349.GB27657@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 25 05:11:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyadZ-0001P7-0H
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 05:11:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792Ab3AYELM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 23:11:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63777 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752732Ab3AYELK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 23:11:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D78F2C882;
	Thu, 24 Jan 2013 23:11:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iRWQ3NHQ8/g8hQQRmYiqYMlYJL0=; b=mnM+HY
	dmY1nmLBeUwGVb5dUhOEMx1E9F/rOyH/nK98+RIjWg+shU38LqEhIayH4CRVe9FL
	o9KFqmHGMAq9Rd3J+RA7qSvm9/6jB33StnnrcFFjnmxTascreCe301IZlewuFbkH
	DBSzBIdkS0VZ4gkzft+Xe9juKV3A42LUZKFMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NT3NkNzUrORgle4MnsBcd4NAnWxeW4nJ
	uG4AYiD/B4J/xR5T8Ts11VBgOa/xLxW5FTI1siqrNJPIcJ7Fk9LiZ51fH/1A/3eV
	lY/WrkV8ub/9uj1cGbL0oLsXSwFQaEjJZHv1Z+GpGFKIBPcu5L29Spc/da05M7GD
	Lwjr7VaH33g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB048C881;
	Thu, 24 Jan 2013 23:11:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C2EEC87E; Thu, 24 Jan 2013
 23:11:09 -0500 (EST)
In-Reply-To: <20130125011349.GB27657@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 24 Jan 2013 20:13:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3F669638-66A5-11E2-8A70-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214487>

Jeff King <peff@peff.net> writes:

> This looks good to me.
>
> The only thing I might add is a test just to double-check that "git help
> -a" is parsed correctly. Like:
>
>   test_expect_success 'command completion works without test harness' '
>            GIT_TESTING_COMMAND_COMPLETION= run_completion "git bun" &&
>            grep "^bundle\$" out
>   '
>
> (we know we are running bash here, so the one-shot variable is OK to be
> used with a function).

I think you meant "^bundle $" there, but don't we have the same
problem when there is an end-user subcommand "git bunny"?

Ahh, ok, we show one element per line and just make sure "bundle"
is there, and we do not care what other buns appear in the output.

Will squash in, then.
