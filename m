From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 2/5] blame: introduce $ as "end of file" in -L syntax
Date: Wed, 13 Mar 2013 09:05:23 -0700
Message-ID: <7vip4v475o.fsf@alter.siamese.dyndns.org>
References: <cover.1362069310.git.trast@student.ethz.ch>
 <7973d90cfcd86a3c15776b8718ad6bd84ee7b4ac.1362069310.git.trast@student.ethz.ch> <7vk3psicgf.fsf@alter.siamese.dyndns.org> <7va9q85jt9.fsf@alter.siamese.dyndns.org> <87wqtbivms.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Will Palmer <wmpalmer@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Mar 13 17:06:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFoBe-0004kO-1R
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 17:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933109Ab3CMQF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 12:05:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54319 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932145Ab3CMQF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 12:05:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3439AF32;
	Wed, 13 Mar 2013 12:05:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fdEKdZCMYsYUkChyTJKC2rAtm+Y=; b=hfIsRl
	SAggLiu4CGPW/p6G3KANUlRXyfFCxvO2pCqlHh7yDVM9guyZo5ptfetaGrr35w9i
	iI+D3+F2GedJZS3FPruV4D6jbuUYmNFyw1jKDW14Z8qLcuds0cOsco9bybRFUU7C
	evDAX8bN3Xsl01/FZv4Dv5wIjU+5L+uVCPQM8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bV3SShrjp9hru4MPZXHRgPzuW+64B1V2
	wnaL5dSK/fKQaS036zvSoY9Y0JQGOg6aTByYluEuv4fvVNziXv5/NTh3xGu/ho8E
	y8FSgXwIw85vhRee5/ooCL7KhNt8ZS0Uuqhp3vJA/7BCFRxweEmadfSuSy6JjbdT
	O9qQcPLqIOg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6E1FAF2B;
	Wed, 13 Mar 2013 12:05:25 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 47577AF28; Wed, 13 Mar 2013
 12:05:25 -0400 (EDT)
In-Reply-To: <87wqtbivms.fsf@pctrast.inf.ethz.ch> (Thomas Rast's message of
 "Wed, 13 Mar 2013 08:52:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D0EEE804-8BF7-11E2-8A02-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218062>

Thomas Rast <trast@inf.ethz.ch> writes:

>> Even though I am moving from builtin/blame.c to line-log.c?  I would
>> otherwise have to call from a rather lib-ish file into a "front
>
> You haven't sent any reply to this.  Does that mean you agree?  Would
> you prefer the shared file to be named something like line-range.c?

The latter, or if you do not want a churn, not moving it out of
blame.c at all.

Because "log -L" does not play well with other patch options, from
the end-user's perspective, even though may does not have cmd_logL()
entry point, I do not think line-log.c is any more library-ish than
cmd_log() or cmd_blame().
