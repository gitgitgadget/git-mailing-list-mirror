From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Support running an arbitrary git action through checkout
Date: Fri, 10 May 2013 08:52:48 -0700
Message-ID: <7vk3n63k8f.fsf@alter.siamese.dyndns.org>
References: <2d5cfb3be9487f607051cad3d5230434660307ba.1368198269.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Steve Losh <steve@stevelosh.com>,
	Jeff King <peff@peff.net>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri May 10 17:52:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uapct-0008Ne-UL
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 17:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821Ab3EJPww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 11:52:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53354 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753621Ab3EJPwv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 11:52:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A77801D5AA;
	Fri, 10 May 2013 15:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kjG6FqSVoWq9N0Ydaj+jTKuXNhY=; b=CV3CXr
	gTUUpU4ARF9fRojn7ynPGofLPSwRm2Mq2nK8tWIB3/YomSBwvHiICdP/Bd2lloae
	3MS117ogcvo16mzqBPa9VojRxXvHucXMhXB5ZRWfmYo57hwnPiXaqv/c3IdSxGR8
	RreQx27+8hmyWQyza9DADTwhWKqHrf1fshfzA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rhp7425XFE477TUpQGPixECBOVw9hwHQ
	RUbhSdSpiYTMguDpZKmy9IzgalksImUZH+8CEfo0RtW4j25yfzuvQKy8RJIYqQVa
	7Srq90l2prdrOP3RJHAy5ZqIRyBdL9uXSiNmCNMtRIu2kHOtbIuLzfUuklzjq59g
	JdsASyEZex4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B0F31D5A9;
	Fri, 10 May 2013 15:52:50 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21F051D5A8;
	Fri, 10 May 2013 15:52:50 +0000 (UTC)
In-Reply-To: <2d5cfb3be9487f607051cad3d5230434660307ba.1368198269.git.trast@inf.ethz.ch>
	(Thomas Rast's message of "Fri, 10 May 2013 17:06:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AAC937BE-B989-11E2-BA88-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223876>

Thomas Rast <trast@inf.ethz.ch> writes:

> [1] correctly observed that we are already wrapping three different
> operations under the git-checkout command.

It is not April 1st, but perhaps it is in Berlin ;-)

By the way I do not necessarily think that different operations
"checking out specific paths" and "checking out another branch"
should be invoked by separate commands.  It of course would be
easier to _implement_ because the command does not have to see which
operation the user wants, but if humans use the same verb to express
these actions, the command should help them do so.
