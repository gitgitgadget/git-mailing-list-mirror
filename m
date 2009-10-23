From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] describe: when failing, tell the user about options that
 work
Date: Thu, 22 Oct 2009 17:25:14 -0700
Message-ID: <7vljj3dkid.fsf@alter.siamese.dyndns.org>
References: <76c5b8580910220810n389d065di349339ab38909ef7@mail.gmail.com>
 <f1e86b9095d63c6541d0a8df6a1cf8eadfe247bb.1256226187.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eugene Sajine <euguess@gmail.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Oct 23 02:25:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N17yJ-0005Bx-2f
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 02:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbZJWAZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 20:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbZJWAZU
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 20:25:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52365 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbZJWAZT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 20:25:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4962A63107;
	Thu, 22 Oct 2009 20:25:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nbZmOMDwH6PMm9mpLCrwY1YoLME=; b=bV5wZQ
	raZviWfzH2uJkPRjk2OeL+foCJwAtWCWRipsTroIlKzo05XU8hmR1bqXmV2KjJxJ
	001nU2t73UQyyyIz91KMArTemKaXCnKDsv8lHwI/fMqq6ruNFokRfMDysboWUO//
	r9k4144Ze3efbGaCAYVTuxVOl63pOBEPO5OpU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eWM8ZI8SMJFPSPukNcAbGIktMVVkuFKR
	u9/YmxKHn2DvbbQCrmVT/GvZKNMXiW0MSdWRKCO9fWjEXPzmGFajcPqUd9RkoE6c
	ZvQ5d790V/T79Xh2ppLug5XMAmyohZX1qKROLaJZV6J33nq7wEhng+l9gb0R5iax
	IsnVcBxySu8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A03C63106;
	Thu, 22 Oct 2009 20:25:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 53ECF63104; Thu, 22 Oct
 2009 20:25:16 -0400 (EDT)
In-Reply-To: <f1e86b9095d63c6541d0a8df6a1cf8eadfe247bb.1256226187.git.trast@student.ethz.ch> (Thomas Rast's message of "Thu\, 22 Oct 2009 17\:44\:39 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8BCAEB4A-BF6A-11DE-9EFD-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131078>

Thomas Rast <trast@student.ethz.ch> writes:

> @@ -259,7 +260,14 @@ static void describe(const char *arg, int last_one)
>  			printf("%s\n", find_unique_abbrev(sha1, abbrev));
>  			return;
>  		}
> -		die("cannot describe '%s'", sha1_to_hex(sha1));
> +		if (unannotated_cnt)
> +			die("cannot describe '%s'"
> +			    " with only\nannotated tags. Try --tags.",

Did you mean UNannotated tags here?

> +			    sha1_to_hex(sha1));
> +		else
> +			die("cannot describe '%s'"
> +			    " with tags\nTry --always, or create some tags.",
> +			    sha1_to_hex(sha1));
>  	}
>  
>  	qsort(all_matches, match_cnt, sizeof(all_matches[0]), compare_pt);
