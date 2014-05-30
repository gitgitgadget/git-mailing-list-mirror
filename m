From: Junio C Hamano <gitster@pobox.com>
Subject: Re: feature request - implement a "GIT_AUTHOR_EMAIL" equivalent, but processed BEFORE .gitconfig
Date: Fri, 30 May 2014 12:48:49 -0700
Message-ID: <xmqqvbsn82u6.fsf@gitster.dls.corp.google.com>
References: <5388CBA5.9030403@neulinger.org>
	<20140530182746.GK12314@google.com> <5388D175.3060500@neulinger.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Nathan Neulinger <nneul@neulinger.org>
X-From: git-owner@vger.kernel.org Fri May 30 21:49:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqSnU-0003Sy-2D
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 21:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932983AbaE3Ts4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 15:48:56 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53793 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525AbaE3Tsz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 15:48:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5F5F61B292;
	Fri, 30 May 2014 15:48:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CHcWv9yEQBzXaBouI+sTOmbNNow=; b=b4S664
	DEKy1L6fSUN9kGrxKN5u8hytFYC3pZmZZxsMLHQXZiOh+WwpIfn2opwbItKhrQtv
	u7hCQaoKumxVh0+wVrhxex8mHCb8SoNC78sEoDAbyBWZCnvXwg7n7IFU9d0U9ETb
	AM8wzF3LBHvQTtv3iHvFrMrThZQtI1xcTWwJA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LdZcz5x5X8toSuX4zC56AaU8lNetx8cY
	ekMKgNl796Nsefw/nrW9NUw/ZTg2KtHsqo+lV7d8MmjDrIWx/tXCTNGlGFQatcjy
	8h2P3QkJfzgHcxMrBRI4bIYAmE75Zorh05g/NBqutKiLZdnM5bVzerESpQJHsYZw
	EwkXPohY5PY=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 528D41B291;
	Fri, 30 May 2014 15:48:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5C6621B28A;
	Fri, 30 May 2014 15:48:51 -0400 (EDT)
In-Reply-To: <5388D175.3060500@neulinger.org> (Nathan Neulinger's message of
	"Fri, 30 May 2014 13:44:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6C95BC7C-E833-11E3-8628-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250470>

Nathan Neulinger <nneul@neulinger.org> writes:

>> I wouldn't mind having a GIT_EMAIL envvar with the semantics you mean,
>> but can you say more about the use case?  What's wrong with the usual
>> EMAIL environment variable?
>
> EMAIL actually worked for this case for me, but there wasn't any
> equivalent for author name, so the commits all look like
> "sharedaccount <myuser@mydomain>".

I do not want to go into the discussion on the sanity/insanity of
using such a "shared account", but I am guessing that you already
have a concrete and workable mechanism in mind to allow you to set
these environment variables such as GIT_WEAKER_AUTHOR_NAME to
individual real users who share that account, and I further guess
that that is what you use to set EMAIL.  Am I guessing right?

If so, wouldn't it be a better option to use that mechanism to set
separate $HOME (or XDG_CONFIG_HOME if you prefer) to these real
users who share the account, so that separate $HOME/.gitconfig files
can be used by them?
