From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v15 04/16] Refactor quote_path_relative, remove unused params
Date: Wed, 26 Jun 2013 10:47:51 -0700
Message-ID: <7v61x0wypk.fsf@alter.siamese.dyndns.org>
References: <cover.1372175282.git.worldhello.net@gmail.com>
	<cover.1372175282.git.worldhello.net@gmail.com>
	<bdd209a2f3848ffa784872f4c244b37d38be82c1.1372175283.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 26 19:47:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Urtp0-0001aQ-8G
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 19:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354Ab3FZRry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 13:47:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62453 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359Ab3FZRrx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 13:47:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CABF2B1A1;
	Wed, 26 Jun 2013 17:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9rncUcmawOX/KFjt8fAYaG9XE9I=; b=M0daHZ
	EW8jqAMXUgVSGdYBt17UKr8WCqun7uT1OiYFvSgw/6P5nEdvmtIHAemH0LuusqaX
	3GRASTooYqjXQmY+FTK/5K2TCMViKtoG9fFZTPKkJrf8vwoqZmcS9oRkoGND4hth
	pWkdBauKmUIsfWzr0kQlH4hVAjJDIUNOhxSCI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CkiJayhCYFMFTlnxoLE4P9T8qWXYzsfC
	eSchxCJk08u65vi46OWkOgzIDj8ii+paxGlctazyPsQy4wMNyDwI1hH0NuROLrFC
	f0u/t9CcTbUz3lamLGvjeBeiawhEo8BjwX4heS278DfkOcWv8vmdMxuYE77niMoa
	+h/vnErFUPs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 331652B1A0;
	Wed, 26 Jun 2013 17:47:53 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 904DE2B19E;
	Wed, 26 Jun 2013 17:47:52 +0000 (UTC)
In-Reply-To: <bdd209a2f3848ffa784872f4c244b37d38be82c1.1372175283.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Tue, 25 Jun 2013 23:53:45 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8662BBBA-DE88-11E2-8543-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229050>

Jiang Xin <worldhello.net@gmail.com> writes:

> After substitute path_relative() in quote.c with relative_path() from
> path.c, parameters (such as len and prefix_len) are obsolete in function
> quote_path_relative(). Remove unused parameters and change the order of
> parameters for quote_path_relative() function.
>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

OK.  I'll amend the log message a bit to say that we verified that
this conversion is safe.

> diff --git a/quote.c b/quote.c
> index 64ff3..ebb8 100644

You seem to be using unusually short abbrev length.

Please don't, at least in format-patch output.

"ebb8" may be unique within your repository, but may not be unique
in repositories of other people who attempt to apply your patches.

Offtopic.  Fixing this, without forcing you to use the default
abbrev length everywhere, _might_ require a bit of changes to the
configuration mechanism, or "git format-patch", or both.  I've also
seen in some other thread that --numstat was used in addition to the
usual --stat, which should not be added to format-patch output only
because the user configured it for other "diff/log" uses, which may
also need to be fixed in the same way.
