From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] http: try standard proxy env vars when http.proxy
 config option is not set
Date: Tue, 28 Feb 2012 11:24:01 -0800
Message-ID: <7v62eqzrqm.fsf@alter.siamese.dyndns.org>
References: <4F4CCE8A.4010800@seap.minhap.es>
 <878vjn8823.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	<git@vger.kernel.org>, <peff@peff.net>,
	<sam.vilain@catalyst.net.nz>, <sam@vilain.net>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 28 20:24:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Seh-0001bn-7M
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 20:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782Ab2B1TYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 14:24:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59575 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966053Ab2B1TYD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 14:24:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53F1D61DE;
	Tue, 28 Feb 2012 14:24:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aV0kxzRGRnoJaQY4MncfjtiH++g=; b=G3OlY6
	X/GHZZ0LqadK5yqsjpwC95FIteUC/KsXZmLAcU/Agh6v2eRboNY5lELw9uzW1AlK
	/BUQLDztLg01BXZ76LPay9JVW1s7Kid4rx+VKzeiVknDRxDnJGH7E2I54ADZ00st
	YxaS9VzJo6rDKe6qKb+O9kEtUjnNV7hFG6bcs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M/rWjZW3cfjeWFcHO+FAQllmWEDWkgGV
	+ZSuGsaX3n0v/IMA/cjP/A8vFAYOBNPcj2t7cL80RiE8rxEogaO7+aEHvxs14lnk
	c+cp6bNLQJiNMJm5f18j67G9uj+DdPe5R32UgLz4SFkQqjGFjWLkUGbmkfm9L37L
	plDByqwo5MU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49DCF61DD;
	Tue, 28 Feb 2012 14:24:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9791A61DC; Tue, 28 Feb 2012
 14:24:02 -0500 (EST)
In-Reply-To: <878vjn8823.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Tue, 28 Feb 2012 13:19:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C5AC89C8-6241-11E1-BE70-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191770>

Thomas Rast <trast@inf.ethz.ch> writes:

> Which raises the questions:
>
> * Why is this needed?  Does git's use of libcurl ignore http_proxy?  [1]
>   seems to indicate that libcurl respects <protocol>_proxy
>   automatically.
>
> * Why do you (need to?) support HTTP_PROXY when curl doesn't?

Let me add a third bullet point.

I've heard rumors that libcurl on some versions/installations of Mac OS X
deliberately ignores the environment. For those who agree with Apple, it
would be a regression if we suddenly start the environment ourselves and
using it.
