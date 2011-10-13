From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/14] resolve_gitlink_ref(): improve docstring
Date: Thu, 13 Oct 2011 11:48:35 -0700
Message-ID: <7vehyg4tj0.fsf@alter.siamese.dyndns.org>
References: <1318492715-5931-1-git-send-email-mhagger@alum.mit.edu>
 <1318492715-5931-7-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 13 20:48:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REQKh-0004ae-VL
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 20:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549Ab1JMSsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 14:48:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36925 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751703Ab1JMSsi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 14:48:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8193A35DD;
	Thu, 13 Oct 2011 14:48:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jtT18jXdt7ORwclVOmXJh7E3vhM=; b=mruKEb
	Y95g+zXnZV0cZwnMWhNmsGP4cHDk9kvXAar5AO2MEmSZEtnTogsbLYx13/f1/6iA
	nU8TU4iHi8gGyAmIojfOK8wmyPIs+PTXU2bjVCclHlCg9gEH/nD74/17gIRI/dbN
	nkfqQfDO5etusMZzKzNWOlqv9yb36ARn2hiHU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jBBFhwnopgTJsMXrnjJNxrBFEVR42G9n
	B2ITv9x+ihBfJkcii1SkA+bWmIixDVBR67SI1nEHX1WRH1MBRvASiwqbs6NJXH9n
	/WFppfFa/Goce3kddKFdAyaeaTP6cp6wYklo7sv6PSzizO9sbXf9Qp2dds+qwhM0
	LyqfL/NxjQE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BBBC35DB;
	Thu, 13 Oct 2011 14:48:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E62FA35D7; Thu, 13 Oct 2011
 14:48:36 -0400 (EDT)
In-Reply-To: <1318492715-5931-7-git-send-email-mhagger@alum.mit.edu>
 (mhagger@alum.mit.edu's message of "Thu, 13 Oct 2011 09:58:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F5A88B00-F5CB-11E0-B440-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183512>

mhagger@alum.mit.edu writes:

> From: Michael Haggerty <mhagger@alum.mit.edu>
>
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

> -/** resolve ref in nested "gitlink" repository */
> +/**
> + * Resolve refname in the nested "gitlink" repository that is located
> + * at name.  If the resolution is successful, return 0 and set sha1 to
> + * the name of the object; otherwise, return a non-zero value.
> + */

It is clear that "refname" would refer to things like "refs/heads/master",
but "name" is still not clear enough with the description. 'repository
that is located at name' hints that we may be dealing with more than one
repository and 'name' is a way to identify which one, but perhaps "path"
or "submodule" a much clearer way to indicate what the code is doing.

At the UI level, a submodule has "name" and "path" that are often the same
but can be different (e.g. when the superproject moves a submodule that
used to be bound to path "dir" to a different location, only the latter
should change). I do not think resolve_gitlink_ref() takes the submodule
name, but it takes the path to the submodule in the superproject. In that
sense, "submodule_path" would be the clearest descriptive name for this
parameter.

>  extern int resolve_gitlink_ref(const char *name, const char *refname, unsigned char *sha1);
