From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2009, #03; Thu, 20)
Date: Fri, 21 Aug 2009 14:43:03 -0700
Message-ID: <7vskfkc07s.fsf@alter.siamese.dyndns.org>
References: <7veir5naq3.fsf@alter.siamese.dyndns.org>
 <F4C7A2F3-B030-449A-87AC-B54CA2B647B4@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Mark A Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Fri Aug 21 23:44:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MebuC-0008RI-JZ
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 23:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664AbZHUVnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 17:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbZHUVnR
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 17:43:17 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52105 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932515AbZHUVnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 17:43:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 55F7013C86;
	Fri, 21 Aug 2009 17:43:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C33Tz8t4Sw6QFSLEP2FC38iCLGE=; b=L4yQ7R
	X4xmWDIyRHyia9iyhC+P9KzRkkkIig9JB7G8vo7p+YrpTbIXLUaeLMhrAEkvE8C2
	LLf95Xo4UautVcbXPjUk50gzWZrDOmm/ZsxnZhoO92CY/38rKY+mJ8JIcTgfo52p
	oWPp+6e/uUva62B5u8F1viIWTMYq700PenJiE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dsmFAlmnTLiqKN0V6gBLSW5hxzV9S31Z
	Xl7yqXb6BAS6/43omEIXfVQ3EQHnntGIwj2IjBuPK5fiNbWdsT/B9VjAXexozWCc
	jShsg1rSii+KCmZ/TgkCO5z5wyjYz8C+ced8NjPtHHZQs4eMuaPdlajVA3pTzIa6
	cEFbpCs/31k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 22E3213C85;
	Fri, 21 Aug 2009 17:43:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 689EC13C7E; Fri, 21 Aug
 2009 17:43:07 -0400 (EDT)
In-Reply-To: <F4C7A2F3-B030-449A-87AC-B54CA2B647B4@mailservices.uwaterloo.ca>
 (Mark A. Rada's message of "Fri\, 21 Aug 2009 08\:40\:34 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9F4615BE-8E9B-11DE-86D3-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126762>

Mark A Rada <marada@uwaterloo.ca> writes:

> Unless I missed a case, the tests show that the extra condition check
> that was added in the &git_snapshot routine is never actually executed,
> because a disabled snapshot format is not added to @snapshot_fmts, which
> is checked first.
>
> snippet:
> 5178     } elsif (!grep($_ eq $format, @snapshot_fmts)) {
> 5179         die_error(403, "Unsupported snapshot format");
> 5180     } elsif ($known_snapshot_formats{$format}{'disabled'}) {
> 5181         die_error(403, "Snapshot format not allowed");
> 5182     }
> 5183

True; filter_snapshot_fmts looks at 'disabled' first.

I do not mind keeping these two lines as belt-and-suspender, though.
