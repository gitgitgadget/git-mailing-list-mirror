From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Strip non-printable characters from syntax
 highlighter output
Date: Fri, 16 Sep 2011 13:24:11 -0700
Message-ID: <7v62ksfd78.fsf@alter.siamese.dyndns.org>
References: <1314053923-13122-1-git-send-email-cfuhrman@panix.com>
 <201109161441.58946.jnareb@gmail.com>
 <7vwrd8fnxr.fsf@alter.siamese.dyndns.org>
 <201109162058.51132.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Christopher M. Fuhrman" <cfuhrman@panix.com>, git@vger.kernel.org,
	Christopher Wilson <cwilson@cdwilson.us>,
	Sylvain Rabot <sylvain@abstraction.fr>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 16 22:24:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4exO-0007OS-TX
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 22:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831Ab1IPUYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 16:24:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54612 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753692Ab1IPUYN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 16:24:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 898E251EC;
	Fri, 16 Sep 2011 16:24:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Arf5CiJ3AFHLPzxzTLuaMa2bsMQ=; b=WQt1aR
	ipX/arjDmcAuGWMXT9SAplOZf/Xh/C9DQzQbRdslqlVV92bdz6h0Xbb3APk6REvm
	3LfjS9U0g/nAZQUSRo57cvzjU+obCm4IV1Ylqjsn93Q5/qTWTFr1lxMEVVIZszZ6
	dHDsw86k3pNIVAP7sr+/UOyhnVwzb2DTrgKBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UDSNk3v4isoh9GjSfJpFOcmTSSwz0fPJ
	DIfNmVjAS6cE3XfM1jmFcfoKqaK5DCwVb/UhCiJmWkkM9GhYl9ISOZYOmdlOiq1y
	2LdvpYoKuC7V7tI5KWnC/Cej8Cmp436/mdqMmZw3lBTFcLOYLNXfLdGcSJ7YpkwZ
	CA4tKMvUI04=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80A6951EB;
	Fri, 16 Sep 2011 16:24:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1683451E9; Fri, 16 Sep 2011
 16:24:12 -0400 (EDT)
In-Reply-To: <201109162058.51132.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri, 16 Sep 2011 20:58:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D7813F3A-E0A1-11E0-B190-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181550>

Jakub Narebski <jnareb@gmail.com> writes:

> So actually now I see that while this line is good to have in esc_html(),
> it is not really necessary in sanitize().
>
> But anyway we don't want to replace undef with an empty string; undef is
> (usually) an error, and we want to catch it, not to hide it.

Heh, get off your high horse---whoever wrote such a caller that calls the
subroutine and uses its result without checking it against undef is not
qualified to make such a statement. I do not think letting "perl -w"
notice and complain about an attempt to concatenate undef with string
counts as "catching" it.
