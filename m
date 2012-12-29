From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] hooks: Add function to check if a hook exists
Date: Sat, 29 Dec 2012 08:54:41 -0800
Message-ID: <7vhan4g5ny.fsf@alter.siamese.dyndns.org>
References: <1356735452-21667-1-git-send-email-aaron@schrab.com>
 <1356735452-21667-2-git-send-email-aaron@schrab.com>
 <7vwqw1fw5a.fsf@alter.siamese.dyndns.org> <20121229145032.GB3789@pug.qqx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Aaron Schrab <aaron@schrab.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 17:55:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tozgg-0003Xf-KJ
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 17:55:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916Ab2L2Qyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2012 11:54:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39940 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752311Ab2L2Qyo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2012 11:54:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8006AF8C;
	Sat, 29 Dec 2012 11:54:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eLdQGCRjERTgX1ZjzBD+dSKl8LY=; b=Y8crzH
	GN3L8K0g1HqgA0awLaVZwAhaPODpWfRHq1AX1kp1IEoDQpClvuavkCwzCBPICi8q
	4NrY5ntXpqiK1ElI/zZG2jrmauR+1S1kWUhJ3Mo0XJ72uyLds4nTaH7HCuIyT8WR
	h8zR7kGl7a+8yBcXPNcUlPEHaUJNl+m9CrylA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KFBAlclASrWE1U5jJhpOPwTXf1M3MwEk
	TmNWlMvly95IznXDaXQXa9XFB7RXJcynU5ciW2W6x7Nvqh7r+4MRTjI+8QTaDUg6
	9DRxFJs8WfC6+lYJeJgO1GaZQ2oGPQF4UEKDN2Kk5WaAcLJpWbfDdTsoZanWgOKS
	sL45Vto6Khs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5D2FAF8B;
	Sat, 29 Dec 2012 11:54:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 331EEAF8A; Sat, 29 Dec 2012
 11:54:43 -0500 (EST)
In-Reply-To: <20121229145032.GB3789@pug.qqx.org> (Aaron Schrab's message of
 "Sat, 29 Dec 2012 09:50:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 716B36A2-51D8-11E2-8647-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212314>

Aaron Schrab <aaron@schrab.com> writes:

> Since I'm going to be changing the interface for this hook in v2 of
> the series so that it will be more complicated than can be readily
> addressed with the run_hook() API (and will have use a fixed number of
> arguments anyway) I'll be dropping the run_hook_argv() function.

Just to make sure there is no misunderstanding (sorry for sending
the message without finishing it with this clarification at the end
in the first place).  I didn't mean that converting all of the
existing callers must come earlier than introducing a new hook
invoker.

I just wanted to make sure that we are aware that we are adding to
our technical debt, if we are adding another that is also
specialized; as the proposed interface looked sufficiently generic,
it would be the ideal one to make _other_ ones thin wrappers around
it to unify the various codepaths.

Thanks.
