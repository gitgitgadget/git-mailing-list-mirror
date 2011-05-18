From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] config: define and document exit codes
Date: Wed, 18 May 2011 08:41:02 -0700
Message-ID: <7vfwocc8z5.fsf@alter.siamese.dyndns.org>
References: <20110517140725.GA17193@sigill.intra.peff.net>
 <6301052eb455e9088e50f78760e6ca1b9499564a.1305646709.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed May 18 17:41:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMis9-0004uF-39
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 17:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756863Ab1ERPlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 11:41:12 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37656 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756849Ab1ERPlM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 11:41:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 55F484716;
	Wed, 18 May 2011 11:43:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=p6bU4npe7QNvCtSc+UayWS7Hb/U=; b=oUL102yJ6hD36vrBG2FI
	a2krKFGpYMAf3v0mzBfdZFizPoJ/TJ8NGsVMEd1x0wSWcRJ+lWtuicp0Rdqdsg0q
	5BHhxiZD1Amx8YAc7D4Y8wg/Uty2d0Uh97JeYNIXZN+FQHToH/o3ScnH79HJ/MdS
	71G91kB3aTxpLXKhbqpQaKs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=jP/zGa/hRaLzDG/pp1J25w629lpKMwkR+WRj8CuqKEKdKU
	ABuwDDqBz/vjyg+OoQ2QhXAgJ966la1nbVGCVvzpUx8BmrYdHR7iIRWbpn/4XFBu
	eAgec6zttjE5ZA11Pq8lhKw4DOrshU2EbRz+pccH6ZPAQTZ8Chd03Hr5Le09w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 239084713;
	Wed, 18 May 2011 11:43:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id ED988470E; Wed, 18 May 2011
 11:43:10 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8B57E550-8165-11E0-808B-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173886>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> +This command will fail (with exit code ret) if:
> +
> +. The config file is invalid (ret=3),
> +. can not write to the config file (ret=4),
> +. no section or name was provided (ret=2),
> +. the section or key is invalid (ret=1),
> +. you try to unset an option which does not exist (ret=5),
> +. you try to unset/set an option for which multiple lines match (ret=5),
> +. you try to use an invalid regexp (ret=6), or
> +. you use '--global' option without $HOME being properly set (ret=128).

I wonder if you want to sort this in the order of return codes.

> +/* git_config_parse_key() returns these negated: */
> +#define CONFIG_INVALID_KEY 1
> +#define CONFIG_NO_SECTION_OR_NAME 2
> +/* git_config_set(), git_config_set_multivar() return the above or these: */
> +#define CONFIG_NO_LOCK -1
> +#define CONFIG_INVALID_FILE 3
> +#define CONFIG_NO_WRITE 4
> +#define CONFIG_NOTHING_SET 5
> +#define CONFIG_INVALID_PATTERN 6

Symbols "CONFIG_FOO" looks too much like they are about the feature set
chosen when compiling git, at least to me. But I do not think of a better
naming scheme ("CONFIG_ERR_FOO" may be a slight improvement but not good
enough improvement for the price we pay by having such long symbol names).

By the way, Are you still interested in "diff --stat-count" topic, or have
you abandoned it?
