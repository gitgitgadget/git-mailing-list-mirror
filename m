From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is there way to set git commit --date to be older than 1970 ?
Date: Wed, 29 Oct 2014 12:31:54 -0700
Message-ID: <xmqqh9ymy8np.fsf@gitster.dls.corp.google.com>
References: <CAOE_JxJp0nA_p_42yOyk_nMjsyMaovj0Fx6AJ5nywiEQfB5XAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Peter Vojtek <peter.vojtek@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 20:32:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjYyU-0004pf-Ct
	for gcvg-git-2@plane.gmane.org; Wed, 29 Oct 2014 20:32:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755504AbaJ2TcB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2014 15:32:01 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53980 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756730AbaJ2Tb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2014 15:31:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 78974194BE;
	Wed, 29 Oct 2014 15:31:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n5akyUDJIN7kMftXj9+POV9l28k=; b=ezYy5+
	alBf7F1UKZjrV35ZJ50gjyc23qWPS1orRtqGu7Na54e4IYM1HJ4GSxpbDwh4S+Ww
	pqa3+Z9z/gMOzHIraZF0UvB6HXWZRS0vqldG4ejY2Cci+ROcH8wUAFklm1kAmbFv
	rk/Ym6GanZoyPWlr2gWPp72yVs1EUu7Wqd1wE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UeQy6h4S/19RdjSYHiIm6vwS2dyxwD5t
	pmBx+lXMubCc/wRZBxsFwH20DSq0/5OJ97VfJQ7yW9db44luzBGXKcvXfrALckAp
	SHCd5NKETBC5rU2nlIzcCv5ivflPL8kMTln6okWCCbMCEuouyMc8QwAbT9lmWzDN
	q6Fsf/3IIKE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 705C8194BD;
	Wed, 29 Oct 2014 15:31:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E280B194BC;
	Wed, 29 Oct 2014 15:31:55 -0400 (EDT)
In-Reply-To: <CAOE_JxJp0nA_p_42yOyk_nMjsyMaovj0Fx6AJ5nywiEQfB5XAQ@mail.gmail.com>
	(Peter Vojtek's message of "Wed, 29 Oct 2014 19:49:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3E1CA270-5FA2-11E4-8880-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peter Vojtek <peter.vojtek@gmail.com> writes:

> It seems the commit date can be between 1970 and 2100 (on my 32bit
> linux),...

The underlying data representation records time as number of seconds
since epoch (1970-01-01).  Theoretically the codepaths that read
data could consider negative timestamps to represent times before
the epoch, but in the context of source code control, negative
values are more likely to be an indication of a bug or a user
mistake, and I do not think any existing code in Git is prepared to
pass such a timestamp as a sane value---instead they diagnose a
failure and die.

> I understand that this is rather an esoteric use case :)

Yeah, this is pretty much outside of what we intend to support.

Thanks.
