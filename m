From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] bundle: Accept prerequisites without commit messages
Date: Sun, 07 Apr 2013 10:29:03 -0700
Message-ID: <7v61zy45cw.fsf@alter.siamese.dyndns.org>
References: <1365335596-19917-1-git-send-email-git@cryptocrack.de>
 <7va9pa5k9u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lukas Fleischer <git@cryptocrack.de>
X-From: git-owner@vger.kernel.org Sun Apr 07 19:29:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOtOy-0001gm-BD
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 19:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934152Ab3DGR3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 13:29:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54925 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934144Ab3DGR3G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 13:29:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8F10134D5;
	Sun,  7 Apr 2013 17:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4pgptn7nsMoCtb4kiDOhe4yLD/Q=; b=eq9zKE
	O1y0xtJqDnkSK4Tx0ybrEd0OpuAmuzRI3h5ldnibFZazxHra8WAFiX9guAwu+u5Q
	DWFUFGyfLTdwPwWMXZT72m8KCA+l0dQXJWrFhRI4KNNxBbmhN/BR1kkEoDRezTLM
	8qvXpgfFZKbXKvTODJoTZVwho+SdvK4R0yJGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EFKXs+yZPCVTWPjquTkcnUGpC6j+JOUF
	FBj3STA/uM17eg+wT+UR/9+jGMrpEAcI9WF4Lpr0OnvQHPPEoAIya4MZDKTefETM
	8LRtLskcoRPXRigoXsDJjRAis/2O2CWEvgYXaEdGjTMhQGuqkuyMZlTWgkLv0bzK
	ORtfDb8Nuvg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD646134D4;
	Sun,  7 Apr 2013 17:29:05 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38D65134D1; Sun,  7 Apr
 2013 17:29:05 +0000 (UTC)
In-Reply-To: <7va9pa5k9u.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 07 Apr 2013 10:21:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A560495C-9FA8-11E2-BC78-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220338>

Junio C Hamano <gitster@pobox.com> writes:

> Lukas Fleischer <git@cryptocrack.de> writes:
>
>> While explicitly stating that the commit message in a prerequisite
>> line is optional, 
>
> Good spotting.  What e9ee84cf28b6 (bundle: allowing to read from an
> unseekable fd, 2011-10-13) meant to say was the SP was optional but

s/say was the SP was optional/say was not the SP was optional/

> we want to allow a tip bundled to have a commit without any commit
> log message (hence making it "optional"), and the check you are
> looking at does try to enforce.  What was buggy was that the
> comparison did not take into account that the codepath earlier
> called rtrim() on it, stripping "-<object name>SP<eol>" of the
> trailing SP it wants to look for.
