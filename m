From: Junio C Hamano <gitster@pobox.com>
Subject: Re: .git ignored regardless of --git-dir value
Date: Fri, 18 Nov 2011 13:26:44 -0800
Message-ID: <7vsjlljf57.fsf@alter.siamese.dyndns.org>
References: <CAC2kKA_PZNDg_dPjWXKeFU4ZVpMas3PubZfSgTnfCfVPuNPdsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Shawn Ferris <shawn.ferris@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 18 22:26:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRVxV-0007Qu-2R
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 22:26:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753070Ab1KRV0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 16:26:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38330 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751105Ab1KRV0r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 16:26:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13C2653BE;
	Fri, 18 Nov 2011 16:26:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M2dNXYopeCZWB3clsWG9RzpHrLM=; b=jnubEN
	IzYJOKrO+TsEZ0g1NS9E2OdFDoejMqOnIOxrZVCTd/Dhq9KozecPtCtg2o+Dk7jA
	nStrUGauABk6qb7+jq5fPbF6gWxSYW6iOzz5HQDyO4LzYfwQppFfOvV72KXT/O3E
	cSr06zik+ME5sEX4NJdODSmavrU6N4n9WqkG8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Es7ssrYAwqm3jZm0BxJ3FWLYPCGLLgGB
	wM85rJHdgoDIV8lCe4XHvyLrKJakkzfRGLjhfejATQHnyGAJnDUhVpY2uPwJCNWO
	Sphlqpbf+AH9UXD2ZnIpviBFI8d/0Pu0oDel5kqIY3eem/8kHP5gl26oBBCw9r1G
	EePJH8XOfY8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F379A53BD;
	Fri, 18 Nov 2011 16:26:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7EB3153BC; Fri, 18 Nov 2011
 16:26:46 -0500 (EST)
In-Reply-To: <CAC2kKA_PZNDg_dPjWXKeFU4ZVpMas3PubZfSgTnfCfVPuNPdsA@mail.gmail.com> (Shawn
 Ferris's message of "Fri, 18 Nov 2011 13:56:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 04BED2B2-122C-11E1-8BFD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185681>

Shawn Ferris <shawn.ferris@gmail.com> writes:

> Is it expected behavior to have the .git directory ignored, even after
> specifying an alternate location with --git-dir? For example:
>
> $ git --git-dir=.foo init
> Initialized empty Git repository in /home/sferris/work/t/.foo/

GIT_DIR and --git-dir are meant to refer to a different .git dir (or a
bare-looking repository) located elsewhere, and not for a random pathname
like ".foo". No matter what, ".git/" anywhere is ignored from very early
days of Git, as Linus himself writes in the source, e.g. 8695c8b (Add
"show-files" command to show the list of managed (or non-managed) files.,
2005-04-11):

 ...
 * Also, we currently ignore all names starting with a dot.
 * That likely will not change. 
 ...
